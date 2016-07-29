package welink.common

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.OrderDetail
import welink.business.TradeDetail
import welink.estate.Community
import welink.user.Employee
import welink.user.Profile

import static com.google.common.base.Preconditions.checkNotNull
import static com.welink.commons.Utils.DAY_FORMATTER

class TradeCalcuController {

    static ImmutableMap<String, String> PAY_TYPE_MAP = ImmutableMap.builder() //
            .put("2", "货到付款")
            .put("<>2", "线上支付")
            .build()

    static ImmutableMap<String, String> SHIPPING_TYPE_MAP = ImmutableMap.builder() //
            .put("-1", "送货上门")
            .put("1", "用户自提")
            .build()

    def index() {

        def t = Trade.createCriteria()

        PagedResultList pagedResultList
        //计算订单总数
        Long TradesNum = 0
        //所有订单总额
        Long TradesTotal = 0
        //商品统计map
        def itemMap = [:]

        def tradeMap = [:]

        def tradeDetailMap = [:]

        params.daterange

        params.payType

        params.courierId

        params.communityId

        params.shippingType

        if (StringUtils.isNotBlank(params.noCourier) && params.noCourier != "false") {
            params.noCourier = true
        } else {
            params.noCourier = false
        }

        def dateRange = params.daterange ? StringUtils.split(String.valueOf(params.daterange), " ") : null

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
            eq('status', 1 as byte)
        }

//        LinkedList<Employee> courierList = Employee.createCriteria().list {
//            eq('status', 1 as byte)
//            order("id", "asc")
//        }

        // 查询语句

        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        // 如果是微邻科技的，传入null，不是的传入各个站点
        Long communityId = employee?.communityId == 1999L ? null : employee?.communityId;

        if (StringUtils.isNotBlank(params.communityId)) {
            communityId = Long.parseLong(params.communityId)
        }

        params.communityId = communityId == null ? null : "${communityId}"

        //只查找3个月内的订单因为慢
        pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            // 走索引
            eq('status', 7 as byte)
            between("dateCreated", new DateTime().minusMonths(3).toDate(), new DateTime().toDate())

            // 如果时间范围做了选区
            if (dateRange != null) {
                between("endTime", DAY_FORMATTER.parseDateTime(dateRange[0]).toDate(), DAY_FORMATTER.parseDateTime(dateRange[2]).plusDays(1).minusSeconds(1).toDate())
            }

            if (params.communityId) {
                eq('communityId', Long.parseLong(params.communityId))
            }

            if (params.noCourier) {
                isNull("courier")
            } else {
                if (params.courierId) {
                    eq("courier", Long.parseLong(params.courierId))
                }
            }

            if (params.shippingType) {
                eq("shippingType", Byte.parseByte(params.shippingType))
            }


            if (params.payType) {
                if (params.payType == '2') {
                    eq("payType", 2 as Byte)
                } else {
                    ne("payType", 2 as Byte)
                }
            }

            //订单号的查询
            if(params.long('tradeId')){
                eq('tradeId',params.long('tradeId'))
            }

            order('endTime', 'desc')
        }

        pagedResultList.iterator().each {
            Trade trade ->
                Logistics logistics = Logistics.findById(trade.consigneeId)

                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logistics?.consigneeId)

                Profile profile = Profile.findById(trade.buyerId)

                int blankIndex

                if (logistics && logistics.addr.contains('\u0001')) {
                    blankIndex = logistics.addr.indexOf('\u0001')
                } else {
                    blankIndex = 0
                }

                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,//订单编号
                        profileMobile: profile?.mobile,//购买人电话
                        communityName: Community.findById(trade.communityId)?.name,
                        address: logistics?.addr.substring(blankIndex),//收货地址
                        modifiAddr: consigneeAddr?.modifiAddr,//修改后地址
                        receiverName: logistics?.contactName,//收货人姓名
                        receiverMobile: logistics?.mobile,//收货人电话
                        totalPrice: trade.totalFee,//总价
                        status: trade.status,//订单状态
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        createTime: trade.dateCreated.toString().substring(0, 16),//订单创建
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无调度时间',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无送货时间',
                        endTime: trade?.endTime ? trade?.endTime.toString().substring(0, 16) : '无确认时间',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人'
                ))
        }

        return [
//                courierList    : courierList,
                communityList  : communityList,
                total          : pagedResultList?.totalCount,
                params         : params,
                tradeList      : pagedResultList,
                tradeMap       : tradeMap,
                itemMap        : itemMap,
                TradesNum      : TradesNum,
                TradesTotal    : TradesTotal
//                shippingTypeMap: SHIPPING_TYPE_MAP,
//                payTypeMap     : PAY_TYPE_MAP
        ]
    }

    def NoShipItemCalcu() {

        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
            eq("status", 1 as byte)
        }

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        def itemMap = [:]

        List<Item> itemList = new ArrayList<Item>()

        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        List<Trade> trades = Lists.newArrayList()

        //计算订单总数
        Long TradesNum = 0

        //所有订单总额
        Long TradesTotal = 0

        // 获得现在的操作用户
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        // 如果是微邻科技的，传入null，不是的传入各个站点
        Long communityId = employee?.communityId == 1999L ? null : employee?.communityId;

        if (StringUtils.isNotBlank(params.communityId)) {
            communityId = Long.parseLong(params.communityId)
        }

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        params.communityId = communityId == null ? null : "${communityId}"

        trades = Trade.withCriteria {
            // 走索引
            eq('status', 4 as byte)
            between("dateCreated", new DateTime().minusMonths(3).toDate(), new DateTime().toDate())

            if (communityId != null) {
                eq('communityId', communityId)
            }
            if (start != null) {
                gt("dateCreated", start)
            }
            if (end != null) {
                lt("dateCreated", end)
            }
        }

        trades.each {
            Trade trade ->

                checkNotNull(trade, "the trade should not be null.")

                TradesNum = TradesNum + 1

                TradesTotal = TradesTotal + ((trade?.totalFee) ?: 0)

                def orderIds = checkNotNull(trade.orders, "the orders should not be null, the trade id is %s", trade.id).split(';')

                orderIds.each {
                    String id ->
                        Order order = Order.findById(Long.parseLong(id))
                        Item item = Item.findById(order.artificialId)
                        if (item) {
                            if (itemMap.get(item.id)) {
                                OrderDetail orderDetail = itemMap.get(item.id)
                                orderDetail.itemNum = orderDetail.itemNum + order?.num
                                orderDetail.orderPrice = orderDetail.orderPrice + order?.totalFee
                                itemMap.put(item.id, orderDetail)
                            } else {
                                OrderDetail orderDetail = new OrderDetail(
                                        itemName: item.title,
                                        itemSpecification: item.specification,
                                        itemNum: order?.num,
                                        orderPrice: order?.totalFee
                                )
                                itemList.add(item)
                                itemMap.put(item.id, orderDetail)
                            }
                        } else {
                            if (itemMap.get(new Item(id: 0L).id)) {
                                OrderDetail orderDetail = itemMap.get(new Item(id: 0L).id)
                                orderDetail.itemNum = orderDetail.itemNum + 1
                                orderDetail.orderPrice = orderDetail.orderPrice + order?.totalFee
                                itemMap.put(new Item(id: 0L).id, orderDetail)
                            } else {
                                OrderDetail orderDetail = new OrderDetail(
                                        itemName: '运费',
                                        itemSpecification: '次',
                                        itemNum: order?.num,
                                        orderPrice: order?.totalFee
                                )
                                itemList.add(new Item(id: 0L))
                                itemMap.put(new Item(id: 0L).id, orderDetail)
                            }
                        }
                }
        }

        Community community
        if (params.communityId) {
            community = Community.findById(params.long('communityId'))
        } else {
            community = Community.findById(employee.communityId)
        }
        return [
                community    : community,
                communityList: communityList,
                TradesNum    : TradesNum,
                TradesTotal  : TradesTotal,
                itemList     : itemList,
                itemMap      : itemMap,
                params       : params
        ]


    }
}

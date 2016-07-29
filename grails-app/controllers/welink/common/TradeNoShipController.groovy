package welink.common

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import com.welink.commons.commons.TradeEventType
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import org.springframework.core.task.TaskExecutor
import pl.touk.excel.export.WebXlsxExporter
import welink.business.MikuReturnGoodsDetail
import welink.business.OrderDetail
import welink.business.OutExcelDetail
import welink.business.TradeDetail
import welink.estate.Community
import welink.estate.TradeSearch
import welink.system.LbsStationBaiduMapService
import welink.system.TradeOpenSearchService
import welink.system.UndeliveredTradeScheduleService
import welink.user.CommunityTenant
import welink.user.Employee
import welink.user.Profile

import javax.annotation.Resource
import java.text.SimpleDateFormat


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import static com.google.common.base.Preconditions.checkNotNull

class TradeNoShipController {

    TradeDispatchedTrackService tradeDispatchedTrackService

    TradeOpenSearchService tradeOpenSearchService

    UndeliveredTradeScheduleService undeliveredTradeScheduleService

    LbsStationBaiduMapService lbsStationBaiduMapService

    MessageSendService messageSendService


    @Resource(name = 'eventTaskExecutor')
    TaskExecutor eventTaskExecutor;

    static ImmutableMap<String, String> PAY_TYPE_MAP = ImmutableMap.builder() //
            .put("2", "货到付款")
            .put("3", "支付宝支付")
            .put("4", "微信支付")
            .build()

    static ImmutableMap<Integer, String> Delivery_Day_Map = ImmutableMap.builder() //
            .put(0, "今天")
            .put(1, "明天")
            .put(2, "后天")
            .build()

    static ImmutableMap<Integer, String> Delivery_Time_Map = ImmutableMap.builder() //
            .put(570, "9:30~12:00")
            .put(720, "12:00~14:30")
            .put(870, "14:30~17:00")
            .put(1020, "17:00~19:30")
            .build()

    static ImmutableMap<String, String> SHIPPING_TYPE_MAP = ImmutableMap.builder() //
            .put("-1", "送货上门")
            .put("1", "用户自提")
            .build()

    static ImmutableMap<String, String> TOTAL_FEE_OP_MAP = ImmutableMap.builder() //
            .put(">", "大于")
            .put("=", "等于")
            .put("<", "小于")
            .build()

    static ImmutableMap<String, String> ORDER_MAP = ImmutableMap.builder() //
            .put("+", "正序")
            .put("-", "倒序")
            .build()

    static ImmutableMap<String, String> ORDER_ENTITY_MAP = ImmutableMap.builder() //
            .put("total_fee", "商品总价")
            .put("date_created", "下单时间")
            .put("appoint_delivery_time", "预约时间")
            .build()

    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .put(500, "500")
            .put(1000, "1000")
            .put(2000, "2000")
            .build()

    //勾选备货
    @Transactional
    def shipTradeChecked() {
        def tradeIds = Lists.newArrayList(params.tradeShipBox)
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)
        tradeIds.each {
            String it ->
                Long id = Long.parseLong(it)
                Trade trade = Trade.findByIdAndStatus(id, 4 as byte)
                if (trade) {
                    trade.status = 6
                    trade.consignTime = new Date()//调度时间
                    trade.timeoutActionTime = new DateTime().plusDays(3).toDate()
                    trade.save(failOnError: true, flush: true)
//                    eventTaskExecutor.execute(new Runnable() {
//                        @Override
//                        void run() {
//                            // 如果勾选了发货，那么删除 TreadSearch
//                            TradeSearch.findById(trade.id)?.delete(flush: true)
//                            lbsStationBaiduMapService.deleteDataInTable(trade)
//                        }
//                    })
//                    messageSendService.sendMessage(trade.tradeId,TradeEventType.TRADE_PACKAGE.getTopic())
                }
        }

//        tradeDispatchedTrackService.trackDispatch(employee.id, tradeIds.collect {
//            Long.parseLong(it)
//        })
        redirect(action: "index")
    }

    /**
     * 获取未发货订单，目前走搜索
     *
     * @return
     */
    def index() {


        //计算订单总数
        Long TradesNum = 0
        //所有订单总额
        Long TradesTotal = 0
        //商品统计map
        def itemMap = [:]

        def tradeMap = [:]

        def tradeDetailMap = [:]

        List<Item> itemList = new ArrayList<Item>()

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
            eq('status', 1 as byte)
        }

//        Community community = new Community()
//        community.setId(-1L)
//        community.setName("微邻科技")
//
//        // 加入其它小区
//        communityList.add(community)

        // 获得现在的操作用户
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        // 配送人员列表，和当前用户的站点相同
//        LinkedList<Employee> courierList = Employee.createCriteria().list {
//            eq('status', 1 as byte)
//            eq('communityId', employee.communityId)
//            order("id", "asc")
//        }

        // 电话号码
        String mobile = params.query

        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }

        // 地址查询
        String address = params.addressQuery

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        // 支付方式
        def payType = params.payType

        // 配送方式
        def shippingType = params.shippingType

        // 实付金额的操作
        def totalFeeOp = params.totalFeeOp

        // 实付金额的价格
        def targetTotalFee = params.targetTotalFee

        // 排序字段
        def orderEntry = params.orderEntry

        // 排序规则
        def ord = params.order

        //配送日期
        def deliveryDay = params.deliveryDay

        //配送时间
        def deliveryTime = params.deliveryTime

        //订单号的查询
        def tradeCode=params.long('tradeCode')

        if (StringUtils.isNotBlank(payType)) {
            payType = payType.toInteger()
        } else {
            payType = null
        }

        if (StringUtils.isNotBlank(shippingType)) {
            shippingType = shippingType.toInteger()
        } else {
            shippingType = null
        }

        Date dead = null

        if (StringUtils.isNotBlank(deliveryDay)) {
            deliveryDay = deliveryDay.toInteger()
            DateTime dateTime = new DateTime()
            dead = dateTime.withTimeAtStartOfDay().plusDays(deliveryDay + 1).toDate()
        } else {
            deliveryDay = null
        }

        def deliveryStartTime = null

        def deliveryEndTime = null

        if (StringUtils.isNotBlank(deliveryTime)) {
            deliveryStartTime = deliveryTime.toInteger()
            deliveryEndTime = deliveryStartTime + 150
        } else {
            deliveryTime = null
        }

//        def totalFeeCompare = StringUtils.EMPTY

        if (StringUtils.isNotBlank(totalFeeOp) && StringUtils.isNotBlank(targetTotalFee)) {
            targetTotalFee=(new BigDecimal(targetTotalFee) * 100).toBigInteger().intValue()
//            totalFeeCompare = "total_fee${totalFeeOp}${targetTotalFee}"
        }


        def completeOrder = StringUtils.EMPTY

        if (StringUtils.isNotBlank(orderEntry) && StringUtils.isNotBlank(ord)) {
            completeOrder = "${ord}${orderEntry}"
        } else {
            completeOrder = "-total_fee"
        }

        // 如果是微邻科技的，传入null，不是的传入各个站点
        Long communityId = employee?.communityId == 1999L ? null : employee?.communityId;

        if (StringUtils.isNotBlank(params.communityId)) {
            communityId = Long.parseLong(params.communityId)
        }

        params.communityId = communityId == null ? null : "${communityId}"

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        log.info "=======测试同步trade-Search 开始=========》" + df.format(new Date());
        /**
         * 最傻逼的做法
         */
        undeliveredTradeScheduleService.execute();
        log.info "=======测试同步trade-Search 结束=========》" + df.format(new Date());
//        List<Trade> trades = Lists.newArrayList()
//        int total = 0
//        int viewTotal = 0;
//        log.info "=======测试openSearch 开始=========》" + df.format(new Date());
//        //执行搜索
//        def searchResult = tradeOpenSearchService.searchUndeliveredTrades(deliveryStartTime, deliveryEndTime, address, mobile, start, end, dead, communityId, shippingType, payType, completeOrder, params.int('offset') ?: 0, params.int('max') ?: 10, totalFeeCompare, params.mapKey)
//        log.info "=======测试openSearch 结束=========》" + df.format(new Date());
//        trades.addAll(searchResult.get("tradeList"))
//        total = searchResult.get('total')
//        viewTotal = searchResult.get('viewTotal')
//
//
//        log.info "=======订单信息统计 开始=========》" + df.format(new Date());
//        //订单信息统计
//        trades.each {
//            Trade trade ->
//
//                checkNotNull(trade, "the trade should not be null.")
//
//                TradesNum = TradesNum + 1
//
//                TradesTotal = TradesTotal + ((trade?.totalFee) ?: 0)
//
//                def orderIds = checkNotNull(trade.orders, "the orders should not be null, the trade id is %s", trade.id).split(';')
//
//                // 获取 order 信息
//                List<OrderDetail> orderList = new ArrayList<OrderDetail>()
//                orderIds.each {
//                    String id ->
//                        Order order = Order.findById(Long.parseLong(id))
//                        Item item = Item.findById(order.artificialId)
//                        if (item) {
//                            if (itemMap.get(item.id)) {
//                                OrderDetail orderDetail = itemMap.get(item.id)
//                                orderDetail.itemNum = orderDetail.itemNum + order?.num
//                                orderDetail.orderPrice = orderDetail.orderPrice + order?.totalFee
//                                itemMap.put(item.id, orderDetail)
//                            } else {
//                                OrderDetail orderDetail = new OrderDetail(
//                                        itemName: item.title,
//                                        itemSpecification: item.specification,
//                                        itemNum: order?.num,
//                                        orderPrice: order?.totalFee
//                                )
//                                itemList.add(item)
//                                itemMap.put(item.id, orderDetail)
//                            }
//                        } else {
//                            if (itemMap.get(new Item(id: 0L).id)) {
//                                OrderDetail orderDetail = itemMap.get(new Item(id: 0L).id)
//                                orderDetail.itemNum = orderDetail.itemNum + 1
//                                orderDetail.orderPrice = orderDetail.orderPrice + order?.totalFee
//                                itemMap.put(new Item(id: 0L).id, orderDetail)
//                            } else {
//                                OrderDetail orderDetail = new OrderDetail(
//                                        itemName: '运费',
//                                        itemNum: order?.num,
//                                        orderPrice: order?.totalFee
//                                )
//                                itemList.add(new Item(id: 0L))
//                                itemMap.put(new Item(id: 0L).id, orderDetail)
//                            }
//                        }
//
//                        orderList.add(new OrderDetail(
//                                itemName: order?.title,
//                                orderId: order?.id,
//                                itemNum: order?.num,
//                                itemPrice: order?.price,
//                                orderPrice: order?.totalFee))
//                }
//                tradeDetailMap.put(trade.id, orderList)
//
//                Logistics logistics = Logistics.findById(trade.consigneeId)
//
//                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logistics?.consigneeId)
//
//                Profile profile = Profile.findById(trade.buyerId)
//
//                int blankIndex
//
//                if (logistics && logistics.addr?.contains('\u0001')) {
//                    blankIndex = logistics.addr.indexOf('\u0001')
//                } else {
//                    blankIndex = 0
//                }
//
//
//                def headAddr = logistics?.addr
//                //具体地址的添加
//                if (logistics) {
//                    headAddr = logistics.country + logistics.province + logistics?.addr
//                }
//
//                tradeMap.put(trade.id, new TradeDetail(
//                        tradeId: trade.tradeId,
//                        profileMobile: profile?.mobile,
//                        communityName: Community.findById(trade.communityId)?.name,
//                        //address: logistics?.addr?.substring(blankIndex),
//                        address: headAddr,
//                        modifiAddr: consigneeAddr?.modifiAddr,
//                        receiverName: logistics?.contactName,
//                        receiverMobile: logistics?.mobile,
//                        totalPrice: trade?.totalFee,
//                        createTime: trade?.payTime.toString().substring(0, 16),
//                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '无预约时间',
//                        status: trade.status,
//                        tradeMemo: trade?.buyerMessage ?: '无备注'
//                ))
//        }

        //======================================================================
        def MyTrade = Trade.createCriteria()
        // 根据的条件进行分页的操作
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 4 as byte)
            eq('returnStatus', 0 as byte)
//            eq('type',1 as byte)
            'in'('type', [1,9,10] as byte[])
//            if (params.communityId) {
//                eq('communityId', params.long('communityId'))
//            }

            if (tradeCode)
            {
                eq('tradeId',tradeCode)
            }

            if (payType != null) {
                eq('payType', (Byte) payType)
            }

            if (shippingType != null) {
                eq('shippingType', (Byte) shippingType)
            }

            if (start != null) {
                gt("dateCreated", start)
            }

            if (end != null) {
                lt("dateCreated", end)
            }

            if (StringUtils.isNotBlank(mobile)) {
                def logisticss = Logistics.findAllByMobile(mobile)
                Profile profile = Profile.findByMobile(mobile)
                if (profile && logisticss) {
                    or {
                        eq("buyerId", profile.id)
                        'in'("consigneeId", logisticss*.id)
                    }
                } else if (profile) {
                    eq('buyerId', profile.id)
                } else if (logisticss) {
                    "in"('consigneeId', logisticss*.id)
                } else {
                    eq("id", -1L)
                }
            }

            //进行实付查询
            if (totalFeeOp && targetTotalFee)
            {
                List<Trade> tlist=Trade.findAllByStatus(4 as byte)
                List<Trade> moneyList=new ArrayList<Trade>()
                tlist.each {
                    Trade tobj->
                       if (totalFeeOp.equals(">") && tobj.totalFee>targetTotalFee)
                        {
                            moneyList.add(tobj)
                        }
                        else if (totalFeeOp.equals("<") && tobj.totalFee<targetTotalFee)
                        {
                            moneyList.add(tobj)
                        }
                        else if(totalFeeOp.equals("=") && tobj.totalFee==targetTotalFee)
                        {
                            moneyList.add(tobj)
                        }

                }
//                List<Trade> moneyList=new ArrayList<Trade>()
//                tlist.each {
//                    Trade tobj->
//                        String[] ordersids=tobj.orders.split(";")
//                        def sum=0
//                        for(int i=0;i<ordersids.length;i++)
//                        {
//                            Order odata=Order.findById(ordersids[i])
//                            //原来
//                            sum+=odata.totalFee
//                        }
//                        if (totalFeeOp.equals(">") && sum>targetTotalFee)
//                        {
//                            moneyList.add(tobj)
//                        }
//                        else if (totalFeeOp.equals("<") && sum<targetTotalFee)
//                        {
//                            moneyList.add(tobj)
//                        }
//                        else if(totalFeeOp.equals("=") && sum==targetTotalFee)
//                        {
//                            moneyList.add(tobj)
//                        }
//                }
                if (moneyList.size())
                {
                    "in"('id', moneyList*.id)
                }
                else{
                    eq("id", -1L)
                }
            }
            order('id', 'desc')

        }
        def newtradeMap = [:]
        def newtradeDetailMap = [:]
        //商品统计map
        def newitemMap = [:]
        List<Item> newitemList = new ArrayList<Item>()
        List<Trade> newTrades=Lists.newArrayList()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                //添加对应订单的信息
                newTrades.add(trade)
                //物流信息
                def  logic=Logistics.findById(trade.consigneeId)
                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logic?.consigneeId)
                Profile profile = Profile.findById(trade.buyerId)

                // 获取 order 信息
                List<OrderDetail> neworderList = new ArrayList<OrderDetail>()
                //商品信息
                String[] ordersids=trade.orders.split(";")
                ordersids.each{
                    oid->
                        def order=Order.findById(Long.parseLong(oid))
                        Item item=Item.findById(order.artificialId)
                        if (item)
                        {
                            if (newitemMap.get(item.id))
                            {
                                  OrderDetail orderDetail = newitemMap.get(item.id)
                                  orderDetail.itemNum = orderDetail.itemNum + order?.num
                                  orderDetail.orderPrice = orderDetail.orderPrice + order?.totalFee
                                  newitemMap.put(item.id, orderDetail)
                            }
                            else
                            {
                                OrderDetail orderDetail = new OrderDetail(
                                        itemName: item.title,
                                        itemSpecification: item.specification,
                                        itemNum: order?.num,
                                        orderPrice: order?.totalFee
                                )
                                newitemList.add(item)
                                newitemMap.put(item.id, orderDetail)
                            }
                        }
                        else
                        {
                            if (newitemMap.get(new Item(id: 0L).id)) {
                                OrderDetail orderDetail = newitemMap.get(new Item(id: 0L).id)
                                orderDetail.itemNum = orderDetail.itemNum + 1
                                orderDetail.orderPrice = orderDetail.orderPrice + order?.totalFee
                                newitemMap.put(new Item(id: 0L).id, orderDetail)
                            } else {
                                OrderDetail orderDetail = new OrderDetail(
                                        itemName: '运费',
                                        itemNum: order?.num,
                                        orderPrice: order?.totalFee
                                )
                                newitemList.add(new Item(id: 0L))
                                newitemMap.put(new Item(id: 0L).id, orderDetail)
                            }
                        }
                        neworderList.add(new OrderDetail(
                                itemName: order?.title,
                                orderId: order?.id,
                                itemNum: order?.num,
                                itemPrice: order?.price,
                                orderPrice: order?.totalFee))
                }
                newtradeDetailMap.put(trade.id, neworderList)

//                def headAddr = domyAddr(logic.addr)
                def headAddr = consigneeAddr?(consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress):""
                //具体地址的添加
//                if (logic) {
//                    headAddr = logic.country + logic.province + logic?.addr
//                }
                //订单信息
                newtradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logic?.contactName,
                        receiverMobile: logic?.mobile,
                        totalPrice: trade?.totalFee,
                        createTime: trade?.payTime?trade?.payTime.toString().substring(0, 16):"",
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '无预约时间',
                        status: trade.status,
                        tradeMemo: trade?.buyerMessage ?: '无备注'
                ))
        }
        //查出对应的的总数
//        def newsum
//        String query = "select count(id) from Trade where status = 4"
//        if (payType) {
//            payType = payType.toInteger()
//            query += " and payType = ${payType}"
//        } else {
//            payType = null
//        }
//        if (shippingType) {
//            shippingType = shippingType.toInteger()
//            query += " and shippingType = ${shippingType}"
//        } else {
//            shippingType = null
//        }
//        if (start != null) {
//            query += " and dateCreated > ?"
//        }
//
//        if (end != null) {
//            query += " and dateCreated < ?"
//        }
//        //添加电话号码
//        if (StringUtils.isNotBlank(mobile)) {
//            def logisticss = Logistics.findAllByMobile(mobile)
//            Profile profile = Profile.findByMobile(mobile)
//            if (profile && logisticss) {
//                query +=" and (buyerId = ${profile.id} or consigneeId in (${StringUtils.join(logisticss*.id,",")}))"
//            } else if (profile) {
//                query +=" and buyerId = ${profile.id}"
//            } else if (logisticss) {
//                query +=" and consigneeId in (${StringUtils.join(logisticss*.id,",")})"
//            } else {
//                query +=" and id = -1"
//            }
//        }
//        if (start != null && end != null) {
//            newsum = Trade.executeQuery(query, [start, end])?.get(0) ?: 0
//        } else if (start != null && end == null) {
//            newsum = Trade.executeQuery(query, [start])?.get(0) ?: 0
//        } else if (start == null && end != null) {
//            newsum = Trade.executeQuery(query, [end])?.get(0) ?: 0
//        } else {
//            newsum = Trade.executeQuery(query)?.get(0) ?: 0
//        }
        //======================================================================

        log.info "=======订单信息统计 结束=========》" + df.format(new Date());


        //原来的内容值
//        return [
//                courierList    : courierList,
//                itemList       : itemList,
//                itemMap        : itemMap,
//                tradeList      : trades,
//                tradeDetailMap : tradeDetailMap,
//                communityList  : communityList,
////                total          : total,
//                total          : tradeDetailMap.size(),
//                viewTotal      : viewTotal,
////                viewTotal      : tradeDetailMap.size(),
//                params         : params,
//                tradeMap       : tradeMap,
//                payTypeMap     : PAY_TYPE_MAP,
//                shippingTypeMap: SHIPPING_TYPE_MAP,
//                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
//                orderMap       : ORDER_MAP,
//                orderEntryMap  : ORDER_ENTITY_MAP,
//                deliveryDayMap : Delivery_Day_Map,
//                deliveryTimeMap: Delivery_Time_Map
//
//        ]




        //最新的分页信息
//        def newtradeMap = [:]
//        def newtradeDetailMap = [:]
//        //商品统计map
//        def newitemMap = [:]
//        List<Item> newitemList = new ArrayList<Item>()
//        List<Trade> newTrades=new ArrayList<Item>()
        return [
//                courierList    : courierList,
                itemList       : newitemList,
                itemMap        : newitemMap,
                tradeList      : newTrades,
                tradeDetailMap : newtradeDetailMap,
                communityList  : communityList,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap    : PageMap,
                tradeMap       : newtradeMap,
                payTypeMap     : PAY_TYPE_MAP,
                shippingTypeMap: SHIPPING_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
                orderMap       : ORDER_MAP,
                orderEntryMap  : ORDER_ENTITY_MAP,
                deliveryDayMap : Delivery_Day_Map,
                deliveryTimeMap: Delivery_Time_Map

        ]

    }


    def finishTradeByMobile() {
        return [
        ]
    }

    @Transactional
    def finishTradeQuick() {
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)
        if (params.mobile) {
            String query = params.mobile
            query = query.replace('-', '')
            if (Profile.findByMobile(query)) {
                Profile profile = Profile.findByMobile(query)
                Trade trade = Trade.findByBuyerIdAndStatusAndTotalFee(profile.id, 4 as byte, 100L)
                if (trade) {
                    trade.courier = employee.id
                    trade.status = 7
                    if (trade.save(failOnError: true, flush: true)) {
                        if (trade.payType == 3 as byte || trade.payType == 4 as byte) {
                            render ImmutableMap.of("code", "1", "message", "成功，线上已支付") as JSON
                        } else {
                            render ImmutableMap.of("code", "1", "message", "成功，货到付款订单") as JSON
                        }
                        return
                    } else {
                        render ImmutableMap.of("code", "1", "message", "失败，系统存储失败") as JSON
                        return
                    }
                } else {
                    render ImmutableMap.of("code", "1", "message", "失败，无订单") as JSON
                    return
                }
            }
        }
        response.status = 405

    }





    //导出订单
    def outPortExcelByTrade()
    {
        def ids=params.TradeExcelids
        String[] idsarr=ids.split(",")
        //excel的集合
//        List<OutExcelModel> outList=new ArrayList<OutExcelModel>()
        List<OutExcelDetail> outList=new ArrayList<OutExcelDetail>()
        idsarr.each {
            id->
                def  trade=Trade.findById(Long.parseLong(id))
                //物流信息
                def  logic=Logistics.findById(trade.consigneeId)
                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logic?.consigneeId)
                int blankIndex=0
                if (logic && logic.addr?.contains('\u0001')) {
                    blankIndex = logic.addr.indexOf('\u0001')
                } else {
                    blankIndex = 0
                }
                String addrStr=logic?.addr?.substring(blankIndex)
                addrStr= addrStr.replace(logic?.city,"")
                //商品信息
                String[] ordersids=trade.orders.split(";")
                ordersids.each{
                    oid->
                        def order=Order.findById(oid)
                        Item oneitem=Item.findById(order.artificialId)
                        if (oneitem)
                        {
                            MikuBrand mikuBrand=MikuBrand.findById(oneitem.brandId)
//                            def addrs=consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress
                            OutExcelDetail oneTd=new OutExcelDetail(
                                    tradeid:trade.tradeId,
                                    outtradeid:"VC_米酷_"+trade.tradeId,
                                    logisticsCompany:"",
                                    createTime:trade.payTime?trade.payTime.toString().split(" ")[0]:"",
                                    buyerid:trade.consigneeId,
                                    buyeMobile:logic.mobile,
                                    buyerName:logic.contactName,
                                    buyerAddr:consigneeAddr?consigneeAddr.receiverAddress:"",
                                    itemcode:oneitem.id,
                                    code: oneitem.code,
                                    itemOnePrice:oneitem.price/100,
                                    itemNum:order.num,
                                    itemMsg:trade.buyerMessage,
                                    buyerProvince:logic.province,
                                    buyerCity:logic.city,
                                    buyerArea:consigneeAddr.receiverDistrict,
                                    //进行添加商品名称与品牌名称
                                    itemName:oneitem.title,
                                    //销售价
                                    xsprice: oneitem.price?(oneitem.price/ 100f):0,
                                    //成本价
                                    cbprice: (com.alibaba.fastjson.JSON.parseObject(oneitem?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f,
                                    brandName:mikuBrand?mikuBrand.name:"",
                                    orderId:order.id,
                                    //身份证
                                    idCard:logic.idCard,
                                    //采购价
                                    cgprice:oneitem.cgprice?(oneitem.cgprice/ 100f):0,
                                    //邮费
                                    postFee: oneitem.postFee?(oneitem.postFee/ 100f):0
                            )
                            outList.add(oneTd)
                        }
                }
        }

        buildOnePoiExcel(outList,"待发货数据")


//        def headers = ['订单号','外部订单号','单据日期','买家','联系人','联系电话','快递公司','送货地址','商品编码','商品单价','商品数量','买家留言','买家省份','买家城市','买家地区']
//        def withProperties = ['tradeid','outtradeid','createTime','buyerid','buyerName','buyeMobile','logisticsCompany','buyerAddr','itemcode','itemOnePrice','itemNum','itemMsg','buyerProvince','buyerCity','buyerArea']
//        List<CommunityTenant> profiles=new ArrayList<CommunityTenant>()
//        def obj=new CommunityTenant(communityName:"2015102910522")
//        profiles.add(obj)
//        new WebXlsxExporter().with {
////            setResponseHeaders(response,"Me.xls")
//            setResponseHeaders(response)
//            fillHeader(headers)
//            add(outList, withProperties)
//            save(response.outputStream)
//        }
    }



    //全部Excel导出
    def outPortAllExcelByTrade()
    {
        Byte type=params.byte('type')
        List<Trade> allList=new ArrayList<Trade>()
        if(type==1 as byte){
//            allList=Trade.findAllByStatusAndTypeAndReturnStatus(4 as byte,type, 0 as byte)
            def tradeCreateria=Trade.createCriteria()
            PagedResultList npagedResultList
            npagedResultList = tradeCreateria.list(max:10000, offset: 0) {
                eq('status', 4 as byte)
                eq('returnStatus', 0 as byte)
                'in'('type', [1,9,10] as byte[])
            }
            npagedResultList.iterator().each {
                Trade trade ->
                    allList.add(trade)
            }
        }
        else if (type==7 as byte){
            //找出成功的众筹订单
            List<MikuCrowdfund> mikuCrowdfundList=MikuCrowdfund.findAllByStatus(1 as byte)
            def MyTrade = Trade.createCriteria()
            PagedResultList pagedResultList
            pagedResultList = MyTrade.list(max:1000, offset: 0) {
                if (mikuCrowdfundList.size()>0){
                    'in'("crowdfundId", mikuCrowdfundList*.id)
                }else {
                    'in'("crowdfundId",-1L)
                }
                eq('status', 4 as byte)
                eq('returnStatus', 0 as byte)
                eq('type',7 as byte)
            }
            pagedResultList.iterator().each {
                Trade trade ->
                    allList.add(trade)
            }
        }
        else if(type==20 as byte){
            def alltradeCreateria=Trade.createCriteria()
            PagedResultList alltradepagedResultList
            Byte status=params.byte('status')
            alltradepagedResultList=alltradeCreateria.list(max:100000, offset: 0) {
                eq('returnStatus', 0 as byte)
                'in'('type', [1,9] as byte[])
                if(status){
                    eq('status',status)
                }else
                {
                    'in'('status', [2,4,6,5,7,9,20,8] as byte[])
                }
            }
            alltradepagedResultList.iterator().each {
                Trade trade ->
                    allList.add(trade)
            }
        }
        List<OutExcelDetail> outList=new ArrayList<OutExcelDetail>()
        allList.each {
            trade->
                //物流信息
                def  logic=Logistics.findById(trade.consigneeId)
                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logic?.consigneeId)
                int blankIndex=0
                if (logic && logic.addr?.contains('\u0001')) {
                    blankIndex = logic.addr.indexOf('\u0001')
                } else {
                    blankIndex = 0
                }
                String addrStr=logic?.addr?.substring(blankIndex)
                addrStr= addrStr.replace(logic?.city,"")
                //商品信息
                String[] ordersids=trade.orders.split(";")
                ordersids.each{
                    oid->
                        def order=Order.findById(oid)
                        Item oneitem=Item.findById(order.artificialId)
                        if (oneitem)
                        {
//                            def addrs=consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress
                            MikuBrand mikuBrand=MikuBrand.findById(oneitem.brandId)
                            OutExcelDetail oneTd=new OutExcelDetail(
                                    tradeid:trade.tradeId,
                                    outtradeid:"VC_米酷_"+trade.tradeId,
                                    logisticsCompany:"",
                                    createTime:trade.payTime?trade.payTime.toString().split(" ")[0]:"",
                                    buyerid:trade.consigneeId,
                                    buyeMobile:logic.mobile,
                                    buyerName:logic.contactName,
//                                    buyerAddr:domyAddr(logic.addr),
                                    buyerAddr:consigneeAddr?consigneeAddr.receiverAddress:"",
                                    itemcode:oneitem.id,
                                    code: oneitem.code,
                                    itemOnePrice:oneitem.price/100,
                                    itemNum:order.num,
                                    itemMsg:trade.buyerMessage,
                                    buyerProvince:logic.province,
                                    buyerCity:logic.city,
                                    buyerArea:consigneeAddr?consigneeAddr.receiverDistrict:"",
                                    //进行添加商品名称与品牌名称
                                    itemName:oneitem.title,
                                    //销售价
                                    xsprice: oneitem.price?(oneitem.price/ 100f):0,
                                    //成本价
                                    cbprice: (com.alibaba.fastjson.JSON.parseObject(oneitem?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f,
                                    brandName:mikuBrand?mikuBrand.name:"",
                                    orderId:order.id,
                                    //身份证
                                    idCard:logic.idCard,
                                    //采购价
                                    cgprice:oneitem.cgprice?(oneitem.cgprice/ 100f):0,
                                    //邮费
                                    postFee: oneitem.postFee?(oneitem.postFee/ 100f):0
                            )
                            outList.add(oneTd)
                        }
                }
        }
        buildOnePoiExcel(outList,"全部待发货数据")
    }



    def buildOnePoiExcel(List<OutExcelDetail> outList,String title)
    {

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet(title);
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
//        def headers = ['外部订单号','订单号','单据日期','买家','联系人','联系电话','快递公司','送货地址','商品编码','商品单价','商品数量','买家留言','买家省份','买家城市','买家地区']

        HSSFCell  cell = row.createCell((short) 0);
        cell.setCellValue("订单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("外部订单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("单据日期");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("买家");
        cell.setCellStyle(style);
        cell = row.createCell((short) 4);
        cell.setCellValue("联系人");
        cell.setCellStyle(style);
        cell = row.createCell((short) 5);
        cell.setCellValue("联系电话");
        cell.setCellStyle(style);
        cell = row.createCell((short) 6);
        cell.setCellValue("快递公司");
        cell.setCellStyle(style);
        cell = row.createCell((short) 7);
        cell.setCellValue("送货地址");
        cell.setCellStyle(style);
        cell = row.createCell((short) 8);
        cell.setCellValue("商品编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 9);
        cell.setCellValue("商品单价");
        cell.setCellStyle(style);
        cell = row.createCell((short) 10);
        cell.setCellValue("商品数量");
        cell.setCellStyle(style);
        cell = row.createCell((short) 11);
        cell.setCellValue("买家留言");
        cell.setCellStyle(style);
        cell = row.createCell((short) 12);
        cell.setCellValue("买家省份");
        cell.setCellStyle(style);
        cell = row.createCell((short) 13);
        cell.setCellValue("买家城市");
        cell.setCellStyle(style);
        cell = row.createCell((short) 14);
        cell.setCellValue("买家地区");
        cell.setCellStyle(style);
        cell = row.createCell((short) 15);
        cell.setCellValue("商品名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 16);
        cell.setCellValue("品牌名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 17);
        cell.setCellValue("成本价");
        cell.setCellStyle(style);
        cell = row.createCell((short) 18);
        cell.setCellValue("销售价");
        cell.setCellStyle(style);
        cell = row.createCell((short) 19);
        cell.setCellValue("身份证号码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 20);
        cell.setCellValue("拆单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 21);
        cell.setCellValue("邮费");
        cell.setCellStyle(style);
        cell = row.createCell((short) 22);
        cell.setCellValue("采购价");
        cell.setCellStyle(style);


        //def withProperties = ['tradeid','outtradeid','createTime','buyerid','buyerName','buyeMobile','logisticsCompany','buyerAddr','itemcode','itemOnePrice','itemNum','itemMsg','buyerProvince','buyerCity','buyerArea']
        for (int i = 0; i < outList.size(); i++)
        {
            row = sheet.createRow((int) i + 1);
            OutExcelDetail oneExcel=outList.get(i);
            // 第四步，创建单元格，并设置值
            row.createCell((short) 0).setCellValue(oneExcel.tradeid);
            row.createCell((short) 1).setCellValue(oneExcel.outtradeid);
            row.createCell((short) 2).setCellValue(oneExcel.createTime);
            row.createCell((short) 3).setCellValue(oneExcel.buyerid);
            row.createCell((short) 4).setCellValue(oneExcel.buyerName);
            row.createCell((short) 5).setCellValue(oneExcel.buyeMobile);
            row.createCell((short) 6).setCellValue(oneExcel.logisticsCompany);
            row.createCell((short) 7).setCellValue(oneExcel.buyerAddr);
            row.createCell((short) 8).setCellValue(oneExcel.code);
            row.createCell((short) 9).setCellValue(oneExcel.itemOnePrice);
            row.createCell((short) 10).setCellValue(oneExcel.itemNum);
            row.createCell((short) 11).setCellValue(oneExcel.itemMsg);
            row.createCell((short) 12).setCellValue(oneExcel.buyerProvince);
            row.createCell((short) 13).setCellValue(oneExcel.buyerCity);
            row.createCell((short) 14).setCellValue(oneExcel.buyerArea);
            row.createCell((short) 15).setCellValue(oneExcel.itemName);
            row.createCell((short) 16).setCellValue(oneExcel.brandName);
            row.createCell((short) 17).setCellValue(oneExcel.cbprice);
            row.createCell((short) 18).setCellValue(oneExcel.xsprice);
            row.createCell((short) 19).setCellValue(oneExcel.idCard);
            row.createCell((short) 20).setCellValue(oneExcel.orderId);
            row.createCell((short) 21).setCellValue(oneExcel.postFee);
            row.createCell((short) 22).setCellValue(oneExcel.cgprice);
        }

        // 第六步，将文件存到指定位置
        try
        {
            String path=request.getSession().getServletContext().getRealPath("")
            UUID uuid = UUID.randomUUID()
            FileOutputStream fout = new FileOutputStream(path+"\\"+uuid+".xls");
            wb.write(fout);
            fout.close();


            //提供进行下载
            // 处理中文乱码
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd")
            Calendar c = Calendar.getInstance()
            int hour = c.get(Calendar.HOUR_OF_DAY);
            int minute = c.get(Calendar.MINUTE);
            int second = c.get(Calendar.SECOND);
            String sfm=hour+"时"+minute+"分"+second+"秒"
            String downloadName=df.format(new Date()).toString()+"-"+sfm+"交易订单.xls"
            def filename = URLEncoder.encode(downloadName, "UTF-8");
//            def filename = URLEncoder.encode("交易订单.xls", "UTF-8");
            response.setHeader("Content-disposition", "attachment; filename="+filename)
            response.contentType = "application/x-rarx-rar-compressed"
            System.out.println("========================================");
            System.out.println(path);
            System.out.println("========================================");
            def out = response.outputStream
            InputStream inputStream = new FileInputStream(path+"\\"+uuid+".xls")
            byte[] buffer = new byte[1024]
            int i = -1
            while ((i = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, i)
            }
            out.flush()
            out.close()
            inputStream.close()
            new File(path+"\\"+uuid+".xls").delete();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    //处理我的地址处理
    def domyAddr(String alladdrs)
    {
        String[] strarr=alladdrs.split('\u0001')
        String str=""
        strarr.each {
            part->
                str+=part
        }
        return str
    }

}

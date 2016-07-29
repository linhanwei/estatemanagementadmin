package welink.common

import com.alibaba.fastjson.JSON
import com.alibaba.fastjson.JSONArray
import com.alibaba.fastjson.JSONObject
import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import com.welink.commons.commons.TradeEventType
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang.StringUtils
import org.apache.commons.lang3.StringUtils
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.dom4j.Document
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.core.task.TaskExecutor
import welink.ExceptionHandler
import welink.business.ModifyItemDetail
import welink.business.OneWlinfo
import welink.business.OrderDetail
import welink.business.OutExcelDetail
import welink.business.TradeDetail
import welink.estate.Community
import welink.estate.TradeSearch
import welink.system.LbsStationBaiduMapService
import welink.system.TradeEvent
import welink.system.UndeliveredTradeScheduleService
import welink.trade.TradeStatus
import welink.user.Employee
import welink.user.Profile
import welink.warehouse.MikuOrdersLogistics

import javax.annotation.Resource
import java.text.DecimalFormat

import static org.apache.commons.lang3.StringUtils.isBlank
import static org.apache.commons.lang3.StringUtils.isBlank
import static org.apache.commons.lang3.StringUtils.isBlank
import static org.apache.commons.lang3.StringUtils.isBlank


@Transactional
class TradeController {

    static Logger logger = LoggerFactory.getLogger(TradeController)

    static ImmutableMap<String, String> ORDER_ENTITY_MAP = ImmutableMap.builder() //
            .put("consignTime", "派送时间")
            .put("id", "下单时间")
            .build()

    static ImmutableMap<Long, String> TRADE_STATUS_MAP = ImmutableMap.builder() //
            .put(2, "没付款")
            .put(4, "未处理")
            .put(6, "待发货")
            .put(5, "配送中")
            .put(7, "交易成功")
            .put(9, "交易结束")
            .put(20, "分润成功")
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

    def copyItemService

    TradeDispatchedTrackService tradeDispatchedTrackService

    UndeliveredTradeScheduleService undeliveredTradeScheduleService

    def messageProcessFacadeService;

    LbsStationBaiduMapService lbsStationBaiduMapService

    @Resource(name = 'eventTaskExecutor')
    TaskExecutor eventTaskExecutor;

    MessageSendService messageSendService

    //指派发货人开始配送
    @Transactional
    def arrangeTradeCourier() {
        def tradeIds = Lists.newArrayList(params.tradeConfirmBox)
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        tradeIds.each {
            String it ->
                Long id = Long.parseLong(it)
                Trade trade = Trade.findByIdAndStatus(id, 6 as byte)
                if (trade) {
                    if (params.courierId && (params.courierId != '-1')) {
                        trade.courier = params.long('courierId')
                        trade.confirmTime = new Date()//出发时间
                        if (TradeCourier.findByTradeIdAndStatusAndType(trade.id, 1 as byte, 1025)) {
                            //重复指派,历史记录置无效
                            TradeCourier.findByTradeIdAndStatusAndType(trade.id, 1 as byte, 1025).with {
                                it.status = 0
                                it.save(failOnError: true, flush: true)
                            }
                        }
                        new TradeCourier().with {
                            tradeId = trade.id
                            employeeId = trade.courier
                            communityId = trade.communityId
                            type = 1025
                            tradeCreated = trade.dateCreated
                            confirmTime = new Date()
                            status = 1 as byte
                            save(failOnError: true, flush: true)
                        }
                    }
                    if (trade.shippingType == 1) {
                        trade.status = 7
                    } else {
                        trade.status = 5
                    }
                    trade.confirmTime = new Date()//配送时间
                    trade.timeoutActionTime = new DateTime().plusDays(3).toDate()
                    trade.save(failOnError: true, flush: true)
                    messageSendService.sendMessage(trade.tradeId,TradeEventType.TRADE_SELLER_SHIP.getTopic())
                }
        }

        tradeDispatchedTrackService.trackDispatch(employee.id, tradeIds.collect {
            Long.parseLong(it)
        })
        redirect(action: "index")
    }

    //修改订单地址
    def modifyAddr() {
        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        Trade trade = Trade.findById(params.long('id'))
        if (trade) {
            Logistics logistics = Logistics.findById(trade.consigneeId)

            if (logistics.consigneeId && params.modifyaddr) {
                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logistics.consigneeId)
                consigneeAddr.modifiAddr = params.modifyaddr
                if (logistics.save(failOnError: true, flush: true)) {
                    new TradeEmployee(tradeId: trade.id,
                            employeeId: employee.id,
                            type: 6 as byte,
                            status: 1 as byte).save(failOnError: true, flush: true)
                    render('true')
                }
            }
        }
        response.status = 405
    }

    // 取消订单
    def cancelTrade() {
        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        Long id = params.long('tid')

        Trade trade = Trade.findById(id)

        if (employee && trade && params.dealcontent) {
            trade.tradeMemo = params.dealcontent
            new TradeEmployee(tradeId: trade.id,
                    employeeId: employee.id,
                    type: 7 as byte,
                    status: 1 as byte).save(failOnError: true, flush: true)
            trade.status = 9

            trade.save(failOnError: true, flush: true)

            eventTaskExecutor.execute(new Runnable() {
                @Override
                void run() {
                    // 如果勾选了发货，那么删除 TreadSearch
                    TradeSearch.findById(trade.id)?.delete(flush: true)
                    lbsStationBaiduMapService.deleteDataInTable(trade)
                }
            })
            redirect(controller: "tradeNoShip", action: "index")
            return
        }
        response.status = 405
    }

    //订单回退
    def shipToNoShip() {
        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        Long id = params.long('tid')

        Trade trade = Trade.findById(id)

        if (employee && trade && params.dealcontent) {
            trade.tradeMemo = params.dealcontent
            new TradeEmployee(tradeId: trade.id,
                    employeeId: employee.id,
                    type: 5 as byte,
                    status: 1 as byte).save(failOnError: true, flush: true)
            trade.status = 4
            if (trade.save(failOnError: true, flush: true)) {
                // 这时候要在 tradeSearch 表里面插入一条数据

                TradeSearch.findById(trade.id)?.delete(flush: true)
                undeliveredTradeScheduleService.transform(trade)?.save(flush: true)

                tradeDispatchedTrackService.retractDispatch(employee.id, Lists.newArrayList(trade.id))
                render('true')
            }
        }
        response.status = 405

    }

    //添加备注
    def addTradeMemo() {

        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        Long id = params.long('tid')

        Trade trade = Trade.findById(id)

        if (employee && trade) {

            trade.tradeMemo = params.dealcontent

            trade.buyerMessage = params.buyerMessage

            new TradeEmployee(tradeId: trade.id,
                    employeeId: employee.id,
                    type: 4 as byte,
                    status: 1 as byte).save(failOnError: true, flush: true)
            if (trade.save(failOnError: true, flush: true)) {
                render('true')
            }
        }
        response.status = 405
    }

    //勾选确认,交易成功
    @Transactional
    def confirmTradeChecked() {

        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        def tradeIds = Lists.newArrayList(params.tradeConfirmBox)

        tradeIds.each {
            String it ->
                Long id = Long.parseLong(it)
                Trade trade = Trade.findById(id)
                if (trade && employee) {
                    //完结订单
                    trade.status = 7
                    trade.endTime = new Date()
                    trade.save(failOnError: true, flush: true)

                    //更新员工订单记录表
                    TradeCourier tradeCourier = TradeCourier.findByTradeIdAndTypeAndStatus(trade.id, 1025, 1 as byte)
                    if (tradeCourier) {
                        tradeCourier.type = 1026
                        tradeCourier.endTime = new Date()
                        tradeCourier.save(failOnError: true, flush: true)
                    }

                    //发消息发积分
                    messageSendService.sendMessage(trade.tradeId,TradeEventType.TRADE_SUCCESS.getTopic())
                }
        }
        redirect(action: "shipped")
    }

    def allTrade() {

        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //站点列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }

        // 电话号码
        String mobile = params.query

        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        String startTime = params.startTime ?: new Date().format('yyyy-MM-dd HH:mm')

        String endTime = params.endTime ?: new Date().format('yyyy-MM-dd HH:mm')

        DateTime earlistTime = formatter.parseDateTime(startTime)

        DateTime latestTime = formatter.parseDateTime(endTime)
        //查找指定时间的所有订单
        pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
//            eq('type',1 as byte)
            'in'('type', [1,9,10] as byte[])
            // 走索引
            'in'('status', [2, 4, 6, 5, 7, 9,20,8] as byte[])

//            eq('returnStatus', 0 as byte)

            if (params.long('tradeCode'))
            {
                eq('tradeId',params.long('tradeCode'))
            }

            between("dateCreated", new DateTime().minusMonths(3).toDate(), new DateTime().toDate())

            if (params.startTime && params.endTime) {
                between("dateCreated", earlistTime.toDate(), latestTime.toDate())
            }

            if (params.communityId) {
                eq('communityId', params.long('communityId'))
            }

            if (params.itemQuery) {
                def orders = Order.withCriteria {
                    ilike("title", "%" + params.itemQuery + "%")
                }
                'in'("tradeId", orders*.tradeId)
            }
            if (params.queryStatus && (params.queryStatus) != '-1') {
                Byte queryStatus = params.byte('queryStatus')
                eq('status', queryStatus)
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
            order('id', 'desc')
        }

        pagedResultList.iterator().each {
            Trade trade ->
                Logistics logistics = Logistics.findById(trade.consigneeId)
                if (logistics == null) {

                    println(trade.consigneeId)
                }

                ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logistics?.consigneeId)

                Profile profile = Profile.findById(trade.buyerId)

                int blankIndex

                if (logistics && logistics.addr.contains('\u0001')) {
                    blankIndex = logistics.addr.indexOf('\u0001')
                } else {
                    blankIndex = 0
                }



                String str=""
                List<MikuOrdersLogistics> list=MikuOrdersLogistics.findAllByTradeId(trade.tradeId)
                if(list.size()>0){
                    list.each {
                        MikuOrdersLogistics m->
                            String one=m.wlcompany+"   "+m.wlnumber+"   ("+m.orderIds+")"
                            if(list.size()>1){
                                one+="<br>"
                            }
                            str+=one
                    }
                }

                def headAddr=logistics?.addr
                //具体地址的添加
                if (logistics)
                {
//                    headAddr=logistics.country+logistics.province+logistics?.addr
                    headAddr=consigneeAddr?(consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress):""
                }
                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
//                        address: logistics?.addr?.substring(blankIndex),
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        createTime: trade.dateCreated.toString().substring(0, 19),
                        status: trade.status,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '无预约时间',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无调度时间',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无送货时间',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人',
                        buyerInfo: str,
                        //添加物流的信息
                        memo:logistics.memo
                ))
        }

        return [
                statusList   : TRADE_STATUS_MAP,
                PageMap    : PageMap,
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
    }

    //未付款订单，实时查询
    def nopay() {

        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
            eq('status',1 as byte)
        }
        // 查询语句
        String query = params.query

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        String startTime = params.startTime ?: new Date().format('yyyy-MM-dd HH:mm')

        String endTime = params.endTime ?: new Date().format('yyyy-MM-dd HH:mm')

        DateTime earlistTime = formatter.parseDateTime(startTime)

        DateTime latestTime = formatter.parseDateTime(endTime)

        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)
        //查找指定时间的所有订单
        pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 2 as byte)
//            eq('returnStatus', 0 as byte)
//            eq('type',1 as byte)
            'in'('type', [1,9,10] as byte[])
            if (params.long('tradeCode'))
            {
                eq('tradeId',params.long('tradeCode'))
            }

            if (employee.communityId != 1999L) {
//                eq('communityId', employee.communityId)
            } else if (employee.communityId == 2005L) {
//                'in'("communityId", [2005L, -1L])
            }
            if (params.communityId) {
//                eq('communityId', params.long('communityId'))
            }

            if (params.startTime && params.endTime) {
                between("dateCreated", earlistTime.toDate(), latestTime.toDate())
            }

            if (query && !(query.equals('null')) && (query.length() == 13)) {
                def logisticss = Logistics.findAllByMobile(query.replace('-', ''))
                Profile profile = Profile.findByMobile(query.replace('-', ''))
                if (profile) {
                    eq('buyerId', profile.id)
                } else if (logisticss) {
                    "in"('consigneeId', logisticss*.id)
                } else {
                    eq('id', -1 as long)
                }

            }
            order('id', 'desc')
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

                def headAddr=logistics?.addr
                //具体地址的添加
                if (logistics)
                {
                    headAddr=logistics.country+logistics.province+logistics?.addr
                }

                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        //address: logistics?.addr.substring(blankIndex),
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        createTime: trade.dateCreated.toString().substring(0, 16),
                        status: trade.status,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无调度时间',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无送货时间',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人'
                ))
        }

        return [
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
    }




    //已派单订单
    def shipped() {

        //计算订单总数
        Long tradesNum = 0
        //所有订单总额
        Long tradesTotal = 0
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

        // 配送人员列表
//        LinkedList<Employee> courierList = Employee.createCriteria().list {
//            eq('status', 1 as byte)
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

        //订单号的查询
//        def tradeCode=params.long('tradeCode')

        String query = "select sum(totalFee) from Trade where status = 5"

        if (StringUtils.isNotBlank(payType)) {
            payType = payType.toInteger()

            query += " and payType = ${payType}"
        } else {
            payType = null
        }

        if (StringUtils.isNotBlank(shippingType)) {
            shippingType = shippingType.toInteger()
            query += " and shippingType = ${shippingType}"
        } else {
            shippingType = null
        }

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        if (start != null) {
            query += " and dateCreated > ?"
        }

        if (end != null) {
            query += " and dateCreated < ?"
        }


        def completeOrder = StringUtils.EMPTY

        if (StringUtils.isNotBlank(orderEntry) && StringUtils.isNotBlank(ord)) {
            completeOrder = "${orderEntry}"
        } else {
            completeOrder = "id"
        }

        // 如果是微邻科技的，传入null，不是的传入各个站点
//        Long communityId = employee?.communityId == 1999L ? null : employee?.communityId;

//        if (StringUtils.isNotBlank(params.communityId)) {
//            communityId = Long.parseLong(params.communityId)
//        }
//
//        if (communityId != null) {
//            query += " and communityId = ${communityId}"
//        }
//        params.communityId = communityId == null ? null : "${communityId}"

        //查找指定时间的所有订单
        def t = Trade.createCriteria()
        PagedResultList pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 5 as byte)
            eq('returnStatus', 0 as byte)
//            eq('type',1 as byte)
            'in'('type', [1,9,10] as byte[])
            if (params.long('tradeCode'))
            {
                eq('tradeId',params.long('tradeCode'))
            }
//            if (communityId != null) {
//                eq('communityId', communityId)
//            }

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


            if (params.courierId) {
                def tes = TradeCourier.findAllByEmployeeIdAndTypeAndStatus(params.long('courierId'), 1025 as Integer, 1 as byte)
                if (tes) {
                    'in'("id", tes*.tradeId)
                } else {
                    eq("id", -1L)
                }
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
            order(completeOrder, (("+" == ord) ? "asc" : "desc"))
        }

        def sum

        if (start != null && end != null) {
            sum = Trade.executeQuery(query, [start, end])?.get(0) ?: 0
        } else if (start != null && end == null) {
            sum = Trade.executeQuery(query, [start])?.get(0) ?: 0
        } else if (start == null && end != null) {
            sum = Trade.executeQuery(query, [end])?.get(0) ?: 0
        } else {
            sum = Trade.executeQuery(query)?.get(0) ?: 0
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

                def headAddr=logistics?.addr
                //具体地址的添加
                if (logistics)
                {
//                    headAddr=logistics.country+logistics.province+logistics?.addr
                    headAddr=consigneeAddr?(consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress):""
                }

                String str=""
                List<MikuOrdersLogistics> list=MikuOrdersLogistics.findAllByTradeId(trade.tradeId)
                if(list.size()>0){
                    list.each {
                        MikuOrdersLogistics m->
                        String one=m.wlcompany+"   "+m.wlnumber+"   ("+m.orderIds+")"
                            if(list.size()>1){
                                one+="<br>"
                            }
                            str+=one
                    }
                }

                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        //address: logistics?.addr.substring(blankIndex),
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        status: trade.status,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        createTime: trade.dateCreated.toString().substring(0, 19),
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '未预约',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无记录',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无记录',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人',
                        buyerInfo: str,
                        //添加物流的信息
                        memo:logistics.memo
                ))
        }
        return [
                communityList  : communityList,
                total          : pagedResultList?.totalCount,
                params         : params,
                tradeList      : pagedResultList,
                tradeMap       : tradeMap,
                itemList       : itemList,
                itemMap        : itemMap,
                TradesNum      : tradesNum,
                TradesTotal    : tradesTotal,
                tradeDetailMap : tradeDetailMap,
                payTypeMap     : TradeNoShipController.PAY_TYPE_MAP,
                shippingTypeMap: TradeNoShipController.SHIPPING_TYPE_MAP,
                totalFeeOpMap  : TradeNoShipController.TOTAL_FEE_OP_MAP,
                orderMap       : TradeNoShipController.ORDER_MAP,
                orderEntryMap  : ORDER_ENTITY_MAP,
                PageMap    : PageMap,
                allTotalFee    : sum
        ]
    }

    //将未付款的单进行手工进行取消订单的状态：status-->9
    @Transactional
    def cancelOneTrade(){
        def id=params.long('id')
        Trade trade=Trade.findByTradeId(id)
        if (trade){
            trade.status=9 as byte
            trade.save(failOnError: true, flush: true)
        }
        render('true')
    }



    //未发货订单
    def index() {

        //计算订单总数
        Long tradesNum = 0
        //所有订单总额
        Long tradesTotal = 0
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

//       这里就只有一个地方:米酷商城
//        Community community = new Community()
//        community.setId(-1L)
//        community.setName("微邻科技")
//
//        // 加入其它小区
//        communityList.add(community)

        // 获得现在的操作用户

        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        // 配送人员列表
        LinkedList<Employee> courierList = Employee.createCriteria().list {
            eq('status', 1 as byte)
            if (employee.communityId != 1999L) {
                eq('communityId', employee.communityId)
            }
            if (params.communityId) {
                eq('communityId', params.long('communityId'))
            }
            order("id", "asc")
        }

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

        //订单号的查询
        def tradeCode=params.long('tradeCode')

        String query = "select sum(totalFee) from Trade where status = 5"

        if (StringUtils.isNotBlank(payType)) {
            payType = payType.toInteger()

            query += " and payType = ${payType}"
        } else {
            payType = null
        }

        if (StringUtils.isNotBlank(shippingType)) {
            shippingType = shippingType.toInteger()
            query += " and shippingType = ${shippingType}"
        } else {
            shippingType = null
        }

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        if (start != null) {
            query += " and dateCreated > ?"
        }

        if (end != null) {
            query += " and dateCreated < ?"
        }


        def completeOrder = StringUtils.EMPTY

        if (StringUtils.isNotBlank(orderEntry) && StringUtils.isNotBlank(ord)) {
            completeOrder = "${orderEntry}"
        } else {
            completeOrder = "id"
        }

        // 如果是微邻科技的，传入null，不是的传入各个站点
        Long communityId = employee?.communityId == 1999L ? null : employee?.communityId;

        if (StringUtils.isNotBlank(params.communityId)) {
            communityId = Long.parseLong(params.communityId)
        }

        if (communityId != null) {
            query += " and communityId = ${communityId}"
        }

        params.communityId = communityId == null ? null : "${communityId}"

        //查找指定时间的所有订单
        def t = Trade.createCriteria()
        PagedResultList pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 6 as byte)
            eq('returnStatus', 0 as byte)
//            eq('type',1 as byte)
            'in'('type', [1,9,10] as byte[])
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
            }

//            if (employee.communityId != 1999L) {
//                eq('communityId', employee.communityId)
//            } else if (employee.communityId == 2005L) {
//                'in'("communityId", [2005L, -1L])
//            }
//            if (params.communityId) {
//                eq('communityId', params.long('communityId'))
//            }

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


            if (params.courierId) {
                def tes = TradeCourier.findAllByEmployeeIdAndTypeAndStatus(params.long('courierId'), 1025 as Integer, 1 as byte)
                if (tes) {
                    'in'("id", tes*.tradeId)
                } else {
                    eq("id", -1L)
                }
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
            order(completeOrder, (("+" == ord) ? "asc" : "desc"))
        }

        def sum

        if (start != null && end != null) {
            sum = Trade.executeQuery(query, [start, end])?.get(0) ?: 0
        } else if (start != null && end == null) {
            sum = Trade.executeQuery(query, [start])?.get(0) ?: 0
        } else if (start == null && end != null) {
            sum = Trade.executeQuery(query, [end])?.get(0) ?: 0
        } else {
            sum = Trade.executeQuery(query)?.get(0) ?: 0
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

                def headAddr=logistics?.addr
                //具体地址的添加
                if (logistics)
                {
//                    headAddr=logistics.country+logistics.province+logistics?.addr
                    headAddr=consigneeAddr?(consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress):""
                }

                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        //address: logistics?.addr.substring(blankIndex),
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        status: trade.status,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        createTime: trade.dateCreated.toString().substring(0, 19),
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '未预约',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无记录',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无记录',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人'
                ))
        }

        return [
                courierList    : courierList,
                communityList  : communityList,
                total          : pagedResultList?.totalCount,
                params         : params,
                tradeList      : pagedResultList,
                tradeMap       : tradeMap,
                itemList       : itemList,
                PageMap    : PageMap,
                itemMap        : itemMap,
                TradesNum      : tradesNum,
                TradesTotal    : tradesTotal,
                tradeDetailMap : tradeDetailMap,
                payTypeMap     : TradeNoShipController.PAY_TYPE_MAP,
                shippingTypeMap: TradeNoShipController.SHIPPING_TYPE_MAP,
                totalFeeOpMap  : TradeNoShipController.TOTAL_FEE_OP_MAP,
                orderMap       : TradeNoShipController.ORDER_MAP,
                orderEntryMap  : ORDER_ENTITY_MAP,
                allTotalFee    : sum
        ]
    }


    //撤销让商品的status回到5--->6
    def goCancel()
    {
        def ids=params.goCancelids
        String[] idsarr=ids.split(",")
        idsarr.each {
            id->
                def  trade=Trade.findById(Long.parseLong(id))
                //物流信息
                def  logic=Logistics.findById(trade.consigneeId)
                logic.memo=""
                logic.save(failOnError: true, flush: true)
                trade.status=6 as byte
                trade.save(failOnError: true, flush: true)

                //进行对物流表的操作
                List<MikuOrdersLogistics> list=MikuOrdersLogistics.findByTradeIdAndIsDelete(trade.tradeId,0 as byte)
                list.each {
                    MikuOrdersLogistics mikuOrdersLogistics->
                        mikuOrdersLogistics.with {
                            it.lastUpdated=new Date()
                            it.isDelete=1 as byte
                            it.save(failOnError: true, flush: true)
                        }
                }
        }





        redirect(controller: 'trade', action: 'shipped')
        return;
    }


    //撤销商品到未处理 status 6-->4
    def goCancelToWcl()
    {
        def ids=params.goCancelids
        String[] idsarr=ids.split(",")
        idsarr.each {
            id->
                def  trade=Trade.findById(Long.parseLong(id))
                trade.status=4 as byte
                trade.save(failOnError: true, flush: true)
        }
        redirect(controller: 'trade', action: 'index')
        return;
    }

    //查看某一trade详情
    def lookTradeDetail() {

        Long tradeId = params.long('tradeId')

        Trade trade = Trade.findByTradeId(tradeId)

        List<OrderDetail> orderList = new ArrayList<OrderDetail>()

        def orderIds = trade.orders.split(';')

        orderIds.iterator().each {
            String id ->
                Order order = Order.findById(Long.parseLong(id))
                if (order) {
                    orderList.add(new OrderDetail(
                            itemName: order?.title,
                            orderId: order?.id,
                            itemNum: order?.num,
                            itemPrice: order?.price,
                            orderPrice: order?.totalFee))
                }
        }
        //该地址对应的ID
        Logistics logistics = Logistics.findById(trade.consigneeId)

        ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logistics?.consigneeId)

        Profile profile = Profile.findById(trade.buyerId)

        AlipayBack alipayBack = AlipayBack.findByOutTradeNo(trade.tradeId)

        int blankIndex

        if (logistics && logistics.addr.contains('\u0001')) {
            blankIndex = logistics.addr.indexOf('\u0001')
        } else {
            blankIndex = 0
        }

        def headAddr=logistics?.addr
        //具体地址的添加
        if (logistics)
        {
            headAddr=logistics.country+logistics.province+logistics?.addr
        }

        //增加用户的电话号码与用户id，名称
        String username="",userId="",userMobile=""
        Profile myprof=Profile.findById(trade.buyerId)
        if (myprof){
            username=myprof.nickname
            userId=myprof.id
            userMobile=myprof.mobile
        }

        TradeDetail tradeDetail = new TradeDetail(
                profileAlipay: alipayBack?.buyerEmail,
                tradeId: trade.tradeId,
                profileMobile: profile?.mobile,
                communityName: Community.findById(trade?.communityId)?.name,
                //address: logistics?.addr.substring(blankIndex),
                address: headAddr,
                modifiAddr: consigneeAddr?.modifiAddr,
                receiverName: logistics?.contactName,
                receiverMobile: logistics?.mobile,
                totalPrice: trade.totalFee,
                createTime: trade.dateCreated.toString().substring(0, 16),
                status: trade.status,
                OrderList: orderList,
                tradeMemo: trade?.tradeMemo,
                buyerMessage: trade?.buyerMessage ?: '无备注',
                courierName: trade?.courier ? Employee.findById(trade.courier)?.name : '没有发货人',
                courierMobile: trade?.courier ? Employee.findById(trade.courier)?.mobile : '没有电话',
                confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无送货时间',
                endTime: trade?.endTime ? trade?.endTime.toString().substring(0, 16) : '未确认收货',
                buyerInfo:(username+"  "+userMobile)
        )

        render(template: "tradeDetail", model: [
                trade      : trade,
                tradeDetail: tradeDetail,
                orderList  : orderList,
                username:username,
                userId:userId,
                userMobile:userMobile,
                total      : orderList.size()
        ])
    }

    //下载模板
    def downloadExcel()
    {
//        response.reset(); //非常重要
        // 处理中文乱码
        def filename = URLEncoder.encode("模板.xls", "UTF-8");
        response.setHeader("Content-disposition", "attachment; filename="+filename)
        response.contentType = "application/x-rarx-rar-compressed"
        String path=request.getSession().getServletContext().getRealPath("")+"\\Excel.xls"
        System.out.println("========================================");
        System.out.println(path);
        System.out.println("========================================");
        def out = response.outputStream
        InputStream inputStream = new FileInputStream(path)
        byte[] buffer = new byte[1024]
        int i = -1
        while ((i = inputStream.read(buffer)) != -1) {
            out.write(buffer, 0, i)
        }
        out.flush()
        out.close()
        inputStream.close()
    }



    def createOneExcel()
    {
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("模板");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("外部订单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("物流单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("物流公司");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("拆单号");
        cell.setCellStyle(style);

        //说明
        row = sheet.createRow(1);
        row.createCell((short) 0).setCellValue("VC_米酷_4234234325[说明:外部订单一定需要以(VC_米酷_)开头,导入之前需要去掉空格]");
        row.createCell((short) 1).setCellValue("miku445354645[说明:对应的物流单号必须以(miku)开头,导入之前需要去掉空格]");
        row.createCell((short) 2).setCellValue("中通速递[说明:中国物流公司名称]");
        row.createCell((short) 3).setCellValue("9643[说明:后台一定需要此数据，导入之前需要去掉空格]");


        row = sheet.createRow(2);
        row.createCell((short) 0).setCellValue("请后台导单人员必须按照的此格式进行导单");

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
            def filename = URLEncoder.encode("模板.xls", "UTF-8");
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




    //导入进行修改对应商品信息
    @Transactional
    def modifyItemInfo(){
        def uploadedFile = request.getFile('myFile')
        String path=request.getSession().getServletContext().getRealPath("")
        //新建的文件目录
        File newFile=new File(path)
        if (!newFile.exists())
        {
            newFile.mkdirs()
        }
        UUID uuid = UUID.randomUUID()
        path=path+uuid+".xls"
        println path
        //新建的文件
        File newBuildFile=new File(path)
        uploadedFile.transferTo(newBuildFile)
        InputStream is=new FileInputStream(path)
        String[] title=readExcelTitle(is)
        System.out.println("获得Excel表格的标题:")
        for (String s:title){
            println(s+" ")
        }
        InputStream is2=new FileInputStream(path)
        Map<Integer, String> map = readExcelContent(is2);
        System.out.println("========================================")
        System.out.println("获得Excel表格的内容:");
        for (int i = 1; i <= map.size(); i++) {
            System.out.println(map.get(i));
        }
        System.out.println("========================================")

        //删除文件
        newBuildFile.delete();
        List<ModifyItemDetail> outList=getModifyItemInfo(title,map)
        for (int i=0;i<outList.size();i++){
            modifySomeItemInfo(outList.get(i))
        }
        redirect(controller: 'shopItemManager', action: 'index')
        return;

    }









    //导入的是只需要对应excel表内的数据
    @Transactional
    def midifyCategroy(){
        def uploadedFile = request.getFile('myFile')
        String path=request.getSession().getServletContext().getRealPath("")
        //新建的文件目录
        File newFile=new File(path)
        if (!newFile.exists())
        {
            newFile.mkdirs()
        }
        UUID uuid = UUID.randomUUID()
        path=path+uuid+".xls"
        println path
        //新建的文件
        File newBuildFile=new File(path)
        uploadedFile.transferTo(newBuildFile)
        InputStream is=new FileInputStream(path)
        String[] title=readExcelTitle(is)
        InputStream is2=new FileInputStream(path)
        Map<Integer, String> map = readExcelContent(is2);
        System.out.println("========================================")
        //删除文件
        newBuildFile.delete();
        //主要的是读取里面的内容
        List<ModifyItemDetail> outList=getItemCategory(title,map)
        for (int i=0;i<outList.size();i++){
            modifySomeItemCategoryInfo(outList.get(i))
        }
        redirect(controller: 'shopItemManager', action: 'index')
        return;

    }



    //进行对商品进行批量修改类目信息
    @Transactional
    def modifySomeItemCategoryInfo(ModifyItemDetail modifyItemDetail){
        Item item=Item.findById(Long.parseLong(modifyItemDetail.id))
        if (item)
        {
            Long twoLevel=0L
            Long oneLevel=0L
            Long threeLevel=0L
            //仅仅是3级类目id
            //查询出的2级类目Id
            if(modifyItemDetail.categoryId && modifyItemDetail.categoryId.trim().length()){
                threeLevel=Long.parseLong(modifyItemDetail.categoryId)
                Category category=Category.findById(threeLevel)
                if(category){
                    twoLevel=category.parentId
                    Category twocategory=Category.findById(twoLevel)
                    if (twocategory){
                        oneLevel=twocategory.parentId
                    }
                }
            }else if (modifyItemDetail.twocategoryId && modifyItemDetail.twocategoryId.trim().length()){
                twoLevel=Long.parseLong(modifyItemDetail.twocategoryId)
                Category category=Category.findById(twoLevel)
                if(category){
                    oneLevel=category.parentId
                    threeLevel=null
                }
            }



            //采购价
            Long cgprice=new BigDecimal(modifyItemDetail.cgprice)*100L

            //邮费
            Long postFee=new BigDecimal(modifyItemDetail.postFee)*100L

            //更新item信息
            item.with {
                it.categoryId=threeLevel
                it.cgprice=cgprice
                it.postFee=postFee
                it.category1_id=oneLevel
                it.category2_id=twoLevel
                it.save(failOnError: true, flush: true)
            }

            //再进行更新上架的商品
            Item onsaleItem=Item.findByBaseItemId(item.id)
            if (onsaleItem){
                onsaleItem.with {
                    it.cgprice=cgprice
                    it.postFee=postFee
                    it.categoryId=threeLevel
                    it.category1_id=oneLevel
                    it.category2_id=twoLevel
                    it.save(failOnError: true, flush: true)
                }
            }
        }
    }




    //进行对商品进行批量修改
    @Transactional
    def modifySomeItemInfo(ModifyItemDetail modifyItemDetail)
    {
        Item item=Item.findById(Long.parseLong(modifyItemDetail.id))
        if (item)
        {
            def map = [:]
            Category category=new Category()
            MikuBrand mikuBrand=new MikuBrand()
            //成本价
            Long purchasingPrice =new BigDecimal(modifyItemDetail.cbPrice)*100L
            //平台利润
            Long itemProfitFee=new BigDecimal(modifyItemDetail.ptLirun)*100L
            //销售价
            Long xsPrice=new BigDecimal(modifyItemDetail.xsPrice)*100L
            //参考价
            Long jyPrice=(modifyItemDetail.ckPrice)?(new BigDecimal(modifyItemDetail.ckPrice)*100L):(xsPrice*1.5)
            //可分利润
            Long kfLiRun=(xsPrice-purchasingPrice-itemProfitFee)
            //库存
            Integer num=Integer.parseInt(modifyItemDetail.num)
            Integer weight=Integer.parseInt(modifyItemDetail.weight)
            //关键字
            String keyWord=modifyItemDetail.keyWord
            //具体里面的参数
            def obj=com.alibaba.fastjson.JSON.parse(item.features)
            //采购价
            Long cgprice=(modifyItemDetail.cgprice)?new BigDecimal(modifyItemDetail.cgprice)*100L:0L

            //邮费
            Long postFee=(modifyItemDetail.postFee)?new BigDecimal(modifyItemDetail.postFee)*100L:0L

            //类目的修改
            if (modifyItemDetail.categroyName){
                category=Category.findByName(modifyItemDetail.categroyName)
            }
            //品牌的修改
            if (modifyItemDetail.brandName){
                mikuBrand=MikuBrand.findByName(modifyItemDetail.brandName)
            }

            //添加2个修改值
            Byte istaxFree=("是".equals(modifyItemDetail.isTaxFreeInfo))?(1 as byte):(0 as byte)
            Byte isrefund=("是".equals(modifyItemDetail.isrefundInfo))?(1 as byte):(0 as byte)

            if (obj){
                //里面的参数【map中的ext里面的内容】
                def content=obj.get('ext')
                map.put('ext',com.alibaba.fastjson.JSON.parseObject(modifyItemDetail.itemAttribute?modifyItemDetail.itemAttribute:""))
                map.put('referencePrice',jyPrice)
                map.put('purchasingPrice',purchasingPrice)
            }
            //A.修改的是商品本身的信息
            item.with {
                it.title=modifyItemDetail.name
                it.code=modifyItemDetail.code
                it.lastUpdated=new Date()
                //销售价
                it.price=xsPrice
                it.features=com.alibaba.fastjson.JSON.toJSONString(map)
                //仓库中的商品进行显示，上架中商品进行下架
//                it.approveStatus= 0 as byte
                it.approveStatus= 1 as byte
                //视频链接
                it.video=modifyItemDetail.video
                //规格
                it.specification=modifyItemDetail.specification?modifyItemDetail.specification:it.specification
                //关键字
                it.keyWord=keyWord
                //库存
                if (num){
                    it.num=num
                }
                //销售基数
                if (modifyItemDetail.baseSoldQuantity){
                    it.baseSoldQuantity=Integer.parseInt(modifyItemDetail.baseSoldQuantity)
                }
                //商品描述
                it.description=modifyItemDetail.description
                //权重的修改
                if (weight){
                    it.weight=weight
                }
                if (category)
                {
                    it.categoryId=category.id
                }
                if (mikuBrand){
                    it.brandId=mikuBrand.id
                }
                //是否退货与免税
                it.isTaxFree=istaxFree
                it.isrefund=isrefund
                if(cgprice){
                    it.cgprice=cgprice
                }
                if(postFee){
                    it.postFee=postFee
                }

                it.save(failOnError: true, flush: true)
            }
            //在上架对应的商品
            Item baseItem=Item.findById(item.baseItemId)
            if (baseItem){
                if (weight){
                    baseItem.weight=weight
                }
                baseItem.keyWord=keyWord
                baseItem.with {
                    it.title=modifyItemDetail.name
                    it.code=modifyItemDetail.code
                    it.lastUpdated=new Date()
                    //销售价
                    it.price=new BigDecimal(modifyItemDetail.xsPrice)*100L
                    it.features=com.alibaba.fastjson.JSON.toJSONString(map)
                    //仓库中的商品进行显示，上架中商品进行下架
//                    it.approveStatus= 0 as byte
                    it.approveStatus= 1 as byte
                    //视频链接
                    it.video=modifyItemDetail.video
                    //规格
                    it.specification=modifyItemDetail.specification?modifyItemDetail.specification:it.specification

                    //库存
                    if (num){
                        it.num=num
                    }
                    //销售基数
                    if (modifyItemDetail.baseSoldQuantity){
                        it.baseSoldQuantity=Integer.parseInt(modifyItemDetail.baseSoldQuantity)
                    }
                    //商品描述
                    it.description=modifyItemDetail.description
                    if (category)
                    {
                        it.categoryId=category.id
                    }
                    if (mikuBrand){
                        it.brandId=mikuBrand.id
                    }
                    //权重的修改
//                    if (weight){
//                        it.weight=weight
//                    }
                    //是否退货与免税
                    it.isTaxFree=istaxFree
                    it.isrefund=isrefund
                    if(cgprice){
                        it.cgprice=cgprice
                    }
                    if(postFee){
                        it.postFee=postFee
                    }
                    it.save(failOnError: true, flush: true)
                }
                //再进行改分润信息表里面的内容【直接改对应的分润信息表的内容】
                MikuItemSharePara mkitemshare =MikuItemSharePara.findByItemId(baseItem.id)
                if (mkitemshare){
                    mkitemshare.with {
                        //平台利润
                        it.itemProfitFee=itemProfitFee
                        //成本价
                        it.itemCostFee=purchasingPrice
                        //可分利润
                        it.itemShareFee=kfLiRun
                        it.dateCreated=new Date()
                        it.save(failOnError: true, flush: true)
                    }
                }
            }
        }
    }







    //批量导入的功能
    def inputPortExcelByTrade()
    {
        Byte type=params.byte('type')
        //handle uploaded file
        def uploadedFile = request.getFile('myFile')
        if(!uploadedFile.empty){
            println "Class: ${uploadedFile.class}"
            println "Name: ${uploadedFile.name}"
            println "OriginalFileName: ${uploadedFile.originalFilename}"
            println "Size: ${uploadedFile.size}"
            println "ContentType: ${uploadedFile.contentType}"
        }
        String path=request.getSession().getServletContext().getRealPath("")
        UUID uuid = UUID.randomUUID()
        path=path+"myFile\\"
        //新建的文件目录
        File newFile=new File(path)
        if (!newFile.exists())
        {
            newFile.mkdirs()
        }
        path=path+uuid+".xls"
        println path
        //新建的文件
        File newBuildFile=new File(path)
        uploadedFile.transferTo(newBuildFile)
        InputStream is=new FileInputStream(path)
        String[] title=readExcelTitle(is)
        System.out.println("获得Excel表格的标题:")
        for (String s:title){
            println(s+" ")
        }

        InputStream is2=new FileInputStream(path)
        Map<Integer, String> map = readExcelContent(is2);
        System.out.println("========================================");
        System.out.println("获得Excel表格的内容:");
        for (int i = 1; i <= map.size(); i++) {
            System.out.println(map.get(i));
        }
        System.out.println("========================================");

        //删除文件
        newBuildFile.delete();
        //获取对应的对象
        List<OutExcelDetail> outlist=doExcelContentToObj(title,map);
//        List<OutExcelModel> outlist=doExcelContentToObj(title,map);
        outlist.each {
            oneExcelObj->
                Trade trade=Trade.findByTradeId(Long.parseLong(oneExcelObj.tradeid))
                if (trade)
                {
                    String json
                    def  logic=Logistics.findById(trade.consigneeId)
                    if(logic){
                        String wldh=oneExcelObj.logisticsWuLiuCode
                        String wlgs=oneExcelObj.logisticsCompany
                        String orderId=oneExcelObj.orderIdStr.toString().replace(".0","")
                        MikuOrdersLogistics mikuOrdersLogistics=MikuOrdersLogistics.findByTradeIdAndWlnumber(trade.tradeId,wldh);
                        if(mikuOrdersLogistics){
                            String orderIds=mikuOrdersLogistics.orderIds
                            def arrstr=orderIds.split(";")
                            boolean bsflag=true
                            for(int j=0;j<arrstr.size();j++){
                                if(orderId.equals(arrstr[j])){
                                    bsflag=false
                                    break
                                }
                            }
                            if (bsflag){
                                int iz=0
                                mikuOrdersLogistics.orderIds=(orderIds+";"+orderId)
                                mikuOrdersLogistics.save(failOnError: true, flush: true)
                            }
                        }else{
                            MikuOrdersLogistics newonedata=new MikuOrdersLogistics()
                            newonedata.with {
                                it.tradeId=trade.tradeId
                                it.logisticsId=logic.id
                                it.wlcompany=wlgs
                                it.dateCreated=new Date()
                                it.lastUpdated=new Date()
                                it.ismainc=getIsMainFlag(wlgs)?1 as byte:0 as byte
                                it.wlsnumber=gewlcompanySimple(wlgs)
                                it.wlnumber=oneExcelObj.logisticsWuLiuCode
                                it.status=0 as byte
                                it.state=0 as byte
                                it.dateCreated=new Date()
                                it.lastUpdated=new Date()
                                it.orderIds=orderId
                                it.memo="正常商品订单物流"
                                it.save(failOnError: true, flush: true)
                            }
                        }
                        def hashMap = [:]
                        hashMap.put("外部单号",oneExcelObj.outtradeid)
                        hashMap.put("物流单号",oneExcelObj.logisticsWuLiuCode)
                        hashMap.put("物流公司",oneExcelObj.logisticsCompany)
                        json=com.alibaba.fastjson.JSON.toJSONString(hashMap)
                        logic.with {
                            it.memo=json
                            it.save(failOnError: true, flush: true)
                        }
                    }
                    //trade的状态status  6--->5
                    trade.with {
                        it.status=5 as byte
                        it.confirmTime=new Date()
                        it.timeoutActionTime=new DateTime().plusDays(7).toDate()
                        it.save(failOnError: true, flush: true)
                    }
                    //消息的发送
//                    messageSendService.sendMessage(trade.tradeId,TradeEventType.TRADE_SELLER_SHIP.getTopic())
                }
        }
        if (type == 1 as byte){
            redirect(controller: 'trade', action: 'shipped')
        }else if(type == 7 as byte){
            redirect(controller: 'mikuCrowdfundTrade', action: 'shipped')
        }
        return;
    }

    //判断是否是主流的快递公司
    def getIsMainFlag(String str){
        String[] arr=['EMS','中通速递','申通E物流','邮政国内小包','申通','顺丰','圆通速递','韵达快递','顺丰快递','申通快递','顺丰','韵达','中通','邮政','中通快递','圆通快递'] as String[]
        boolean flag=false
        for(int j=0;j<arr.length;j++){
            if(str.equals(arr[j])){
                flag=true
                break
            }
        }
        return  flag
    }


    //获取的是快递公司的简码
    def gewlcompanySimple(String info){
        Map<String,String> map=new HashMap<String,String>();
        map.put("EMS", "ems");
        map.put("中通速递", "zhongtong");
        map.put("中通", "zhongtong");
        map.put("中通快递", "zhongtong");
        map.put("申通", "shentong");
        map.put("申通E物流", "shentong");
        map.put("邮政国内小包", "youzhengguonei");
        map.put("云栈百世汇通", "huitongkuaidi");
        map.put("百世汇通", "huitongkuaidi");
        map.put("申通", "shentong");
        map.put("顺丰快递", "shunfeng");
        map.put("圆通速递", "yuantong");
        map.put("圆通", "yuantong");
        map.put("圆通快递", "yuantong");
        map.put("韵达快运", "yunda");
        map.put("韵达快递", "yunda");
        map.put("韵达", "yunda");
        map.put("顺丰", "shunfeng");
        map.put("天天快递", "tiantian");
        map.put("天天", "tiantian");
        String rinfo=map.get(info);
        return rinfo;
    }


    //获取的是对应物流信息，也就是去重啦
    //对象集合
    def getWuLiuByNum(List<OneWlinfo> list){
        Map map=new HashMap()
        String str=""
        for(int i=0;i<list.size();i++){
            OneWlinfo one=list.get(i)
            map.put(one.wlnumber,one.wlcompany)
        }
        //进行遍历对应的Map集合
        List<OneWlinfo> newlist=new ArrayList<OneWlinfo>()
        for (String key:map.keySet()){
            OneWlinfo newdata=new OneWlinfo()
            newdata.wlcompany=map.get(key)
            newdata.wlnumber=key
            newlist.add(newdata)
        }
        return newlist
    }

    //字符串
    def getWuLiuByNumStr(List<OneWlinfo> list){
        Map map=new HashMap()
        String str=""
        for(int i=0;i<list.size();i++){
            OneWlinfo one=list.get(i)
            map.put(one.wlnumber,one.wlcompany)
        }
        for (String key:map.keySet()){
            str+=map.get(key)
            str+=":"
            str+=key
            str+=" "
        }
        return str
    }




    //发货的功能
    def sendOneTradeFromDo(){
        Byte type=params.byte('type')
        Long tradeid=params.long('tradeId')
        String wuliuNum=params.wuliuNum
        String wuliuCompany=params.wuliuCompany
        Trade trade=Trade.findByTradeId(tradeid)
        def hashMap = [:]
        hashMap.put("物流单号",wuliuNum)
        hashMap.put("物流公司",wuliuCompany)
        def  logic=Logistics.findById(trade.consigneeId)
        String json=com.alibaba.fastjson.JSON.toJSONString(hashMap)


        //进行对多单物流信息添加
        String[] arr=(trade.orders).split(';')
        List<String> strlist=new ArrayList<String>()
        String finalorders=""
        if (arr.length==1){
            finalorders=trade.orders
        }else{
            for (int i=0;i<arr.size();i++){
                Order order=Order.findById(arr[i])
                if (!("运费").equals(order.title)){
                    strlist.add(order.id)
                }
            }
            finalorders= StringUtils.join(strlist,";")
        }
        MikuOrdersLogistics mikuOrdersLogistics=new MikuOrdersLogistics()
        mikuOrdersLogistics.with {
            it.tradeId=tradeid
            it.logisticsId=logic.id
            it.wlcompany=wuliuCompany
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.ismainc=getIsMainFlag(wuliuCompany)?1 as byte:0 as byte
            it.wlsnumber=gewlcompanySimple(wuliuCompany)
            it.wlnumber=wuliuNum
            it.status=0 as byte
            it.state=0 as byte
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.orderIds=finalorders
            it.memo="正常商品订单物流"
            it.save(failOnError: true, flush: true)
        }


        logic.with {
            it.memo=json
            it.save(failOnError: true, flush: true)
        }
        //trade的状态status  6--->5
        trade.with {
            it.status=5 as byte
            it.confirmTime=new Date()
            it.timeoutActionTime=new DateTime().plusDays(7).toDate()
            it.save(failOnError: true, flush: true)
        }
        //消息的发送
//        messageSendService.sendMessage(trade.tradeId,TradeEventType.TRADE_SELLER_SHIP.getTopic())
        if (type == 1 as  byte){
            redirect(controller: 'trade', action: 'shipped')
        }else if (type == 7 as  byte){
            redirect(controller: 'mikuCrowdfundTrade', action: 'shipped')
        }else if (type == 12 as  byte){
            redirect(controller: 'mikuCustomizedOrder', action: 'shipped')
        }
    }


    //获取需要修改商品的信息
    def getItemCategory(String[] titleArr,Map<Integer, String> map){
        List<ModifyItemDetail> outlist=new ArrayList<ModifyItemDetail>()
        for (int i=1;i<=map.size();i++)
        {
            String[] contentArr=map.get(i).split("##");
            ModifyItemDetail one=new ModifyItemDetail()
            for (int j=0;j<titleArr.length;j++)
            {
                switch (titleArr[j]){
                    case "商品id":
                        one.id=contentArr[j].substring(0,contentArr[j].indexOf('.'));
                        break;
                    case "一级类目ID":
                        one.onwcategoryId=contentArr[j].toString().replace("a","");
                        break;
                    case "二级类目ID":
                        one.twocategoryId=contentArr[j].toString().replace("b","");
                        break;
                    case "三级类目ID":
                        one.categoryId=contentArr[j].toString().replace("c","");
                        break;
                    case "采购价":
                        one.cgprice=contentArr[j];
                        break;
                    case "邮费":
                        one.postFee=contentArr[j];
                        break;
                    case "成本价":
                        one.cbPrice=contentArr[j];
                        break;
                }
            }
            outlist.add(one);
        }
        return outlist;
    }




    //获取需要修改的商品信息
    def getModifyItemInfo(String[] titleArr,Map<Integer, String> map){
        List<ModifyItemDetail> outlist=new ArrayList<ModifyItemDetail>()
        for (int i=1;i<=map.size();i++)
        {
            String[] contentArr=map.get(i).split("##");
            ModifyItemDetail one=new ModifyItemDetail()
            for (int j=0;j<titleArr.length;j++)
            {
//                DecimalFormat df =new DecimalFormat("0");
                switch (titleArr[j]){
                    case "商品id":
//                        one.id=contentArr[j];
                        one.id=contentArr[j].substring(0,contentArr[j].indexOf('.'));
                        break;
                    case "商品名称":
                        one.name=contentArr[j];
                        break;
                    case "商品编码":
                        one.code=contentArr[j];
                        break;
                    case "品牌":
                        one.brandName=contentArr[j];
                        break;
                    case "销售价":
                        one.xsPrice=contentArr[j];
                        break;
                    case "成本价":
                        one.cbPrice=contentArr[j];
                        break;
                    case "平台利润":
                        one.ptLirun=contentArr[j];
                        break;
                    case "类目":
                        one.categroyName=contentArr[j];
                        break;
                    case "图片信息":
                        one.imgInfo=contentArr[j];
                        break;
                    case "参考价":
                        one.ckPrice=contentArr[j];
                        break;
                    case "规格":
                        one.specification=contentArr[j];
                        break;
                    case "库存":
//                        one.num=contentArr[j];
                        one.num=contentArr[j].substring(0,contentArr[j].indexOf('.'));
                        break;
                    case "销售基数":
//                        one.baseSoldQuantity=contentArr[j];
                        one.baseSoldQuantity=contentArr[j].substring(0,contentArr[j].indexOf('.'));
                        break;
                    case "商品描述":
                        one.description=contentArr[j];
                        break;
                    case "具体描述":
                        one.itemAttribute=contentArr[j];
                        break;
                    case "视频链接":
                        one.video=contentArr[j];
                        break;
                    case "权重":
//                        one.weight=contentArr[j];
                        one.weight=contentArr[j].substring(0,contentArr[j].indexOf('.'));
                        break;
                    case "关键字":
                        one.keyWord=contentArr[j];
                        break;
                    case "是否免税":
                        one.isTaxFreeInfo=contentArr[j];
                        break;
                    case "是否可退货":
                        one.isrefundInfo=contentArr[j];
                        break;
                    case "是否可退货":
                        one.isrefundInfo=contentArr[j];
                        break;
                    case "是否可退货":
                        one.isrefundInfo=contentArr[j];
                        break;
                    case "采购价":
                        one.cgprice=contentArr[j];
                        break;
                    case "邮费":
                        one.postFee=contentArr[j];
                        break;
                }
            }
            outlist.add(one);
        }
        return outlist;
    }






    //处理Excel内容的对象
    //外部单号 物流单号 物流公司  买家留言  订单号
    def doExcelContentToObj(String[] titleArr,Map<Integer, String> map)
    {
        List<OutExcelDetail> outlist=new ArrayList<OutExcelDetail>();
        for (int i=1;i<=map.size();i++)
        {
            String[] contentArr=map.get(i).split("##");
            OutExcelDetail one=new OutExcelDetail();
            for (int j=0;j<titleArr.length;j++)
            {
                switch (titleArr[j]){
                    case "外部订单号":
                        one.outtradeid=contentArr[j];
                        if (contentArr[j]){
                            //因为是
//                            one.tradeid= contentArr[j].substring(8)
                            one.tradeid= contentArr[j].replace("VC_米酷_","")
                        }
                        break;
                    case "物流单号":
                        one.logisticsWuLiuCode=contentArr[j].replace("miku","")
                        break;
                    case "物流公司":
                        one.logisticsCompany=contentArr[j];
                        break;
                    case "买家留言":
                        one.itemMsg=contentArr[j];
                        break;
                    case "拆单号":
                        one.orderIdStr=contentArr[j];
                        break;
                }
            }
            outlist.add(one);
        }
        return outlist;
    }



















    //读入的EXCEL
    String[] readExcelTitle(InputStream is)
    {
        def POIFSFileSystem fs;
        def HSSFWorkbook wb;
        def HSSFSheet sheet;
        def HSSFRow row;

        try {
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        row = sheet.getRow(0);
        // 标题总列数
        int colNum = row.getPhysicalNumberOfCells();
        System.out.println("colNum:" + colNum);
        String[] title = new String[colNum];
        for (int i = 0; i < colNum; i++) {
            title[i] = getCellFormatValue(row.getCell((short) i));
        }
        return title;
    }



    String getCellFormatValue(HSSFCell cell)
    {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
            // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC:
                case HSSFCell.CELL_TYPE_FORMULA:
                    DecimalFormat df =new DecimalFormat("0");
//                    String str=df.format(cell.getNumericCellValue());
//                    cellvalue = df.format(cell.getNumericCellValue());
                    cellvalue = (cell.getNumericCellValue()).toString();
//                    cellvalue = String.valueOf(cell.getNumericCellValue());
                    break;
            // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getRichStringCellValue().getString();
                    break;
            // 默认的Cell值
                default:
                    cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;
    }



    /**
     * 获取单元格数据内容为字符串类型的数据
     *
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                strCell = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                strCell = String.valueOf(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                strCell = String.valueOf(cell.getBooleanCellValue());
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                strCell = "";
                break;
            default:
                strCell = "";
                break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        if (cell == null) {
            return "";
        }
        return strCell;
    }



    /**
     * 读取Excel数据内容
     * @param InputStream
     * @return Map 包含单元格数据内容的Map对象
     */
    Map<Integer, String> readExcelContent(InputStream is)
    {
        def POIFSFileSystem fs;
        def HSSFWorkbook wb;
        def HSSFSheet sheet;
        def HSSFRow row;
        Map<Integer, String> content = new HashMap<Integer, String>();
        String str = "";
        try {
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        // 得到总行数
        int rowNum = sheet.getLastRowNum();
        row = sheet.getRow(0);
        int colNum = row.getPhysicalNumberOfCells();
        // 正文内容应该从第二行开始,第一行为表头的标题
        for (int i = 1; i <= rowNum; i++) {
            row = sheet.getRow(i);
            int j = 0;
            while (j < colNum) {
                // 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
                // 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
                // str += getStringCellValue(row.getCell((short) j)).trim() +
                // "-";
                String loc=getCellFormatValue(row.getCell((short) j)).trim();

                if ("".equals(loc))
                {
                    str +="  "+ "##";
                }
                else{
                    str +=loc+ "##";
                }
                j++;
            }
            content.put(i, str);
            str = "";
        }
        return content;
    }



}
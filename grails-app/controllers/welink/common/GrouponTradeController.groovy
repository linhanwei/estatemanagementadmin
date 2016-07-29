package welink.common

import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import pl.touk.excel.export.WebXlsxExporter
import welink.business.OrderDetail
import welink.business.TradeDetail
import welink.estate.Community
import welink.user.Profile

@Transactional(readOnly = true)
class GrouponTradeController {

    //未付款订单，实时查询
    def nopay() {

        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }
        // 查询语句
        String query = params.query

        if (query && !(query.equals('null')) && (query.length() == 13)) {
            //查询指定用户
            Profile profile = Profile.findByMobile(query.replace('-', ''))

            if (profile) {
                //查找指定用户的所有订单记录

                pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                    eq('buyerId', profile.id as long)
                    eq('status', 2 as byte)
                    eq('type',3 as byte)
                    eq('shopId', 999L)
                    order('lastUpdated', 'desc')
                }

                pagedResultList.iterator().each {

                    Trade trade ->
                        //该地址对应的ID
                        Logistics logistics = Logistics.findById(trade.consigneeId)

                        tradeMap.put(trade.id, new TradeDetail(
                                tradeId: trade.tradeId,
                                profileMobile: profile.mobile,
                                communityName: Community.findById(trade.communityId).name,
                                address:logistics?.addr,
                                receiverName: logistics?.contactName,
                                receiverMobile: logistics?.mobile,
                                totalPrice: trade.totalFee,
                                createTime: trade.dateCreated.toString().substring(0, 16),
                                status: trade.status,
                                tradeMemo: trade?.tradeMemo ?: '无备注'
                        ))
                }
            }
        }else {
            //查找指定时间的所有订单
            pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                eq('status', 2 as byte)
                eq('type',3 as byte)
                eq('shopId', 999L)
                order('lastUpdated', 'desc')
                if(params.communityId){
                    Long communityId = params.long('communityId')
                    eq('communityId', communityId)
                }
            }
            pagedResultList.iterator().each {
                Trade trade ->
                    //该地址对应的ID
                    Logistics logistics = Logistics.findById(trade.consigneeId)

                    Profile profile = Profile.findById(trade.buyerId)

                    tradeMap.put(trade.id, new TradeDetail(
                            tradeId: trade.tradeId,
                            profileMobile: profile.mobile,
                            communityName: Community.findById(trade.communityId).name,
                            address:logistics?.addr,
                            receiverName: logistics?.contactName,
                            receiverMobile: logistics?.mobile,
                            totalPrice: trade.totalFee,
                            createTime: trade.dateCreated.toString().substring(0, 16),
                            status: trade.status,
                            tradeMemo: trade?.tradeMemo ?: '无备注'
                    ))
            }

        }

        return [
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
    }

    def history() {
        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }
        // 查询语句
        String query = params.query

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd")

        //页面第一次载入时时间为当天时间
        String acceptTime = params.acceptTime ?: new Date().format('yyyy-MM-dd')

        DateTime dt = formatter.parseDateTime(acceptTime)

        DateTime earlistTime = dt.withTimeAtStartOfDay()

        DateTime latestTime = earlistTime.plusHours(23).plusMinutes(59).plusMillis(59000)


        if (query && !(query.equals('null')) && (query.length() == 13)) {
            //查询指定用户
            Profile profile = Profile.findByMobile(query.replace('-', ''))

            if (profile) {
                //查找指定用户的所有订单记录

                pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                    eq('buyerId', profile.id as long)
                    eq('type',3 as byte)
                    eq('status', 7 as byte)
                    eq('shopId', 999L)
                    order('lastUpdated', 'desc')
                }

                pagedResultList.iterator().each {
                    Trade trade ->
                        //该地址对应的ID
                        Logistics logistics = Logistics.findById(trade.consigneeId)

                        tradeMap.put(trade.id, new TradeDetail(
                                tradeId: trade.tradeId,
                                profileMobile: profile.mobile,
                                communityName: Community.findById(trade.communityId).name,
                                address:logistics?.addr,
                                receiverName: logistics?.contactName,
                                receiverMobile: logistics?.mobile,
                                totalPrice: trade.totalFee,
                                createTime: trade.dateCreated.toString().substring(0, 16),
                                status: trade.status,
                                tradeMemo: trade?.tradeMemo ?: '无备注'
                        ))
                }
            }
        } else {
            //查找指定时间的所有订单
            pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                if(params.acceptTime){
                    between("dateCreated", earlistTime.toDate(), latestTime.toDate())
                }
                if(params.communityId){
                    Long communityId = params.long('communityId')
                    eq('communityId', communityId)
                }
                eq('type',3 as byte)
                eq('status', 7 as byte)
                eq('shopId', 999L)
                order('lastUpdated', 'desc')
            }
            pagedResultList.iterator().each {
                Trade trade ->
                    //该地址对应的ID
                    Logistics logistics = Logistics.findById(trade.consigneeId)

                    Profile profile = Profile.findById(trade.buyerId)

                    tradeMap.put(trade.id, new TradeDetail(
                            tradeId: trade.tradeId,
                            profileMobile: profile.mobile,
                            communityName: Community.findById(trade.communityId).name,
                            address:logistics?.addr,
                            receiverName: logistics?.contactName,
                            receiverMobile: logistics?.mobile,
                            totalPrice: trade.totalFee,
                            createTime: trade.dateCreated.toString().substring(0, 16),
                            status: trade.status,
                            tradeMemo: trade?.tradeMemo ?: '无备注'
                    ))
            }
        }

        return [
                acceptTime   : acceptTime,
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
    }

    //已派单订单
    def shipped() {
        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }
        // 查询语句
        String query = params.query

        String communityName

        if (params.communityId) {
            communityName = Community.findById(params.long('communityId')).name
        } else {
            communityName = '还未选择小区'
        }

        if (query && !(query.equals('null')) && (query.length() == 13)) {
            //查询指定用户
            Profile profile = Profile.findByMobile(query.replace('-', ''))

            if (profile) {
                //查找指定用户的所有订单记录

                pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                    eq('buyerId', profile.id as long)
                    eq('status', 5 as byte)
                    eq('shopId', 999L)
                    eq('type',3 as byte)
                    order('lastUpdated', 'desc')
                }

                pagedResultList.iterator().each {

                    Trade trade ->
                        //该地址对应的ID
                        Logistics logistics = Logistics.findById(trade.consigneeId)

                        tradeMap.put(trade.id, new TradeDetail(
                                tradeId: trade.tradeId,
                                profileMobile: profile.mobile,
                                communityName: Community.findById(trade.communityId).name,
                                address:logistics?.addr,
                                receiverName: logistics?.contactName,
                                receiverMobile: logistics?.mobile,
                                totalPrice: trade.totalFee,
                                createTime: trade.dateCreated.toString().substring(0, 16),
                                status: trade.status,
                                tradeMemo: trade?.tradeMemo ?: '无备注'
                        ))
                }
            }
        } else if (params.communityId) {

            Long communityId = params.long('communityId')

            pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                eq('status', 5 as byte)
                eq('shopId', 999L)
                eq('type',3 as byte)
                order('lastUpdated', 'desc')
                eq('communityId', communityId)
            }

            pagedResultList.iterator().each {
                Trade trade ->
                    //该地址对应的ID
                    Logistics logistics = Logistics.findById(trade.consigneeId)

                    Profile profile = Profile.findById(trade.buyerId)

                    tradeMap.put(trade.id, new TradeDetail(
                            tradeId: trade.tradeId,
                            profileMobile: profile.mobile,
                            communityName: Community.findById(trade.communityId).name,
                            address:logistics?.addr,
                            receiverName: logistics?.contactName,
                            receiverMobile: logistics?.mobile,
                            totalPrice: trade.totalFee,
                            createTime: trade.dateCreated.toString().substring(0, 16),
                            status: trade.status,
                            tradeMemo: trade?.tradeMemo ?: '无备注'
                    ))
            }
        } else {
            //查找指定时间的所有订单
            pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                eq('status', 5 as byte)
                eq('type',3 as byte)
                eq('shopId', 999L)
                order('lastUpdated', 'desc')
            }
            pagedResultList.iterator().each {
                Trade trade ->
                    //该地址对应的ID
                    Logistics logistics = Logistics.findById(trade.consigneeId)

                    Profile profile = Profile.findById(trade.buyerId)

                    tradeMap.put(trade.id, new TradeDetail(
                            tradeId: trade.tradeId,
                            profileMobile: profile.mobile,
                            communityName: Community.findById(trade.communityId).name,
                            address:logistics?.addr,
                            receiverName: logistics?.contactName,
                            receiverMobile: logistics?.mobile,
                            totalPrice: trade.totalFee,
                            createTime: trade.dateCreated.toString().substring(0, 16),
                            status: trade.status,
                            tradeMemo: trade?.tradeMemo ?: '无备注'
                    ))
            }
        }

        return [
                communityId  : params.communityId,
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
    }

    //已关闭
    def close() {

        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }
        // 查询语句
        String query = params.query

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd")

        //页面第一次载入时时间为当天时间
        String acceptTime = params.acceptTime ?: new Date().format('yyyy-MM-dd')

        DateTime dt = formatter.parseDateTime(acceptTime)

        DateTime earlistTime = dt.withTimeAtStartOfDay()

        DateTime latestTime = earlistTime.plusHours(23).plusMinutes(59).plusMillis(59000)

        if (query && !(query.equals('null')) && (query.length() == 13)) {
            //查询指定用户
            Profile profile = Profile.findByMobile(query.replace('-',''))

            if (profile) {
                //查找指定用户的所有订单记录

                pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                    eq('buyerId', profile.id as long)
                    eq('status', 9 as byte)
                    eq('shopId', 999L)
                    eq('type',3 as byte)
                    order('lastUpdated', 'desc')
                }

                pagedResultList.iterator().each {

                    Trade trade ->
                        //该地址对应的ID
                        Logistics logistics = Logistics.findById(trade.consigneeId)

                        tradeMap.put(trade.id, new TradeDetail(
                                tradeId: trade.tradeId,
                                profileMobile: profile.mobile,
                                communityName: Community.findById(trade.communityId).name,
                                address:logistics?.addr,
                                receiverName: logistics?.contactName,
                                receiverMobile: logistics?.mobile,
                                totalPrice: trade.totalFee,
                                createTime: trade.dateCreated.toString().substring(0, 16),
                                status: trade.status,
                                tradeMemo: trade?.tradeMemo ?: '无备注'
                        ))
                }
            }
        }else {
            //查找指定时间的所有订单
            pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                if(params.acceptTime){
                    between("dateCreated", earlistTime.toDate(), latestTime.toDate())
                }
                if(params.communityId){
                    Long communityId = params.long('communityId')
                    eq('communityId', communityId)
                }
                eq('status', 9 as byte)
                eq('shopId', 999L)
                eq('type',3 as byte)
                order('lastUpdated', 'desc')
            }
            pagedResultList.iterator().each {
                Trade trade ->
                    //该地址对应的ID
                    Logistics logistics = Logistics.findById(trade.consigneeId)

                    Profile profile = Profile.findById(trade.buyerId)

                    tradeMap.put(trade.id, new TradeDetail(
                            tradeId: trade.tradeId,
                            profileMobile: profile.mobile,
                            communityName: Community.findById(trade.communityId).name,
                            address:logistics?.addr,
                            receiverName: logistics?.contactName,
                            receiverMobile: logistics?.mobile,
                            totalPrice: trade.totalFee,
                            createTime: trade.dateCreated.toString().substring(0, 16),
                            status: trade.status,
                            tradeMemo: trade?.tradeMemo ?: '无备注'
                    ))
            }
        }

        return [
                acceptTime   : acceptTime,
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
    }

    //批量发送
    @Transactional
    def sendAll() {

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd")

        Long communityId = params.long('communityId')

        String query = params.query

        def tradelist = Trade.withCriteria {
            eq('status', 4 as byte)
            eq('shopId', 999L)
            eq('type',3 as byte)
            order('lastUpdated', 'desc')
            if (params.acceptTime) {

                String acceptTime = params.acceptTime ?: new Date().format('yyyy-MM-dd')

                DateTime dt = formatter.parseDateTime(acceptTime)

                DateTime earlistTime = dt.withTimeAtStartOfDay()

                DateTime latestTime = earlistTime.plusHours(23).plusMinutes(59).plusMillis(59000)

                between("dateCreated", earlistTime.toDate(), latestTime.toDate())
            }
            if (communityId) {
                eq('communityId', communityId)
            }
            if (query && !(query.equals('null')) && (query.length() == 13)) {
                eq('buyerId', Profile.findByMobile(query).id)
            }
        }

        if (tradelist) {
            tradelist.iterator().each {
                Trade trade ->
                    trade.status = 5
                    trade.timeoutActionTime = new DateTime().plusDays(3).toDate()
                    trade.save(failOnError: true, flush: true)
            }
        }

        redirect(action: "index")
    }

    //发送某订单
    @Transactional
    def sendTrade() {

        if (params.tradeId) {
            Long tradeId = params.long('tradeId')

            Trade trade = Trade.findByTradeId(tradeId)

            trade.timeoutActionTime = new DateTime().plusDays(3).toDate()

            trade.status = 5

            trade.save(failOnError: true, flush: true)

            redirect(action: "index")
        }

    }

    def exportExcel() {

        //计算订单总数
        Long total = 0

        List<TradeDetail> tradeList = new ArrayList<TradeDetail>()

        byte status = params.byte('status')

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd")

        String acceptTime = params.acceptTime ?: new Date().format('yyyy-MM-dd')

        DateTime dt = formatter.parseDateTime(acceptTime)

        DateTime earlistTime = dt.withTimeAtStartOfDay()

        DateTime latestTime = earlistTime.plusHours(23).plusMinutes(59).plusMillis(59000)

        Long communityId = params.long('communityId')

        String query = params.query

        def tradelist

        if (status ==5||status==2) {
            tradelist = Trade.withCriteria {
                eq('status', status)
                eq('shopId', 999L)
                eq('type',3 as byte)
                order('communityId', 'asc')
                order('lastUpdated', 'desc')

                if (communityId) {
                    eq('communityId', communityId)
                }
                if (query && !(query.equals('null')) && (query.length() == 13)) {
                    eq('buyerId', Profile.findByMobile(query).id)
                }
            }
        } else {
            tradelist = Trade.withCriteria {
                if (params.acceptTime) {
                    between("dateCreated", earlistTime.toDate(), latestTime.toDate())
                }
                eq('status', status)
                eq('shopId', 999L)
                eq('type',3 as byte)
                order('communityId', 'asc')
                order('lastUpdated', 'desc')

                if (communityId) {
                    eq('communityId', communityId)
                }
                if (query && !(query.equals('null')) && (query.length() == 13)) {
                    eq('buyerId', Profile.findByMobile(query.replace('-', '')).id)
                }
            }
        }

        tradelist.iterator().each {
            Trade trade ->
                total = total + 1

                def orderIds = trade.orders.split(';')
                //该地址对应的ID
                Logistics logistics = Logistics.findById(trade.consigneeId)

                Profile profile = Profile.findById(trade.buyerId)

                tradeList.add(new TradeDetail(
                        communityName: Community.findById(trade.communityId)?.name,
                        communityAddress: Community.findById(trade.communityId)?.city+Community.findById(trade.communityId)?.district+Community.findById(trade.communityId)?.location,
                        tradeId: trade.tradeId.toString(),
                        profileMobile: profile.mobile,
                        address:logistics?.addr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        createTime: trade.dateCreated.toString().substring(0, 16),
                        status: trade.status,
                        tradeMemo: trade?.tradeMemo ?: '无备注',
                        itemName: '商品名称',
                        itemNum: '商品数量'
                ))
                tradeList.add(new TradeDetail(
                        communityName: '商品ID',
                        communityAddress: '商品名称',
                        address: '规格',
                        receiverName: '数量',
                        receiverMobile: '单价',
                        tradeId: '总价'
                ))

                orderIds.iterator().each {
                    String id ->
                        Order order = Order.findById(Long.parseLong(id))
                        if(order){
                            tradeList.add(new TradeDetail(
                                    communityAddress: order?.title,
                                    receiverName: order?.num,
                                    receiverMobile: order?.price,
                                    tradeId: order?.totalFee
                            ))
                        }

                }
                //每条trade记录后加一条空白
                tradeList.add(new TradeDetail())
        }
        tradeList.add(new TradeDetail(communityName: '总订单数：', communityAddress: total))

        def headers = ['小区', '小区地址', '收货地址','联系人', '联系电话', '订单编号', '订单时间', '订单金额', '用户留言']

        def withProperties = ['communityName','communityAddress','address','receiverName','receiverMobile','tradeId','createTime','totalPrice','tradeMemo']

        WebXlsxExporter webXlsxExporter = new WebXlsxExporter()

        String type = ''

        switch (status) {
            case 2:
                type = '未付款';
                break;
            case 4:
                type = '未发货';
                break;
            case 7:
                type = '已完成';
                break;
            case 9:
                type = '已取消';
                break;
            case 5:
                type = '已发货';
                break;
            default:
                type = '非法'
                break;
        }

        if (params.communityId) {
            String communityName = Community.findById(params.long('communityId')).name

            webXlsxExporter.setWorksheetName(communityName + '-' + acceptTime + type)

        } else {

            webXlsxExporter.setWorksheetName('全部小区-' + acceptTime + type)
        }


        webXlsxExporter.with {
            setResponseHeaders(response)
            fillHeader(headers)
            add(tradeList, withProperties)
            save(response.outputStream)
        }
    }

    def index() {

        def tradeMap = [:]

        def t = Trade.createCriteria()

        PagedResultList pagedResultList

        //小区列表
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }
        // 查询语句
        String query = params.query

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd")

        String communityName

        if (params.communityId) {
            communityName = Community.findById(params.long('communityId')).name
        } else {
            communityName = '还未选择小区'
        }

        //页面第一次载入时间为当天时间
        String acceptTime = params.acceptTime ?: new Date().format('yyyy-MM-dd')

        DateTime dt = formatter.parseDateTime(acceptTime)

        DateTime earlistTime = dt.withTimeAtStartOfDay()

        DateTime latestTime = earlistTime.plusHours(23).plusMinutes(59).plusMillis(59000)

        if (query && !(query.equals('null')) && (query.length() == 13)) {
            //查询指定用户
            Profile profile = Profile.findByMobile(query.replace('-', ''))

            if (profile) {
                //查找指定用户的所有订单记录

                pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                    eq('buyerId', profile.id as long)
                    eq('status', 4 as byte)
                    eq('shopId', 999L)
                    eq('type',3 as byte)
                    order('lastUpdated', 'desc')
                }

                pagedResultList.iterator().each {

                    Trade trade ->
                        //该地址对应的ID
                        Logistics logistics = Logistics.findById(trade.consigneeId)

                        tradeMap.put(trade.id, new TradeDetail(
                                tradeId: trade.tradeId,
                                profileMobile: profile?.mobile,
                                communityName: Community.findById(trade.communityId)?.name,
                                address:logistics?.addr,
                                receiverName: logistics?.contactName,
                                receiverMobile: logistics?.mobile,
                                totalPrice: trade.totalFee,
                                createTime: trade.dateCreated.toString().substring(0, 16),
                                status: trade.status,
                                tradeMemo: trade?.tradeMemo ?: '无备注'
                        ))
                }
            }
        }else {
            //查找指定时间的所有订单
            pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                if(params.acceptTime){
                    between("dateCreated", earlistTime.toDate(), latestTime.toDate())
                }
                if(params.communityId){
                    Long communityId = params.long('communityId')
                    eq('communityId', communityId)
                }
                eq('status', 4 as byte)
                eq('shopId', 999L)
                eq('type',3 as byte)
                order('communityId', 'asc')
                order('lastUpdated', 'desc')

            }

            pagedResultList.iterator().each {
                Trade trade ->
                    //该地址对应的ID
                    Logistics logistics = Logistics.findById(trade.consigneeId)

                    Profile profile = Profile.findById(trade.buyerId)

                    tradeMap.put(trade.id, new TradeDetail(
                            tradeId: trade.tradeId,
                            profileMobile: profile.mobile,
                            communityName: Community.findById(trade.communityId)?.name,
                            address:logistics?.addr,
                            receiverName: logistics?.contactName,
                            receiverMobile: logistics?.mobile,
                            totalPrice: trade.totalFee,
                            createTime: trade.dateCreated.toString().substring(0, 16),
                            status: trade.status,
                            tradeMemo: trade?.tradeMemo ?: '无备注'
                    ))
            }
        }

        return [
                communityId  : params.communityId,
                acceptTime   : acceptTime,
                communityList: communityList,
                total        : pagedResultList?.totalCount,
                params       : params,
                tradeList    : pagedResultList,
                tradeMap     : tradeMap
        ]
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
                if(order){
                    orderList.add(new OrderDetail(
                            itemName: order?.title,
                            orderId: order?.id,
                            itemNum: order?.num,
                            orderPrice: order?.price))

                }
        }

        //该地址对应的ID
        Logistics logistics = Logistics.findById(trade.consigneeId)

        Profile profile = Profile.findById(trade.buyerId)

        TradeDetail tradeDetail = new TradeDetail(
                tradeId: trade.tradeId,
                profileMobile: profile.mobile,
                communityName: Community.findById(trade.communityId)?.name,
                address:logistics?.addr,
                receiverName: logistics?.contactName,
                receiverMobile: logistics?.mobile,
                totalPrice: trade.totalFee,
                createTime: trade.dateCreated.toString().substring(0, 16),
                status: trade.status,
                OrderList: orderList,
                tradeMemo: trade?.tradeMemo ?: '无备注'
        )

        render(template: "tradeDetail", model: [
                tradeDetail: tradeDetail,
                orderList  : orderList,
                total      : orderList.size()
        ])
    }


}

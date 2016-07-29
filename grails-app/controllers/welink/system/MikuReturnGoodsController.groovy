package welink.system

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.MikuReturnGoodsDetail
import welink.business.TradeDetail
import welink.common.AlipayBack
import welink.common.ConsigneeAddr
import welink.common.Item
import welink.common.Logistics
import welink.common.MikuAgencyShareAccount
import welink.common.MikuReturnGoods
import welink.common.MikuSalesRecord
import welink.common.MikuWallet
import welink.common.MikuWalletOrigin
import welink.common.Order
import welink.common.Trade
import welink.common.TradeCourier
import welink.common.TradeNoShipController
import welink.common.WeixinBack
import welink.estate.Community
import welink.estate.ObjectTagged
import welink.estate.Tags
import welink.user.Employee
import welink.user.Profile
import welink.user.ProfileWechat
import welink.user.WechatProfile

import java.text.SimpleDateFormat

class MikuReturnGoodsController {
    def copyItemService
    def wxRefundService

    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .build()


    static ImmutableMap<String, String> ORDER_ENTITY_MAP = ImmutableMap.builder() //
            .put("consignTime", "派送时间")
            .put("id", "下单时间")
            .build()

    //后台需要审核退货的订单[1--->2状态]
    def index() {
        //查询条件
        def query=params.query
        def tradeCode=params.long('tradeCode')
        def od=Order.createCriteria()
        PagedResultList pagedResultList=getPageList(query,tradeCode,1 as byte)
        //进行trade对象的数据封装
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=getDetail(pagedResultList)

        render(view: 'index', model: [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap    : PageMap,
                mikuReturnGoodsList : mikuReturnGoodsList
        ])
    }


    //审核完之后再移到用户寄货
    def jhinfo(){
        def query=params.query
        def tradeCode=params.long('tradeCode')
        PagedResultList pagedResultList=getPageList(query,tradeCode,2 as byte)
        //进行trade对象的数据封装
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=getDetail(pagedResultList)
        render(view: 'jhinfo', model: [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                mikuReturnGoodsList : mikuReturnGoodsList
        ])
    }


    //确认收货页面[]
    def qrshinfo(){
        def query=params.query
        def tradeCode=params.long('tradeCode')
        PagedResultList pagedResultList=getPageList(query,tradeCode,3 as byte)
        //进行trade对象的数据封装
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=getDetail(pagedResultList)
        render(view: 'qrshinfo', model: [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                mikuReturnGoodsList : mikuReturnGoodsList
        ])
    }


    //审核不通过
    @Transactional
    def noreturnGood(){
        def id=params.long('id')
        def errorcause=params.errorcause
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            mikuReturnGoods.with {
                it.status=6L
                it.finishTime=new Date()
                it.timeoutActionTime=new DateTime().plusDays(3).toDate()
                it.sellerMemo=errorcause
                it.save(failOnError: true, flush: true)
            }
            Order order=Order.findById(mikuReturnGoods.orderId)
            order.returnStatus=6L
            order.save(failOnError: true, flush: true)
            //进行trade表的操作
            Trade trade=Trade.findByTradeId(mikuReturnGoods.tradeId)
            if (trade){
                trade.with {
                    it.timeoutActionTime=new DateTime().plusDays(3).toDate()
                    it.returnStatus= 0 as byte
                    it.save(failOnError: true, flush: true)
                }
            }
        }
        redirect(action: 'index')
    }


    //收货前退货
    def hqindex(){
        def tradeCode=params.long('tradeCode')
        def query=params.query
        def t = Trade.createCriteria()
        def tradeMap = [:]
        PagedResultList pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            'in'('status', [ 6 as byte,4 as byte,2 as byte])
            eq('returnStatus', 1 as byte)
            order("id", "desc")
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
            }
//            进行特别的处理
//            eq('tradeId',5646358017327057)
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
                List<MikuReturnGoods> mikuReturnGoodsList=MikuReturnGoods.findAllByTradeId(trade.tradeId)
                String iteminfo=""
                String reason=""
                for (int i=0;i<mikuReturnGoodsList.size();i++){
                    if (i==mikuReturnGoodsList.size()-1){
                        iteminfo=iteminfo+mikuReturnGoodsList.get(i).title
                        reason=mikuReturnGoodsList.get(i).returnReason
                    }else{
                        iteminfo=iteminfo+mikuReturnGoodsList.get(i).title
                        iteminfo=iteminfo+" ,  "
                    }
                }
                //判断是否过期
                Byte isgq=0 as byte
                if (trade.timeoutActionTime>new Date()){
                    isgq=1 as byte
                }
                //查看是否是支付宝的退款
                if (trade.payType== 3 as byte){
                    List<AlipayBack> alipayBackList=AlipayBack.findAllByOutTradeNo(trade.tradeId)
                    if (alipayBackList.size()>0){
                        trade.buyerMemo=alipayBackList.get(0).buyerEmail
                        trade.alipayNo=alipayBackList.get(0).tradeNo
                    }
                }
                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        status: trade.status,
                        iteminfo: iteminfo,
                        reason: reason,
                        ispassDate: isgq,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        createTime: trade.dateCreated.toString().substring(0, 16),
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '未预约',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无记录',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无记录',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人'
                ))
        }
        return [
                total          : pagedResultList?.totalCount,
                params         : params,
                tradeList      : pagedResultList,
                tradeMap       : tradeMap,
                PageMap        : PageMap,
                payTypeMap     : TradeNoShipController.PAY_TYPE_MAP,
                shippingTypeMap: TradeNoShipController.SHIPPING_TYPE_MAP,
                totalFeeOpMap  : TradeNoShipController.TOTAL_FEE_OP_MAP,
                orderMap       : TradeNoShipController.ORDER_MAP,
                orderEntryMap  : ORDER_ENTITY_MAP,
        ]


    }


    def thwctradeinfo(){
        def tradeCode=params.long('tradeCode')
        def query=params.query
        def t = Trade.createCriteria()
        def tradeMap = [:]
        PagedResultList pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            'in'('status', [ 6 as byte,4 as byte])
            eq('returnStatus', 2 as byte)
            order("id", "desc")
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
            }
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
                List<MikuReturnGoods> mikuReturnGoodsList=MikuReturnGoods.findAllByTradeId(trade.tradeId)
                String iteminfo=""
                String reason=""
                for (int i=0;i<mikuReturnGoodsList.size();i++){
                    if (i==mikuReturnGoodsList.size()-1){
                        iteminfo=iteminfo+mikuReturnGoodsList.get(i).title
                        if (iteminfo+mikuReturnGoodsList.get(i).num!=null){
//                            iteminfo=iteminfo+"x"+mikuReturnGoodsList.get(i).num
                            iteminfo=iteminfo
                        }
                        reason=mikuReturnGoodsList.get(i).returnReason
                    }else{
                        iteminfo=iteminfo+mikuReturnGoodsList.get(i).title
                        if (iteminfo+mikuReturnGoodsList.get(i).num!=null){
//                            iteminfo=iteminfo+"x"+mikuReturnGoodsList.get(i).num+"  ,  "
                            iteminfo=iteminfo+"  ,  "
                        }
                    }
                }
                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        status: trade.status,
                        iteminfo: iteminfo,
                        reason: reason,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        createTime: trade.dateCreated.toString().substring(0, 16),
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '未预约',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无记录',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无记录',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人'
                ))
        }
        return [
                total          : pagedResultList?.totalCount,
                params         : params,
                tradeList      : pagedResultList,
                tradeMap       : tradeMap,
                PageMap        : PageMap,
                payTypeMap     : TradeNoShipController.PAY_TYPE_MAP,
                shippingTypeMap: TradeNoShipController.SHIPPING_TYPE_MAP,
                totalFeeOpMap  : TradeNoShipController.TOTAL_FEE_OP_MAP,
                orderMap       : TradeNoShipController.ORDER_MAP,
                orderEntryMap  : ORDER_ENTITY_MAP,
        ]
    }




    def allinfo(){
        //查询条件
        def query=params.query
        def tradeCode=params.long('tradeCode')
        if (StringUtils.isNotBlank(query)) {
            query = StringUtils.replace(query, "-", "");
        }
        def od=Order.createCriteria()
        PagedResultList pagedResultList
        //查出对应正在退款当中的商品
        pagedResultList = od.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            'in'('returnStatus', [1 as byte, 2 as byte, 3 as byte, 4 as byte,5 as byte,6 as byte])
            order("id", "desc")
            if (query){
                Profile profile = Profile.findByMobile(query)
                if (profile){
                    eq("buyerId", profile.id)
                }else{
                    eq("buyerId",-1L)
                }
            }
            if (tradeCode){
                eq('tradeId',tradeCode)
            }
        }
        //进行trade对象的数据封装
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=new ArrayList<MikuReturnGoodsDetail>()
        pagedResultList.iterator().each {
            Order order->
                MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findByOrderIdAndStatusNotEqual(order.id,-1 as byte)
                if (mikuReturnGoods){
                    MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findByTradeIdAndItemId(mikuReturnGoods.tradeId,mikuReturnGoods.artificialId)
                    MikuReturnGoodsDetail mikuReturnGoodsDetail=copyItemService.getmikureturnInfo(mikuReturnGoods)
                    mikuReturnGoodsList.add(mikuReturnGoodsDetail)
                }
        }

        render(view: 'allinfo', model: [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap    : PageMap,
                mikuReturnGoodsList : mikuReturnGoodsList
        ])
    }

    //退货当中
    def inginfo(){
        //查询条件
        def query=params.query
        def tradeCode=params.long('tradeCode')
        PagedResultList pagedResultList=getPageList(query,tradeCode,4 as byte)
        //进行trade对象的数据封装
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=getDetail(pagedResultList)
        render(view: 'inginfo', model: [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                mikuReturnGoodsList : mikuReturnGoodsList
        ])
    }


    //cancelOneTrade:发货前进行取消整个订单
    @Transactional
    def cancelOneTrade(){
        def tradeid=params.long('id')
        Trade trade=Trade.findByTradeId(tradeid)
        if (tradeid && trade){
            //订单的修改
            trade.returnStatus= 2 as byte
            trade.timeoutActionTime=new DateTime().plusDays(7).toDate()
            trade.save(failOnError: true, flush: true)
            List<Order> orderList=Order.findAllByTradeId(tradeid)
            //Order表的设值
            orderList.each {
                Order order->
                    order.returnStatus=5L
                    order.save(failOnError: true, flush: true)
                //取消整个订单的时候，这里需要注意的是Item表的库存与销售数量都需要改的[总仓+上架的商品]
                Item item=Item.findById(order.artificialId)
                if (item){
                    //抢购标商品的处理
                    if (order.hasPanicTag == 1 as byte){
                        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)
                        //进行对限购标数量的获取[在售商品]
                        tagsOnShow.each {
                            ObjectTagged objtag->
                                Tags tags=Tags.findById(objtag.tagId)
                                if ("抢购标".equals(tags.name))
                                {
                                    //库存
                                    objtag.activityNum= objtag.activityNum+order.num
                                    //已售数量
                                    objtag.activitySoldNum=objtag.activitySoldNum-order.num
                                    objtag.save(failOnError: true, flush: true)
                                }
                        }
                        //总仓信息内容修改
                        Item baseItem=Item.findById(item.baseItemId)
                        def baseTagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(baseItem.id, 1 as byte)
                        //进行对限购标数量的获取[总仓]
                        baseTagsOnShow.each {
                            ObjectTagged objtag->
                                Tags tags=Tags.findById(objtag.tagId)
                                if ("抢购标".equals(tags.name))
                                {
                                    //库存
                                    objtag.activityNum= objtag.activityNum+order.num
                                    //已售数量
                                    objtag.activitySoldNum=objtag.activitySoldNum-order.num
                                    objtag.save(failOnError: true, flush: true)
                                }
                        }
                    }else{
                        //上架商品信息的修改
                        item.soldQuantity=item.soldQuantity-order.num
                        item.num=item.num+order.num
                        item.save(failOnError: true, flush: true)
                        //总仓信息内容修改
                        Item baseItem=Item.findById(item.baseItemId)
                        baseItem.num=item.num+order.num
                        baseItem.save(failOnError: true, flush: true)
                    }
                }

            }
            //退货表的状态
            List<MikuReturnGoods> mikuReturnGoodsList=MikuReturnGoods.findAllByTradeId(tradeid)
            mikuReturnGoodsList.each {
                MikuReturnGoods mm->
                    if (mm.status!=-1L){
                        mm.status=5L
                        mm.timeoutActionTime=new DateTime().plusDays(7).toDate()
                        mm.finishTime=new Date()
                        mm.save(failOnError: true, flush: true)
                        //进行更新miku_agency_share_account
//                        List<MikuSalesRecord> mikuSalesRecordList=MikuSalesRecord.findAllByTradeIdAndItemId(mm.tradeId,mm.artificialId)
//                        for (int i=0;i<mikuSalesRecordList.size();i++){
//                            MikuSalesRecord mikuSalesRecord=mikuSalesRecordList.get(i)
//                            //修改对应的代理表中的数据
//                            MikuAgencyShareAccount mikuAgencyShareAccount=MikuAgencyShareAccount.findByAgencyId(mikuSalesRecord.agencyId)
//                            mikuAgencyShareAccount.with {
//                                it.noGetpayFee=it.noGetpayFee-mikuSalesRecord.shareFee
//                                it.totalShareFee=it.totalShareFee-mikuSalesRecord.shareFee
//                                it.save(failOnError: true, flush: true)
//                            }
//                        }
                    }
            }
            //进行钱包数值的计算
            MikuWallet mikuWallet=MikuWallet.findByUserId(trade.buyerId)
            if (mikuWallet){
                mikuWallet.balanceFee+=trade.price
                mikuWallet.save(failOnError: true, flush: true)
            }
            //新添一条数据
            MikuWalletOrigin mikuWalletOrigin=new MikuWalletOrigin()
            mikuWalletOrigin.with {
                it.userId=trade.buyerId
                //0是充值 1是退款 2是购买使用
                it.type=1L
                it.totalFee=trade.price
                it.orginId=trade.tradeId
                it.getpayStatus=1L
                it.version=1L
                it.dateCreated=new Date()
                it.lastUpdated=new Date()
                it.save(failOnError: true, flush: true)
            }
        }
        render('true')
    }

    //直接的订单的处理[对应的订单恢复正常的状态]
    @Transactional
    def cancelOneTradeToError(){
        def tradeid=params.long('id')
        def errorcause=params.errorcause
        Trade trade=Trade.findByTradeId(tradeid)
        if (tradeid && trade){
            //订单的修改
            trade.returnStatus= 0 as byte
            trade.save(failOnError: true, flush: true)
            List<Order> orderList=Order.findAllByTradeId(tradeid)
            //Order表的设值
            orderList.each {
                Order order->
                    order.returnStatus=0L
                    order.save(failOnError: true, flush: true)
            }
            //退货表的状态
            List<MikuReturnGoods> mikuReturnGoodsList=MikuReturnGoods.findAllByTradeId(tradeid)
            mikuReturnGoodsList.each {
                MikuReturnGoods mm->
                    if (mm.status!=-1L){
                        mm.status=6L
                        mm.finishTime=new Date()
                        mm.timeoutActionTime=new DateTime().plusDays(3).toDate()
                        mm.sellerMemo=errorcause
                        mm.save(failOnError: true, flush: true)
                    }
            }
        }
        redirect(action: 'hqindex')
    }

    //进行退货的处理
    @Transactional
    def returnGoodToing(){
        def id=params.long('id')
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            //再进行查出对应的order表数据
            Order order=Order.findById(mikuReturnGoods.orderId)
            order.returnStatus=4L
            order.save(failOnError: true, flush: true)
            //进行根据订单的状态来修改对应的miku_returngoods表的值
            mikuReturnGoods.status=4L
            mikuReturnGoods.timeoutActionTime=new DateTime().plusDays(3).toDate()
            mikuReturnGoods.reqExamine=new Date()
            //收货时间
            mikuReturnGoods.receiptTime=new Date()
            mikuReturnGoods.save(failOnError: true, flush: true)
        }
        render('true')
    }

    

    //申请退货订单进入审核的步骤【1---->2】
    @Transactional
    def returnGoodToSH(){
        def id=params.long('id')
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            //再进行查出对应的order表数据
            Order order=Order.findById(mikuReturnGoods.orderId)
            order.returnStatus=2L
            order.save(failOnError: true, flush: true)
            //进行根据订单的状态来修改对应的miku_returngoods表的值
            if (mikuReturnGoods.status!=-1L){
                mikuReturnGoods.status=2L
                mikuReturnGoods.timeoutActionTime=new DateTime().plusDays(7).toDate()
                mikuReturnGoods.reqExamine=new Date()
                mikuReturnGoods.save(failOnError: true, flush: true)
            }
            //进行订单的修改
            Trade trade=Trade.findByTradeId(mikuReturnGoods.tradeId)
            trade.with {
                it.timeoutActionTime=new DateTime().plusDays(7).toDate()
                it.save(failOnError: true, flush: true)
            }
        }
        render('true')
    }

    //由退货当中变为完成的处理
    @Transactional
    def returnGoodToSuccess(){
        def id=params.long('id')
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            mikuReturnGoods.status=5L
            mikuReturnGoods.timeoutActionTime=new Date()
            mikuReturnGoods.finishTime=new Date()
            mikuReturnGoods.save(failOnError: true, flush: true)
            //再进行查出对应的order表数据
            Order order=Order.findById(mikuReturnGoods.orderId)
            order.returnStatus=5L
            order.save(failOnError: true, flush: true)
            //进行钱包数据的更新
            MikuWallet mikuWallet=MikuWallet.findByUserId(mikuReturnGoods.buyerId)
            if (mikuWallet){
                mikuWallet.balanceFee+=mikuReturnGoods.refundFee
                mikuWallet.save(failOnError: true, flush: true)
            }
            //新添一条数据
            MikuWalletOrigin mikuWalletOrigin=new MikuWalletOrigin()
            mikuWalletOrigin.with {
                it.userId=mikuReturnGoods.buyerId
                //0是充值 1是退款 2是购买使用
                it.type=1L
                it.totalFee=mikuReturnGoods.refundFee
                it.orginId=mikuReturnGoods.id
                it.getpayStatus=1L
                it.version=1L
                it.dateCreated=new Date()
                it.lastUpdated=new Date()
                it.save(failOnError: true, flush: true)
            }
            //进行trade表的操作
            Trade trade=Trade.findByTradeId(mikuReturnGoods.tradeId)
            List<Order> orderList=Order.findAllByTradeId(mikuReturnGoods.tradeId)
            int flag=0
            for (int i=0;i<orderList.size();i++){
                if (orderList.get(i).returnStatus!= 5 as byte){
                    flag=1
                    break
                }
            }
            if (flag){
                trade.returnStatus=0 as byte
                trade.timeoutActionTime=new DateTime().plusDays(3).toDate()
            }else {
                trade.returnStatus=2 as byte
                trade.status=8 as byte
                trade.timeoutActionTime=new DateTime().plusDays(7).toDate()
            }
            trade.save(failOnError: true, flush: true)

            //进行更新miku_agency_share_account
//            List<MikuSalesRecord> mikuSalesRecordList=MikuSalesRecord.findAllByTradeIdAndItemId(mikuReturnGoods.tradeId,mikuReturnGoods.artificialId)
//            for (int i=0;i<mikuSalesRecordList.size();i++){
//                MikuSalesRecord mikuSalesRecord=mikuSalesRecordList.get(i)
//                //修改对应的代理表中的数据
//                MikuAgencyShareAccount mikuAgencyShareAccount=MikuAgencyShareAccount.findByAgencyId(mikuSalesRecord.agencyId)
//                mikuAgencyShareAccount.with {
//                    it.noGetpayFee=it.noGetpayFee-mikuSalesRecord.shareFee
//                    it.totalShareFee=it.totalShareFee-mikuSalesRecord.shareFee
//                    it.save(failOnError: true, flush: true)
//                }
//            }
        }
        render('true')

    }

    @Transactional
    def returnGoodToError(){
        String path=request.getSession().getServletContext().getRealPath("")
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        def id=params.long('id')
        def errorcause=params.errorcause
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            mikuReturnGoods.with {
                it.status=6L
                it.timeoutActionTime=new DateTime().plusDays(3).toDate()
                it.sellerMemo=errorcause
                it.finishTime=new Date()
                it.save(failOnError: true, flush: true)
            }
            //再进行查出对应的order表数据
            Order order=Order.findById(mikuReturnGoods.orderId)
            order.returnStatus=6L
            order.save(failOnError: true, flush: true)
            //Trade表的操作
            Trade trade=Trade.findByTradeId(mikuReturnGoods.tradeId)
            trade.returnStatus=0 as byte
            trade.timeoutActionTime=new DateTime().plusDays(7).toDate()
            trade.save(failOnError: true, flush: true)
        }
        redirect(action: 'inginfo')
    }


    def testMoney(){
        copyItemService.wxRefundToMoneyToDo()
        render('true')
    }


    @Transactional
    def reFundMoneyByDo(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String path=request.getSession().getServletContext().getRealPath("//")+"apiclient_cert.p12"
        def id=params.long('id')
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            //查找的对应的Buyer的微信公众号
            WechatProfile wechatProfile=WechatProfile.findByProfileId(mikuReturnGoods.buyerId)
            if (wechatProfile){
                ProfileWechat profileWechat=ProfileWechat.findById(wechatProfile.wechatId)
                if (profileWechat){
                    //证书的路径的指定
                    //进行支付-->支付成功后再进行对表的操作
                    String info=wxRefundService.wxRefundToMoneyToDoByWechatProfile(profileWechat,mikuReturnGoods,path)
                    if ("SUCCESS".equals(info)){
                        mikuReturnGoods.status=3L
                        mikuReturnGoods.timeoutActionTime=new Date()
                        mikuReturnGoods.save(failOnError: true, flush: true)
                        //再进行查出对应的order表数据
                        Order order=Order.findById(mikuReturnGoods.orderId)
                        order.returnStatus=3L
                        order.save(failOnError: true, flush: true)
                        //进行钱包数据的更新
                        MikuWallet mikuWallet=MikuWallet.findByUserId(mikuReturnGoods.buyerId)
                        if (mikuWallet){
                            mikuWallet.balanceFee+=mikuReturnGoods.refundFee
                            mikuWallet.save(failOnError: true, flush: true)
                        }
                        //新添一条数据
                        MikuWalletOrigin mikuWalletOrigin=new MikuWalletOrigin()
                        mikuWalletOrigin.with {
                            it.userId=mikuReturnGoods.buyerId
                            it.type=0L
                            it.totalFee=mikuReturnGoods.refundFee
                            it.orginId=mikuReturnGoods.id
                            it.getpayStatus=1L
                            it.version=1L
                            it.dateCreated=new Date()
                            it.lastUpdated=new Date()
                            it.save(failOnError: true, flush: true)
                        }
                        //进行miku_sales_record的记录表进行修改
//                        List<MikuSalesRecord> mikuSalesRecordList=MikuSalesRecord.findAllByTradeIdAndItemId(mikuReturnGoods.tradeId,mikuReturnGoods.artificialId)
//                        for (int i=0;i<mikuSalesRecordList.size();i++){
//                            MikuSalesRecord mikuSalesRecord=mikuSalesRecordList.get(i)
//                            String str="update  MikuSalesRecord  set returnStatus=3,timeoutActionTime='"+df.format(new Date())+"' where id="+mikuSalesRecord.id
//                            MikuSalesRecord.executeUpdate(str)
//                            //修改对应的代理表中的数据
//                            MikuAgencyShareAccount mikuAgencyShareAccount=MikuAgencyShareAccount.findByAgencyId(mikuSalesRecord.agencyId)
//                            String str1="update  MikuAgencyShareAccount  set noGetpayFee="+(mikuAgencyShareAccount.noGetpayFee-mikuSalesRecord.shareFee)+",totalShareFee="+(mikuAgencyShareAccount.totalShareFee-mikuSalesRecord.shareFee)+"where id="+mikuAgencyShareAccount.id;
//                            MikuAgencyShareAccount.executeUpdate(str1)
//                        }
                        render('true')
                    }else{
                        render(info)
                    }
                }else{
                    //没有对应的微信用户
                    render("退货的用户没有关联微信账号")
                }
            }
            else{
                //连有关联数据（微信与用户关联表的内容）
                render("退货的用户没有关联微信账号")
            }
        }
    }



    @Transactional
    def returnThqGood(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String path=request.getSession().getServletContext().getRealPath("//")+"apiclient_cert.p12"
        def id=params.long('id')
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            //查找的对应的Buyer的微信公众号
            WechatProfile wechatProfile=WechatProfile.findByProfileId(mikuReturnGoods.buyerId)
            if (wechatProfile){
                ProfileWechat profileWechat=ProfileWechat.findById(wechatProfile.wechatId)
                if (profileWechat){
                    //当有对应的用户的时候【查看对应的order的总列数---->仅一条退货状态的话，则需要把trade表信息内容修改；如果是多条的话则不需要】
                    List<Order> orderList=Order.findAllByTradeId(mikuReturnGoods.tradeId)
                    //证书的路径的指定
                    //进行支付-->支付成功后再进行对表的操作
                    String info=wxRefundService.wxRefundToMoneyToDoByWechatProfile(profileWechat,mikuReturnGoods,path)
                    if ("SUCCESS".equals(info)){
                        mikuReturnGoods.status=3L
                        mikuReturnGoods.timeoutActionTime=new Date()
                        mikuReturnGoods.save(failOnError: true, flush: true)
                        //再进行查出对应的order表数据
                        Order order=Order.findById(mikuReturnGoods.orderId)
                        order.returnStatus=3L
                        order.save(failOnError: true, flush: true)
                        //进行钱包数据的更新
                        MikuWallet mikuWallet=MikuWallet.findByUserId(mikuReturnGoods.buyerId)
                        if (mikuWallet){
                            mikuWallet.balanceFee+=mikuReturnGoods.refundFee
                            mikuWallet.save(failOnError: true, flush: true)
                        }
                        //新添一条数据
                        MikuWalletOrigin mikuWalletOrigin=new MikuWalletOrigin()
                        mikuWalletOrigin.with {
                            it.userId=mikuReturnGoods.buyerId
                            it.type=0L
                            it.totalFee=mikuReturnGoods.refundFee
                            it.orginId=mikuReturnGoods.id
                            it.getpayStatus=1L
                            it.version=1L
                            it.dateCreated=new Date()
                            it.lastUpdated=new Date()
                            it.save(failOnError: true, flush: true)
                        }
                        //进行miku_sales_record的记录表进行修改
//                        List<MikuSalesRecord> mikuSalesRecordList=MikuSalesRecord.findAllByTradeIdAndItemId(mikuReturnGoods.tradeId,mikuReturnGoods.artificialId)
//                        for (int i=0;i<mikuSalesRecordList.size();i++){
//                            MikuSalesRecord mikuSalesRecord=mikuSalesRecordList.get(i)
//                            String str="update  MikuSalesRecord  set returnStatus=3,timeoutActionTime='"+df.format(new Date())+"' where id="+mikuSalesRecord.id
//                            MikuSalesRecord.executeUpdate(str)
//                            //修改对应的代理表中的数据
//                            MikuAgencyShareAccount mikuAgencyShareAccount=MikuAgencyShareAccount.findByAgencyId(mikuSalesRecord.agencyId)
//                            String str1="update  MikuAgencyShareAccount  set noGetpayFee="+(mikuAgencyShareAccount.noGetpayFee-mikuSalesRecord.shareFee)+",totalShareFee="+(mikuAgencyShareAccount.totalShareFee-mikuSalesRecord.shareFee)+"where id="+mikuAgencyShareAccount.id;
//                            MikuAgencyShareAccount.executeUpdate(str1)
//                        }
                        render('true')
                    }else{
                        render(info)
                    }
                }else{
                    //没有对应的微信用户
                    render("退货的用户没有关联微信账号")
                }
            }
            else{
                //连有关联数据（微信与用户关联表的内容）
                render("退货的用户没有关联微信账号")
            }
        }
    }



    //判断Order数据状态来决定Trade表status值
    def  dependTradeStatus(List<Order> orderList,Long orderId){
        //在退货之前的货物:具有3种状态（0:代表正常 1:代表退货当中 5:退货成功）
        int sum=orderList.size()
        int thcout=0
        List<Order> thOrderList=new ArrayList<Order>()
        int comcout=0
        int wcthcout=0
        orderList.each {
            Order order->
                if (order.returnStatus == 1 as byte){
                    thcout++
                    thOrderList.add(order)
                }
                else if (order.returnStatus == 0 as byte){
                    comcout++
                }
                else if (order.returnStatus == 5 as byte){
                    wcthcout++
                }
        }
        //数量的比较
        //获取order的状态的数据是来确定的Trade数据的状态
        //仅有1条数据为审核当中
        if (comcout && wcthcout && thcout){
            if (thcout == 1 && thOrderList.get(0).id == orderId)
            {
                return "1"
            }else
            {
                return "0"
            }
        }
    }



    def getDetail(PagedResultList pagedResultList){
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=new ArrayList<MikuReturnGoodsDetail>()
        pagedResultList.iterator().each {
            Order order->
//                MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findByOrderId(order.id)
                //查找的是MikuReturnGoods数据
                MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findByOrderIdAndStatusNotEqual(order.id,-1 as byte)
                if (mikuReturnGoods){
                    MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findByTradeIdAndItemId(mikuReturnGoods.tradeId,mikuReturnGoods.artificialId)
                    MikuReturnGoodsDetail mikuReturnGoodsDetail=copyItemService.getmikureturnInfo(mikuReturnGoods)
                    mikuReturnGoodsList.add(mikuReturnGoodsDetail)
                }
        }
        return  mikuReturnGoodsList
    }


    def getPageList(String query,Long tradeCode,Byte status){
        def od=Order.createCriteria()
        List<MikuReturnGoods> m1=MikuReturnGoods.findAllByTradeStatus(5 as byte)
        List<MikuReturnGoods> m2=MikuReturnGoods.findAllByTradeStatus(7 as byte)
        m2.each {
            MikuReturnGoods mikuReturnGoods->
                m1.add(mikuReturnGoods)
        }
        PagedResultList pagedResultList
        //查出对应正在退款当中的商品
        pagedResultList = od.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('returnStatus',status)
            order("id", "desc")
            if (query){
                Profile profile = Profile.findByMobile(query)
                if (profile){
                    eq("buyerId", profile.id)
                }else{
                    eq("buyerId",-1L)
                }
            }
            if (tradeCode){
                eq('tradeId',tradeCode)
            }
//            "in"('tradeStatus',[5 as byte,7 as byte])
//            'in'("tradeId", m1*.id)
        }
        return  pagedResultList
    }



    //=======================2016年03月10日进行直接退款的操作并不返回对应的积分与优惠劵[单纯的退款]========================//
    @Transactional
    def wxpayRefund(){
        def tradeid=params.long('id')
        Trade trade=Trade.findByTradeId(tradeid)
        List<WeixinBack> wxlist=WeixinBack.findAllByOutTradeNo(trade.tradeId)
        WeixinBack weixinBack=new WeixinBack()
        boolean flag=true
        String fileName="",info=""
        if (wxlist.size()>0){
            weixinBack= wxlist.get(0)
            if (weixinBack.openid){
                //米酷SDP
                fileName="sdp_miku_apiclient_cert.p12"
                //米酷mime
//                fileName="miku_apiclient_cert.p12"
                //丽源堂
//                fileName="apiclient_cert.p12"
            }else {
                fileName="app_apiclient_cert.p12"
                flag=false
            }
        }else{
            render("找不到对应的微信订单号")
            return false
        }
        //Miku Mine的公众号
        String path=request.getSession().getServletContext().getRealPath("//")+fileName
        if(flag){
            info=wxRefundService.wxrefundByOneTrade(path,weixinBack)
        }else{
            info=wxRefundService.mikuwxrefundByOneTrade(path,weixinBack)
        }
        if ("SUCCESS".equals(info)){
            //进行weixin_back表的新增
            WeixinBack newWx=new WeixinBack().with {
                it.appid=weixinBack.appid
                it.mchId=weixinBack.mchId
                it.nonceStr="微信公众号退款"
                it.deviceInfo="退款成功"
                it.sign=weixinBack.sign
                it.resultCode="success"
                it.openid=weixinBack.openid
                it.isSubscribe=weixinBack.isSubscribe
                it.tradeType="WEB"
                it.bankType=weixinBack.bankType
                it.totalFee=weixinBack.totalFee
                it.feeType=weixinBack.feeType
                it.transactionId=weixinBack.transactionId
                it.outTradeNo=weixinBack.outTradeNo
                it.dateCreated=new Date()
                it.lastUpdated=new Date()
                it.resultCode="success"
                it.save(failOnError: true, flush: true)
            }
            //进行订单的状态的改变
            if (tradeid && trade){
                //订单的修改
                trade.returnStatus= 2 as byte
                trade.status=8 as byte
                trade.timeoutActionTime=new DateTime().plusDays(7).toDate()
                trade.save(failOnError: true, flush: true)
                List<Order> orderList=Order.findAllByTradeId(trade.tradeId)
                //Order表的设值
                orderList.each {
                    Order order->
                        order.returnStatus=5L
                        order.save(failOnError: true, flush: true)
                        //取消整个订单的时候，这里需要注意的是Item表的库存与销售数量都需要改的[总仓+上架的商品]
                        Item item=Item.findById(order.artificialId)
                        if (item){
                            //抢购标商品的处理
                            if (order.hasPanicTag == 1 as byte){
                                def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)
                                //进行对限购标数量的获取[在售商品]
                                tagsOnShow.each {
                                    ObjectTagged objtag->
                                        Tags tags=Tags.findById(objtag.tagId)
                                        if (tags && "抢购标".equals(tags.name))
                                        {
                                            if (objtag.activityNum && order.num && objtag.activitySoldNum && order.num){
                                                //库存
                                                objtag.activityNum= objtag.activityNum+order.num
                                                //已售数量
                                                objtag.activitySoldNum=objtag.activitySoldNum-order.num
                                                objtag.save(failOnError: true, flush: true)
                                            }
                                        }
                                }
                                //总仓信息内容修改
                                Item baseItem=Item.findById(item.baseItemId)
                                def baseTagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(baseItem.id, 1 as byte)
                                //进行对限购标数量的获取[总仓]
                                baseTagsOnShow.each {
                                    ObjectTagged objtag->
                                        Tags tags=Tags.findById(objtag.tagId)
                                        if (tags && "抢购标".equals(tags.name))
                                        {
                                            if (objtag.activityNum && order.num && objtag.activitySoldNum  && order.num){
                                                //库存
                                                objtag.activityNum= objtag.activityNum+order.num
                                                //已售数量
                                                objtag.activitySoldNum=objtag.activitySoldNum-order.num
                                                objtag.save(failOnError: true, flush: true)
                                            }
                                        }
                                }
                            }else{
                                //上架商品信息的修改
                                item.soldQuantity=item.soldQuantity-order.num
                                item.num=item.num+order.num
                                item.save(failOnError: true, flush: true)
                                //总仓信息内容修改
                                Item baseItem=Item.findById(item.baseItemId)
                                baseItem.num=item.num+order.num
                                baseItem.save(failOnError: true, flush: true)
                            }
                        }
                }
                //退货表的状态
                List<MikuReturnGoods> mikuReturnGoodsList=MikuReturnGoods.findAllByTradeId(trade.tradeId)
                mikuReturnGoodsList.each {
                    MikuReturnGoods mm->
                        if (mm.status!=-1L){
                            mm.status=5L
                            mm.timeoutActionTime=new DateTime().plusDays(7).toDate()
                            mm.finishTime=new Date()
                            mm.save(failOnError: true, flush: true)
                        }
                }
            }
        }
        else{
            render(info)
        }
        render('true')
    }




    //支付宝的全额退款
    @Transactional
    def alipayRefund(){

    }




    //自定义退款的界面
    def personaldefine(){
        def tradeCode=params.long('tradeCode')
        def t = Trade.createCriteria()
        def tradeMap = [:]
        PagedResultList pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
            }else {
                eq('tradeId',-1L)
            }
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
                List<MikuReturnGoods> mikuReturnGoodsList=MikuReturnGoods.findAllByTradeId(trade.tradeId)
                String iteminfo=""
                String reason=""
                for (int i=0;i<mikuReturnGoodsList.size();i++){
                    if (i==mikuReturnGoodsList.size()-1){
                        iteminfo=iteminfo+mikuReturnGoodsList.get(i).title
                        reason=mikuReturnGoodsList.get(i).returnReason
                    }else{
                        iteminfo=iteminfo+mikuReturnGoodsList.get(i).title
                        iteminfo=iteminfo+" ,  "
                    }
                }
                //判断是否过期
                Byte isgq=0 as byte
                if (trade.timeoutActionTime>new Date()){
                    isgq=1 as byte
                }
                //查看是否是支付宝的退款
                if (trade.payType== 3 as byte){
                    List<AlipayBack> alipayBackList=AlipayBack.findAllByOutTradeNo(trade.tradeId)
                    if (alipayBackList.size()>0){
                        trade.buyerMemo=alipayBackList.get(0).buyerEmail
                        trade.alipayNo=alipayBackList.get(0).tradeNo
                    }
                }
                tradeMap.put(trade.id, new TradeDetail(
                        tradeId: trade.tradeId,
                        profileMobile: profile?.mobile,
                        communityName: Community.findById(trade.communityId)?.name,
                        address: headAddr,
                        modifiAddr: consigneeAddr?.modifiAddr,
                        receiverName: logistics?.contactName,
                        receiverMobile: logistics?.mobile,
                        totalPrice: trade.totalFee,
                        status: trade.status,
                        iteminfo: iteminfo,
                        reason: reason,
                        ispassDate: isgq,
                        tradeMemo: trade?.buyerMessage ?: '无备注',
                        createTime: trade.dateCreated.toString().substring(0, 16),
                        appointDeliveryTime: trade?.appointDeliveryTime ? trade?.appointDeliveryTime.toString().substring(0, 16) : '未预约',
                        consignTime: trade?.consignTime ? trade?.consignTime.toString().substring(0, 16) : '无记录',
                        confirmTime: trade?.confirmTime ? trade?.confirmTime.toString().substring(0, 16) : '无记录',
                        courierName: trade?.courier ? (Employee.findById(trade?.courier)?.name) : '没有发货人'
                ))
        }
        return [
                total          : pagedResultList?.totalCount,
                params         : params,
                tradeList      : pagedResultList,
                tradeMap       : tradeMap,
                PageMap        : PageMap,
                payTypeMap     : TradeNoShipController.PAY_TYPE_MAP,
                shippingTypeMap: TradeNoShipController.SHIPPING_TYPE_MAP,
                totalFeeOpMap  : TradeNoShipController.TOTAL_FEE_OP_MAP,
                orderMap       : TradeNoShipController.ORDER_MAP,
                orderEntryMap  : ORDER_ENTITY_MAP,
        ]

    }




    //单品的查找
    def personalOrderdefine(){
        def tradeCode=params.long('tradeCode')
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findByOrderIdAndStatusNotEqual(tradeCode,-1 as byte)
        List<MikuReturnGoodsDetail> mikuReturnGoodsList=new ArrayList<MikuReturnGoodsDetail>()
        if (mikuReturnGoods){
            MikuReturnGoodsDetail mikuReturnGoodsDetail=copyItemService.getmikureturnInfo(mikuReturnGoods)
            mikuReturnGoodsList.add(mikuReturnGoodsDetail)
        }
        render(view: 'personalOrderdefine', model: [
                total          : mikuReturnGoodsList.size(),
                viewTotal      : mikuReturnGoodsList.size(),
                params         : params,
                PageMap        : PageMap,
                mikuReturnGoodsList : mikuReturnGoodsList
        ])
    }


    //单品的退款
    def refundOneOrder(){
        def id=params.long('id')
        //修改2长表的状态
        MikuReturnGoods mikuReturnGoods=MikuReturnGoods.findById(id)
        if (mikuReturnGoods){
            mikuReturnGoods.status=5L
            mikuReturnGoods.timeoutActionTime=new Date()
            mikuReturnGoods.finishTime=new Date()
            mikuReturnGoods.save(failOnError: true, flush: true)
            //再进行查出对应的order表数据
            Order order=Order.findById(mikuReturnGoods.orderId)
            order.returnStatus=5L
            order.save(failOnError: true, flush: true)
            //进行trade表的操作
            Trade trade=Trade.findByTradeId(mikuReturnGoods.tradeId)
            List<Order> orderList=Order.findAllByTradeId(mikuReturnGoods.tradeId)
            int flag=0
            for (int i=0;i<orderList.size();i++){
                if (orderList.get(i).returnStatus!= 5 as byte){
                    flag=1
                    break
                }
            }
            if (flag){
                trade.returnStatus=0 as byte
                trade.timeoutActionTime=new DateTime().plusDays(3).toDate()
            }else {
                trade.returnStatus=2 as byte
                trade.status=8 as byte
                trade.timeoutActionTime=new DateTime().plusDays(7).toDate()
            }
            trade.save(failOnError: true, flush: true)
        }
        render('true')
    }




}

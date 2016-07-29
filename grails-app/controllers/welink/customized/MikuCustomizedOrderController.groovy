package welink.customized

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import org.springframework.core.task.TaskExecutor
import welink.business.TradeDetail
import welink.common.*
import welink.user.Profile

import javax.annotation.Resource

//私人定制订单管理
class MikuCustomizedOrderController {

    @Resource(name = 'eventTaskExecutor')
    TaskExecutor eventTaskExecutor;

    static ImmutableMap<String, String> PAY_TYPE_MAP = ImmutableMap.builder() //
            .put("3", "支付宝支付")
            .put("4", "微信支付")
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

    //以下是对项目订单处理
    def index() {
        // 电话号码
        String mobile = params.query
        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }
        //时间
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        // 开始时间
        String startTime = params.startTime
        // 结束时间
        String endTime = params.endTime
        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null
        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        //订单号的查询
        def tradeCode=params.long('tradeCode')
        // 实付金额的操作
        def totalFeeOp = params.totalFeeOp
        // 实付金额的价格
        def targetTotalFee = params.targetTotalFee
        //openSearch的操作
        log.info "=======测试同步trade-Search 开始=========》"
//        undeliveredTradeScheduleService.execute();
        log.info "=======测试同步trade-Search 结束=========》"
        //查询符合Trade表操作的数据
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
//            'in'('status', [2, 4, 6, 5, 7, 9,20] as byte[])
            eq('returnStatus', 0 as byte)
            eq('type',12 as byte)
            if (start != null) {
                gt("dateCreated", start)
            }
            if (end != null) {
                lt("dateCreated", end)
            }
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
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

        List<TradeDetail> list = new ArrayList<TradeDetail>()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                TradeDetail tradeDetail=getTradeDetail(trade)
                list.add(tradeDetail)
        }
        return [
                tradeList      : list,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                payTypeMap     : PAY_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
        ]
    }

    //未付款的订单
    def nopay(){
        // 电话号码
        String mobile = params.query
        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }
        //订单号的查询
        def tradeCode=params.long('tradeCode')
        //查询符合Trade表操作的数据
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 2 as byte)
            eq('returnStatus', 0 as byte)
            eq('type',12 as byte)
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
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
        List<TradeDetail> list = new ArrayList<TradeDetail>()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                TradeDetail tradeDetail=getTradeDetail(trade)
                list.add(tradeDetail)
        }
        return [
                tradeList      : list,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                payTypeMap     : PAY_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
        ]
    }

    //zcFail:失败的订单
    def zcFail(){
        // 电话号码
        String mobile = params.query
        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }
        //订单号的查询
        def tradeCode=params.long('tradeCode')

        //查询符合Trade表操作的数据
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            eq('returnStatus', 0 as byte)
            eq('crowdfundRefundStatus', 1 as byte)
            eq('type',12 as byte)
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
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
//            order('id', 'desc')
        }
        List<TradeDetail> list = new ArrayList<TradeDetail>()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                TradeDetail tradeDetail=getTradeDetail(trade)
                list.add(tradeDetail)
        }
        return [
                tradeList      : list,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                payTypeMap     : PAY_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
        ]
    }

    //成功的订单
    def zcSuccess(){
        // 电话号码
        String mobile = params.query
        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }

        //时间
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        // 开始时间
        String startTime = params.startTime
        // 结束时间
        String endTime = params.endTime
        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null
        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        //订单号的查询
        def tradeCode=params.long('tradeCode')
        // 实付金额的操作
        def totalFeeOp = params.totalFeeOp
        // 实付金额的价格
        def targetTotalFee = params.targetTotalFee
        //查询符合Trade表操作的数据
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            eq('status', 4 as byte)
            eq('returnStatus', 0 as byte)
            eq('type',12 as byte)
            if (start != null) {
                gt("dateCreated", start)
            }
            if (end != null) {
                lt("dateCreated", end)
            }
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
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

        List<TradeDetail> list = new ArrayList<TradeDetail>()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                TradeDetail tradeDetail=getTradeDetail(trade)
                list.add(tradeDetail)
        }
        return [
                tradeList      : list,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                payTypeMap     : PAY_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
        ]
    }

    //待发货的页面
    def dfhuo(){
        // 电话号码
        String mobile = params.query
        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }

        //时间
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        // 开始时间
        String startTime = params.startTime
        // 结束时间
        String endTime = params.endTime
        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null
        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        //订单号的查询
        def tradeCode=params.long('tradeCode')
        // 实付金额的操作
        def totalFeeOp = params.totalFeeOp
        // 实付金额的价格
        def targetTotalFee = params.targetTotalFee
        //查询符合Trade表操作的数据
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            eq('status', 6 as byte)
            eq('returnStatus', 0 as byte)
            eq('type',12 as byte)
            if (start != null) {
                gt("dateCreated", start)
            }
            if (end != null) {
                lt("dateCreated", end)
            }
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
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

        List<TradeDetail> list = new ArrayList<TradeDetail>()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                TradeDetail tradeDetail=getTradeDetail(trade)
                list.add(tradeDetail)
        }
        return [
                tradeList      : list,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                payTypeMap     : PAY_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
        ]
    }

    //取消对应的订单
    def cancelOneTrade(){
        def id=params.long('id')
        Trade trade=Trade.findByTradeId(id)
        if (trade){
            trade.status=9 as byte
            trade.save(failOnError: true, flush: true)
        }
        redirect(action: 'nopay')
    }

    //传trade值进行获取的tradeDetail的值
    def getTradeDetail(Trade trade){
        //物流信息
        def  logic=Logistics.findById(trade.consigneeId)
        ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logic?.consigneeId)
        TradeDetail tradeDetail=new TradeDetail()
        //商品信息
        String info=""
        String[] ordersids=trade.orders.split(";")
        ordersids.each{
            oid->
                def order=Order.findById(Long.parseLong(oid))
                String str=order?.title+"x"+order?.num
                info+=str
                info+="             "
        }
        def headAddr = logic?.addr
        //具体地址的添加
        if (logic) {
            headAddr = logic.country + logic.province + logic?.addr
        }

        tradeDetail.with {
            it.id=trade.id
            it.tradeFrom=trade.tradeFrom
            it.shippingType=trade.shippingType
            it.dateCreated=trade.dateCreated
            it.totalFee=trade.totalFee
            it.tradeMemo=trade.tradeMemo
            it.payType=trade.payType
            it.buyerMessage=trade.buyerMessage
            it.tradeId=trade.tradeId
            it.price=trade.price
            //modifiAddr
            it.modifiAddr=consigneeAddr?.modifiAddr
            //receiverMobile
            it.receiverMobile=logic?.mobile
            //receiverName
            it.receiverName=logic?.contactName
            it.address=headAddr
            it.info=info
            it.status=trade.status
            it.totalFee=trade.totalFee
            //物流信息
            it.memo=logic.memo
            it.crowdfundRefundStatus=trade.crowdfundRefundStatus

            //添加付款方式:判断是支付宝 还是微信应用的【需要分开微信版 + APP版本】
            //支付的方式【支付宝1 公众号微信2  app的微信版3  不明支付-1】
            it.refundpayType=-1 as byte
            if (trade.payType== 3 as byte){
                it.refundpayType=1 as byte
                List<AlipayBack> alipayBackList=AlipayBack.findAllByOutTradeNo(trade.tradeId)
                if (alipayBackList.size()>0){
                    it.buyerMemo=alipayBackList.get(0).buyerEmail
                    it.alipayNo=alipayBackList.get(0).tradeNo
                }
            }else if (trade.payType== 4 as byte){
                List<WeixinBack> wxlist=WeixinBack.findAllByOutTradeNo(trade.tradeId)
                if (wxlist.size()>0){
                    it.wxpayId=wxlist.get(0).id
                    if (wxlist.get(0).openid){
                        it.refundpayType=2 as byte
                    }else {
                        it.refundpayType=3 as byte
                    }
                }
            }
        }
        return  tradeDetail
    }

    //批量备单的操作
    def shipTradeChecked(){
        def tradeIds = Lists.newArrayList(params.tradeShipBox)
        tradeIds.each {
            String it ->
                Long id = Long.parseLong(it)
                Trade trade = Trade.findByIdAndStatus(id, 4 as byte)
                if (trade) {
                    trade.status = 6
                    trade.consignTime = new Date()//调度时间
                    trade.timeoutActionTime = new DateTime().plusDays(3).toDate()
                    trade.save(failOnError: true, flush: true)
                }
        }
        redirect(action: "zcSuccess")
    }

    //goCancelToWcl:撤销返回的操作
    def goCancelToWcl(){
        def ids=params.goCancelids
        String[] idsarr=ids.split(",")
        idsarr.each {
            id->
                def  trade=Trade.findById(Long.parseLong(id))
                trade.status=4 as byte
                trade.save(failOnError: true, flush: true)
        }
        redirect(action: 'dfhuo')
    }

    //撤销让商品的status回到5--->6
    def goCancel(){
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
        }
        redirect( action: 'shipped')
        return;
    }

    def shipped(){
        // 电话号码
        String mobile = params.query
        if (StringUtils.isNotBlank(mobile)) {
            mobile = StringUtils.replace(mobile, "-", "");
        }

        //时间
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        // 开始时间
        String startTime = params.startTime
        // 结束时间
        String endTime = params.endTime
        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null
        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        //订单号的查询
        def tradeCode=params.long('tradeCode')
        // 实付金额的操作
        def totalFeeOp = params.totalFeeOp
        // 实付金额的价格
        def targetTotalFee = params.targetTotalFee
        //查询符合Trade表操作的数据
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            eq('status', 5 as byte)
            eq('returnStatus', 0 as byte)
            eq('type',12 as byte)
            if (start != null) {
                gt("dateCreated", start)
            }
            if (end != null) {
                lt("dateCreated", end)
            }
            if (tradeCode)
            {
                eq('tradeId',tradeCode)
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

        List<TradeDetail> list = new ArrayList<TradeDetail>()
        //具体的交易订单的信息
        pagedResultList.iterator().each {
            Trade trade ->
                TradeDetail tradeDetail=getTradeDetail(trade)
                list.add(tradeDetail)
        }
        return [
                tradeList      : list,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                payTypeMap     : PAY_TYPE_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
        ]
    }

    def test(){}

}

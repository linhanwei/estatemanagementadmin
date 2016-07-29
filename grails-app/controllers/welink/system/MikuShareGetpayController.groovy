package welink.system

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.MikuGetPayDetail
import welink.business.MikuSalesRecordDetail
import welink.common.*
import welink.user.ProfileWechat
import welink.user.WechatProfile

import java.text.SimpleDateFormat

class MikuShareGetpayController {

    static String partner = "2088101295767275";
    static String key = "geconpb5bh6ols7qtb89n4b9c6cqej3d";
    static String input_charset = "utf-8";
    GetPayInfoService  getPayInfoService
    def wxRefundService
    def alipayRefundService

    static ImmutableMap<String, String> PAY_TYPE_MAP = ImmutableMap.builder() //
            .put("1", "支付宝")
            .put("2", "微信钱包")
            .put("3", "银行卡")
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
//            .put(1, "1")
//            .put(2, "2")
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(70, "70")
            .put(80, "80")
            .put(100, "100")
            .put(200, "200")
            .put(300, "300")
            .put(500, "500")
            .put(1000, "1000")
            .build()





    def index() {

        def agencyMobile =params.agencyMobile
        if (agencyMobile) {
            agencyMobile = StringUtils.replace(agencyMobile, "-", "");
        }

        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        // 支付方式
        def payType = params.payType

        // 排序规则
        def ord = params.order

        //进行比较符号
        def totalFeeOp=params.totalFeeOp
        //金钱的多少
        def  targetTotalFee=params.targetTotalFee
        if (targetTotalFee)
        {
//            targetTotalFee=Long.parseLong(targetTotalFee)*100
            targetTotalFee=Long.parseLong(targetTotalFee)*100
        }

        def mkgp=ProFitGetPay.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = mkgp.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 0 as byte)


            if (agencyMobile) {
                eq('agencyMobile', agencyMobile)
            }

            if (start != null) {
                gt("transDate", start)
            }

            if (end != null) {
                lt("transDate", end)
            }

            if(payType)
            {
                eq('getpayType', Long.parseLong(payType))
            }


            if(targetTotalFee)
            {
                if (totalFeeOp.equals(">"))
                {
                    gt("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("="))
                {
                    eq("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("<"))
                {
                    lt("getpayFee",targetTotalFee)
                }
            }

            if(ord)
            {
                if (ord.equals("-"))
                {
                    order('getpayFee','desc')
                    order('applyDate','desc')
                }
                else if (ord.equals("+"))
                {
                    order('getpayFee','asc')
                    order('applyDate','asc')
                }
            }
            else {
                order('id','desc')
            }

        }

        List<MikuGetPayDetail> mgpd=new ArrayList<MikuGetPayDetail>()

        pagedResultList.iterator().each {
            ProFitGetPay proFitGetPay->
                List<MikuShareGetpay> msgpList=MikuShareGetpay.findAllByGetpayId(proFitGetPay.id)
//                PagedResultList msRecordList
                List<MikuSalesRecord> mikuSalesRecordList=new ArrayList<MikuSalesRecord>()
//                if (msgpList.size()>0){
//                    for(int i=0;i<msgpList.size();i++){
//                        MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(msgpList.get(i).salesRecordId)
//                        mikuSalesRecordList.add(mikuSalesRecord)
//                    }
////                    msRecordList=MikuSalesRecord.createCriteria().list {
////                        'in'("id", msgpList*.salesRecordId)
////                    }
//                }
                MikuGetPayDetail oneDetail=getPayInfoService.getOneGetPayInfo(mikuSalesRecordList,proFitGetPay,msgpList.size())
                mgpd.add(oneDetail)
        }
        List<MikuSalesRecordDetail> mikuSalesRecordDetailList=new ArrayList<MikuSalesRecordDetail>()


        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                getPayList     : mgpd,
                params         : params,
                PageMap    : PageMap,
                list           : mikuSalesRecordDetailList,
                payTypeMap     : PAY_TYPE_MAP,
                orderMap       : ORDER_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP
        ]


    }


    def allInfo(){
        def agencyMobile =params.agencyMobile
        if (agencyMobile) {
            agencyMobile = StringUtils.replace(agencyMobile, "-", "");
        }

        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        // 支付方式
        def payType = params.payType

        // 排序规则
        def ord = params.order

        //进行比较符号
        def totalFeeOp=params.totalFeeOp
        //金钱的多少
        def  targetTotalFee=params.targetTotalFee
        if (targetTotalFee)
        {
            targetTotalFee=new BigDecimal(targetTotalFee)
        }

        def mkgp=ProFitGetPay.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = mkgp.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            if (agencyMobile) {
                eq('agencyMobile', agencyMobile)
            }

            if (start != null) {
                gt("transDate", start)
            }

            if (end != null) {
                lt("transDate", end)
            }

            if(payType)
            {
                eq('getpayType', Long.parseLong(payType))
            }


            if(targetTotalFee)
            {
                if (totalFeeOp.equals(">"))
                {
                    gt("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("="))
                {
                    eq("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("<"))
                {
                    lt("getpayFee",targetTotalFee)
                }
            }

            if(ord)
            {
                if (ord.equals("-"))
                {
                    order('getpayFee','desc')
                    order('applyDate','desc')
                }
                else if (ord.equals("+"))
                {
                    order('getpayFee','asc')
                    order('applyDate','asc')
                }
            }
            else {
                order('id','desc')
            }

        }

        List<MikuGetPayDetail> mgpd=new ArrayList<MikuGetPayDetail>()

        pagedResultList.iterator().each {
            ProFitGetPay proFitGetPay->
                List<MikuShareGetpay> msgpList=MikuShareGetpay.findAllByGetpayId(proFitGetPay.id)
//                PagedResultList msRecordList
                List<MikuSalesRecord> mikuSalesRecordList=new ArrayList<MikuSalesRecord>()
//                if (msgpList.size()>0){
//                    for(int i=0;i<msgpList.size();i++){
//                        MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(msgpList.get(i).salesRecordId)
//                        mikuSalesRecordList.add(mikuSalesRecord)
//                    }
////                    msRecordList=MikuSalesRecord.createCriteria().list {
////                        'in'("id", msgpList*.salesRecordId)
////                    }
//                }
                MikuGetPayDetail oneDetail=getPayInfoService.getOneGetPayInfo(mikuSalesRecordList,proFitGetPay,msgpList.size())
                mgpd.add(oneDetail)
        }
        List<MikuSalesRecordDetail> mikuSalesRecordDetailList=new ArrayList<MikuSalesRecordDetail>()


        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                getPayList     : mgpd,
                params         : params,
                PageMap    : PageMap,
                list           : mikuSalesRecordDetailList,
                payTypeMap     : PAY_TYPE_MAP,
                orderMap       : ORDER_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP
        ]
    }


    @Transactional
    def lookDetail(){

        ProFitGetPay proFitGetPay=ProFitGetPay.findById(params.long('id'))

        List<MikuShareGetpay> msgpList=MikuShareGetpay.findAllByGetpayId(proFitGetPay.id)
        List<MikuSalesRecord> mikuSalesRecordList=new ArrayList<MikuSalesRecord>()
        if (msgpList.size()>0){
            for(int i=0;i<msgpList.size();i++){
                MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(msgpList.get(i).salesRecordId)
                mikuSalesRecordList.add(mikuSalesRecord)
            }
        }

        //查找对应的商品
        List<MikuSalesRecordDetail> mikuSalesRecordDetailList=getPayInfoService.getsalesRecordeDetail(mikuSalesRecordList)
        render(template: "detail", model: [
                list:mikuSalesRecordDetailList
        ])
    }


    @Transactional
    def shipTradeChecked(){

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
        def Ids = Lists.newArrayList(params.modelShipBox)
        for (int i=0;i<Ids.size();i++)
        {
            def  p=ProFitGetPay.findById(Long.parseLong(Ids.get(i)))
            String str="update  ProFitGetPay m set status=1,lastUpated='"+df.format(new Date())+"'"
            str+="  where m.id="+Long.parseLong(Ids[i])
            ProFitGetPay.executeUpdate(str)

            //需要对3个表进行：MikuAgencyShareAccount  ProFitGetPay  MikuSalesRecord
            List<MikuShareGetpay> mikuShareGetpayList=MikuShareGetpay.findAllByGetpayId(Ids.get(i))
//            getPayInfoService.changeSalesRecordStatus(mikuShareGetpayList,p)
//            //最重要的分润信息进行修改
//            //进行分润金额的修改
            MikuAgencyShareAccount masa=MikuAgencyShareAccount.findByAgencyId(p.agencyId)
            def successNum=0
//            //记录表进行了修改
            mikuShareGetpayList.each {
                MikuShareGetpay mikuShareGetpay->
                    MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
                    Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
                    if (trade.status==7 as byte){
                        mikuSalesRecord.isGetpay=2L
                        successNum+=mikuSalesRecord.shareFee
                    }
                    else if (trade.status== 8 as byte){
                        mikuSalesRecord.isGetpay=1L
                    }else {
                        mikuSalesRecord.isGetpay=0L
                    }
//                String sql="update MikuSalesRecord msr set isGetpay="+mikuSalesRecord.isGetpay+" where msr.id="+mikuSalesRecord.id
//                MikuSalesRecord.executeUpdate(sql)
//                    MikuSalesRecord.executeQuery(sql)
//              mikuSalesRecord.save(failOnError: true, flush: true)
            }

//            for(int i=0;i<mikuShareGetpayList.size();i++){
//                MikuShareGetpay mikuShareGetpay=mikuShareGetpayList.get(i)
//                MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
//                Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
//                if (trade.status==7 as byte){
//                    mikuSalesRecord.isGetpay=2L
//                    successNum+=mikuSalesRecord.shareFee
//                }
//                else if (trade.status== 8 as byte){
//                    mikuSalesRecord.isGetpay=1L
//                }else {
//                    mikuSalesRecord.isGetpay=0L
//                }
////                String sql="update MikuSalesRecord msr set isGetpay="+mikuSalesRecord.isGetpay+" where msr.id="+mikuSalesRecord.id
////                MikuSalesRecord.executeUpdate(sql)
//            mikuSalesRecord.save(failOnError: true, flush: true)
//            }
//
            //未提现金额
            masa.noGetpayFee=masa.noGetpayFee-successNum
            //已提现
            masa.totalGotpayFee=masa.totalGotpayFee+successNum
            //提现中的数据
            masa.getpayingFee=masa.getpayingFee-successNum
            masa.lastUpdated=new Date()
//            masa.save(failOnError: true, flush: true)

            String sqlStr="update MikuAgencyShareAccount mm set noGetpayFee="+masa.noGetpayFee+",totalGotpayFee="+masa.totalGotpayFee+",getpayingFee="+masa.getpayingFee
            sqlStr+="  ,lastUpdated='"+df.format(new Date())+"'  where mm.id="+masa.id
            MikuAgencyShareAccount.executeUpdate(sqlStr)
        }
        redirect(uri: '/mikuShareGetpay/index')

    }


    def changeGetPayStatus(){
        def Ids =params.ids
        String[] idarr=Ids.split("&&")
        for (int i=0;i<idarr.length;i++){
            List<MikuShareGetpay> mikuShareGetpayList=MikuShareGetpay.findAllByGetpayId(Long.parseLong(idarr[i]))
            mikuShareGetpayList.each {
                MikuShareGetpay mikuShareGetpay->
                    MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
                    Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
                    if (trade.status==7 as byte){
                        mikuSalesRecord.isGetpay=2L
                    }
                    else if (trade.status== 8 as byte){
                        mikuSalesRecord.isGetpay=1L
                    }else {
                        mikuSalesRecord.isGetpay=0L
                    }
                    String sql="update MikuSalesRecord msr set isGetpay="+mikuSalesRecord.isGetpay+" where msr.id="+mikuSalesRecord.id
                    MikuSalesRecord.executeUpdate(sql)
//              mikuSalesRecord.save(failOnError: true, flush: true)
            }
        }
        render('1')
        return
    }



    //单单进行审核的功能
    @Transactional
    def changeSumGetPayStatusMethod(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
        def Ids = Lists.newArrayList(params.modelShipBox)
        for (int i=0;i<Ids.size();i++)
        {
            def  p=ProFitGetPay.findById(Long.parseLong(Ids.get(i)))
            p.status=1 as byte
            p.lastUpated=new Date()
            p.save(failOnError: true, flush: true)
            //需要对3个表进行：MikuAgencyShareAccount  ProFitGetPay  MikuSalesRecord
            List<MikuShareGetpay> mikuShareGetpayList=MikuShareGetpay.findAllByGetpayId(Ids.get(i))
//            //最重要的分润信息进行修改
//            //进行分润金额的修改
            MikuAgencyShareAccount masa=MikuAgencyShareAccount.findByAgencyId(p.agencyId)
            def successNum=0
//            //记录表进行了修改
            mikuShareGetpayList.each {
                MikuShareGetpay mikuShareGetpay->
                    MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
                    Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
                    if (trade.status==20 as byte){
                        mikuSalesRecord.isGetpay=2L
                        successNum+=mikuSalesRecord.shareFee
                    }
                    else if (trade.status== 8 as byte){
                        mikuSalesRecord.isGetpay=1L
                    }else {
                        mikuSalesRecord.isGetpay=0L
                    }
                    mikuSalesRecord.save(failOnError: true, flush: true)
            }
            //未提现金额
            masa.noGetpayFee=masa.noGetpayFee-successNum
            //已提现
            masa.totalGotpayFee=masa.totalGotpayFee+successNum
            //提现中的数据
            masa.getpayingFee=masa.getpayingFee-successNum
            masa.lastUpdated=new Date()
            masa.save(failOnError: true, flush: true)
        }
        redirect(uri: '/mikuShareGetpay/index')
    }

    //审核+微信支付的操作
    @Transactional
    def changeSumGetPayStatusMethodBywxService(){
        //丽源堂
//        String path=request.getSession().getServletContext().getRealPath("//")+"apiclient_cert.p12"

        //Miku Mine的公众号
//        String path=request.getSession().getServletContext().getRealPath("//")+"miku_apiclient_cert.p12"
        //Miku SDP的公众号
        String path=request.getSession().getServletContext().getRealPath("//")+"sdp_miku_apiclient_cert.p12"
            def Id = params.long("id")
            def  p=ProFitGetPay.findById(Id)
            int price=params.int('price')
            //需要对3个表进行：MikuAgencyShareAccount  ProFitGetPay  MikuSalesRecord
            List<MikuShareGetpay> mikuShareGetpayList=MikuShareGetpay.findAllByGetpayId(Id)
            //最重要的分润信息进行修改
            //进行分润金额的修改
            MikuAgencyShareAccount masa=MikuAgencyShareAccount.findByAgencyId(p.agencyId)
            int successNum=0
            boolean flag=false
            //记录表进行了修改
//            mikuShareGetpayList.each {
//                MikuShareGetpay mikuShareGetpay->
//                    MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
//                    Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
//                    String orders=trade.orders
//                    String[] arr=orders.split(";")
//                    for (int i=0;i<arr.length;i++){
//                        Long myid=Long.parseLong(arr[i])
//                        if (myid){
//                            Order order=Order.findById(myid)
//                            if (order){
//                                Item item=Item.findById(order.artificialId)
//                                if (item && item.isrefund==1 as byte && trade.status!=20 as byte)
//                                {
//                                    flag=true
//                                }
//                            }
//                        }
//                    }
//            }
//
//        mikuShareGetpayList.each {
//            MikuShareGetpay mikuShareGetpay ->
//                MikuSalesRecord mikuSalesRecord = MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
//                Trade trade = Trade.findByTradeId(mikuSalesRecord.tradeId)
//                if (flag){
//                    if (trade.status==20 as byte){
//                        successNum+=mikuSalesRecord.shareFee
//                    }
//                }
//                else{
//                    successNum+=mikuSalesRecord.shareFee
//                }
//        }

            //进行微信的企业支付--->证书，操作成功之后进行对分润表数据操作
            //先查找对应的微信账户
            //查找的对应的Buyer的微信公众号
//            WechatProfile wechatProfile=null
            WechatProfile wechatProfile=WechatProfile.findByProfileId(masa.agencyId)
            //测试
//            if (!wechatProfile){
//                wechatProfile=WechatProfile.findById(56069)
//            }
            if (wechatProfile){
                //具有对应微信公众号对应的微信成员
                ProfileWechat profileWechat=ProfileWechat.findById(wechatProfile.wechatId)
                if (profileWechat){
                    String info=wxRefundService.wxmikugetByWechatProfile(profileWechat,price,path)
                    if ("SUCCESS".equals(info)){
                        //添加一条微信记录
                        WeixinBack newWx=new WeixinBack().with {
                            it.deviceInfo="提现分润"
                            it.nonceStr="微信提现"
                            it.resultCode="success"
                            it.openid=profileWechat.openid
                            it.tradeType="WEB"
                            it.bankType="PAY"
                            it.totalFee=price
                            it.feeType="CNY"
                            it.couponBatchId_n=Id+""
                            it.attach=profileWechat.nickname
                            it.dateCreated=new Date()
                            it.lastUpdated=new Date()
                            if(price==successNum){
                                it.sign="校验成功.金额是相等的,对应金额为"+price
                            }else{
                                it.sign=("校验是不对的,提现的金额为:"+price + "    对应的金额为:"+successNum)
                            }
                            it.resultCode="success"
                            it.save(failOnError: true, flush: true)
                        }
                        mikuShareGetpayList.each {
                            MikuShareGetpay mikuShareGetpay->
                                MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
//                                Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
//                                boolean nfalg=false
//                                String orders=trade.orders
//                                String[] arr=orders.split(";")
//                                for (int i=0;i<arr.length;i++){
//                                    Long myid=Long.parseLong(arr[i])
//                                    if (myid){
//                                        Order order=Order.findById(myid)
//                                        if (order){
//                                            Item item=Item.findById(order.artificialId)
//                                            if (item && item.isrefund==1 as byte && trade.status!=20 as byte)
//                                            {
//                                                nfalg=true
//                                            }
//                                        }
//                                    }
//                                }
//                                if (nfalg){
//                                    if (trade.status==20 as byte){
//                                        mikuSalesRecord.isGetpay=1L
//                                    }
//                                    else if (trade.status== 8 as byte){
//                                        mikuSalesRecord.isGetpay=2L
//                                    }else {
//                                        mikuSalesRecord.isGetpay=-1L
//                                    }
//                                }else{
//                                    mikuSalesRecord.isGetpay=1L
//                                }
                                mikuSalesRecord.isGetpay=1L
                                mikuSalesRecord.save(failOnError: true, flush: true)
                        }
                        p.status=1 as byte
                        p.lastUpated=new Date()
                        p.save(failOnError: true, flush: true)
                        //未提现金额
                        masa.noGetpayFee=masa.noGetpayFee-price
                        //已提现
                        masa.totalGotpayFee=masa.totalGotpayFee+price
                        //提现中的数据
                        masa.getpayingFee=masa.getpayingFee-price
                        masa.lastUpdated=new Date()
                        masa.save(failOnError: true, flush: true)
                        render(true)
                    }else {
                        render(info)
                    }
                }
                else{
                    render("不是微信关注号成员")
                }
            }else{
               //不是其成员的话，则无法进行微信的提现
                render("不是微信关注号成员")
            }
    }



    //批量付款的操作的页面[支付宝]
    def alipayindex(){
        def agencyMobile =params.agencyMobile
        if (agencyMobile) {
            agencyMobile = StringUtils.replace(agencyMobile, "-", "");
        }
        // 开始时间
        String startTime = params.startTime
        // 结束时间
        String endTime = params.endTime
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null
        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        def mkgp=ProFitGetPay.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = mkgp.list(max: params.max ?:10, offset: params.offset ?: 0) {
            eq('status', 0 as byte)
            eq('getpayType',1L)
//            if (agencyMobile) {
//                eq('agencyMobile', agencyMobile)
//            }
//            if (start != null) {
//                gt("transDate", start)
//            }
//            if (end != null) {
//                lt("transDate", end)
//            }
//                order('id','desc')
        }
        List<MikuGetPayDetail> mgpd=new ArrayList<MikuGetPayDetail>()
        pagedResultList.iterator().each {
            ProFitGetPay proFitGetPay->
                List<MikuShareGetpay> msgpList=MikuShareGetpay.findAllByGetpayId(proFitGetPay.id)
                List<MikuSalesRecord> mikuSalesRecordList=new ArrayList<MikuSalesRecord>()
//                if (msgpList.size()>0){
//                    for(int i=0;i<msgpList.size();i++){
//                        MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(msgpList.get(i).salesRecordId)
//                        mikuSalesRecordList.add(mikuSalesRecord)
//                    }
//                }
                MikuGetPayDetail oneDetail=getPayInfoService.getOneGetPayInfo(mikuSalesRecordList,proFitGetPay,msgpList.size())
                mgpd.add(oneDetail)
        }
        List<MikuSalesRecordDetail> mikuSalesRecordDetailList=new ArrayList<MikuSalesRecordDetail>()
        //当前支付宝的详情内容
        Long sumaccount=0
        mgpd.each {
            if(it.getpayType == 1 as byte && it.successNum==it.tradeNum){
                mikuSalesRecordDetailList.add(it)
                sumaccount+=it.getpayFee
            }
        }
        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                getPayList     : mikuSalesRecordDetailList,
                params         : params,
                list           : mikuSalesRecordDetailList,
                sum            : sumaccount,
                PageMap    : PageMap,
//                total            : mikuSalesRecordDetailList.size(),
                count          : mikuSalesRecordDetailList.size()
        ]

    }


    //批量付款的操作的页面[微信]
    def wxindex(){
        def mkgp=ProFitGetPay.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = mkgp.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 0 as byte)
            eq('getpayType',2L)
//            order('id','desc')
        }
        List<MikuGetPayDetail> mgpd=new ArrayList<MikuGetPayDetail>()
        pagedResultList.iterator().each {
            ProFitGetPay proFitGetPay->
                List<MikuShareGetpay> msgpList=MikuShareGetpay.findAllByGetpayId(proFitGetPay.id)
                List<MikuSalesRecord> mikuSalesRecordList=new ArrayList<MikuSalesRecord>()
//                if (msgpList.size()>0){
//                    for(int i=0;i<msgpList.size();i++){
//                        MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(msgpList.get(i).salesRecordId)
//                        mikuSalesRecordList.add(mikuSalesRecord)
//                    }
//                }
                MikuGetPayDetail oneDetail=getPayInfoService.getOneGetPayInfo(mikuSalesRecordList,proFitGetPay,msgpList.size())
                mgpd.add(oneDetail)
        }
        List<MikuSalesRecordDetail> mikuSalesRecordDetailList=new ArrayList<MikuSalesRecordDetail>()
        //当前支付宝的详情内容
        Long sumaccount=0
        mgpd.each {
            if(it.getpayType == 2 as byte && it.successNum==it.tradeNum){
                mikuSalesRecordDetailList.add(it)
                sumaccount+=it.getpayFee
            }
        }
        return [
                PageMap    : PageMap,
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                getPayList     : mikuSalesRecordDetailList,
                params         : params,
                list           : mikuSalesRecordDetailList,
                sum            : sumaccount,
                count          : mikuSalesRecordDetailList.size()
        ]
    }





    //生成对应的参数来进行获取对应的加完密的参数
    def alipay(){
        //服务器异步通知页面路径
//        String notify_url = "http://test.unesmall.com/api/h/1.0/alipayBatchTransCallBack.json";
        String notify_url = "http://miku.unesmall.com:80/api/m/1.0/alipayBatchTransCallBack.json";
        //付款账号
        String WIDemail = params.WIDemail
        //付款账户名
        String WIDaccount_name = params.WIDaccount_name
        //付款当天日期
        String WIDpay_date = params.WIDpay_date
        //批次号
        String WIDbatch_no = params.WIDbatch_no
        //付款总金额
        String WIDbatch_fee=params.WIDbatch_fee
        //付款笔数
        String WIDbatch_num=params.WIDbatch_num
        //付款详细数据
        String WIDdetail_data=params.WIDdetail_data
        String ids=params.ids
        String lshids=params.lshids
        //必填，具体格式请参见接口技术文档
        //把请求参数打包成数组
        Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("service", "batch_trans_notify");
        sParaTemp.put("partner", partner);
        sParaTemp.put("_input_charset", input_charset);
        sParaTemp.put("notify_url", notify_url);
        sParaTemp.put("email", WIDemail);
        sParaTemp.put("account_name", WIDaccount_name);
        sParaTemp.put("pay_date", WIDpay_date);
        sParaTemp.put("batch_no", WIDbatch_no);
        sParaTemp.put("batch_fee", WIDbatch_fee);
        sParaTemp.put("batch_num", WIDbatch_num);
        sParaTemp.put("detail_data", WIDdetail_data);
        //建立请求
//        String sHtmlText = alipayRefundService.buildRequest(sParaTemp,"get","确认");
        Map<String, String> sPara = alipayRefundService.buildRequestPara(sParaTemp)
        //对已加密操作的全参数操作
        alipayRefundService.insertTransBatch(ids,sPara,lshids)
        return [
                sPara : sPara
        ]
    }


    //查询出对应支付宝与微信成功提现的数据
    def getPayBySuccessData(){
        //支付宝
        List<AlipayBack> alist=AlipayBack.findAllByPaymentTypeAndSubject("企业付款","提现完成")
        //微信
        List<WeixinBack> wlist=WeixinBack.findAllById(1L)

    }




    //进行手动的异常退回处理【分润记录】
    @Transactional
    def rollBackGetPay(){
        def  id=params.long('id')
        //更改miku_getpay表中status=2 lastupdate=new Date()  errormemo="提现异常"
        ProFitGetPay proFitGetPay=ProFitGetPay.findById(id)
        proFitGetPay.with {
            it.status= 2 as byte
            it.lastUpated=new Date()
            it.errorMemo="提现异常"
            it.save(failOnError: true, flush: true)
        }
        List<MikuShareGetpay> msgpList=MikuShareGetpay.findAllByGetpayId(proFitGetPay.id)
        for(int i=0;i<msgpList.size();i++){
            MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(msgpList.get(i).salesRecordId)
            mikuSalesRecord.with {
                //异常的处理
                it.isGetpay=2 as byte
                it.lastUpdated=new Date()
                it.save(failOnError: true, flush: true)
            }
        }
        //更改对应用户的分润表
        MikuAgencyShareAccount mikuAgencyShareAccount=MikuAgencyShareAccount.findByAgencyId(proFitGetPay.agencyId)
        mikuAgencyShareAccount.with {
            it.getpayingFee=it.getpayingFee-proFitGetPay.getpayFee
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        redirect(action: "index")

    }








}

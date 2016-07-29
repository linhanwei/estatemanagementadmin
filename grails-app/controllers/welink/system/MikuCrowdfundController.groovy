package welink.system

import com.google.common.base.Preconditions
import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import com.welink.buy.utils.Constants
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.ItemDetailData
import welink.common.AlipayBack
import welink.common.Item
import welink.common.MikuCrowdfund
import welink.common.MikuCrowdfundDetail
import welink.common.MikuItemSharePara
import welink.common.Shop
import welink.common.Trade
import welink.common.WeixinBack
import welink.user.Profile

class MikuCrowdfundController {

    static String partner = "2088101295767275";
    static String key = "geconpb5bh6ols7qtb89n4b9c6cqej3d";
    static String input_charset = "utf-8";
    static final Byte SUBYTE=4 as byte
    static final Byte REDYTE=0 as byte
    static final Byte FAILYTE=-1 as byte
    static final Byte ZFDYTE=3 as byte

    //订单的支付的标示
    static final Byte WXTYPE=4 as byte

    static ImmutableMap<Integer, String> FalgMap = ImmutableMap.builder() //
            .put(2, "成功")
            .put(3, "失败")
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
    def alipayRefundService
    def copyItemService
    def wxRefundService


    def index() {
        List<Trade>  tradeList=Trade.findAllByStatusAndReturnStatusAndPayType(SUBYTE,REDYTE,ZFDYTE)
        List<Trade> newTradeList=new ArrayList<Trade>()
        tradeList.each {
            Trade trade->
                List<AlipayBack> alipayBackList=AlipayBack.findAllByOutTradeNo(trade.tradeId)
                if (alipayBackList.size()>0){
                    trade.buyerMemo=alipayBackList.get(0).buyerEmail
                    trade.alipayNo=alipayBackList.get(0).tradeNo
                }
                newTradeList.add(trade)
        }
        return [
                tradeList : newTradeList,
                total     : tradeList.size()
        ]
    }

    //列表信息
    def list(){
        //对各个字段进行排序
        String  fieldName=params.fieldName
        String  fieldstate=params.fieldstate
        //状态
        Byte status=params.byte('selectstatus')
        //名字模糊查询
        if(params.query){
            List<MikuCrowdfund> list=MikuCrowdfund.findAllByStatusNotEqualAndTitleIlike(FAILYTE,"%" + params.query + "%")
            params.max=list.size()
        }
        def mc=MikuCrowdfund.createCriteria()
        PagedResultList pagedResultList =mc.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            'in'("status", [0,1,2] as byte[])
            if (status){
                eq("status",status)
            }
            if(params.query){
                ilike("title", "%" + params.query + "%")
            }
            //各字段排序
            if(fieldName && fieldstate){
                order(fieldName, fieldstate)
            }

            order('id', 'desc')
        }
        return [
                FalgMap:FalgMap,
                PageMap:PageMap,
                list : pagedResultList,
                total: pagedResultList.totalCount
        ]
    }


    //添加众筹商品
    def add(){
        return [

        ]
    }

    //进入配置项
    def set(){
        Long id=params.long('id')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)
        String title=mikuCrowdfund.title
        List<MikuCrowdfundDetail> list=MikuCrowdfundDetail.findAllByCrowdfundId(id)
        List<ItemDetailData> detailDataList=new ArrayList<ItemDetailData>()
        list.each {
            MikuCrowdfundDetail mikuCrowdfundDetail->
                ItemDetailData itemDetailData=new ItemDetailData()
                Item item=Item.findById(mikuCrowdfundDetail.itemId)
                if (mikuCrowdfundDetail.approveStatus!=-1 as byte){
                    itemDetailData.with {
                        it.id=mikuCrowdfundDetail.itemId
                        it.soldNum=mikuCrowdfundDetail.soldNum?mikuCrowdfundDetail.soldNum:0
                        it.returnContent=mikuCrowdfundDetail.returnContent
                        it.riskTips=mikuCrowdfundDetail.riskTips
                        it.specialNote=mikuCrowdfundDetail.specialNote
                        it.code=item.code
                        it.title=item.title
                        it.price=item.price
                        it.num=item.num
                        it.approveStatus=item.approveStatus
                        it.weight=item.weight
                    }
                    detailDataList.add(itemDetailData)
                }
        }
        return [
            list:detailDataList,
            total:detailDataList.size(),
            title:title,
               id:id
        ]

    }

    //新添一条众筹商品的数据
    def  addDetail(){
        Long id=params.long('id')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)
        String title=mikuCrowdfund.title
        return [
                title:title,
                id:id
        ]
    }



    //操作insert一条数据
    def addOneData(){
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        Long id=params.long('id')
        String title = params.title
        List<String> itemPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        List<String> detailPics = params.'detail-pic' ? Lists.newArrayList(params.'detail-pic') : Collections.emptyList()
        String description = params.description
        String video = params.video
        Long referencePrice = new BigDecimal(params.referencePrice) * 100L
        Date startTime=formatter.parseDateTime(params.start_time).toDate()
        Date endTime=formatter.parseDateTime(params.end_time).toDate()
        int days=params.int('days')
        //添加对应权重
        Byte weight = params.byte('weight')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)?MikuCrowdfund.findById(id):new MikuCrowdfund()
        mikuCrowdfund.with {
            it.title=title
            it.picUrls=StringUtils.join(itemPics, ';')
            it.detail=StringUtils.join(detailPics, ';')
            it.description=description
            it.video=video
            it.targetAmount=referencePrice
            it.startTime=startTime
            it.endTime=endTime
            it.plusDay=days
            it.weight=weight
            if (MikuCrowdfund.findById(id)){

            }else{
                it.soldNum=0L
                it.totalFee=0L
            }
            it.version=1L
            it.status=REDYTE
            it.approveStatus=1 as byte
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        redirect(controller: 'mikuCrowdfund', action: 'list')
    }

    //删除一条数据
    def detele(){
        Long id=params.long('id')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)
        mikuCrowdfund.with {
            it.status=-1 as byte
            it.save(failOnError: true, flush: true)
        }
        redirect(controller: 'mikuCrowdfund', action: 'list')
    }


    def changeApprove(){
        Long id=params.long('id')
        Byte status=params.byte('status')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)
        mikuCrowdfund.with {
            it.approveStatus=status
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        redirect(controller: 'mikuCrowdfund', action: 'list')
    }



    //进行编辑的一条数据
    def edit(){
        Long id=params.long('id')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)
        return [
            item:mikuCrowdfund
        ]
    }

    //进行修改对应的权重
    def updateOneweight(){
        Long id=params.long('id')
        //添加对应权重
        Byte weight = params.byte('weight')
        MikuCrowdfund mikuCrowdfund=MikuCrowdfund.findById(id)
        mikuCrowdfund.with {
            it.weight=weight
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        render(true)
    }

    @Transactional
    def toBeOneDetailData(){
        //详情detail的id
        Long cid=params.long('cid')
        String ctitle = params.ctitle
        //商品列表具体信息
        String title = params.title
        List<String> itemPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        String description = params.description
        String specification = params.specification
        Long purchasingPrice = new BigDecimal(params.purchasingPrice) * 100L
        Long price = new BigDecimal(params.price) * 100L
        Long itemNum=params.long('num')
        if (!itemNum){
            itemNum=0
        }
        //添加对应权重
        Integer weight = params.int('weight')
        //商品销售基数
        Integer soldquantity=params.int('soldquantity')
        if (!soldquantity){
            soldquantity=0
        }
        //关联分润表
        String itemShareFee=params.long('itemShareFee')
        String itemProfitFee=params.long('itemProfitFee')
        String frJson=params.frJson
        //新添加的2个值：商品编码 品牌id
        String code=params.code
        //添加新字段:是否可退货
        Byte isrefund=params.isrefund?1 as byte:0 as byte
        // 自营店铺，用来送菜
        Shop shop = Shop.findById(999L)
        Long sellerId = 999L;
        byte sellerType = 2 as byte
        // 店铺肯定得存在的
        Preconditions.checkNotNull(shop, "the shop should not be null ...")
        def map = [:]
        def hashMap = [:]
        map.put('purchasingPrice', purchasingPrice.toString())
        map.put('ext', "")
        String f = com.alibaba.fastjson.JSON.toJSONString(map)
        Long id = params.id ? params.long('id') : null
        Item item = id ? Item.findByShopIdAndId(999L, id) : new Item()
        item.with {
            //众筹的类型
            it.type= 7 as byte
            it.title = StringUtils.trimToEmpty(title)
            it.shopId = shop.id
            it.shopType=shop.type
            it.sellerId = sellerId
            it.sellerType = sellerType
            it.specification = specification
            it.price = price
            it.features = f
            it.weight=weight
            it.num=itemNum
            it.categoryId=-1L
            it.isrefund=isrefund
            it.baseSoldQuantity=soldquantity
            //搜索关键字
            it.keyWord=params.keyWord?params.keyWord:""
            it.onlineStartTime = System.currentTimeMillis()
            it.onlineEndTime = new DateTime().plusYears(20).toDate().time
            it.num = itemNum
            if (params.makeOnSale){
                it.approveStatus = Constants.ApproveStatus.ON_SALE.approveStatusId
            }
            it.picUrls = StringUtils.join(itemPics, ';')
            it.description = description
            //分润表
            it.uuid=uuid
            //商品编码
            it.code=code
            //是否免税
            if(params.isTaxFree){
                it.isTaxFree= 1 as byte
            }
        }
        item.save(failOnError: true, flush: true)

        Long itemShareParaId = params.itemShareParaId ? params.long('itemShareParaId') : null
        MikuItemSharePara mkitemshare = itemShareParaId ? MikuItemSharePara.findById(itemShareParaId) : new MikuItemSharePara()
        mkitemshare.with {
            it.itemCostFee=new BigDecimal(params.purchasingPrice)*100L
            it.itemProfitFee=new BigDecimal(params.itemProfitFee)*100L
            it.itemShareFee=new BigDecimal(params.itemShareFee)*100L
            it.itemId=item.id
            it.schemeName=item.title
            it.parameter="[{\"id\":1,\"value\":\"4.8\",\"title\":\"一度\"},{\"id\":2,\"value\":\"4.8\",\"title\":\"二度\"},{\"id\":3,\"value\":\"6.4\",\"title\":\"三度\"},{\"id\":4,\"value\":\"8\",\"title\":\"四度\"},{\"id\":5,\"value\":\"8\",\"title\":\"五度\"},{\"id\":6,\"value\":\"8\",\"title\":\"六度\"},{\"id\":7,\"value\":\"8\",\"title\":\"七度\"},{\"id\":8,\"value\":\"32\",\"title\":\"八度\"},{\"id\":9,\"value\":\"1\",\"title\":\"CEO4\"},{\"id\":10,\"value\":\"6\",\"title\":\"CEO3\"},{\"id\":11,\"value\":\"12\",\"title\":\"CEO2\"},{\"id\":12,\"value\":\"20\",\"title\":\"CEO1\"}]"
            //超级管理员的id
            it.creatorId="60"
            it.dateCreated=new Date()
            it.isDisable=0 as byte

            it.save(failOnError: true, flush: true)
        }

        //进行对分站点数据的copy到对应的分站点
        copyItemService.copyItemToFzNewItem(item)
        //下面是众筹详情表数据关联
        //回报说明
        String returnContent=params.returnContent
        String riskTips=params.riskTips
        String specialNote=params.specialNote
        MikuCrowdfundDetail mikuCrowdfund =MikuCrowdfundDetail.findByItemId(Item.findByBaseItemId(item.id).id)?MikuCrowdfundDetail.findByItemId(Item.findByBaseItemId(item.id).id):new MikuCrowdfundDetail()
        mikuCrowdfund.with {
            if (params.makeOnSale){
              it.approveStatus=1 as byte
            }else {
              it.approveStatus=0 as byte
            }
           it.itemId=Item.findByBaseItemId(item.id).id
           it.crowdfundId=cid
           if (id){

           }else{
               it.soldNum=0
           }
            it.returnContent=returnContent
           it.riskTips=riskTips
           it.specialNote=specialNote
           it.dateCreated=new Date()
           it.lastUpdated=new Date()
           it.version=1L
           it.save(failOnError: true, flush: true)
        }
        return[
                id: mikuCrowdfund.crowdfundId,
                title:ctitle
        ]
    }

    //编辑一条众筹的详情的页面
    def editDetail(){
        Long id=params.long('id')
        //众筹商品的详情
        MikuCrowdfundDetail mikuCrowdfund =MikuCrowdfundDetail.findByItemId(id)
        MikuCrowdfund fund=MikuCrowdfund.findById(mikuCrowdfund.crowdfundId)
        Item onitem=Item.findById(mikuCrowdfund.itemId)
        Item item=Item.findById(onitem.baseItemId)
        //进行拿分润的数据
        MikuItemSharePara onemsp=MikuItemSharePara.findByItemId(item.id)
        ItemDetailData itemDetailData=new ItemDetailData()
        itemDetailData.with {
            it.id=item.id
            it.picUrls=item.picUrls
            it.title=item.title
            it.keyWord=item.keyWord
            it.code=item.code
            it.weight=item.weight
            it.features=item.features
            it.price=item.price
            it.specification=item.specification
            it.num=item.num
            it.description=item.description
            it.baseSoldQuantity=item.baseSoldQuantity
            it.returnContent=mikuCrowdfund.returnContent
            it.riskTips=mikuCrowdfund.riskTips
            it.isrefund=item.isrefund
            it.specialNote=mikuCrowdfund.specialNote
            it.approveStatus=item.approveStatus
        }
        return[
                item            : itemDetailData,
                itemSharePara   : onemsp,
                id: mikuCrowdfund.crowdfundId,
                title:fund.title
        ]
    }

    //进行对的详情表进行操作的是：show  delete  hide
    @Transactional
    def doForDetail(){
        //参数:状态 + 详情的id
        Long id=params.long('id')
        Byte type=params.byte('status')

        Long cid=params.long('cid')
        String title=params.title

        //详情数据的修改
        MikuCrowdfundDetail detail=MikuCrowdfundDetail.findByItemId(id)
        if (detail){
             detail.with {
                 it.approveStatus=type
                 it.lastUpdated=new Date()
                 it.save(failOnError: true, flush: true)
            }
        }
        //对应的2条数据进行更改
        Item onsaleItem=Item.findById(detail.itemId)
        onsaleItem.with {
            it.lastUpdated=new Date()
            it.approveStatus=type
            it.save(failOnError: true, flush: true)
        }
        Item baseItem=Item.findById(onsaleItem.baseItemId)
        baseItem.with {
            it.lastUpdated=new Date()
            it.approveStatus=type
            it.save(failOnError: true, flush: true)
        }

        return [
                id:cid,
                title: title
        ]
    }

    //更改众筹的商品与数量
    @Transactional
    def modifyParam(){
        //data: {'id': id, 'target': newWeight,'name':name}
        Long id=params.long('id')
        String name=params.name
        Byte weight
        Long num
        if (name=="num"){
            num=params.long('target')
        }else if (name=="weight"){
            weight=params.byte('target')
        }
        //查找对应的商品
        Item item =Item.findById(id)
        if (item){
            if (name=="num"){
                item.num=num
                item.save(failOnError: true, flush: true)
                //总仓的商品
                Item baseItema=Item.findById(item.baseItemId)
                baseItema.num=num
                baseItema.save(failOnError: true, flush: true)
            }else if (name=="weight"){
                item.weight=weight
                item.save(failOnError: true, flush: true)
                Item baseItema=Item.findById(item.baseItemId)
                baseItema.weight=weight
                baseItema.save(failOnError: true, flush: true)
            }
        }
        render(true)
    }



    //微信交易的订单
    def wxtradeindex(){
        List<Trade>  tradeList=Trade.findAllByStatusAndReturnStatusAndPayType(SUBYTE,REDYTE,WXTYPE)
        List<Trade> newTradeList=new ArrayList<Trade>()
        tradeList.each {
            Trade trade->
                List<WeixinBack> wxlist=WeixinBack.findAllByOutTradeNo(trade.tradeId)
                if (wxlist.size()>0){
                    trade.buyerMemo=wxlist.get(0).openid
                    trade.alipayNo=wxlist.get(0).transactionId
                    trade.categoryId=wxlist.get(0).id
                    Profile profile=Profile.findById(trade?.buyerId)
                    if (profile)
                    {
                        trade.promotion=profile.mobile
                    }
                    if (wxlist.get(0).openid){
                        newTradeList.add(trade)
                    }
                }
        }
        return [
                tradeList : newTradeList,
                total     : tradeList.size()
        ]
    }


    //微信交易的退款
    @Transactional
    def wxpayRefund(){
        Long id=params.long('id')
        WeixinBack weixinBack=WeixinBack.findById(id)
        //丽源堂
//        String path=request.getSession().getServletContext().getRealPath("//")+"apiclient_cert.p12"
        //Miku Mine的公众号
//        String path=request.getSession().getServletContext().getRealPath("//")+"miku_apiclient_cert.p12"
        //米酷SDP
        String path=request.getSession().getServletContext().getRealPath("//")+"sdp_miku_apiclient_cert.p12"
        String info=wxRefundService.wxrefundByOneTrade(path,weixinBack)
        if ("SUCCESS".equals(info)){
            //进行订单的状态的改变
            Trade trade =Trade.findByTradeId(weixinBack.outTradeNo)
            trade.with {
                it.crowdfundRefundStatus=2 as byte
                it.save(failOnError: true, flush: true)
            }
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
            render('true')
        }else {
            render(info)
        }
    }



    //App的微信交易的退款
    @Transactional
    def mikuAppwxpayRefund(){
        Long id=params.long('id')
        WeixinBack weixinBack=WeixinBack.findById(id)
        String path=request.getSession().getServletContext().getRealPath("//")+"app_apiclient_cert.p12"
        String info=wxRefundService.mikuwxrefundByOneTrade(path,weixinBack)
        if ("SUCCESS".equals(info)){
            //进行订单的状态的改变
            Trade trade =Trade.findByTradeId(weixinBack.outTradeNo)
            trade.with {
                it.crowdfundRefundStatus=2 as byte
                it.save(failOnError: true, flush: true)
            }
              //进行weixin_back表的新增
//            WeixinBack wxobj=copyOneRefundToSuccess(weixinBack)
//            wxobj.save(failOnError: true, flush: true)
            WeixinBack newWx=new WeixinBack().with {
                it.appid=weixinBack.appid
                it.mchId=weixinBack.mchId
                it.deviceInfo="退款成功"
                it.nonceStr="App微信支付的退款"
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
                render('true')
        }else {
            render(info)
        }
    }







    //生成对应的参数来进行获取对应的加完密的参数
    def alipay(){
        //服务器异步通知页面路径
        String notify_url = "http://miku.unesmall.com:80/api/m/1.0/alipayRefundCallBack.json";
        //需http://格式的完整路径，不允许加?id=123这类自定义参数
        //卖家支付宝帐户
//      String seller_email = new String(request.getParameter("WIDseller_email").getBytes("ISO-8859-1"),"UTF-8");
        String seller_email = params.WIDseller_email
        //必填
        //退款当天日期
//      String refund_date = new String(request.getParameter("WIDrefund_date").getBytes("ISO-8859-1"),"UTF-8");
        String refund_date = params.WIDrefund_date
        //必填，格式：年[4位]-月[2位]-日[2位] 小时[2位 24小时制]:分[2位]:秒[2位]，如：2007-10-01 13:13:13
        //批次号
//      String batch_no = new String(request.getParameter("WIDbatch_no").getBytes("ISO-8859-1"),"UTF-8");
        String batch_no = params.WIDbatch_no
        //必填，格式：当天日期[8位]+序列号[3至24位]，如：201008010000001
        //退款笔数
//      String batch_num = new String(request.getParameter("WIDbatch_num").getBytes("ISO-8859-1"),"UTF-8");
        String batch_num = params.WIDbatch_num
        //必填，参数detail_data的值中，“#”字符出现的数量加1，最大支持1000笔（即“#”字符出现的数量999个）
        //退款详细数据
//      String detail_data = new String(request.getParameter("WIDdetail_data").getBytes("ISO-8859-1"),"UTF-8");
        String detail_data = params.WIDdetail_data
        //交易id获取
        String tradeId=params.WIDbatch_tradeId
        //必填，具体格式请参见接口技术文档
        //把请求参数打包成数组
        Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("service", "refund_fastpay_by_platform_pwd");
        sParaTemp.put("partner", partner);
        sParaTemp.put("_input_charset", input_charset);
        sParaTemp.put("notify_url", notify_url);
        sParaTemp.put("seller_email", seller_email);
        sParaTemp.put("refund_date", refund_date);
        sParaTemp.put("batch_no", batch_no);
        sParaTemp.put("batch_num", batch_num);
        sParaTemp.put("detail_data", detail_data);
        //建立请求
//        String sHtmlText = alipayRefundService.buildRequest(sParaTemp,"get","确认");
        Map<String, String> sPara = alipayRefundService.buildRequestPara(sParaTemp)
        //对已加密操作的全参数操作
        alipayRefundService.doAlipayRefundToOneData(sPara,tradeId)
        return [
                sPara : sPara
        ]
    }

    //进行对weixin_back的属性的添加
    def copyOneRefundToSuccess(WeixinBack weixinBack){
        WeixinBack copy=new WeixinBack().with {
            it.appid=weixinBack.appid
            it.mchId=weixinBack.mchId
            it.deviceInfo="退款成功"
            it.nonceStr=weixinBack.nonceStr
            it.sign=weixinBack.sign
//            it.resultCode="success"
            it.openid=weixinBack.openid
            it.isSubscribe=weixinBack.isSubscribe
            it.tradeType="WEB"
            it.bankType=weixinBack.bankType
            it.totalFee=weixinBack.totalFee
            it.feeType=weixinBack.feeType
            it.transactionId=weixinBack.transactionId
            it.outTradeNo=weixinBack.outTradeNo
//            it.dateCreated=new Date()
//            it.lastUpdated=new Date()
//            it.resultCode="success"
        }
        return copy
    }


}

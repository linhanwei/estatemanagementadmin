package welink.warehouse

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import welink.business.ModifyItemDetail
import welink.business.TradeDetail
import welink.common.Item
import welink.common.Logistics
import welink.common.MikuBrand
import welink.common.Order
import welink.common.Trade
import grails.converters.JSON

import java.text.SimpleDateFormat

class MikuPGoodsController {


    OrdersLogisticsService ordersLogisticsService
    DoExcelManagerService doExcelManagerService

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
            .build()



    def index() {

    }


    //撤回的操作
    def cancelOneTrade(){
        Long id=params.long('id')
        MikuPdeliveryTrade trade=MikuPdeliveryTrade.findById(id)
        trade.with {
            it.lastUpdated=new Date()
            it.status=1 as byte
            it.save(flush: true,failOnError: true)

            //出库的操作就是订单状态的改变
            Trade mtrde=Trade.findByTradeId(tradeId)
            if (mtrde){
                mtrde.with {
                    it.status=4 as byte
                    it.confirmTime=new Date()
                    it.timeoutActionTime=new DateTime().plusDays(7).toDate()
                    it.save(failOnError: true, flush: true)
                }
            }
        }
        redirect(action: "list")
    }




    def list(){
        //订单号的查询
        Long tradeId=params.long('tradeId')
        String moblie=params.mobile
        def MyTrade = MikuPdeliveryTrade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status',2 as byte)
            if (tradeId){
                eq('tradeId',tradeId)
            }
            if (moblie){
                List<Logistics> list=Logistics.findAllByMobile(moblie)
                'in'("logicId", list*.id)
            }
        }
        def map=[:]
        List<TradeDetail> list=new ArrayList<TradeDetail>()
        pagedResultList.iterator().each {
            MikuPdeliveryTrade trade->
                TradeDetail tradeDetail=new TradeDetail()
                Logistics logistics=Logistics.findById(trade.logicId)
                tradeDetail.with {
                    it.id=trade.id
                    it.tradeId=trade.tradeId
                    //收货人+地址
                    it.buyerInfo=logistics.contactName+(logistics.mobile)
                    it.address=logistics.province+" "+logistics.city
                    //金额
                    it.totalFee=trade.totalFee
                    //订单详情
                    it.memo=getItemsInfo(trade.tradeId)
                }
                list.add(tradeDetail)
                //添加对应的供应商
                map.put(trade.id+"",getItemListInfo(trade.tradeId))
        }

        return [
                tagList: list,
                map:map,
                PageMap:PageMap,
                total  : pagedResultList.totalCount,
                params : params,
        ]
    }


    @Transactional
    def doSuccessOneTrade(){
        Long tradeId=params.long('tradeId')
        MikuPdeliveryTrade mikuPdeliveryTrade= MikuPdeliveryTrade.findByTradeId(tradeId)
        if (mikuPdeliveryTrade){
            mikuPdeliveryTrade.with {
                it.status=3 as byte
                it.lastUpdated=new Date()
                it.save(failOnError: true,flush: true)
            }
            //出库的操作就是订单状态的改变
            Trade trade=Trade.findByTradeId(tradeId)
            if (trade){
                trade.with {
                    it.status=5 as byte
                    it.confirmTime=new Date()
                    it.timeoutActionTime=new DateTime().plusDays(7).toDate()
                    it.save(failOnError: true, flush: true)
                }
            }
        }
        redirect(action: "list")
    }



    @Transactional
    def doSuccessTrades(){
        def tradeIds = Lists.newArrayList(params.itemShipBox)
        tradeIds.each {
            String it ->
                Long id = Long.parseLong(it)
                MikuPdeliveryTrade mikuPdeliveryTrade= MikuPdeliveryTrade.findByTradeId(id)
                if (mikuPdeliveryTrade){
                    mikuPdeliveryTrade.with {
                        it.status=3 as byte
                        it.lastUpdated=new Date()
                        it.save(failOnError: true,flush: true)
                    }
                    //出库的操作就是订单状态的改变
                    Trade trade=Trade.findByTradeId(id)
                    if (trade){
                        trade.with {
                            it.status=5 as byte
                            it.confirmTime=new Date()
                            it.timeoutActionTime=new DateTime().plusDays(7).toDate()
                            it.save(failOnError: true, flush: true)
                        }
                    }
                }
        }
        redirect(action: "list")
    }


    //获取对应的商品
    def getItemListInfo(Long tradeId){
        //添加对应供应商品的信息
        List<MikuPdeliveryOrders> ordersList=MikuPdeliveryOrders.findAllByTradeIdAndIsDelete(tradeId,0 as byte)
        List<MikuProvider> list=new ArrayList<MikuProvider>()
        ordersList.each {
            MikuPdeliveryOrders mikuPdeliveryOrders->
                Long num=mikuPdeliveryOrders.num
                MikuProvider mikuProvider=MikuProvider.findById(mikuPdeliveryOrders.pid)
                if(mikuProvider){
                    //供应商名称 地区  账期
                    mikuProvider.with {
                        //数量
                        it.job=mikuPdeliveryOrders?mikuPdeliveryOrders.num:0
                        //分类名称
                        it.assess=MikuPclassify.findById(it.clssfiyId)?MikuPclassify.findById(it.clssfiyId).name:""
                        MikuPiteminfo onempinfo=MikuPiteminfo.findById(mikuPdeliveryOrders.pitemId)
                        //邮费
                        it.zipcode=onempinfo?onempinfo.postFee/100f:"0"
                        //价格
                        it.email=onempinfo?onempinfo.price/100f:"0"
                        //利润
                        Long sum=0
                        //实付
                        it.sname=mikuPdeliveryOrders?mikuPdeliveryOrders.totalFee/100f:0
                        //合计
                        it.version=0L
                        def newnum=num
                        if (onempinfo){
                            sum=onempinfo.price*newnum
                            sum+=onempinfo.postFee
                            it.version=sum/100f
                            sum=mikuPdeliveryOrders.totalFee-sum
                            System.out.println(mikuPdeliveryOrders.num);
                            System.out.println(onempinfo.price*mikuPdeliveryOrders.num);
                            System.out.println(onempinfo.postFee);
                            System.out.println(mikuPdeliveryOrders.totalFee);
                        }
                        it.changeId=onempinfo?sum:""
                    }
                    list.add(mikuProvider)
                }
        }
        return  list
    }



    //获取的是订单的详情
    def getItemsInfo(Long tradeId){
        List<String> slist=new ArrayList<String>()
        List<MikuPdeliveryOrders> list=MikuPdeliveryOrders.findAllByTradeIdAndIsDelete(tradeId,0 as byte)
        list.each {
            MikuPdeliveryOrders mm->
                slist.add(mm.title+"X"+mm.num)
        }
        return StringUtils.join(slist, ';')
    }



    def  cklist(){
        //订单号的查询
        Long tradeId=params.long('tradeId')
        String moblie=params.mobile
        def MyTrade = MikuPdeliveryTrade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status',3 as byte)
            if (tradeId){
                eq('tradeId',tradeId)
            }
            if (moblie){
                List<Logistics> list=Logistics.findAllByMobile(moblie)
                'in'("logicId", list*.id)
            }
        }
        def map=[:]
        List<TradeDetail> list=new ArrayList<TradeDetail>()
        pagedResultList.iterator().each {
            MikuPdeliveryTrade trade->
                if (trade){
                    TradeDetail tradeDetail=new TradeDetail()
                    Logistics logistics=Logistics.findById(trade.logicId)
                    tradeDetail.with {
                        it.id=trade.id
                        it.tradeId=trade.tradeId
                        //收货人+地址
                        it.buyerInfo=logistics.contactName+(logistics.mobile)
                        it.address=logistics.province+" "+logistics.city
                        //金额
                        it.totalFee=trade.totalFee
                        //订单详情
                        it.memo=getItemsInfo(trade.tradeId)
                    }
                    list.add(tradeDetail)
                    //添加对应的供应商
                    map.put(trade.id+"",getItemListInfo(trade.tradeId))
                }
        }

        return [
                tagList: list,
                map:map,
                PageMap:PageMap,
                total  : pagedResultList.totalCount,
                params : params,
        ]
    }





    //进行批量出库的操作
    def bathOutportItem(){
        def tradeIds = Lists.newArrayList(params.itemShipBox)
        tradeIds.each {
            String it ->
                System.out.println(it)
        }
        redirect(action: "list")
    }






    //根据订单号查出对应商品信息
    def getOrdersByTradeId(){
        Long tradeId=params.long('tradeId')
        Trade trade=Trade.findByTradeId(tradeId)
        List<Item> itemList=new ArrayList<Item>()
        if (trade){
            //查询的供应商里面的订单
            List<MikuPdeliveryOrders> ordersList=MikuPdeliveryOrders.findAllByIsDeleteAndTradeId(0 as byte,tradeId)
            ordersList.each {
                Order order=Order.findById(it.orderId)
                if (order && !("运费".equals(order.title))){
                    Item newItem=new Item()
                    Item item=Item.findById(order.artificialId)
                    //数量
                    item.num=it.num
                    //品牌
                    MikuBrand brand=MikuBrand.findById(item.brandId)
                    item.keyWord=brand?brand.name:""
                    item.specification=order.id
                    item.hasInvoice=ordersLogisticsService.getISCheckByorderId(tradeId,order.id)?1 as byte:0 as  byte
                    newItem.with {
                        it.title=item.title
                        it.price=item.price
                        it.num=item.num
                        it.keyWord=item.keyWord
                        it.specification=item.specification
                        it.hasInvoice=item.hasInvoice
                    }
                    itemList.add(newItem)
                }
            }
//            String str=trade.orders
//            String[]  arr=str.split(';')
//            for (int i=0;i<arr.length;i++){
//                Order order=Order.findById(Long.parseLong(arr[i]))
//                if (order && !("运费".equals(order.title))){
//                    Item item=Item.findById(order.artificialId)
//                    //数量
//                    item.num=order.num
//                    //品牌
//                    MikuBrand brand=MikuBrand.findById(item.brandId)
//                    item.keyWord=brand?brand.name:""
//                    item.specification=order.id
//                    item.hasInvoice=ordersLogisticsService.getISCheckByorderId(tradeId,order.id)?1 as byte:0 as  byte
//                    itemList.add(item)
//                }
//            }
        }
        render(itemList as JSON)
    }




    //进行对物流信息与order关联
    def insertOneMikuLogistic(){
        //orders的结合
        String orders=params.orders
        //物流公司
        String wlcompany=params.wlcompany
        //物流号
        String wlh=params.wlh
        //订单号
        Long tradeId=params.long('tradeId')
        //进行添加对物流公司与物流号的查询
        MikuOrdersLogistics mikuOrdersLogistics=new MikuOrdersLogistics()
        //添加对应的物流信息
        ordersLogisticsService.insertOneLogistics(wlh,wlcompany,tradeId,orders)
        //再进行回查对应的物流信息
        List<Item> list=ordersLogisticsService.getMikulogitcInfo(tradeId)
        render(list as JSON)
    }


    //撤销的操作
    def cancelOnelogistic(){
        //物流号
        String wlh=params.wlh
        //订单号
        Long tradeId=params.long('tradeId')
        ordersLogisticsService.cancelOneMikuLogistics(wlh, tradeId)
        //再进行回查对应的物流信息
        List<Item> list=ordersLogisticsService.getMikulogitcInfo(tradeId)
        render(list as JSON)
    }




    //回显的操作
    def getlogisticInfo(){
        //订单号
        Long tradeId=params.long('tradeId')
        //再进行回查对应的物流信息
        List<Item> list=ordersLogisticsService.getMikulogitcInfo(tradeId)
        render(list as JSON)
    }





    //根据导出的类型进行下载对应的Excel
    def downloadExcelByTradeId(){
        String flag=params.flag
        String path=request.getSession().getServletContext().getRealPath("")
        List<MikuPdeliveryTrade> rlist=new ArrayList<MikuPdeliveryTrade>()
        if ("2".equals(flag)){
            rlist=MikuPdeliveryTrade.findAllByStatus(2 as byte)
        }else  if ("3".equals(flag)){
            rlist=MikuPdeliveryTrade.findAllByStatus(3 as byte)
        }
        else{
            def tradeIds = Lists.newArrayList(params.itemShipBox)
            tradeIds.each {
                String it ->
                    Long id = Long.parseLong(it)
                    MikuPdeliveryTrade mikuPdeliveryTrade= MikuPdeliveryTrade.findByTradeId(id)
                    if (mikuPdeliveryTrade){
                        rlist.add(mikuPdeliveryTrade)
                    }
            }
        }
        String uuid=doExcelManagerService.createOneExcel(path,rlist)
        // 处理中文乱码
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd")
        Calendar c = Calendar.getInstance()
        int hour = c.get(Calendar.HOUR_OF_DAY);
        int minute = c.get(Calendar.MINUTE);
        int second = c.get(Calendar.SECOND);
        String sfm=hour+"时"+minute+"分"+second+"秒"
        String downloadName=df.format(new Date()).toString()+"-"+sfm+"交易订单.xls"
        def filename = URLEncoder.encode(downloadName, "UTF-8");
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



    //出库单回到完成状态
    def cancelOneTradeToWc(){
        Long id=params.long('id')
        MikuPdeliveryTrade trade=MikuPdeliveryTrade.findById(id)
        if (trade){
            trade.with {
                it.lastUpdated=new Date()
                it.status=2 as byte
                it.save(failOnError: true,flush: true)
            }

            Trade mtrade=Trade.findByTradeId(trade.tradeId)
            if (mtrade){
                mtrade.with {
                    it.status=6 as byte
                    it.confirmTime=new Date()
                    it.timeoutActionTime=new DateTime().plusDays(7).toDate()
                    it.save(failOnError: true, flush: true)
                }
            }


        }
        redirect(action: "cklist")
    }







}

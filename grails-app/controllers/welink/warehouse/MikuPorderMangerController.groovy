package welink.warehouse

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.joda.time.DateTime
import welink.common.Item
import welink.common.Logistics
import welink.common.Order
import welink.common.Trade
import org.apache.commons.lang3.StringUtils

class MikuPorderMangerController {
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
        //进行同步订单
        //insertAllData()
        //查出对应的ERP信息表的内容
        Long tradeId=params.long('tradeId')
        def MyTrade = MikuPdeliveryTrade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            if (tradeId){
                eq('tradeId',tradeId)
            }
            'in'('status', [0,1] as byte[])
        }
        return [
                params:params,
                list:pagedResultList,
                params      : params,
                total       : pagedResultList?.totalCount
        ]

    }



    //查找订单的详情
    def selectTradeOrders(){
        Long tradeId=params.long('tradeId')
        Trade trade=Trade.findByTradeId(tradeId)
        List<Order> orderList=new ArrayList<Order>()
        List<Item> itemList=new ArrayList<Item>()
        if(trade){
            String[] arr=trade.orders.toString().split(";")
            for (int i=0;i<arr.length;i++){
                Long oid=Long.parseLong(arr[i])
                Order order=Order.findById(oid)
                if (order && !("运费".equals(order.title))){
                    Item item=Item.findById(order.artificialId)
                    //查出对应订单地址
                    Logistics logistics=Logistics.findById(trade.consigneeId)
                    item.address=(logistics.province+" "+logistics.city)
                    item.num=order.num
                    item.shopId=order.id
                    //加多一个判断的标示：是否已经被选择上
                    Boolean flag=MikuPdeliveryOrders.findByOrderIdAndIsDelete(order.id,0 as byte)?true:false
                    if (flag){
                        item.type= 1 as byte
                    }else{
                        item.type= 0 as byte
                    }
                    itemList.add(item)
                }
            }
        }
        render(itemList as  JSON)
    }


    //查询的是供应商品的编码
    def getInfoByCode(){
        String code=params.code
        Long orderId=params.long('orderId')
        List<MikuPiteminfo> list=MikuPiteminfo.findAllByStatusAndPitemCode(1 as byte,code)
        List<MikuPiteminfo> nlist=new ArrayList<MikuPiteminfo>()
        list.each {
            MikuPiteminfo mm->
                MikuProvider mikuProvider=MikuProvider.findById(mm.providerId)
                //判断是否有选过
                List<MikuPdeliveryOrders> pdeliveryOrdersList=MikuPdeliveryOrders.findAllByOrderIdAndIsDelete(orderId,0 as byte)
                Boolean flag=true
                Boolean pflg=true
                String str=""
                int count=0;
                for(int i=0;i<pdeliveryOrdersList.size();i++){
                    MikuPdeliveryOrders pp=pdeliveryOrdersList.get(i)
                    if (pp.pitemId == mm.id){
                        flag=false
                        count=pp.num
                    }
                    if (pp.pid == mm.providerId){
                        pflg=false
                        str=pp.title+" X "+pp.num
                    }
                }
                if (pflg){
                    mm.changeId=1
                    mm.pitemCode=str
                }else{
                    mm.changeId=0
                }
                if (flag){
                    mm.status=0 as byte
                }else{
                    mm.status=1 as byte
                }
                if(mikuProvider){
                    mm.memo=mikuProvider.name
                    mm.assess=mikuProvider.accounttime
                    mm.logisticDestrion=count
                    nlist.add(mm)
                }else {
                    mm.memo=""
                    mm.logisticDestrion=""
                    mm.assess=""
                }

        }
        render(nlist as  JSON)
    }




    //进行成功的操作
    @Transactional
    def doOnePOrder(){
        //订单号
        Long tradeId=params.long('tradeId')
        //供应商品id
        Long pitemId=params.long('pitemId')
        //其中一张订单id
        Long orderId=params.long('orderId')
        //pselectitemIds
        //这里出现拆单的情况
        String pselectitemIds=params.pselectitemIds


        Trade trade=Trade.findByTradeId(tradeId)
        MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(pitemId)
        Order order=Order.findById(orderId)

        //1.对订单的构建
        if(order && trade){
            //订单从未处理到备单状态
            trade.with {
                it.status = 6 as byte
                it.consignTime = new Date()//调度时间
                it.timeoutActionTime = new DateTime().plusDays(3).toDate()
                it.save(failOnError: true, flush: true)
            }
            //身份证
            Logistics logistics=Logistics.findById(trade.consigneeId)
            //进行订单的添加[供应商品的订单]
            boolean flag=MikuPdeliveryTrade.findByTradeId(tradeId)?true:false
            MikuPdeliveryTrade mikuPdeliveryTrade=flag?MikuPdeliveryTrade.findByTradeId(tradeId):new MikuPdeliveryTrade()
            List<MikuPdeliveryOrders> list=MikuPdeliveryOrders.findAllByOrderIdAndIsDelete(order.id,0 as byte)
            if (list.size()>0){
                list.each {
                    //再把库存添加回去
                    MikuPiteminfo oneItem=MikuPiteminfo.findById(it.pitemId)
                    oneItem.rknum+=it.num
                    oneItem.lastUpdated=new Date()
                    oneItem.save(failOnError: true,flush: true)
                    //再进行取消订单
                    it.isDelete=1 as byte
                    //trade表当中也不需要对应的order值
                    if (getChangeStr(mikuPdeliveryTrade.doOrders,(it.orderId+""),false)){
                        mikuPdeliveryTrade.doOrders=getChangeStr(mikuPdeliveryTrade.doOrders,(it.orderId+""),true)
                        mikuPdeliveryTrade.donum=mikuPdeliveryTrade.donum-1
                    }
                    it.save(failOnError: true,flush: true)
                }
            }
            if (pselectitemIds){
                //多选的操作
                //id1#num1;id2#num2;id3#num3
                String[] idarr=pselectitemIds.split(";")
                for (int j=0;j<idarr.length;j++){
                    //拆分单号与数量
                    Long oneId=Long.parseLong(idarr[j].split("#")[0])
                    Long oneNum=Long.parseLong(idarr[j].split("#")[1])
                    if(oneId && oneNum){
                        //先判断此条数据有没有选。选了的话则需要把对应的数据进行删除
                        //我们要以多选为考虑的因素
                        MikuPiteminfo onemipinfo=MikuPiteminfo.findById(oneId)
                        onemipinfo.with {
                            it.rknum=it.rknum-oneNum
                            it.save(failOnError: true,flush: true)
                        }
                        //再进行生成一张新的订单[order]
                        MikuPdeliveryOrders oneorder=new MikuPdeliveryOrders()
                        oneorder.with {
                            it.pid=onemipinfo.providerId
                            it.pitemId=onemipinfo.id
                            it.tradeId=tradeId
                            it.title=order.title
                            it.dateCreated=new Date()
                            it.lastUpdated=new Date()
                            it.num=oneNum
                            it.idcard=logistics?logistics.idCard:""
                            it.orderId=order.id
                            it.isDelete=0 as byte
                            //订单金额
                            it.totalFee=order.totalFee
                            it.save(failOnError: true, flush: true)
                        }

                        //新建一张trade
                        mikuPdeliveryTrade.with {
                            it.dateCreated=new Date()
                            it.lastUpdated=new Date()
                            it.name=trade.title
                            it.tradeId=tradeId
                            it.orders=getDoOrderCount(trade.orders,false)
                            it.payType=trade.payType
                            it.logicId=trade.consigneeId
                            if (flag){
                                 //判断是否对应集合是否有对应的OrderID[没有这个orderid值]
                                if (!(getChangeStr(mikuPdeliveryTrade.doOrders,(orderId+""),false))){
                                    it.doOrders=(it.doOrders+";"+order.id)
                                    it.donum=it.donum+1
                                }
                                if(it.donum == it.alldonum){
                                    it.status=2 as byte
                                }else
                                {
                                    it.status=1 as byte
                                }
                            }
                            it.save(failOnError: true, flush: true)
                        }
                    }
                }
            }else{
                //单选的操作
                MikuPdeliveryOrders mikuPdeliveryOrders=new MikuPdeliveryOrders()
                mikuPdeliveryOrders.with {
                    it.pid=mikuPiteminfo.providerId
                    it.pitemId=mikuPiteminfo.id
                    it.tradeId=tradeId
                    it.title=order.title
                    it.dateCreated=new Date()
                    it.lastUpdated=new Date()
                    it.num=order.num
                    it.idcard=logistics?logistics.idCard:""
                    it.orderId=order.id
                    it.isDelete=0 as byte
                    //订单金额
                    it.totalFee=order.totalFee
                    it.save(failOnError: true, flush: true)
                }

                mikuPdeliveryTrade.with {
                    it.dateCreated=new Date()
                    it.lastUpdated=new Date()
                    it.name=trade.title
                    it.tradeId=tradeId
                    it.orders=getDoOrderCount(trade.orders,false)
                    it.payType=trade.payType
                    it.logicId=trade.consigneeId
                    if (flag){
                        //判断是否对应集合是否有对应的OrderID[没有这个orderid值]
                        if (!(getChangeStr(mikuPdeliveryTrade.doOrders,(orderId+""),false))){
                            it.doOrders=(it.doOrders+";"+order.id)
                            it.donum=it.donum+1
                        }
                        if(it.donum == it.alldonum){
                            it.status=2 as byte
                        }else
                        {
                            it.status=1 as byte
                        }
//                        if(it.doOrders){
//                            it.doOrders=order.id
//                        }else
//                        {
//                            it.doOrders=(it.doOrders+";"+order.id)
//                        }
//                        it.donum=it.donum+1
//                        if(it.donum == it.alldonum){
//                            it.status=2 as byte
//                        }else
//                        {
//                            it.status=1 as byte
//                        }
                    }
                    it.save(failOnError: true, flush: true)
                }

                //进行库存的操作
                mikuPiteminfo.with {
                    it.cknum=it.cknum+order.num
                    it.rknum=it.rknum-order.num
                    it.lastUpdated=new Date()
                    it.save(failOnError: true, flush: true)
                }
            }
        }
        redirect(action: 'index')
    }



    //去掉订单里面的order值
    def getChangeStr(String orders,String onestr,Boolean flag){
        String[]  arr=orders.split(';')
        Boolean bsflg=false
        List<String> list=new  ArrayList<String>()
        for (int i=0;i<arr.length;i++){
            if(!(onestr.equals(arr[i]))){
                list.add(arr[i]);
            }else {
                bsflg=true
            }
        }
        if(flag){
            return   StringUtils.join(list, ';')
        }else {
            return   bsflg
        }

    }



    //获取的订单的总数
    def getDoOrderCount(String orders,Boolean flag){
            String[]  arr=orders.split(';')
            List<String> list=new  ArrayList<String>()
            int num=0
            for (int i=0;i<arr.length;i++){
                Order order=Order.findById(Long.parseLong(arr[i]))
                if (order && !("运费".equals(order.title))){
                    num++
                    list.add(order.id)
                }
            }
            if (flag){
                return  num
            }else{
                return   StringUtils.join(list, ';')
            }
    }







    //针对于全部订单的同步
    @Transactional
    def insertAllData(){
        def MyTrade = Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10000, offset: params.offset ?: 0) {
            eq('status', 4 as byte)
            eq('returnStatus', 0 as byte)
            'in'('type', [1,9,10] as byte[])
            order('id', 'asc')
        }
        pagedResultList.iterator().each {
            Trade trade->
                //先判断这个值是否存在ERP当中
                MikuPdeliveryTrade mikuPdeliveryTrade=MikuPdeliveryTrade.findByTradeId(trade.tradeId)
                if (mikuPdeliveryTrade){
                    //不操作
                }else{
                    mikuPdeliveryTrade=new MikuPdeliveryTrade()
                    mikuPdeliveryTrade.with {
                        it.dateCreated=trade.dateCreated
                        it.lastUpdated=trade.lastUpdated
                        it.name=trade.title
                        it.tradeId=trade.tradeId
                        it.orders=getDoOrderCount(trade.orders,false)
                        it.status=0 as byte
                        it.payType=trade.payType
                        it.logicId=trade.consigneeId
                        it.doOrders=""
                        it.donum=0
                        it.alldonum=getDoOrderCount(trade.orders,true)
                        it.totalFee=trade.totalFee
                        it.buyerMessage=trade.buyerMessage
                        it.save(failOnError: true, flush: true)
                    }
                }
        }
    }





    //查询出订单列表的信息
    def list(){
        def MyTrade = MikuPdeliveryTrade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status',0 as byte)
        }
        return [
                tagList: pagedResultList,
                total  : pagedResultList.totalCount,
                params : params,
        ]
    }





    //进行同步商品
    @Transactional
    def SyncData(){
        insertAllData()
        redirect(action: 'index')
    }













}

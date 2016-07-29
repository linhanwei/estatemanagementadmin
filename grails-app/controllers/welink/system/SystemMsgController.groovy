package welink.system

import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang.StringUtils
import welink.common.Logistics
import welink.common.Order
import welink.common.Trade
import welink.warehouse.MikuOrdersLogistics
import org.apache.commons.lang3.StringUtils
import welink.warehouse.MikuPclassify


class SystemMsgController {

    def messageProcessFacadeService;

    def grailsApplication

    def syncSearchItem() {
        SystemSignal systemSignal = new SystemSignal();
        systemSignal.setCode(SystemSignalConstants.Signal.SEARCH_ITEM_REFRESH.getCode());

        String message = com.alibaba.fastjson.JSON.toJSONString(systemSignal);
        String topic = grailsApplication.config.ons.system_signal.topic

        messageProcessFacadeService.sendMessage(topic, "system", systemSignal.getCode(), message);

        render([result: "ok"] as JSON)

    }

    def index() {

    }


    //进行对原来物流信息进行在多订单表的插入
    @Transactional
    def insertAllDataTologics()
    {

//        List<Trade> tradeList=Trade.findAll()
        List<Trade> tradeList=new ArrayList<Trade>()
        def t=Trade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = t.list(max:10000, offset:0 ) {
            gt('id',7999L)
            lt("id", 9000L)
            not {
                eq('status', 8 as byte)
            }
        }
        pagedResultList.iterator().each {
            Trade trade->
                tradeList.add(trade)
        }




        List<Logistics> allList=new ArrayList<Logistics>()
        tradeList.each {
            Trade trade->
                Logistics logistics=Logistics.findById(trade.consigneeId)
                List<String> strlist=new ArrayList<String>()
                //进行查找对应的order值
                String orders=trade.orders
                String[] arr=orders.split(';')
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
                if (logistics && logistics.memo){
                    logistics.zipCode=trade.tradeId
                    logistics.addr=finalorders
                    allList.add(logistics)
                }

                System.out.println("------------------------------------>"+finalorders)
        }

        //进行物流信息的添加
        allList.each {
            Logistics logistics->
                MikuOrdersLogistics mikuOrdersLogistics=MikuOrdersLogistics.findById(Long.parseLong(logistics.zipCode))
                if (mikuOrdersLogistics == null){
                    MikuOrdersLogistics newOneLogistics=new MikuOrdersLogistics()
                    def memo=com.alibaba.fastjson.JSON.parseObject(logistics.memo)
                    newOneLogistics.with {
                        it.tradeId=Long.parseLong(logistics.zipCode)
                        it.logisticsId=logistics.id
                        it.wlcompany=memo.get('物流公司')
                        it.dateCreated=new Date()
                        it.lastUpdated=new Date()
                        it.ismainc=getIsMainFlag(memo.get('物流公司'))?1 as byte:0 as byte
                        it.wlsnumber=gewlcompanySimple(memo.get('物流公司'))
                        it.wlnumber=memo.get('物流单号')
                        it.status=0 as byte
                        it.state=0 as byte
                        it.dateCreated=new Date()
                        it.lastUpdated=new Date()
                        it.orderIds=logistics.addr
                        it.memo="正常商品订单物流"
                        it.save(failOnError: true, flush: true)
                    }
                }
        }
        redirect(action: "index")

        int i=0


    }




    //判断是否是主流的快递公司
    def getIsMainFlag(String str){
        String[] arr=['EMS','中通速递','申通E物流','邮政国内小包','申通','顺丰','圆通速递','韵达快运','顺丰快递','申通快递','顺丰','韵达','中通','邮政'] as String[]
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
        map.put("申通", "shentong");
        map.put("申通E物流", "shentong");
        map.put("邮政国内小包", "youzhengguonei");
        map.put("云栈百世汇通", "huitongkuaidi");
        map.put("申通", "shentong");
        map.put("顺丰快递", "shunfeng");
        map.put("圆通速递", "yuantong");
        map.put("圆通", "yuantong");
        map.put("韵达快运", "yunda");
        map.put("韵达快递", "yunda");
        map.put("韵达", "yunda");
        map.put("顺丰", "shunfeng");
        map.put("天天快递", "tiantian");
        map.put("天天", "tiantian");
        String rinfo=map.get(info);
        return rinfo;
    }






    @Transactional
    def inseronedata(){
        String name=params.name
        Long pId=params.long('pId')
        System.out.println("====================================================================")
        System.out.println(name)
        System.out.println("====================================================================")
        MikuPclassify mikuPclassify=new MikuPclassify()
        mikuPclassify.with {
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.parentId=pId
            it.name=name
            it.memo=name
            it.isDelete=0 as byte
            it.save(failOnError: true, flush: true)
        }
        redirect(action: "index")
    }


}

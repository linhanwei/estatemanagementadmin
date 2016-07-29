package welink.warehouse

import grails.transaction.Transactional
import welink.common.Item
import welink.common.Logistics
import welink.common.MikuBrand
import welink.common.Order
import welink.common.Trade

@Transactional
class OrdersLogisticsService {


    @Transactional
    def insertOneLogistics(String wlh,String wlcompany,Long tradeId,String orders){
        Trade trade=Trade.findByTradeId(tradeId)
        if(trade){
            def  logic=Logistics.findById(trade.consigneeId)
            Boolean flag=MikuOrdersLogistics.findByTradeIdAndWlnumberAndIsDelete(tradeId,wlh,0 as byte)?true:false
            MikuOrdersLogistics mikuOrdersLogistics=flag?MikuOrdersLogistics.findByTradeIdAndWlnumberAndIsDelete(tradeId,wlh,0 as byte):new MikuOrdersLogistics()
            mikuOrdersLogistics.with {
                if (!flag){
                    it.dateCreated=new Date()
                    it.tradeId=tradeId
                }
                it.logisticsId=logic.id
                it.wlcompany=wlcompany
                it.lastUpdated=new Date()
                it.ismainc=getIsMainFlag(wlcompany)?1 as byte:0 as byte
                it.wlsnumber=gewlcompanySimple(wlcompany)
                it.wlnumber=wlh
                it.status=0 as byte
                it.state=0 as byte
                it.lastUpdated=new Date()
                it.orderIds=orders
                it.memo="正常商品订单物流"
                it.save(failOnError: true, flush: true)
            }
        }
    }



    //进行对物流信息的撤销
    def cancelOneMikuLogistics(String wlh,Long tradeId){
        MikuOrdersLogistics mikuOrdersLogistics=MikuOrdersLogistics.findByTradeIdAndWlnumberAndIsDelete(tradeId,wlh,0 as byte)
        mikuOrdersLogistics.with {
            it.lastUpdated=new Date()
            it.isDelete= 1 as byte
            it.save(failOnError: true, flush: true)
        }
    }




    //根据订单号来查询对应的物流信息
    def getMikulogitcInfo(Long tradeId){
        List<MikuOrdersLogistics> list=MikuOrdersLogistics.findAllByTradeIdAndIsDelete(tradeId,0 as byte)
        List<Item> itemList=new ArrayList<Item>()
        //要的是物流公司与物流号还有对应的商品
        list.each {
            MikuOrdersLogistics mm->
                String orders=mm.orderIds
                itemList.add(getOrdersByids(orders,mm))
        }
        return  itemList
    }



    //根据orderIds来查出对应的商品对应的名称
    def getOrdersByids(String orders,MikuOrdersLogistics mikuOrdersLogistics) {
        String[] arr = orders.split(';')
        Item one=new Item()
        String name="",keyword=""
        for (int i = 0; i < arr.length; i++) {
            Order order = Order.findById(Long.parseLong(arr[i]))
            if (order && !("运费".equals(order.title))) {
                Item item = Item.findById(order.artificialId)
                name+=item.title+"X"+order.num
                name+="   "
                //品牌
                MikuBrand brand = MikuBrand.findById(item.brandId)
                keyword= brand ? brand.name+"   " : ""
            }
        }
        one.with {
            it.title=name
            it.keyWord=keyword
            //物流单号
            it.inputStr = mikuOrdersLogistics.wlnumber
            //物流公司
            it.props = mikuOrdersLogistics.wlcompany
        }
        return  one
    }



    //判断是否是主流的快递公司
    def getIsMainFlag(String str){
        String[] arr=['EMS','中通速递','申通E物流','邮政国内小包','申通','顺丰','圆通速递','韵达快运','顺丰快递','申通快递','韵达','中通','邮政','韵达快递','申通快递'] as String[]
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
        map.put("邮政", "youzhengguonei");
        map.put("云栈百世汇通", "huitongkuaidi");
        map.put("百世汇通", "huitongkuaidi");
        map.put("申通快递", "shentong");
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




    //看对应订单号是否已经被选了
    def getISCheckByorderId(Long tradeId,Long orderId){
        List<MikuOrdersLogistics> list=MikuOrdersLogistics.findAllByTradeIdAndIsDelete(tradeId,0 as byte)
        boolean falg=false
        list.each {
            String  str=it.orderIds
            String[] arr = str.split(';')
            for (int i = 0; i < arr.length; i++) {
                if((orderId+"").equals(arr[i])){
                    falg=true
                }
            }
        }
        return  falg
    }











}

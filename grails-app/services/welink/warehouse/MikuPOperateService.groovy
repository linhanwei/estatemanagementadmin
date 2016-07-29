package welink.warehouse

import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.OperateData
import welink.common.Logistics
import welink.common.MikuSalesRecord
import welink.common.Trade

@Transactional
class MikuPOperateService {

    static  DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

    //统计月与年出库的统计
    def outKuBytime(String startTime,String endTime,String timeinfo,String eeeDate, int size,String flag){
        List<MikuPdeliveryTrade> tradeList=getTradeInfo(startTime,endTime)
        List<OperateData> list=doByType(flag,tradeList,size,timeinfo,eeeDate)
        return  list
    }



    //统计月与年支出的统计
    def expensesByTime(String startTime,String endTime,String timeinfo,String eeeDate, int size,String flag){

    }

















    //根据类型来进行判断对应各种类型：需求尽可能的复用
    def doByType(String flag,List<MikuPdeliveryTrade> tradeList,int size,String timeinfo,String eeeDate){
        def operdatemap=[:]
        operdatemap= doByTimeParams(tradeList,size,timeinfo,eeeDate,flag)
        List<OperateData> list=countSomerkNum(timeinfo,size,operdatemap,flag)
        return  list
    }




    //年月操作
    def doByTimeParams(List<MikuPdeliveryTrade> tradeList,int size,String timeinfo,String eeeDate,String flag){
        def operdatemap=[:]
        tradeList.each {
            MikuPdeliveryTrade trade->
                for (int k=1;k<size+1;k++){
                    String lb=k<10?"0"+k:k
                    String ln=(k+1)<10?"0"+(k+1):(k+1)
                    String beginDate="",endDate=""
                    if ("Y".equals(flag)){
                        beginDate=timeinfo+"-"+lb+"-01 00:00"
                        endDate=timeinfo+"-"+ln+"-01 00:00"
                        if (k==size){
                            endDate=eeeDate+"-01-01 00:00"
                        }
                    }else if ("M".equals(flag)){
                        beginDate=timeinfo+"-"+lb+" 00:00"
                        endDate=timeinfo+"-"+ln+" 00:00"
                        if (k==size){
                            endDate=eeeDate+" 00:00"
                        }
                    }
                    if (trade.lastUpdated>=formatter.parseDateTime(beginDate).toDate() && trade.lastUpdated<=formatter.parseDateTime(endDate).toDate()){
                        List<MikuPdeliveryOrders> ordersList=MikuPdeliveryOrders.findAllByTradeIdAndIsDelete(trade.tradeId,0 as byte);
                        if (operdatemap.get(timeinfo+"-"+k)){
                            List<MikuPdeliveryOrders>  oldlist=operdatemap.get(timeinfo+"-"+k)
                            oldlist.addAll(ordersList)
                            operdatemap.put(timeinfo+"-"+k,oldlist)
                        }else {
                            operdatemap.put(timeinfo+"-"+k,ordersList)
                        }
                    }
                }
        }
        return  operdatemap
    }



    def countSomerkNum(String timeinfo,int size,Map operdatemap,String flag){
        List<OperateData> list=new ArrayList<OperateData>()
        def newmap=[:]
        for (int k=1;k<size+1;k++){
            List<MikuPdeliveryOrders>  oldlist=operdatemap.get(timeinfo+"-"+k)
            int sum=0
            oldlist.each {
                MikuPdeliveryOrders orders->
                    sum+=orders.num
            }
            OperateData operateData=new OperateData()
            operateData.with {
                it.id=k
                it.num=sum
            }
            list.add(operateData)
            newmap.put(timeinfo+"-"+k,sum)
        }
        return list
    }



    //进行对字符的获取[月]
    def getTimeInfo(String beginstr){
        String str=""
        String[] arr=beginstr.split("-")
        if (arr.size()==3){
            str=arr[0]+"-"+arr[1]
        }
        return str
    }






    def getTradeInfo(String startTime,String endTime){
        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null
        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        def MyTrade = MikuPdeliveryTrade.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = MyTrade.list(max:100000, offset:0) {
            eq('status',2 as byte)
            if (start != null) {
                gt("lastUpdated", start)
            }
            if (end != null) {
                lt("lastUpdated", end)
            }
        }
        List<MikuPdeliveryOrders> ordersList=new ArrayList<MikuPdeliveryOrders>()
        List<MikuPdeliveryTrade> tradeList=new ArrayList<MikuPdeliveryTrade>()
        pagedResultList.iterator().each {
            MikuPdeliveryTrade trade->
                tradeList.add(trade)
        }
        return tradeList
    }





    //进行的订单与数量的统计
    def  getTradesBynumsOrFee(String time,String flag,String type){
        //接收类型的是：type --> Fee  num
        //接收的时间标示: flag  --> Y  M
        //具体的时间值：time
        if ("Fee".equals(type)){

        }
        else if("Num".equals(type)){
            if ("Y".equals(flag)){

            }
            else if("M".equals(flag)){

            }
        }
    }



    def getTradeFeeByTimeType(String flag,String time,String type){
        List<OperateData> sumlist=new ArrayList<OperateData>()
        if ("Fee".equals(type)){
            if ("Y".equals(flag)){
                //开始时间数组
                List<String> startArr=getMonthArr(time,0)
                //结束时间数组
                List<String> endArr=getMonthArr(time,1)
                for (int j=0;j<12;j++){
                    OperateData operateData=new OperateData()
                    operateData.num=seleTargetFromTrade(startArr.get(j),endArr.get(j),1).get(0)?seleTargetFromTrade(startArr.get(j),endArr.get(j),1).get(0):0
                    operateData.name=time+"-"+(j+1)
                    sumlist.add(operateData)
                }
            }
            else if("M".equals(flag)){
                //单个月的值
                //12个月的值
                String[] arr=time.split("-")
                String year=arr[0]
                String month=arr[1]
                String start=time+"-1 00:00"
                String end=time+"-"+getOneMonthDays(Integer.parseInt(month),Integer.parseInt(year))+" 00:00"
                OperateData operateData=new OperateData()
                operateData.num=seleTargetFromTrade(start,end,1).get(0)?seleTargetFromTrade(start,end,1).get(0):0
                operateData.name=time
                sumlist.add(operateData)
            }
        }
        else if("Num".equals(type)){
            if ("Y".equals(flag)){
                //开始时间数组
                List<String> startArr=getMonthArr(time,0)
                //结束时间数组
                List<String> endArr=getMonthArr(time,1)
                for (int j=0;j<12;j++){
                    OperateData operateData=new OperateData()
                    operateData.num=seleTargetFromTrade(startArr.get(j),endArr.get(j),0).get(0)?seleTargetFromTrade(startArr.get(j),endArr.get(j),0).get(0):0
                    operateData.name=time+"-"+(j+1)
                    sumlist.add(operateData)
                }
            }
            else if("M".equals(flag)){
                //单个月的值
                //12个月的值
                String[] arr=time.split("-")
                String year=arr[0]
                String month=arr[1]
                String start=time+"-1 00:00"
                String end=time+"-"+getOneMonthDays(Integer.parseInt(month),Integer.parseInt(year))+" 00:00"
                OperateData operateData=new OperateData()
                operateData.num=seleTargetFromTrade(start,end,0).get(0)?seleTargetFromTrade(start,end,0).get(0):0
                operateData.name=time
                sumlist.add(operateData)
            }
        }
        else if ("Frun".equals(type)){
            if ("Y".equals(flag)){
                //开始时间数组
                List<String> startArr=getMonthArr(time,0)
                //结束时间数组
                List<String> endArr=getMonthArr(time,1)
                for (int j=0;j<12;j++){
                    OperateData operateData=new OperateData()
                    operateData.num=selectTargetFormSalesRecords(startArr.get(j),endArr.get(j),1).get(0)?selectTargetFormSalesRecords(startArr.get(j),endArr.get(j),1).get(0):0
                    operateData.name=time+"-"+(j+1)
                    sumlist.add(operateData)
                }
            }
            else if("M".equals(flag)){
                //单个月的值
                //12个月的值
                String[] arr=time.split("-")
                String year=arr[0]
                String month=arr[1]
                String start=time+"-1 00:00"
                String end=time+"-"+getOneMonthDays(Integer.parseInt(month),Integer.parseInt(year))+" 00:00"
                OperateData operateData=new OperateData()
                operateData.num=selectTargetFormSalesRecords(start,end,1).get(0)?selectTargetFormSalesRecords(start,end,1).get(0):0
                operateData.name=time
                sumlist.add(operateData)
            }
        }
        else if ("FrunNum".equals(type)){
            if ("Y".equals(flag)){
                //开始时间数组
                List<String> startArr=getMonthArr(time,0)
                //结束时间数组
                List<String> endArr=getMonthArr(time,1)
                for (int j=0;j<12;j++){
                    OperateData operateData=new OperateData()
                    operateData.num=selectTargetFormSalesRecords(startArr.get(j),endArr.get(j),0).get(0)?selectTargetFormSalesRecords(startArr.get(j),endArr.get(j),0).get(0):0
                    operateData.name=time+"-"+(j+1)
                    sumlist.add(operateData)
                }
            }
            else if("M".equals(flag)){
                //单个月的值
                //12个月的值
                String[] arr=time.split("-")
                String year=arr[0]
                String month=arr[1]
                String start=time+"-1 00:00"
                String end=time+"-"+getOneMonthDays(Integer.parseInt(month),Integer.parseInt(year))+" 00:00"
                OperateData operateData=new OperateData()
                operateData.num=selectTargetFormSalesRecords(start,end,0).get(0)?selectTargetFormSalesRecords(start,end,0).get(0):0
                operateData.name=time
                sumlist.add(operateData)
            }
        }
        return  sumlist
    }




    //查询对应数量，根据给我的对应时间参数
    def seleTargetFromTrade(String start,String end,int flag){
        def sum=0
        String query=""
        if (flag){
            query+=("select sum(totalFee) from Trade where payTime  between '"+start+"'  and '"+end+"'")
        }else{
            query+=("select count(id) from Trade where payTime  between '"+start+"'  and '"+end+"'")
        }
        query+=" and type in(1,9) and status in(4, 6, 5, 7, 20) and returnStatus=0"
        sum=Trade.executeQuery(query)
        return sum
    }


    //查询的对应的分润内容，根据时间参数
    def selectTargetFormSalesRecords(String start,String end,int flag){
        def sum=0
        String query=""
        if (flag){
            query+=("select sum(shareFee) from MikuSalesRecord where lastUpdated  between '"+start+"'  and '"+end+"'")
        }else{
            query+=("select count(id) from MikuSalesRecord where lastUpdated  between '"+start+"'  and '"+end+"'")
        }
        query+=" and returnStatus=0"
        sum=MikuSalesRecord.executeQuery(query)
        return sum
    }



    //封装数据用的
    def getMonthArr(String year,int flag){
        List<String> stringList=new ArrayList<String>()
        if (flag==0){
            for(int i=1;i<13;i++){
                StringBuilder str=new StringBuilder(year)
                str.append("-")
                str.append(i)
                str.append("-")
                str.append("1 00:00")
                stringList.add(str.toString())
            }
        }else{
            for(int i=1;i<13;i++){
                StringBuilder str=new StringBuilder(year)
                str.append("-")
                str.append(i)
                str.append("-")
                str.append(getOneMonthDays(i,Integer.parseInt(year))+" 00:00")
                stringList.add(str.toString())
            }
        }
        return  stringList
    }


    //进行对的年度天数统计
    def getOneMonthDays(int month,int year){
        int count=0
        switch (month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                count=31;
                break;
            case 4:
            case 6:
            case 9:
            case 11:
                count=30;
                break;
            case 2:
                if (year % 4 == 0) {
                    if (year % 100 != 0) {
                        count= 29;
                    }
                    else {
                        if (year % 400 == 0) {
                            count= 29;
                        }
                        else {
                            count= 28;
                        }
                    }
                }
                else {
                    count=  28;
                }
                break;
        }
        return  count;
    }




}

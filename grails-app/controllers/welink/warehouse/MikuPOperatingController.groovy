package welink.warehouse

import com.google.common.collect.ImmutableMap
import grails.converters.JSON

class MikuPOperatingController {
    MikuPOperateService mikuPOperateService
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


    //查出出库内容
    def getckNumByParams(){
        String startTime=params.startTime
        String endTime=params.endTime
        String timeinfo=params.timeinfo
        String eeeDate=params.eeeDate
        String flag=params.flag
        int size=params.int('size')
//        def map=mikuPOperateService.outKuBytime("2016-04-01 00:00","2016-05-01 00:00","2016-04","2016-05-01",30,"M")
//        def map=mikuPOperateService.outKuBytime("2016-01-01 00:00","2017-01-01 00:00","2016","2017-01-01",12,"Y")
        def map=mikuPOperateService.outKuBytime(startTime,endTime,timeinfo,eeeDate,size,flag)
        if (map){
            render(map as JSON)
        }else {
            render("no data")
        }

        //总体
//        if("1".equals(type)){
//
//        }
//        //个体
//        else{
//            Long lmtype=params.long('lmtype')
//            Long providId=params.long('providId')
//        }


    }




    //查出平台获取金额
    def getSumPriceByParams(){
        String type=params.type
        String timeflg=params.timeflg


    }





    //查出对应利润金额
    def getlirunByParams(){
        String type=params.type
        String timeflg=params.timeflg
    }



}

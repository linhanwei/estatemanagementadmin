package welink.system

import grails.converters.JSON
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.codehaus.groovy.grails.web.json.JSONObject
import org.joda.time.DateTime
import org.joda.time.DateTimeZone
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.OperateData
import welink.common.Category
import welink.common.Item
import welink.common.MikuBrand
import welink.common.Trade
import welink.estate.Community
import welink.user.Employee

class OperatingStatisticController {


    final DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")

    final DateTimeFormatter pageTimeFormatter = DateTimeFormat.forPattern("yyyy-MM-dd")

    def keenIOService

    def operateDataService

    def index() {

        //进行记录的是各个类目集合
        List<OperateData> operateDataList=operateDataService.initDataList()
        //A.获取所有的一级类目id
        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1)
        return [
                categoryList: categoryList,
                listr:com.alibaba.fastjson.JSON.toJSON(operateDataList)
        ]
    }


    //获取对应的条件
    def getcomdition()
    {
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        //父节点id
        def  onelevel=params.long('onelevel')
        def  twolevel=params.long('twolevel')
        def  threelevel=params.long('threelevel')
        def  falg=params.falg
        def  lmbzflag=params.lmbzflag
        //全不选上面类目的时候
        if (lmbzflag=="1"){
            operateDataList=operateDataService.nocheckLMDataList(falg)
        }else{
            if ("0".equals(falg))
            {
                operateDataList=operateDataService.returnNoCheckDataList(onelevel,twolevel)
            }
            //选类目
            else if ("1".equals(falg))
            {
                operateDataList=operateDataService.returnoperateDataList(onelevel,twolevel)
            }
            //选品牌
            else if ("2".equals(falg))
            {
                operateDataList=operateDataService.returnPingpaiDataList(onelevel,twolevel)
            }
            //选类目+品牌
            else if ("3".equals(falg))
            {
                operateDataList= operateDataService.returnAllCheckDataList(onelevel,twolevel)
            }
        }
        render(operateDataList as JSON)
    }


    def incomeStatistics(def communityId) {


        def incomeStats
        if (communityId == null) {
            incomeStats = keenIOService.runQuery("https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/queries/sum?api_key=acf39e4593f46967bb81d13e7159b314b14f5a21b5bb3ee567fb1af57486fd1722b24490c358b7e3f32327e8f075b0727979d190cb4bb554d4e9f80071c566de437f5be33f4fea65f33984ac49613be943465e79a2d405c7ec9aebb14345f76b1b95f305d9066194e67e66063c64ff69&event_collection=trade&timeframe=this_7_days&timezone=28800&target_property=data.totalFee&interval=daily")
        } else {
            incomeStats = keenIOService.runQuery("https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/queries/sum?api_key=acf39e4593f46967bb81d13e7159b314b14f5a21b5bb3ee567fb1af57486fd1722b24490c358b7e3f32327e8f075b0727979d190cb4bb554d4e9f80071c566de437f5be33f4fea65f33984ac49613be943465e79a2d405c7ec9aebb14345f76b1b95f305d9066194e67e66063c64ff69&event_collection=trade&filters=%5B%7B%22property_name%22%3A%22data.communityId%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A${communityId}%7D%5D&timeframe=this_7_days&timezone=28800&target_property=data.totalFee&interval=daily")
        }



        JSONObject json = new JSONObject()

        def categories = []

        def values = []

        for (def result in incomeStats.'result') {

            values << result.'value' / 100

            String endTime = result?.'timeframe'?.'end'
            def time = DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parseDateTime(endTime).withZone(DateTimeZone.forID("+08"))
            categories << "'${time.toString("MM-dd")}'"
        }

        json.put("values", values)
        json.put("categories", categories)

        return json
    }

    def deliveryStatistics(def communityId, String startTime, String endTime) {

        def itemStats

        if (communityId == null) {
            itemStats = keenIOService.runQuery("https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/queries/sum?api_key=acf39e4593f46967bb81d13e7159b314b14f5a21b5bb3ee567fb1af57486fd1722b24490c358b7e3f32327e8f075b0727979d190cb4bb554d4e9f80071c566de437f5be33f4fea65f33984ac49613be943465e79a2d405c7ec9aebb14345f76b1b95f305d9066194e67e66063c64ff69&event_collection=dispatched-orders&timeframe=today&timezone=28800&target_property=data.num&group_by=data.itemId")
        } else {
            itemStats = keenIOService.runQuery("https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/queries/sum?api_key=acf39e4593f46967bb81d13e7159b314b14f5a21b5bb3ee567fb1af57486fd1722b24490c358b7e3f32327e8f075b0727979d190cb4bb554d4e9f80071c566de437f5be33f4fea65f33984ac49613be943465e79a2d405c7ec9aebb14345f76b1b95f305d9066194e67e66063c64ff69&event_collection=dispatched-orders&filters=%5B%7B%22property_name%22%3A%22features.communityId%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A${communityId}%7D%5D&timeframe=today&timezone=28800&target_property=data.num&group_by=data.itemId")
        }


        def retList = []

        for (def result in itemStats.'result') {

            def list = []
            int count = result.'result'
            int itemId = result.'data.itemId'

            String title
            if (itemId != -1) {
                title = Item.findById(itemId, [cache: true])?.title
            } else {
                title = '运费'
            }
            list << title
            list << count

            retList << list
        }

        retList.sort {
            a, b ->
                return b.get(1) <=> a.get(1)
        }

        retList

    }

    def deliveryYesterdayStatistics(def communityId, String startTime, String endTime) {

        def itemStats

        if (communityId == null) {
            itemStats = keenIOService.runQuery("https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/queries/sum?api_key=acf39e4593f46967bb81d13e7159b314b14f5a21b5bb3ee567fb1af57486fd1722b24490c358b7e3f32327e8f075b0727979d190cb4bb554d4e9f80071c566de437f5be33f4fea65f33984ac49613be943465e79a2d405c7ec9aebb14345f76b1b95f305d9066194e67e66063c64ff69&event_collection=dispatched-orders&timeframe=yesterday&timezone=28800&target_property=data.num&group_by=data.itemId")
        } else {
            itemStats = keenIOService.runQuery("https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/queries/sum?api_key=acf39e4593f46967bb81d13e7159b314b14f5a21b5bb3ee567fb1af57486fd1722b24490c358b7e3f32327e8f075b0727979d190cb4bb554d4e9f80071c566de437f5be33f4fea65f33984ac49613be943465e79a2d405c7ec9aebb14345f76b1b95f305d9066194e67e66063c64ff69&event_collection=dispatched-orders&filters=%5B%7B%22property_name%22%3A%22features.communityId%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A${communityId}%7D%5D&timeframe=yesterday&timezone=28800&target_property=data.num&group_by=data.itemId")
        }


        def retList = []

        for (def result in itemStats.'result') {

            def list = []
            int count = result.'result'
            int itemId = result.'data.itemId'

            String title
            if (itemId != -1) {
                title = Item.findById(itemId, [cache: true])?.title
            } else {
                title = '运费'
            }
            list << title
            list << count

            retList << list
        }

        retList.sort {
            a, b ->
                return b.get(1) <=> a.get(1)
        }

        retList

    }
}

import com.google.common.collect.HashMultiset
import com.google.common.collect.Multiset
import org.apache.commons.lang3.StringUtils
import org.codehaus.groovy.grails.web.json.JSONObject
import welink.common.Logistics
import welink.common.Trade
import welink.estate.Community
import welink.system.PointInPolygonService
import welink.system.UndeliveredTradeScheduleService

UndeliveredTradeScheduleService undeliveredTradeScheduleService = ctx.getBean('undeliveredTradeScheduleService')

PointInPolygonService pointInPolygonService = ctx.getBean("pointInPolygonService")

List<Trade> tradeList = Trade.findAllByStatusAndCommunityId(4 as Byte, -1 as Byte)

List<Community> communities = Community.findAll()

Multiset<String> multiset = HashMultiset.create()

def list = []

list.add("###" + tradeList.size())

tradeList.each {
    Trade trade ->
        String location = Logistics.findById(trade.consigneeId)?.addr
        if (!location) {
            return
        }
        try {

            location = location.replace("\u0001", "")
            Thread.sleep(1000)
            def geo = new JSONObject("http://restapi.amap.com/v3/geocode/geo?address=${location}&key=36d9f8e2f79ffb2dd451b6d109ac1d4b".toURL().text)
            if (geo.status == '1' && geo.count.toInteger() > 0) {
                def point = geo.geocodes[geo.count.toInteger() - 1].location

                communities.each {
                    Community community ->
                        if (StringUtils.isNotBlank(community.deliveryArea)) {

                            if (pointInPolygonService.isIn(point, community.deliveryArea)) {
                                trade.communityId = community.id
                                trade.save(flush: true, failOnError: true)
                                multiset.add("${community.id}")
                                list.add("OK ${community.id} ~ " + location)
                                return
                            }


                        }
                }
            } else {
                list.add("+++" + location + "+++" + geo.toString())
            }
        } catch (Exception e) {
            list.add(e.getMessage())
        }

}

list.toListString()








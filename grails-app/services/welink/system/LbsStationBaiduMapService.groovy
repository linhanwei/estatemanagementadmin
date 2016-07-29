package welink.system

import com.google.common.collect.ImmutableMap
import org.apache.commons.lang3.StringUtils
import org.apache.commons.lang3.builder.ToStringBuilder
import org.joda.time.DateTime
import welink.common.Logistics
import welink.common.Trade
import welink.estate.Community
import welink.sdk.baidu.BaiduMap
import welink.sdk.baidu.result.DataCreateResult

import static com.google.common.base.Preconditions.checkArgument
import static com.google.common.base.Preconditions.checkNotNull
import static org.apache.commons.lang3.StringUtils.isNotBlank

class LbsStationBaiduMapService {

    def grailsApplication

    /**
     * 给一个配送点建立一个百度地图
     *
     * @param community
     */
    def createCommunityCloudMap(Community community) {
        checkNotNull(community, "the community should not be null.")
        checkArgument(isNotBlank(community.name))

        String ak = grailsApplication.config.baidu.rest_key

        def tableId = checkNotNull(BaiduMap.createBaiduMapTable(ak, community.name).id)

        BaiduMap.createBaiduMapColumn(ak, "订单号", "trade_id", "1", true, false, true, true, tableId);
        BaiduMap.createBaiduMapColumn(ak, "预约时间", "appointment_delivery_time", "1", true, false, true, false, tableId);

        community.cloudTable = tableId
        community.save(flush: true, failOnError: true)
    }

    /**
     * 未发货订单，把订单反应到地图里面
     *
     * @param trade
     */
    def createNewDate2BaiduMapTable(Trade trade) {

        // 自提订单不丢进去
        if (trade.shippingType == 1 as Byte) {
            return true
        }

        String ak = grailsApplication.config.baidu.rest_key

        Community community = Community.findById(trade.communityId)

        checkNotNull(community, "the community could not be null by id [%s] ", trade.communityId)
        checkNotNull(community.cloudTable)

        def logistics = Logistics.findById(trade.consigneeId)

        def location = "${logistics.longitude},${logistics.latitude}"

        location = BaiduMap.transform(ak, location)

        double x = Double.valueOf(StringUtils.split(location, ",")[0]);
        double y = Double.valueOf(StringUtils.split(location, ",")[1]);

        def adt = trade.appointDeliveryTime != null ? trade.appointDeliveryTime.time : defaultAppointmentDeliveryTime(trade.dateCreated).millis

        Map<String, String> data = ImmutableMap.<String, String> builder() //
                .put("trade_id", String.valueOf(trade.tradeId)) //
                .put("appointment_delivery_time", String.valueOf(adt)) //
                .build();

        DataCreateResult dataCreateResult = BaiduMap.createDataInTable(ak, community.cloudTable, "订单", logistics.addr, "订单", x, y, data);

        def ret = (dataCreateResult.status == 0)

        if (!ret) {
            log.error("baidu map data created error with [${ToStringBuilder.reflectionToString(dataCreateResult)}], and the trade id is ${trade.tradeId}")
        }

        return ret
    }


    DateTime defaultAppointmentDeliveryTime(Date dateCreated) {
        DateTime time = new DateTime(dateCreated.time)

        if (time.getHourOfDay() < 14) {
            return new DateTime().withTimeAtStartOfDay().plusHours(18)
        } else {
            return new DateTime().withTimeAtStartOfDay().plusDays(1).plusHours(12)
        }
    }

    def deleteDataInTable(Trade trade) {

        String key = grailsApplication.config.baidu.rest_key

        Community community = Community.findById(trade.communityId)

        checkNotNull(community)
        checkNotNull(community.cloudTable)

        // 自提订单不丢进去
        if (trade.shippingType == 1 as Byte) {
            return true
        }

        def table = BaiduMap.deleteDataInTable(key, community.cloudTable, "${trade.tradeId}")

        def ret = (table.status == 0)

        if (!ret) {
            log.error("baidu map delete error with [${ToStringBuilder.reflectionToString(table)}], and the trade id is ${trade.tradeId}")
        }

        return ret

    }
}

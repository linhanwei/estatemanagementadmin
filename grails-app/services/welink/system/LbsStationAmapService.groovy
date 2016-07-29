package welink.system

import com.google.common.collect.ImmutableMap
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.common.Logistics
import welink.common.Trade
import welink.estate.Community
import welink.sdk.amap.AMap
import welink.sdk.amap.result.DataDeleteResult

import static com.google.common.base.Preconditions.checkNotNull

/**
 * 当出现一笔待发货订单的时候，直接把lbs信息存入到amap里面。如果点击已发货，就把这个从表里面删除
 *
 * 有可能出现不同步的风险
 */
class LbsStationAmapService {

    static DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss")

    def grailsApplication

    def redisService

    def createNewDate2AmapTable(Trade trade) {

        String key = grailsApplication.config.amap.rest_key

        Community community = Community.findById(trade.communityId)

        checkNotNull(community, "the community could not be null by id [%s] ", trade.communityId)
        checkNotNull(community.cloudTable)

        def logistics = Logistics.findById(trade.consigneeId)

        def location = "${logistics.longitude},${logistics.latitude}"
        // 不需要名字，没有用

        String date = new DateTime(trade.dateCreated.time).toString(formatter)

        def data = ImmutableMap.builder()
                .put("_name", "${trade.tradeId}")
                .put("_location", location)
                .put("_address", StringUtils.replace(logistics.addr, "\u0001", ""))
                .put("trade_id", "${trade.tradeId}")
                .put("date_created", date)
                .put("has_buyer_message", StringUtils.isNotBlank(trade.buyerMessage) ? 1 : 0)
                .put("has_company_message", StringUtils.isNotBlank(trade.tradeMemo) ? 1 : 0)
                .put("pay_type", trade.payType ?: -1)
                .put("type", trade.type ?: -1)
                .put("shipping_type", trade.shippingType ?: -1)
                .build()

        String redisKey = "${community.cloudTable}_${trade.tradeId}"

        // 如果存在在redis里面，那就说明这个key存在，也在地图里面
        if (redisService.setnx(redisKey, StringUtils.EMPTY) == 0) {
            return false
        }

        // 如果不存在，在地图里面去创建数据，往下走，这里设置时间的原因是怕下面出现异常
        redisService.expire(redisKey, 604800) // 7 天


        def dataCreateResult = AMap.createDataInTable(key, community.cloudTable, data)

        // 然后
        if (dataCreateResult.status == 1) {
            String tableDataId = dataCreateResult.id // value
            redisService.set(redisKey, tableDataId)
            redisService.expire(redisKey, 604800)
        }

        dataCreateResult.status == 1
    }

    def deleteDataInTable(Trade trade) {

        String key = grailsApplication.config.amap.rest_key

        Community community = Community.findById(trade.communityId)

        checkNotNull(community)
        checkNotNull(community.cloudTable)

        String id = "${community.cloudTable}_${trade.tradeId}"

        String dataId = redisService.get(id)

        redisService.del(id)

        if (StringUtils.isNotBlank(dataId)) {
            DataDeleteResult dataDeleteResult = AMap.deleteDataInTable(key, community.cloudTable, dataId)
            return dataDeleteResult.status == 1
        }

        return false

    }

}

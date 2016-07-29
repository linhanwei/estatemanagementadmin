package welink.system

import com.google.common.base.Preconditions
import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import com.welink.commons.Utils
import groovy.json.JsonBuilder
import org.apache.commons.lang3.StringUtils
import org.apache.commons.lang3.tuple.ImmutablePair
import org.codehaus.groovy.grails.web.json.JSONObject
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.common.Trade
import welink.estate.TradeSearch

class AmapCloudDataService {

    def grailsApplication

    def redisService

    LbsStationAmapService lbsStationAmapService

    static DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss")

    /**
     * 当用户选区一个范围，会把这个方位内的所有点，都传到Redis，然后返回这个有效的key，
     * TTL选择30分钟
     * @param tradeList
     */
    def saveCloudData2Redis(Long userId, String tableId, List<Trade> tradeList) {

        List<String> stringList = Lists.newArrayList()

        String key = "${userId}_${tableId}_${System.currentTimeMillis()}"

        tradeList.each {
            Trade trade ->
                def data = ImmutableMap.builder() //
                        .put("trade_id", "${trade.tradeId}")
                        .put("date_created", new DateTime(trade.dateCreated.time).toString(formatter))
                        .put("pay_type", trade.payType ?: -1)
                        .put("type", trade.type ?: -1)
                        .put("shipping_type", trade.shippingType ?: -1)
                        .build()

                String json = new JsonBuilder(data).toString()
                stringList.add(json)
        }

        redisService.sadd(key, stringList.toArray(new String[0]))
        redisService.expire(key, 3600) // 一小时

        return key

    }

    /**
     * 通过key来搜索redis，然后过滤出我需要的trade_id，然后limit, offset
     *
     * @param key
     * @param type
     * @param shippingType
     * @param payType
     * @param order
     * @param offset
     * @param limit
     */
    ImmutablePair searchTradesInRedis(String key, Integer type, Integer shippingType, Integer payType, String order, int offset, int limit) {
        Set<String> strings = redisService.smembers(key)

        // 如果这个key没有关联的数据，或者这个数据集是empty
        if (strings.isEmpty()) {
            return Lists.newArrayList()
        }

        // 开始做过滤
        def filtered = strings.collect {
            new JSONObject(it)
        }

        if (shippingType != null) {
            filtered = filtered.findAll {
                it."shipping_type" == shippingType
            }
        }

        if (payType != null) {
            filtered = filtered.findAll {
                it."pay_type" == payType
            }
        }

        if (type != null) {
            filtered = filtered.findAll {
                it."type" == type
            }
        }

        // 返回所有的订单
        List<Trade> tradeList = filtered.collect {
            Trade trade = Trade.findByTradeId(Long.parseLong(it.'trade_id'))
            // 如果已经呗删除了
            Preconditions.checkNotNull(trade, "the trade should not be null with trade id %s", it.'trade_id')
            if (trade.status != 4) {
                try {
                    lbsStationAmapService.deleteDataInTable(trade)
                } catch (Exception e) {
                    log.error(e.getMessage(), e)
                }
            }
            return trade
        }

        tradeList.sort {
            Trade trade ->
                (TradeSearch.findById(trade.id)?.consigneeMobile) ?: StringUtils.EMPTY
        }

        tradeList.removeAll([null])

        int total = strings.size()

        return ImmutablePair.of(tradeList, total);

    }

}

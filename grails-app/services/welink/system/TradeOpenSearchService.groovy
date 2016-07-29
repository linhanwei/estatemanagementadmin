package welink.system

import com.google.common.collect.Lists
import com.google.common.collect.Maps
import com.opensearch.javasdk.CloudsearchClient
import com.opensearch.javasdk.CloudsearchSearch
import com.opensearch.javasdk.object.KeyTypeEnum
import com.welink.buy.utils.Constants
import grails.util.Environment
import org.apache.commons.lang3.StringUtils
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject
import welink.common.Trade
import welink.estate.TradeSearch

import static org.apache.commons.lang3.StringUtils.replace

class TradeOpenSearchService {

    static lazyInit = false

    String defaultIndexName

    def grailsApplication


    List<Trade> searchUndeliveredTrades(String phone, Date startTime, Date endTime, Long communityId, Integer shippingType, Integer payType, String totalFeeCompare) {
        CloudsearchSearch cloudSearchSearch = new CloudsearchSearch(getCloudsearchClient());
        cloudSearchSearch.addIndex(defaultIndexName);

        if (communityId != null) {
            cloudSearchSearch.addFilter("community_id=${communityId}")
        }

        if (shippingType != null) {
            cloudSearchSearch.addFilter("shipping_type=${shippingType}")
        }

        if (payType != null) {
            cloudSearchSearch.addFilter("pay_type=${payType}")
        }

        if (startTime != null) {
            cloudSearchSearch.addFilter("date_created>${startTime.time}")
        }

        if (endTime != null) {
            cloudSearchSearch.addFilter("date_created<${endTime.time}")
        }

        if (StringUtils.isNotBlank(totalFeeCompare)) {
            cloudSearchSearch.addFilter("${totalFeeCompare}")
        }


        String query = StringUtils.EMPTY

        if (StringUtils.isNotBlank(phone)) {
            query += " AND consignee_mobile:'${phone}'"
        }

        if (StringUtils.isNotBlank(query)) {
            query = StringUtils.removeStart(StringUtils.trim(query), "AND").trim()
            cloudSearchSearch.setQueryString(query)
        }

        cloudSearchSearch.setFormat("json");

        def str = cloudSearchSearch.search()

        cloudSearchSearch.clear()

        JSONObject result = new JSONObject(str)

        def map = [:]

        float searchTime = result.'result'.'searchtime'.toFloat()
        int total = result.'result'.'total'.toInteger()
        int num = result.'result'.'num'.toInteger()
        int viewTotal = result.'result'.'viewtotal'.toInteger()


        List<Trade> tradeList = Lists.newArrayList()

        JSONArray array = result.'result'.getJSONArray("items");

        int min = Math.min(array.size(), total);

        map.put('searchTime', searchTime)
        map.put('total', total)
        map.put('num', num)
        map.put('viewTotal', viewTotal)
        map.put('tradeList', tradeList)

        for (int i = 0; i < min; i++) {
            long tradeId = array.getJSONObject(i).getLong("id");
            Trade trade = Trade.findByIdAndStatus(tradeId, Constants.TradeStatus.WAIT_SELLER_SEND_GOODS.tradeStatusId)
            //搜索，过滤掉团购商品
            if (trade) {
                tradeList.add(trade)
            } else {
                TradeSearch.findById(tradeId)?.delete(flush: true)
            }
        }

        tradeList
    }

    def searchUndeliveredTrades(Integer deliveryStartTime, Integer deliveryEndTime, String address, String phone, Date startTime, Date endTime, Date dead, Long communityId, Integer shippingType, Integer payType, String order, int offset, int limit, String totalFeeCompare, String lbs) {
        CloudsearchSearch cloudSearchSearch = new CloudsearchSearch(getCloudsearchClient());
        cloudSearchSearch.addIndex(defaultIndexName);

        if (communityId != null) {
            cloudSearchSearch.addFilter("community_id=${communityId}")
        }

        if (deliveryStartTime != null && deliveryEndTime != null) {
            cloudSearchSearch.addFilter("bit_struct(daily_delivery_time, \"0-31,32-63\",\"overlap,\$1,\$2,${deliveryStartTime},${deliveryEndTime}\")!=-1")
        }

        if (shippingType != null) {
            cloudSearchSearch.addFilter("shipping_type=${shippingType}")
        }

        if (payType != null) {
            cloudSearchSearch.addFilter("pay_type=${payType}")
        }

        if (startTime != null) {
            cloudSearchSearch.addFilter("date_created>${startTime.time}")
        }

        if (endTime != null) {
            cloudSearchSearch.addFilter("date_created<${endTime.time}")
        }

        if (StringUtils.isNotBlank(lbs)) {
            cloudSearchSearch.addFilter("in_query_polygon(\"polygons\", lbs)>0")
        }

        if (dead != null) {
            cloudSearchSearch.addFilter("appoint_delivery_time<${dead.time + 1}")
            cloudSearchSearch.addFilter("appoint_delivery_time>${dead.time - 86400000}")
        }

        if (StringUtils.isNotBlank(totalFeeCompare)) {
            cloudSearchSearch.addFilter("${totalFeeCompare}")
        }

        String query = StringUtils.EMPTY

        if (StringUtils.isNotBlank(address)) {
            query += " AND address:'${address}'"
        }

        if (StringUtils.isNotBlank(phone)) {
            query += " AND (buyer_mobile:'${phone}' OR consignee_mobile:'${phone}')"
        }

        if (StringUtils.isNotBlank(query)) {
            query = StringUtils.removeStart(StringUtils.trim(query), "AND").trim()
            cloudSearchSearch.setQueryString(query)
        }

        if (StringUtils.isNotBlank(order)) {
            cloudSearchSearch.addSort(order.substring(1), order.substring(0, 1));
        }

        cloudSearchSearch.addDistinct("consignee_mobile", 1, 1, "false")

        if (StringUtils.isNotBlank(lbs)) {
            cloudSearchSearch.setPair("duniqfield:consignee_mobile,polygons:${replace(lbs, ';', ',').replace(',', '\\,')}")
        } else {
            cloudSearchSearch.setPair("duniqfield:consignee_mobile")
        }

        cloudSearchSearch.setFormat("json");
        cloudSearchSearch.setStartHit(offset);
        cloudSearchSearch.setHits(limit);

        def str = cloudSearchSearch.search()

        if (Environment.current != Environment.APPLICATION) {
            log.info(cloudSearchSearch.getDebugInfo())
        }

        cloudSearchSearch.clear()

        JSONObject result = new JSONObject(str)

        def map = [:]

        float searchTime = result.'result'.'searchtime'.toFloat()
        int total = result.'result'.'total'.toInteger()
        int num = result.'result'.'num'.toInteger()
        int viewTotal = result.'result'.'viewtotal'.toInteger()


        List<Trade> tradeList = Lists.newArrayList()

        JSONArray array = result.'result'.getJSONArray("items");

        int min = Math.min(array.size(), limit);

        map.put('searchTime', searchTime)
        map.put('total', total)
        map.put('num', num)
        map.put('viewTotal', viewTotal)
        map.put('tradeList', tradeList)

        for (int i = 0; i < min; i++) {
            def object = array.getJSONObject(i)
            String mobile = object.getString("consignee_mobile")
            List<Trade> trades = searchUndeliveredTrades(mobile, startTime, endTime, communityId, shippingType, payType, totalFeeCompare)
            tradeList.addAll(trades)
        }

        map
    }

    public CloudsearchClient getCloudsearchClient() {
//        String accesskey = "rMlOdjfVBlJH852g";
//        String secret = "YDG248OQfD5z9w5hHQaTdGdEBeRWMP";
        String  accesskey = "GDheOkyZuLg7VALU";
        String secret = "7sQA8nMHZkB3CNgspOWnpzrl5B7tx0";

        Map<String, Object> opts = Maps.newHashMap();

        if (Environment.current == Environment.PRODUCTION) {
            opts.put("host", "http://intranet.opensearch-cn-hangzhou.aliyuncs.com");
            opts.put("gzip", "true");
        } else {
            opts.put("host", "http://opensearch-cn-hangzhou.aliyuncs.com");
            opts.put("gzip", "true");
            opts.put("debug", "true");
        }

        switch (Environment.current) {
            case Environment.DEVELOPMENT:
            case Environment.TEST:
//                defaultIndexName = "test_trade_undelivered_search"
                defaultIndexName = "trade_undelivered_search"
                break;
            case Environment.PRODUCTION:
                defaultIndexName = "trade_undelivered_search"
                break
        }

        CloudsearchClient cloudsearchClient = new CloudsearchClient(accesskey, secret, opts, KeyTypeEnum.ALIYUN);
        cloudsearchClient.setMaxConnections(10);
        return cloudsearchClient;
    }
}

package welink.trade

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.converters.JSON
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.common.Trade
import welink.estate.Community
import welink.sdk.amap.AMap
import welink.sdk.baidu.BaiduMap
import welink.system.AmapCloudDataService
import welink.user.Employee

import static com.google.common.base.Preconditions.checkArgument
import static com.google.common.base.Preconditions.checkNotNull
import static org.apache.commons.lang3.StringUtils.isNotBlank

class TradeMapController {

    AmapCloudDataService amapCloudDataService

    def makeMap() {

        checkArgument(isNotBlank(params.ids))
        checkArgument(isNotBlank(params.tableId))


        def tradeList = Lists.newArrayList(StringUtils.split(params.ids, ",")).collect {
            String tradeId ->
                checkArgument(StringUtils.length(tradeId) > 9)
                Trade trade = Trade.findByTradeIdAndStatus(Long.parseLong(tradeId), 4 as Byte)
                trade
        }

        tradeList.removeAll([null])

        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        String key = amapCloudDataService.saveCloudData2Redis(employee.id, params.tableId, tradeList)

        render ImmutableMap.of("code", "1", "key", key) as JSON
    }

    def selectTradeMap() {

        String lbs = params.lbs;

        def key = AMap.transformBaiduToAMap(grailsApplication.config.amap.rest_key, lbs)

        render ImmutableMap.of("code", "1", "key", key) as JSON

    }

    def index() {

        checkNotNull(params.id)

        Community community = Community.findById(params.long("id"))

        def lbs = BaiduMap.transform(grailsApplication.config.baidu.rest_key, community.lbs)

        Double longitude = StringUtils.split(lbs, ",")[0].toDouble()
        Double latitude = StringUtils.split(lbs, ",")[1].toDouble()

        return [
                communityId: community.id,
                community: community,
                longitude: longitude,
                latitude : latitude
        ]

    }
}

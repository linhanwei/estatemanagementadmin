import org.joda.time.DateTime
import welink.common.Trade
import welink.system.LbsStationBaiduMapService

LbsStationBaiduMapService lbsStationBaiduMapService = ctx.getBean('lbsStationBaiduMapService')

Trade.findAllByStatusInListAndDateCreatedBetween([5, 7], new DateTime().minusWeeks(4).toDate(), new Date()).each {
    Trade trade ->

        lbsStationBaiduMapService.deleteDataInTable(trade)
}


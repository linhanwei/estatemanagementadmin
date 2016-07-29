import welink.common.Trade
import welink.estate.TradeSearch
import welink.system.UndeliveredTradeScheduleService

UndeliveredTradeScheduleService undeliveredTradeScheduleService = ctx.getBean("undeliveredTradeScheduleService")
undeliveredTradeScheduleService.lastUsage = -1

// 获取所有未投递订单
List<Trade> trades = Trade.findAllByStatus(4 as byte)

// 检查Trade是否在TradeSearch里面存在，不存在的话插入

trades.each {
    Trade trade ->
        TradeSearch tradeSearch = TradeSearch.findById(trade.id)

        if (!tradeSearch) { // 如果不存在，就插入进去
            undeliveredTradeScheduleService.transform(trade).save(failOnError: true, flush: true)
        }

}



trades.size()
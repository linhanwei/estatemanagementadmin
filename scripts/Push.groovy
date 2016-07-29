import org.apache.commons.lang.builder.ToStringBuilder
import org.apache.commons.lang3.StringUtils
import welink.common.Logistics
import welink.common.Trade
import welink.estate.TradeSearch

String text = """

"""

List<String> mobiles = StringUtils.split(text, " ").toList().collect { StringUtils.trim(it) }


Trade t
mobiles.each {
    String mobile ->
        Logistics.findAllByMobile(mobile).each {
            Logistics logistics ->
                List<Trade> trades = Trade.findAllByBuyerIdAndStatus(logistics.userId, 4 as Byte)

                trades.each {
                    Trade trade ->
                        try {
                            t = trade
//                            if (trade.totalFee == 100 || trade.totalFee == 600) {
                            if (trade) {
                                t = trade
                                trade.status = 7 as byte
                                trade.codStatus = 8 as byte
                                trade.save(failOnError: true, flush: true)



                                TradeSearch.findById(trade.id)?.delete(flush: true)
                            }
                        } catch (Exception e) {
                            System.err.println(e)
                        }

                }

        }
}

ToStringBuilder.reflectionToString(t)




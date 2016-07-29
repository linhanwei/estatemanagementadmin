import com.alibaba.fastjson.JSON
import welink.system.MessageProcessFacadeService
import welink.system.TradeEvent

MessageProcessFacadeService messageProcessFacadeService = ctx.getBean('messageProcessFacadeService')

Long tradeId = 1342879847375387L

TradeEvent tradeEvent = new TradeEvent()
tradeEvent.setTradeId(tradeId)
tradeEvent.event = "trade_status"

String message = JSON.toJSONString(tradeEvent);
String topic = grailsApplication.config.ons.trade_event.topic


messageProcessFacadeService.sendMessage(topic, "trade_event_status", String.valueOf(tradeId), message);
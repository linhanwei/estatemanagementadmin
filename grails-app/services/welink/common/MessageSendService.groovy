package welink.common

import com.alibaba.fastjson.JSON
import grails.transaction.Transactional
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import welink.system.MessageProcessFacadeService
import welink.system.TradeEvent

import javax.annotation.Resource

@Transactional
class MessageSendService {

    def serviceMethod() {

    }
    @Resource
    MessageProcessFacadeService messageProcessFacadeService

    def grailsApplication

    static Logger logger = LoggerFactory.getLogger(Trade)

    public void sendMessage(long tradeId, String type) {

        TradeEvent tradeEvent = new TradeEvent()
        tradeEvent.setTid(tradeId)
        tradeEvent.setCreated(new Date())
        tradeEvent.setTopic(type)

        try {
            String message = JSON.toJSONString(tradeEvent)
            String topic = grailsApplication.config.ons.trade_event.topic
            messageProcessFacadeService.sendMessage(topic, "trade", String.valueOf(tradeId), message)

        } catch (Exception e) {
            logger.error(e.getMessage(), e)
        }
    }
}

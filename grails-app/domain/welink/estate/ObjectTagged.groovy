package welink.estate

import com.alibaba.fastjson.JSON
import com.google.common.collect.Maps
import org.slf4j.Logger
import org.slf4j.LoggerFactory

import javax.annotation.Resource

class ObjectTagged {

    Long id
    // 可能是商品，可能是店铺
    Long artificialId
    // 具体的关联到哪个tag
    Long tagId

    String kv
    // 类型
    Integer type
    // 状态
    Byte status
    // 开始时间
    Date startTime
    // 结束时间
    Date endTime

    Date lastUpdated

    Date dateCreated

    //活动限量库存
    Long activityNum
    //活动已售
    Long activitySoldNum

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }


    def messageProcessFacadeService

    def grailsApplication

    @Resource
    def eventTaskExecutor

    def afterUpdate = {
        sendMessage(artificialId)
    }

    def afterInsert = {
        sendMessage(artificialId)
    }

    static Logger logger = LoggerFactory.getLogger(ObjectTagged)

    void sendMessage(long itemId) {
        eventTaskExecutor.execute(new Runnable() {
            @Override
            void run() {
                Map<String, String> params = Maps.newHashMap();
                params.put("item_id", String.valueOf(itemId));
                params.put("type", "update");
                try {
                    String message = JSON.toJSONString(params)
                    String topic = grailsApplication.config.ons.item_update.topic
                    messageProcessFacadeService.sendMessage(topic, "item", String.valueOf(itemId), message)
                } catch (Exception e) {
                    logger.error(e.getMessage(), e)
                }
            }
        })
    }
}

package welink.system

import com.alibaba.rocketmq.client.producer.SendResult
import com.aliyun.openservices.ons.api.Message
import com.aliyun.openservices.ons.api.ONSFactory
import com.aliyun.openservices.ons.api.Producer
import com.aliyun.openservices.ons.api.PropertyKeyConst
import com.google.common.collect.Maps

import javax.annotation.Nonnull
import javax.annotation.Nullable
import javax.annotation.PostConstruct
import javax.annotation.PreDestroy

import static com.google.common.base.Preconditions.checkNotNull

class MessageProcessFacadeService {

    static lazyInit = false


    //开发环境
//    public static final String ACCESS_KEY = "GDheOkyZuLg7VALU";
//
//    public static final String SECRET_KEY = "7sQA8nMHZkB3CNgspOWnpzrl5B7tx0";

    //2016年03月14日的开发环境的测试
//    public static final String ACCESS_KEY = "GDheOkyZuLg7VALU";
//
//    public static final String SECRET_KEY = "7sQA8nMHZkB3CNgspOWnpzrl5B7tx0";



    //生产环境
    public static final String ACCESS_KEY = "aHg4n4dESlLleVJz";

    public static final String SECRET_KEY = "L2iNoTs1UyRStJgUtkTtqmHUS22Thd";


    public static Map<String, MessageProcessRegister> topicMessageRegisterMap = Maps.newConcurrentMap();

    def grailsApplication

    public void register(@Nonnull MessageProcess messageProcess) {

        if(topicMessageRegisterMap.containsKey(messageProcess.getTopic())) {
            throw new IllegalStateException("duplicate topic process [" + messageProcess.getTopic() + "] ...");
        }else {
            topicMessageRegisterMap.put(messageProcess.getTopic(), new MessageProcessRegister(messageProcess));
        }

    }

    public void sendMessage(@Nonnull String topic, @Nonnull String tag, @Nullable String key, @Nonnull String body) {
        Producer producer = checkNotNull(topicMessageRegisterMap.get(topic)).producer;

        Message message = new Message(topic, tag, key, body.getBytes());

        producer.send(message);
    }

    static class MessageProcessRegister {

        private Producer producer;

        public MessageProcessRegister(final MessageProcess messageProcess) {

            Properties pprops = new Properties();
            pprops.put(PropertyKeyConst.ProducerId, messageProcess.getProducerId());
            pprops.put(PropertyKeyConst.AccessKey, ACCESS_KEY);
            pprops.put(PropertyKeyConst.SecretKey, SECRET_KEY);
            producer = ONSFactory.createProducer(pprops);
            producer.start();

        }
    }

    @PreDestroy
    public final void close() {
        for (Map.Entry<String, MessageProcessRegister> entry : topicMessageRegisterMap.entrySet()) {
            entry.getValue().producer.shutdown();
        }

        topicMessageRegisterMap.clear();
    }

    @PostConstruct
    public final void init() {
        MessageProcess itemUpdateProcess = new MessageProcess(
                topic: grailsApplication.config.ons.item_update.topic,
                producerId: grailsApplication.config.ons.item_update.producer_id
        )

        register(itemUpdateProcess);


        MessageProcess systemSignalProcess = new MessageProcess(
                topic: grailsApplication.config.ons.system_signal.topic,
                producerId: grailsApplication.config.ons.system_signal.producer_id
        )

        register(systemSignalProcess);

        MessageProcess tradeEventProcess = new MessageProcess(
                topic: grailsApplication.config.ons.trade_event.topic,
                producerId: grailsApplication.config.ons.trade_event.producer_id
        )

        register(tradeEventProcess);


    }
}

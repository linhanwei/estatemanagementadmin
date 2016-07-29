package welink.common

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Maps
import grails.transaction.Transactional
import org.springframework.core.task.TaskExecutor
import welink.estate.TradeSearch
import welink.user.Employee

import javax.annotation.Resource

@Transactional
class TradeDispatchedTrackService {

    @Resource(name = 'eventTaskExecutor')
    TaskExecutor eventTaskExecutor;

    @Resource
    KeenIOService keenIOService

    /**
     * 跟踪调度的商品信息，主要是纪录每天有多少商品已经发货了
     *
     * @param dispatcherId
     * @param tradeIds
     */
    def trackDispatch(final Long dispatcherId, final List<Long> tradeIds) {
        eventTaskExecutor.execute(new Runnable() {
            @Override
            void run() {
                try {
                    dispatch(dispatcherId, tradeIds)
                } catch (Exception e) {
                    log.error(e.getMessage(), e)
                }
            }
        })
    }

    /**
     * 撤回一个Order的发货统计，并且删除TradeSearch表里面的数据，这样就不会搜索到了
     *
     * @param dispatcherId
     * @param tradeIds
     */
    def retractDispatch(final Long dispatcherId, final List<Long> tradeIds) {
        eventTaskExecutor.execute(new Runnable() {
            @Override
            void run() {
                try {
                    retract(dispatcherId, tradeIds)
                } catch (Exception e) {
                    log.error(e.getMessage(), e)
                }
            }
        })
    }

    def retract(long dispatcherId, List<Long> tradeIds) {
        tradeIds.iterator().each {
            Long tradeId ->
                Trade trade = Trade.findById(tradeId)
                String query = "https://api.keen.io/3.0/projects/549d2c9246f9a71b4e266b6e/events/dispatched-orders?api_key=4F8913D6C630D875A2CF52553F2C73AB&filters=%5B%7B%22property_name%22%3A%22features.tradeId%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A${trade.id}%7D%5D&timezone=28800";
                keenIOService.runDelete(query)
        }
    }

    /**
     *
     *
     * @param dispatcherId
     * @param tradeIds
     */
    def dispatch(long dispatcherId, List<Long> tradeIds) {

        Employee employee = Employee.findById(dispatcherId)


        tradeIds.iterator().each {
            Long tradeId ->
                Trade trade = Trade.findById(tradeId)

                if (trade.totalFee != 1) {
                    def orderIds = trade.orders.split(';')
                    orderIds.each {
                        String id ->
                            Order order = Order.findById(Long.parseLong(id))
                            Map<String, Object> features = ImmutableMap.<String, Object> builder() //
                                    .put("tradeId", trade.getId()) //
                                    .put("communityId", trade.getCommunityId()) //
                                    .put("dispatcherId", dispatcherId) //
                                    .build();

                            Map<String, Object> orderMap = Maps.newHashMap()
                            orderMap.put("itemId", order.getArtificialId())
                            orderMap.put("num", order.getNum())

                            Long baseItemId = Item.findById(order.getArtificialId())?.baseItemId
                            if (baseItemId != null) {
                                orderMap.put("baseItemId", baseItemId)
                            }

                            keenIOService.track(employee.getMobile() ?: employee.getName(), "dispatched-orders", orderMap, features)
                    }
                }


        }
    }
}

package welink.system

import com.google.common.collect.Lists
import me.chanjar.weixin.common.util.StringUtils
import org.joda.time.DateTime
import org.joda.time.Days
import org.joda.time.Minutes
import org.springframework.core.task.TaskExecutor
import welink.common.Logistics
import welink.common.Trade
import welink.estate.TradeSearch
import welink.user.Profile

import javax.annotation.Resource

import static com.welink.buy.utils.Constants.TradeStatus.WAIT_SELLER_SEND_GOODS

/**
 * 直接扫描数据库，启动的时候全量扫描，其它时候增量扫描，如果在
 */
class UndeliveredTradeScheduleService {

    public volatile long lastUsage = -1L;

    public volatile boolean started = false;

    LbsStationBaiduMapService lbsStationBaiduMapService

    @Resource(name = 'eventTaskExecutor')
    TaskExecutor eventTaskExecutor;

    /**
     * 5秒钟扫一下数据库，还好我们只有一台数据库
     */
    public synchronized void execute() {

        long now = System.currentTimeMillis();

        List<Trade> trades = Lists.newArrayList()

        if (lastUsage == -1L) {
            trades.addAll(Trade.findAllByStatus(WAIT_SELLER_SEND_GOODS.tradeStatusId))
        } else {

            Date start = new DateTime(lastUsage).minusMinutes(1).toDate()
            Date end = new DateTime(now).plusMinutes(1).toDate()

            trades.addAll(Trade.findAllByStatusAndDateCreatedBetween(WAIT_SELLER_SEND_GOODS.tradeStatusId, start, end))
            trades.addAll(Trade.findAllByStatusAndLastUpdatedBetween(WAIT_SELLER_SEND_GOODS.tradeStatusId, start, end))
        }

        // 获取所有未投递订单，使用between使用索引

        // 检查Trade是否在TradeSearch里面存在，不存在的话插入

        trades.each {
            Trade trade ->

                if (!TradeSearch.findById(trade.id)) { // 如果不存在，就插入进去
                    try {
                        TradeSearch tradeSearch = transform(trade)
                        tradeSearch.save(failOnError: true, flush: true)
                    } catch (Exception e) {
                        log.error(e.getMessage(), e)
                    }

                    // 然后把point放到了高的地图中
                    eventTaskExecutor.execute(new Runnable() {
                        @Override
                        void run() {
                            // 会自给判断地图上面是否有对应的点
                            try {
                                lbsStationBaiduMapService.createNewDate2BaiduMapTable(trade)
                            } catch (Exception e) {
                                log.error(e.getMessage(), e)
                            }
                        }
                    })
                }
        }

        // 如果都OK
        lastUsage = now
    }

    public TradeSearch transform(Trade trade) {
        TradeSearch tradeSearch = new TradeSearch()
        tradeSearch.setId(trade.id)
        tradeSearch.setBuyerId(trade.buyerId)
        // 获取购买人的信息
        Profile profile = Profile.findById(trade.buyerId)
        tradeSearch.setBuyerName(profile?.nickname)
        tradeSearch.setBuyerMobile(profile?.mobile)

        // 获取收货人的信息
        Logistics logistics = Logistics.findById(trade.consigneeId)
        tradeSearch.setConsigneeId(logistics?.id)
        tradeSearch.setConsigneeName(logistics?.contactName)
        tradeSearch.setConsigneeMobile(logistics?.mobile)

        if (StringUtils.isNotBlank(logistics.longitude)) {
            tradeSearch.setLongitude(Double.valueOf(logistics.longitude))
        }

        if (StringUtils.isNotBlank(logistics.latitude)) {
            tradeSearch.setLatitude(Double.valueOf(logistics.latitude))
        }

        if (StringUtils.isNotBlank(logistics.longitude) && StringUtils.isNotBlank(logistics.latitude)) {
            tradeSearch.setLbs("${logistics.longitude},${logistics.latitude}")
        }

        tradeSearch.setPayType(trade.payType)
        tradeSearch.setShippingType(trade.shippingType)
        tradeSearch.setAddress(logistics?.addr)

        tradeSearch.setCommunityId(trade.communityId)
        tradeSearch.setShopId(trade.shopId)
        tradeSearch.setTotalFee(trade.totalFee)
        tradeSearch.setStatus(trade.status)
        tradeSearch.setType(trade.type)
        tradeSearch.setAppointDeliveryTime(trade.appointDeliveryTime?.time)

        if (trade.appointDeliveryTime != null) {
            DateTime dateTime = new DateTime(trade.appointDeliveryTime)
            DateTime start = dateTime.withTimeAtStartOfDay()
            Long startTime = Minutes.minutesBetween(start, dateTime).getMinutes();
            Long endTime = startTime + 150
            Long result = (startTime << 32) | endTime
            tradeSearch.setDailyDeliveryTime(result)
        }

        tradeSearch.setDateCreated(trade.dateCreated.time)

        return tradeSearch
    }

    long getLastUsage() {
        return lastUsage
    }

    boolean getStarted() {
        return started
    }
}
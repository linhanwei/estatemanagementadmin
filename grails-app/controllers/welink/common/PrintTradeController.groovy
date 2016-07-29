package welink.common

import com.google.common.base.Preconditions
import com.google.common.collect.Lists
import com.welink.commons.Utils
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.estate.Community

import java.text.DateFormat
import java.text.SimpleDateFormat

class PrintTradeController {

    final DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");

    final Random random = new Random(System.currentTimeMillis())

    def print() {

    }

    def index() {

        String startTime

        String endTime

        Trade trade = Trade.findById(Long.parseLong(params.id))

        if (trade == null) {
            trade = Trade.findByTradeId(Long.parseLong(params.id))
        }

        DateTimeFormatter formatter = DateTimeFormat.forPattern("MM-dd HH:mm")

        if(trade.appointDeliveryTime){
            DateTime dateTime=new DateTime(trade.appointDeliveryTime)
            startTime=dateTime.toString(formatter)
            endTime=dateTime.plusHours(2).plusMinutes(30).toString(formatter)

        }

        Preconditions.checkNotNull(trade, "the trade [%s] should not be null ...", params.id)

        List<Order> orders = Lists.newArrayList()

        Map<Long, Item> itemMap = [:]

        Lists.newArrayList(StringUtils.split(trade.getOrders(), ';')).collect {
            String orderId ->
                Long.parseLong(orderId)
        }.each {
            Long orderId ->
                Order order = Order.findById(orderId)
                orders.add(order)
                itemMap.put(order.getArtificialId(), Item.findById(order.getArtificialId()))
        }

        //该地址对应的ID
        Logistics logistics = Logistics.findById(trade.consigneeId)

        ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logistics?.consigneeId)

        if (consigneeAddr?.modifiAddr) {
            logistics.addr = consigneeAddr?.modifiAddr
        }

        long communityId = trade.getCommunityId() > 2000 ? trade.getCommunityId() : 2000

        Community community = Community.findById(communityId)

        trade.id = Long.parseLong(Long.toString(Long.parseLong("${generator(2)}" + "${trade.id}" + "${generator(1)}"), 8))

        return [
                startTime: startTime,
                endTime  : endTime,
                trade    : trade,
                orders   : orders,
                formatter: formatter,
                itemMap  : itemMap,
                logistics: logistics,
                community: community
        ]
    }

    String generator(int num) {
        StringBuilder stringBuilder = new StringBuilder(num)

        while (num--) {
            int i = random.nextInt(9) + 1
            stringBuilder.append(i)
        }

        stringBuilder.toString()
    }
}

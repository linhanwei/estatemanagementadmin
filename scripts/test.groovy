import com.google.common.collect.Lists
import org.joda.time.DateTime
import welink.activiti.ItemCopyTaskService
import welink.common.Item
import welink.common.Trade

ItemCopyTaskService itemCopyTaskService = ctx.getBean('ItemCopyTaskService')

itemCopyTaskService.pushItemToAllStation(Item.findById(2266), true)


def buyerIds = [] as Set

Trade.findAllByStatusAndTotalFeeAndIdLessThanEquals(7 as Byte, 100L, 31458).each {
    Trade trade ->
        if (Trade.countByBuyerIdAndIdLessThan(trade.buyerId, 31458) == 1) {
            buyerIds.add(trade.buyerId)
        }
}

println("buyerIds ---> " + buyerIds.size())

def tradeLists = Trade.findAllByIdGreaterThan(31458)

println("tradeLists ---> " + tradeLists.size())

int count = 0;

tradeLists.each {
    Trade trade ->
        if (buyerIds.contains(trade.buyerId)) {
            count++;
        }
}

print "count ---> ${count}"
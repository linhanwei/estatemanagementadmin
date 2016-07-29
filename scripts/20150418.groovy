
import welink.activiti.ItemCopyTaskService
import welink.activiti.ShopTaskService
import welink.common.Item
import welink.common.Shop
import welink.estate.Community



ShopTaskService shopTaskService = ctx.getBean('shopTaskService')

ItemCopyTaskService itemCopyTaskService = ctx.getBean('itemCopyTaskService')

Shop shop = Shop.findById(999L)

// 创建店铺
Community.findAllByStatus(1 as byte).each {
    Community community ->
        shopTaskService.createStationShopByCommunity(shop, community)
}


Item.findAllByApproveStatusAndShopId(1 as byte, 999L).each {
    Item source ->

        Shop.findAllByTypeAndStatus(1 as byte, 1 as byte).each {
            Shop s ->
                println "${source.shopId} - ${source.id} - ${s.id}"
                try {
                    itemCopyTaskService.copyCityItemToStationItem(source, s)
                } catch (Exception e) {
                    println e.getMessage()
                }

        }
}

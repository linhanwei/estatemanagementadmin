import welink.activiti.ItemCopyTaskService
import welink.activiti.ShopTaskService
import welink.common.Item
import welink.common.SellerProfile
import welink.common.Shop
import welink.estate.Community
import welink.estate.ObjectTagged

ShopTaskService shopTaskService = ctx.getBean('shopTaskService')

ItemCopyTaskService itemCopyTaskService = ctx.getBean('itemCopyTaskService')


def communityIds = [2014L, 2015L, 2016L, 2017L, 2019L, 2021L, 2022L, 2023L, 2024L, 2032L, 2033L, 2035L, 2036L, 2037L, 2029L, 2030L, 2031L]

def categoryIds = [20000025L, 20000026L, 20000027L]

def copyCityItemToStationItem(Item source, Shop targetStationShop) {

    Item newItem = Item.findOrCreateByShopIdAndBaseItemId(targetStationShop.id, source.id)?.with {

        it.categoryId = source?.categoryId
        it.title = source?.title
        it.sellerId = targetStationShop?.sellerId
        it.sellerType = source?.sellerType
        it.address = source?.address
        it.specification = source?.specification
        it.video = source?.video
        it.price = source?.price
        it.features = source?.features
        it.onlineStartTime = source?.onlineStartTime
        it.onlineEndTime = source?.onlineEndTime
        it.type = source?.type
        it.picUrls = source?.picUrls
        it.detail = source?.detail
        it.description = source?.description
        it.approveStatus = source?.approveStatus
        //复制的核心，店铺ID，商品编号，店铺等级
        it.shopId = targetStationShop?.id
        it.shopType = targetStationShop?.type
        it.baseItemId = source?.id

        it.num = source?.num
        it.price = source?.price

        save(failOnError: true, flush: true)
    }

    // tag 复制
    ObjectTagged.findAllByArtificialIdAndTypeBetween(source.id, 999, 1999)?.each {
        ObjectTagged objectTagged ->
            ObjectTagged.findOrCreateByArtificialIdAndTagId(newItem.id, objectTagged.tagId)?.with {
                it.artificialId = newItem.id
                it.type = objectTagged?.type
                it.kv = objectTagged?.kv
                it.status = objectTagged?.status
                it.startTime = objectTagged?.startTime
                it.endTime = objectTagged?.endTime
                it.tagId = objectTagged?.tagId
                save(failOnError: true, flush: true)
            }
    }
}


Community.findAllByIdGreaterThan(2011).each {
    Community community ->
        if (!communityIds.contains(community.id)) {
            community.delete(flush: true)
        }
}

Shop.findAllByShopIdGreaterThan(2011).each {
    Shop shop ->
        if (!communityIds.contains(shop.shopId)) {
            shop.delete(flush: true)
        }
}

// #1
// 修改 community

println("站点订正")

Community.findAllByIdInList(communityIds).each {
    Community community ->
        community.status = 1
        community.save(failOnError: true, flush: true)
}

Community.findAllByIdInList([2005, 2000]).each {
    Community community ->
        community.status = 0
        community.save(failOnError: true, flush: true)

}


println("创建用户")

//#2
Shop.findAllByShopIdInList(communityIds).each { it ->
    Long communityId = it.shopId
    Community community = Community.findById(communityId)
    SellerProfile sellerProfile = SellerProfile.findOrCreateByShopId(it.id)
    sellerProfile.communityId = communityId
    sellerProfile.shopId = it.id
    sellerProfile.mobile = community.phone
    sellerProfile.password = "\$2a\$10\$/Hy.XiOQKTunWynzGfnPS.HSQ58F/KzrzseyEPPb.xnZ.yEKCx2Xe"
    sellerProfile.status = 1
    sellerProfile.save(failOnError: true, flush: true)

    Shop shop = it
    shop.sellerId = sellerProfile.id
    shop.status = 1

    shop.save(failOnError: true, flush: true)
}

// #3
println("商品复制")

Item.findAllByCategoryIdInListAndShopId(categoryIds, 999).reverse().each {
    Item source ->
        Shop.findAllByShopIdInList(communityIds).each {
            Shop s ->
                println "${source.shopId} - ${source.id} - ${s.shopId}"
                copyCityItemToStationItem(source, s)
        }
}


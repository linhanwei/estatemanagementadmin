package welink.activiti

import com.welink.commons.commons.BizConstants
import welink.common.Shop
import welink.estate.Community

import static com.google.common.base.Preconditions.checkArgument
import static com.google.common.base.Preconditions.checkNotNull
import static com.welink.commons.commons.BizConstants.ShopTypeEnum.CITY_SHOP
import static com.welink.commons.commons.BizConstants.ShopTypeEnum.STATION_SHOP

class ShopTaskService {

    /**
     * 创建一个站点的时候，会开始一个创建店铺的流程
     */
    def createStationShop(Long cityId) {

        checkNotNull(cityId)
    }

    /**
     * 创建一个站点的时候，会开始一个创建店铺的流程
     */
    def createStationShopByCommunity(Shop cityShop, Community community) {

        checkNotNull(cityShop)
        checkArgument(cityShop.type == BizConstants.ShopTypeEnum.CITY_SHOP.action)
        checkArgument(cityShop.status == 1)
        checkNotNull(community)
        checkArgument(community.status == 1)

        Shop shop = Shop.findOrCreateByCityIdAndShopId(cityShop.cityId, community.id)
        shop.type = STATION_SHOP.action
        shop.alipayAccount = cityShop.alipayAccount
        shop.save(flush: true, failOnError: true)
    }

    /**
     * 删除一个站点店铺
     *
     * @param stationShop
     * @return
     */
    def deleteStationShop(Shop stationShop) {

        checkNotNull(stationShop)

        Shop.findById(stationShop.id)?.with {
            status = 0 as Byte
            save(failOnError: true, flush: true)
        }
    }
}

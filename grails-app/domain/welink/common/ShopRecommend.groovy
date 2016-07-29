package welink.common

class ShopRecommend {

    Long id

    // 店铺Id
    Long shopId

    // 商品Id
    Long itemId

    // 商品类型
    Long categoryId

    // 是否删除，0表示删除，1表示有效
    Byte status

    Date dateCreated

    Date lastUpdated

    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
        shopId index: 'idx_shopId_categoryId'
        categoryId index: 'idx_shopId_categoryId'
    }
}

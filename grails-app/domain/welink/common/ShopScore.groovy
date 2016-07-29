package welink.common

class ShopScore {
    // 店铺分数Id
    Long id
    // 商品描述评分
    Long itemScore
    // 服务态度评分
    Long serviceScore
    // 发货速度评分
    Long deliverScore


    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }
}

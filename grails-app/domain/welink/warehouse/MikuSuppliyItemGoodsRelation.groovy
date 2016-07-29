package welink.warehouse

//供应商提供的商品与总仓商品关联数据表
class MikuSuppliyItemGoodsRelation {

    Long id

    //总仓商品ID
    Long itemId

    //供应商商品ID
    Long supplyGoodsId

    //供应商商品价格


    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

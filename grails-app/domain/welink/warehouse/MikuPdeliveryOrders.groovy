package welink.warehouse

class MikuPdeliveryOrders {


    Long id

    //供应商的id
    Long pid

    //供应商的对应商品的id
    Long pitemId

    //订单的id
    Long tradeId

    //title
    String title

    //创建时间
    Date dateCreated

    //修改时间
    Date lastUpdated

    //商品的数量
    Integer num




    //考虑到海外购的问题【身份证】
    String idcard
    //关联的OrderId
    Long orderId
    //订单的金额
    Long totalFee


    //是否删除[1已删除  0没有删除]
    Byte isDelete









    static mapping = {
        id generator: 'identity'
        version(false)
    }

    static constraints = {
    }
}

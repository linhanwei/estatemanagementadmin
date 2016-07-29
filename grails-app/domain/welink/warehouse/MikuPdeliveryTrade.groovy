package welink.warehouse

class MikuPdeliveryTrade {

    //出库的订单

    Long id



    //订单名称
    String name

    //订单的id
    Long tradeId

    //订单列表
    String orders

    //删除-1 未开始0  进行中1  完成2   出库3
    Byte status

    //支付方式
    //1:线上支付 4.线上微信支付 3.支付宝支付
    Byte payType

    // 创建时间
    Date dateCreated

    // 修改时间
    Date lastUpdated


    //处理订单
    String doOrders



    //处理订单数量
    Integer donum


    //订单数量
    Integer alldonum


    //用户的快递物流关联ID
    Long logicId

    //实际付款的金额
    Long totalFee


    //用户的需求
    String buyerMessage











    static mapping = {
        id generator: 'identity'
        version(false)
    }

    static constraints = {
    }
}

package welink.common

class ValueAddedOrder {
    // 虚拟服务子订单订单号
    Integer id
    // 服务所属的交易订单号。如果服务为一年包换，则item_oid这笔订单享受改服务的保护
    // 如果是家政服务或者预约服务类的，非正式商品
    Long ItemOrderId
    // 购买者来自哪个小区
    Long communityId
    // 服务数字id
    Long serviceId
    // 服务详情
    Long snapshotId
    // 服务详情
    String snapshot
    // 购买数量，取值范围为大于0的整数
    Integer num
    // 服务价格，精确到小数点后两位：单位:元
    Long price
    // 子订单实付金额。精确到2位小数，单位:元。如:200.07，表示:200元7分。
    Long payment
    // 商品名称
    String title
    // 服务子订单总费用
    Long totalFee
    // 买家Id
    Long buyerId
    // 卖家Id
    Long sellerId
    // 卖家类型
    Byte sellerType
    // 最近退款的id
    Long refundId
    // 图片的文件地址
    String picPath

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }
}

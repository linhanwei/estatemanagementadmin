package welink.common

class MikuReturnGoods {
    Long id
    //版本
    Long version
    //交易id
    Long tradeId
    //订单id
    Long orderId
    //商品id
    Long artificialId
    //买家id
    Long buyerId
    //品牌名称
//    String name
    //图片地址
    String picUrl
    //价格
    Long price
    //总金额
    Long totalFee
    //退款金额
    Long refundFee
    //卖家ID
//    Long sellerId
    //卖家类型
//    Long sellerType
    //状态(-1=删除;0=正常单;1=待审核;2=申请退货已审核;3=退货中;4=退货确认收货;5=退货完成;6=退货异常)
    Byte status
    //过期时间
    Date timeoutActionTime
    //结束时间
//    Date endTime
    //标题
    String title
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated
    //配送时间
    Date consignTime
    //退货成功时间
//    Date returnedTime
    //物流地址
    Long consigneeId
    //买家备注
    String buyerMemo
    //卖家备注
    String sellerMemo

    //数量
    Long num
    //代理id
//    Long agencyId
    //分润金额
//    Long shareFee
    //积分
//    Long point


    //退货成功时间
    Date finishTime
    //退货原因
    String returnReason
    //申请审核时间
    Date reqExamine
    //收货时间
    Date receiptTime
    //是否补贴(0=不补贴; 1=补贴)
    Byte isSubsidy
    //补贴金额
    Long subsidyFee
    //trade表的状态
    Byte tradeStatus

    static mapping = {
        table('miku_return_goods')
        id generator: 'identity'
    }


}

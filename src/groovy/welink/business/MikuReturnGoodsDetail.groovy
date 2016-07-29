package welink.business

/**
 * Created by unescc on 2016/1/13.
 */
class MikuReturnGoodsDetail {
    Long id
    //版本
    Long version
    //交易id
    Long tradeId
    //订单id
    Long orderId
    //对应的商品订单的数量
    Long orderNum
    //商品id
    Long artificialId
    //商品名称
    String itemName
    //买家id
    Long buyerId
    //买家姓名
    String buyername
    //买家电话
    String buyermobile
    //品牌名称
    String name
    //图片地址
    String picUrl
    //价格
    Long price
    //总金额
    Long totalFee
    //退款金额
    Long refundFee
    //卖家ID
    Long sellerId
    //卖家类型
    Long sellerType
    //状态(-1:删除;0:正常单;1:申请退货;2=退货中;3=退货完成;4=退货异常)
    Long status
    //过期时间
    Date timeoutActionTime
    //结束时间
    Date endTime
    //标题
    String title
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated
    //配送时间
    Date consignTime
    //退货成功时间
    Date returnedTime
    //物流地址
    Long consigneeId
    //具体的物流地址
    String consigneeAddress
    //买家备注
    String buyerMemo
    //卖家备注
    String sellerMemo
    //移动设备标示
    byte tradeFrom


    //数量
    Long num
    //代理id
    Long agencyId
    //分润金额
    Long shareFee
    //积分
    Long point

    //品牌名称
    String brandName


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

    //来说明过不过期的
    String timeOutStatement

    //trade表的状态
    Byte tradeStatus
    //是否为过期
    Byte ispassDate

}

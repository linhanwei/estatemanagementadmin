package welink.common

import groovy.transform.ToString

@ToString
class Order {
    // 子订单Id
    Long id
    // 订单Id
    Long tradeId
    //M8原装电池:便携支架:M8专用座充:莫凡保护袋套餐的值。如：M8原装电池:便携支架:M8专用座充:莫凡保护袋
    String itemMealName
    //商品图片的文件地址
    String picUrl
    // 卖家Id
    Long sellerId
    // 卖家类型，可选值为：商城商家，普通卖家，物业卖家等等
    Byte sellerType
    //买家Id
    Long buyerId
    // 购买者来自哪个小区
    Long communityId
    //退款状态。退款状态。可选值 WAIT_SELLER_AGREE(买家已经申请退款，等待卖家同意) WAIT_BUYER_RETURN_GOODS(卖家已经同意退款，等待买家退货) WAIT_SELLER_CONFIRM_GOODS(买家已经退货，等待卖家确认收货) SELLER_REFUSE_BUYER(卖家拒绝退款) CLOSED(退款关闭) SUCCESS(退款成功)
    Byte refundStatus
    // 商家外部编码(可与商家外部系统对接)。外部商家自己定义的商品Item的id，可以通过taobao.items.custom.get获取商品的Item的信息
    Long outerId
    // 订单快照Id
    Long snapshotId
    // 订单快照详细信息，自定义
    String snapshot
    // 订单超时到期时间。格式:yyyy-MM-dd HH:mm:ss
    Date timeoutActionTime
    // 买家是否评价
    Byte buyerRate
    // 卖家是否评价
    Byte sellerRate
    // 交易商品对应的类目ID
    Long categoryId
    // 订单状态（请关注此状态，如果为TRADE_CLOSED_BY_TAOBAO状态，则不要对此订单进行发货，切记啊！）。可选值:
    // TRADE_NO_CREATE_PAY(没有创建支付宝交易)
    // WAIT_BUYER_PAY(等待买家付款)
    // WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款)
    // WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货)
    // TRADE_BUYER_SIGNED(买家已签收,货到付款专用)
    // TRADE_FINISHED(交易成功)
    // TRADE_CLOSED(付款以后用户退款成功，交易自动关闭)
    // TRADE_CLOSED_BY_TAOBAO(付款以前，卖家或买家主动关闭交易)
    //PAY_PENDING(国际信用卡支付付款确认中)
    Byte status
    // 泛商品Id，通过categoryId来关联
    Long artificialId
    // title
    String title
    // 商品价格。精确到2位小数；单位:分。如:20007，表示:200元7分
    Long price
    // 套餐Id
    Long itemMealId
    // skuId
    Long skuId
    // 购买数量。取值范围:大于零的整数
    Integer num
    // 外部网店自己定义的Sku编号
    Long outerSkuId
    //子订单来源,如jhs(聚划算)、taobao(淘宝)、wap(无线)
    Byte orderFrom
    // 应付金额（商品价格 * 商品数量 + 手工调整金额 - 子订单级订单优惠金额）。精确到2位小数;单位:分。如:20007，表示:200元7分
    Long totalFee
    // 子订单实付金额。精确到2位小数，单位:元。如:200.07，表示:200元7分。对于多子订单的交易，计算公式如下：payment = price * num + adjust_fee - discount_fee ；单子订单交易，payment与主订单的payment一致，对于退款成功的子订单，由于主订单的优惠分摊金额，会造成该字段可能不为0.00元。建议使用退款前的实付金额减去退款单中的实际退款金额计算。
    Long payment
    // 子订单级订单优惠金额。精确到2位小数;单位:元。如:200.07，表示:200元7分
    Long discountFee
    // 手工调整金额.格式为:1.01;单位:元;精确到小数点后两位
    Long adjustFee
    // SKU的值。如：机身颜色:黑色;手机套餐:官方标配  颜色:桔色;尺码:M
    String skuPropertiesName
    // 最近退款ID
    Long refundId
    // 是否超卖
    Byte isOversold
    // 是否是服务订单，是返回true，否返回false。
    Byte isServiceOrder
    // 子订单的交易结束时间 说明：子订单有单独的结束时间，与主订单的结束时间可能有所不同，在有退款发起的时候或者是主订单分阶段付款的时候，子订单的结束时间会早于主订单的结束时间，所以开放这个字段便于订单结束状态的判断
    Date endTime
    // 子订单发货时间，当卖家对订单进行了多次发货，子订单的发货时间和主订单的发货时间可能不一样了，那么就需要以子订单的时间为准。（没有进行多次发货的订单，主订单的发货时间和子订单的发货时间都一样）
    Date consignTime
    // 子订单的运送方式（卖家对订单进行多次发货之后，一个主订单下的子订单的运送方式可能不同，用order.shipping_type来区分子订单的运送方式）
    Integer shippingType
    // 捆绑的子订单号，表示该子订单要和捆绑的子订单一起发货，用于卖家子订单捆绑发货
    Long bindOid
    // 子订单发货的快递公司名称
    String logisticsCompany
    // 子订单所在包裹的运单号
    String invoiceNo
    // 南京QDHEWL-0004	发货的仓库编码
    String storeCode
    //退款状态(-1=删除;0=正常单;1=待审核;2=申请退货已审核;3=退货中;4=退货确认收货;5=退货完成;6=退货异常)
    Byte returnStatus




    Date lastUpdated
    Date dateCreated

    //字段has_panic_tag说明的是：是否有抢购标
    Byte hasPanicTag


    static constraints = {

    }

    static mapping = {
        table('t_order')
        id generator: 'identity'
        version(true)
        cache true
    }
}

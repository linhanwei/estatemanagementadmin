package welink.common

import groovy.transform.ToString

/**
 * buyer_cod_fee：买家货到付款服务费，由买家支付给物流公司。
 seller_cod_fee：卖家货到付款服务费，由卖家支付给物流公司 。
 cod_fee：货到付款服务费，不同的物流公司不同 。如果是买家支付服务费，则buyer_cod_fee=cod_fee ；如果是卖家支付，则seller_cod_fee=cod_fee；
 若是买家、卖家共同支付则是两者之和。卖家可设置货到付款服务费由谁支付。
 货到付款服务介绍参考：http://service.taobao.com/support/knowledge-847852.htm?spm=0.0.0.41.XRGCJF&dkey=searchview
 */
@ToString
class Trade {
    // 交易Id
    Long id
    // trade Id 展示用的
    Long tradeId
    // 卖家Id
    Long buyerId
    // 类目
    Long categoryId
    // 商品的相对途径
    String picUrl
    // 实付金额。精确到2位小数;单位:分。如:20007，表示:200元7分
    Long payment
    // 邮费
    Long postFee
    // 买家支付宝账号
    String buyerAlipayAccount
    // 小区Id
    Long communityId
    // 收货人的房屋Id
    Long buildingId
    // 卖家Id
    Long sellerId
    // 卖家类型
    Byte sellerType
    // 店铺Id
    Long shopId
    // 卖家手机
    String sellerMobile
    // 卖家电话
    String sellerPhone
    // 卖家名字
    String sellerName
    // 交易中剩余的确认收货金额（这个金额会随着子订单确认收货而不断减少，交易成功后会变为零）。精确到2位小数;单位:元。如:200.07，表示:200 元7分
    String availableConfirmFee
    // 卖家实际收到的支付宝打款金额（由于子订单可以部分确认收货，这个金额会随着子订单的确认收货而不断增加，交易成功后等于买家实付款减去退款金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分
    String receivedPayment
    // 超时到期时间。格式:yyyy-MM-dd HH:mm:ss。业务规则： 前提条件：只有在买家已付款，卖家已发货的情况下才有效 如果申请了退款，那么超时会落在子订单上；比如说3笔ABC，A申请了，那么返回的是BC的列表, 主定单不存在 如果没有申请过退款，那么超时会挂在主定单上；比如ABC，返回主定单，ABC的超时和主定单相同
    Date timeoutActionTime
    // 	订单列表
    String orders
    // 交易促销详细信息
    String promotion
    // 优惠详情
    Long promotionId
    // 商品购买数量。取值范围：大于零的整数,对于一个trade对应多个order的时候（一笔主订单，对应多笔子订单），num=0，num是一个跟商品关联的属性，一笔订单对应多比子订单的时候，主订单上的num无意义。
    Integer num

    // TODO 加一个状态
    // 交易状态。可选值:
    // * WAIT_BUYER_PAY(等待买家付款)
    // * SELLER_CONSIGNED_PART(卖家部分发货)
    // * WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款)
    // * WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货)
    // * TRADE_BUYER_SIGNED(买家已签收,货到付款专用)
    // * TRADE_FINISHED(交易成功)
    // * TRADE_CLOSED(付款以后用户退款成功，交易自动关闭)
    // * TRADE_CLOSED_BY_TAOBAO(付款以前，卖家或买家主动关闭交易)
    // * PAY_PENDING(国际信用卡支付付款确认中)
    // * WAIT_PRE_AUTH_CONFIRM(0元购合约中)
    Byte status
    // 交易标题，以店铺名作为此标题的值。注:taobao.trades.get接口返回的Trade中的title是商品名称
    String title
    // 交易类型列表，同时查询多种交易类型可用逗号分隔。默认同时查询guarantee_trade, auto_delivery, ec, cod的4种交易类型的数据 可选值 fixed(一口价) auction(拍卖) guarantee_trade(一口价、拍卖) auto_delivery(自动发货) independent_simple_trade(旺店入门版交易) independent_shop_trade(旺店标准版交易) ec(直冲) cod(货到付款) fenxiao(分销) game_equipment(游戏装备) shopex_trade(ShopEX交易) netcn_trade(万网交易) external_trade(统一外部交易) step (万人团) nopaid(无付款订单) pre_auth_type(预授权0元购机交易)
    Byte type
    // 商品价格。精确到2位小数；单位：元。如：200.07，表示：200元7分
    Long price
    // 卖家货到付款服务费。精确到2位小数;单位:元。如:12.07，表示:12元7分。卖家不承担服务费的订单：未发货的订单获取服务费为0，发货后就能获取到正确值。
    Long sellerCodFee
    // 建议使用trade.promotion_details查询系统优惠 系统优惠金额（如打折，VIP，满就送等），精确到2位小数，单位：元。如：200.07，表示：200元7分
    Long discountFee
    // 买家使用积分,下单时生成，且一直不变。格式:100;单位:个.
    Long pointFee
    // 是否包含邮费。与available_confirm_fee同时使用。可选值:true(包含),false(不包含)
    Byte hasPostFee
    // 商品金额（商品价格乘以数量的总金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分
    Long totalFee
    // 付款时间。格式:yyyy-MM-dd HH:mm:ss。订单的付款时间即为物流订单的创建时间。
    Date payTime
    // 交易结束时间。交易成功时间(更新交易状态为成功的同时更新)/确认收货时间或者交易关闭时间 。格式:yyyy-MM-dd HH:mm:ss
    Date endTime
    // 买家留言
    String buyerMessage
    // 支付宝交易号
    String alipayNo
    // 创建交易接口成功后，返回的支付url
    String alipayUrl
    // 买家备注（与淘宝网上订单的买家备注对应，只有买家才能查看该字段）
    String buyerMemo
    // 发票抬头
    String invoiceName
    // 发票类型
    Byte invoiceType
    // 判断订单是否有买家留言，有买家留言返回true，否则返回false
    Byte hasBuyerMessage
    // 分阶段付款的订单状态（例如万人团订单等），目前有三返回状态 FRONT_NOPAID_FINAL_NOPAID(定金未付尾款未付)，FRONT_PAID_FINAL_NOPAID(定金已付尾款未付)，FRONT_PAID_FINAL_PAID(定金和尾款都付)
    Byte stepTradeStatus
    // 分阶段付款的已付金额（万人团订单已付金额）
    Long stepPaidFee
    // 订单出现异常问题的时候，给予用户的描述,没有异常的时候，此值为空
    String markDesc
    // 电子凭证的垂直信息
    String eTicketExt
    // 订单将在此时间前发出，主要用于预售订单
    String sendTime
    // 创建交易时的物流方式（交易完成前，物流方式有可能改变，但系统里的这个字段一直不变）。可选值：free(卖家包邮),post(平邮),express(快递),ems(EMS),virtual(虚拟发货)，25(次日必达)，26(预约配送)。
    Byte shippingType
    // 买家货到付款服务费。精确到2位小数;单位:元。如:12.07，表示:12元7分
    Long buyerCodFee
    // 快递代收款。精确到2位小数;单位:元。如:212.07，表示:212元7分
    Long expressAgencyFee
    // 卖家手工调整金额，精确到2位小数，单位：元。如：200.07，表示：200元7分。来源于订单价格修改，如果有多笔子订单的时候，这个为0，单笔的话则跟[order].adjust_fee一样
    Long adjustFee
    // 买家获得积分,返点的积分。格式:100;单位:个。返点的积分要交易成功之后才能获得。
    Long buyerObtainPointFee
    // 货到付款服务费。精确到2位小数;单位:元。如:12.07，表示:12元7分。
    Long codFee
    // 交易内部来源。 WAP(手机);HITAO(嗨淘);TOP(TOP平台);TAOBAO(普通淘宝);JHS(聚划算) 一笔订单可能同时有以上多个标记，则以逗号分隔
    Byte tradeFrom
    // 淘宝下单成功了,但由于某种错误支付宝订单没有创建时返回的信息。taobao.trade.add接口专用
    String alipayWarnMsg
    // 货到付款物流状态。 初始状态 NEW_CREATED, 接单成功 ACCEPTED_BY_COMPANY, 接单失败 REJECTED_BY_COMPANY, 接单超时 RECIEVE_TIMEOUT, 揽收成功 TAKEN_IN_SUCCESS, 揽收失败 TAKEN_IN_FAILED, 揽收超时 TAKEN_TIMEOUT, 签收成功 SIGN_IN, 签收失败 REJECTED_BY_OTHER_SIDE, 订单等待发送给物流公司 WAITING_TO_BE_SENT, 用户取消物流订单 CANCELED
    Byte codStatus
    // 买家可以通过此字段查询是否当前交易可以评论，can_rate=true可以评价，false则不能评价。
    Byte canRate
    // 买家是否已评价。可选值:true(已评价),false(未评价)。如买家只评价未打分，此字段仍返回false
    Byte buyerRate
    // 卖家是否已经评价
    Byte sellerRate
    // 服务子订单列表
    String valueAddedOrders
    // 交易备注
    String tradeMemo
    // 交易外部来源：ownshop(商家官网)
    Byte tradeSource
    // 卖家是否可以对订单进行评价
    Byte sellerCanRate
    // 买家实际使用积分（扣除部分退款使用的积分），交易完成后生成（交易成功或关闭），交易未完成时该字段值为0。格式:100;单位:个
    Integer realPointFee
    // 物流到货时效，单位天
    Integer arriveInterval
    // 物流到货时效截单时间，格式 HH:mm
    String arriveCutTime
    // 物流发货时效，单位小时
    Integer consignInterval
    // 调度时间
    Date consignTime
    // 扫码发货时间
    Date confirmTime
    // 同步到卖家库的时间，taobao.trades.sold.incrementv.get接口返回此字段
    Date asyncModified
    // 在返回的trade对象上专门增加一个字段zero_purchase来区分，这个为true的就是0元购机预授权交易
    Byte zeroPurchase
    // 支付方式，线上还是线下
    //各类型的支付的方式：
        //1:线上支付      2.线下支付/货到付款   3.地上支付宝支付
        //4.线上微信支付   5.线上0元支付        6.线下现金支付
        //7.线下支付宝支付  8.线下微信支付
    Byte payType
    // 快递员Id，非全职嘛
    Long courier
    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date lastUpdated
    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date dateCreated
    //收获地址ID
    Long consigneeId
    //预约上门时间
    Date appointDeliveryTime

    //交易退货状态(0=正常单; 1=退货中; 2=已退货)
    Byte returnStatus

    //众筹id
    Long crowdfundId
    //支持项的id
    Long crowdfundDetailId
    //退款状态[0正常  1退款中  2退款成功]
    Byte crowdfundRefundStatus




    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }
}

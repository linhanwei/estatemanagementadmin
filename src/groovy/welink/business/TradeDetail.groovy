package welink.business

/**
 * Created by spider on 13/11/14.
 */
class TradeDetail {

    String tradeId

    String profileMobile

    String address

    String itemName

    String itemNum

    String itemPrice

    String orderPrice

    String itemSpecification

    List<OrderDetail> OrderList

    String totalPrice

    String createTime

    String consignTime

    String confirmTime

    String appointDeliveryTime

    String endTime

    String status

    String receiverName

    String receiverMobile

    String tradeMemo

    String buyerMessage

    String communityName

    String communityAddress

    String profileAlipay

    String courierName

    String modifiAddr

    String courierMobile

    //根据物流进行添加的字段
    //物流公司
    String logisticsCompany
    //物流号
    String logisticsWuLiuCode
    //外部订单
    String outtradeid
    //物流的汇总信息
    String memo


    String iteminfo
    String reason

    //退货用的标示
    Byte ispassDate


    //因为需求来进行添加的
    // 交易内部来源。 WAP(手机);HITAO(嗨淘);TOP(TOP平台);TAOBAO(普通淘宝);JHS(聚划算) 一笔订单可能同时有以上多个标记，则以逗号分隔
    Byte tradeFrom
    // 创建交易时的物流方式（交易完成前，物流方式有可能改变，但系统里的这个字段一直不变）。可选值：free(卖家包邮),post(平邮),express(快递),ems(EMS),virtual(虚拟发货)，25(次日必达)，26(预约配送)。
    Byte shippingType
    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date dateCreated
    // 商品金额（商品价格乘以数量的总金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分
    Long totalFee
    //各类型的支付的方式：
    //1:线上支付      2.线下支付/货到付款   3.地上支付宝支付
    //4.线上微信支付   5.线上0元支付        6.线下现金支付
    //7.线下支付宝支付  8.线下微信支付
    Byte payType
    //商品详情
    String info
    // 商品价格。精确到2位小数；单位：元。如：200.07，表示：200元7分
    Long price
    Long id
    //有关于的众筹的项目的状态
    Byte mcstatus
    //支付的方式【支付宝1 公众号微信2  app的微信版3 】
    Byte refundpayType
    //微信weixinback的id
    String wxpayId

    //支付宝信息
    String buyerMemo
    //支付宝alipayId
    String alipayNo

    //退款状态
    Byte crowdfundRefundStatus


    //收货人
    String buyerInfo


}

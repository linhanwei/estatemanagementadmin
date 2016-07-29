package welink.common

class MikuSalesRecord {



    Long id
    //代理等级名称
    Long agencyId
    //代理等级名称
    String agencyLevelName
    //交易id
    Long tradeId
    //买家id（与代理构成分润关系的代理用户id）
    Long buyerId
    //买家名字
    String buyerName
    //买家电话
    String buyerMobile
    //交易产品id
    Long itemId
    //产品名称
    String itemName
    //交易数量
    Integer num
    //商品单价，以分为单位
    Long price
    //总金额，以分为单位
    Long amount
    //付款时间
    Date payTime
    //确认日期
    Date confirmDate
    //退货日期
    Date returnDate
    //分润金额
    Long shareFee
    //分润方案
    String parameter
    //版本
    Long version
    //记录创建日期
    Date dateCreated
    //记录更新日期
    Date lastUpdated

    //是否提现:(-1=未提现；0=提现中；1=已提现;2=提现异常)
    Long isGetpay

    //退款状态(-1=删除;0=正常单;1=待审核;2=申请退货已审核;3=退货中;4=退货确认收货;5=退货完成;6=退货异常)
    Long returnStatus
    //退货的时间
    Date timeoutActionTime

    static mapping = {
        table('miku_sales_record')
        id generator: 'identity'
    }
    static constraints = {
    }
}

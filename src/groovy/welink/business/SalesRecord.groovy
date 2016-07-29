package welink.business

/**
 * Created by unescc on 2015/11/23.
 */
class SalesRecord {


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

    //用户基本信息
    String agencyName
    //用户的电话
    String agencyMoblie
    //用户的其他信息
    String agencyInfo

}

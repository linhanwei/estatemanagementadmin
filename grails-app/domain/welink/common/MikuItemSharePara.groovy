package welink.common

class MikuItemSharePara {

    Long id

    //版本
    Long version

    //分润方案名称
    String schemeName

    //备注说明
    String memo

    //商品id
    Long itemId

    //成本金额，单位为分，与平台利润金额、可分润金额相加=商品卖价
    BigDecimal  itemCostFee

    //平台利润金额
    BigDecimal  itemProfitFee

    //可分润金额
    BigDecimal  itemShareFee

    //分润参数（以json-kv的方式进行存储，例：代理等级id:可得分润金额）
    String parameter

    //创建用户，后台管理员id
    String creatorId

    //创建日期
    Date dateCreated

    //更新日期
    Date lastUpdated

    //是否禁用
    Byte isDisable

//    BigDecimal testone
//
//    BigDecimal testTwo

    static mapping = {
        id generator: 'identity'
    }

//    static constraints = {
//        testTwo(max:1000, scale:2)    //这个限制搞了很久才搞出来, 映射为DECIMAL(10,6)
//    }
}

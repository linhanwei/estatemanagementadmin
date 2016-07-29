package welink.estate

class PointRecord {

    Long id

    //账户Id
    Long accountId

    //动作
    Long actionId

    //用户Id
    Long userId

    //变更积分数量
    Long amount

    //变更类型
    Integer type

    //变更来源
    Integer from

    //交易ID
    Long tradeId

    Long availableBalance

    //变更备注
    String memo

    //变更属性
    String attributes

    //创建时间
    Date dateCreated
    //最后修改时间
    Date lastUpdated



    static mapping = {
        id generator: 'identity'
        version(true)
    }

    static constraints = {
    }
}

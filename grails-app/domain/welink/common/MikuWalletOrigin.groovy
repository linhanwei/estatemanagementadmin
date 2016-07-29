package welink.common

class MikuWalletOrigin {

    //id
    Long id
    //用户id
    Long userId
    //0是充值 1是退款 2是购买使用
    Long type
    //金额
    Long totalFee
    //来源id
    Long orginId
    //提现状态(-1=未提现/删除；0=提现中/待审核；1=已提现/已审核;2=提现异常)
    Long getpayStatus
    //版本
    Long version
    //创建日期
    Date dateCreated
    //更新时间
    Date lastUpdated

    static mapping = {
        table('miku_wallet_origin')
        id generator: 'identity'
    }
    static constraints = {
    }
}

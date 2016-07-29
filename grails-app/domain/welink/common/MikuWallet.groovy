package welink.common

class MikuWallet {

    //id
    Long id
    //用户id
    Long userId
    //电话
    String mobile
    //余额
    Long balanceFee
    //已提现金额
    Long getpayedFee
    //提现中金额
    Long getpayingFee
    //版本
    Long version
    //创建日期
    Date dateCreated
    //更新时间
    Date lastUpdated

    static mapping = {
        table('miku_wallet')
        id generator: 'identity'
    }
    static constraints = {
    }
}

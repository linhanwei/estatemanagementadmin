package welink.business

/**
 * Created by unescc on 2015/11/6.
 */
class MikuGetPayDetail {

    Long id
//    代理id（即成为代理的用户id）
    Long agencyId
//    代理用户昵称
    String agencyNickname
//    代理用户电话
    String agencyMobile
//    代理等级名称
    String agencyLevelName
//    申请日期
    Date applyDate
//    提现类型（1支付宝，2微信钱包，3银行卡）
    Long getpayType
//    提现类型名称
    String getpayTypeName
//    提现金额，单位分
    Long getpayFee
//    提现账号（支付宝、微信帐号、银行卡号）
    String getpayAccount
//    提现人姓名
    String getpayUserName
//    申请状态（0提现中/待审核，1已审核，2异常）
    byte status
//    申请状态名称
    String dostatusName
//    转账时间
    Date transDate
//    审核人id（后台管理员id）
    Long clerkerId
//    审核人用户名
    String clerkerUserName
//    审核人名称
    String clerkerName
//    版本
    Long version
//    创建日期
    Date dateCreated
//    更新时间
    Date lastUpated
//   订单的个数
    Integer tradeNum
//   成功个数
    Integer successNum
//   失败个数
    Integer failNum
//   处于过程
    Integer tingNum

    //金额除以100的字符串
    String amount






    //为了进行核对使用额外字段

    //全部提现金额
    Long totalpay
    //正在提现中的
    Long getpayIng
    //提现当中的金额
    Long totalgetpay
    Long getpayId



}

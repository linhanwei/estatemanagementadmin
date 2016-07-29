package welink.common

class WeixinBack {
//    idbigint(20)
//    appidvarchar(32)
//    mch_idvarchar(32)
//    device_infovarchar(32)
//    nonce_strvarchar(32)
//    signvarchar(32)
//    result_codevarchar(16)
//    err_codevarchar(32)
//    err_code_desvarchar(128)
//    openidvarchar(128)
//    is_subscribevarchar(1)
//    trade_typevarchar(16)
//    bank_typevarchar(16)
//    total_feeint(11)
//    fee_typevarchar(8)
//    cash_feeint(11)
//    cash_fee_typevarchar(16)
//    coupon_feeint(11)
//    coupon_countint(11)
//    coupon_batch_id_nvarchar(20)
//    coupon_id_nvarchar(20)
//    coupon_fee_nint(11)
//    transaction_idvarchar(32)
//    out_trade_novarchar(32)
//    attachvarchar(128)
//    time_endvarchar(14)
//    date_createddatetime
//    last_updateddatetime
//    return_codevarchar(16)
//    return_msgvarchar(128)


    Long id
    //appid
    String appid
    //微信号的商户号
    String mchId
    //设备信息
    String deviceInfo
    //
    String nonceStr
    //密文
    String sign
    //返回的标示code
    String resultCode
    //错误编码
    String errCode
    //错误信息
    String errCodeDes
    //openId
    String openid

    String isSubscribe
    //交易类型
    String tradeType
    String bankType
    //总金额
    Integer totalFee
    String feeType
    Integer cashFee
    String cashFeeType
    Integer couponFee
    Integer couponCount
    String couponBatchId_n
    String couponId_n
    Integer couponFee_n
    String transactionId
    String outTradeNo
    String attach
    String timeEnd
    Date dateCreated
    Date lastUpdated
    String returnCode
    String returnMsg
    static mapping = {
        table('weixin_back')
        id generator: 'identity'
        version(false)
    }
}

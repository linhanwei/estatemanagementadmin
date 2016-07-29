package welink.common

class AlipayBack {

    Long id

    String discount

    String paymentType

    String subject

    String tradeNo

    String buyerEmail

    Date gmtCreate

    String notifyType

    String quantity

    String outTradeNo

    String sellerId

    Date notifyTime

    String body

    String tradeStatus

    String isTotalFeeAdjust

    String totalFee

    String sellerEmail

    String price

    String notifyId

    String useCoupon

    String signType

    String sign

    Date dateCreated

    Date gmtPayment

    static constraints = {
    }

    static mapping = {
        version(false)
    }
}

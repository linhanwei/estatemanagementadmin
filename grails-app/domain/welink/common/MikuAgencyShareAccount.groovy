package welink.common

class MikuAgencyShareAccount {

    Long id
//    代理id（即成为代理的用户id）
    Long agencyId
//    累计分润额
    Long totalShareFee
//    累计已提现金额
    Long totalGotpayFee
//    未提现金额
    Long noGetpayFee
//    提现中金额
    Long getpayingFee
//    直接分销金额
    Long directSalesFee
//    直接分润金额
    Long directShareFee
//    间接分销金额
    Long indirectSalesFee
//    间接分润金额
    Long indirectShareFee
//    订单数
    Long pTradesCount
//    父级2层代理_订单数2
    Long p2_tradesCount
//    Long p2TradesCount
//    父级3层代理_订单数3
    Long p3_tradesCount
//    Long p3TradesCount
//    父级4层代理_订单数4
    Long p4_tradesCount
//    Long p4TradesCount
//    父级5层代理_订单数5
    Long p5_tradesCount
//    Long p5TradesCount
//    累计销售额，单位为分
    Long pSalesFee
 //    父级2层代理_累计销售额2，单位为分
    Long p2_salesFee
//    Long p2SalesFee
 //   父级3层代理_累计销售额3，单位为分
    Long p3_salesFee
//    Long p3SalesFee
 //    父级4层代理_累计销售额4，单位为分
    Long p4_salesFee
//    Long p4SalesFee
 //    父级5层代理_累计销售额5，单位为分
    Long p5_salesFee
//    Long p5SalesFee
//    贡献分润，单位为分
    Long pOfferFee
//    父级2层代理_贡献分润额2，单位为分
    Long p2_offerFee
//    Long p2OfferFee
//    父级3层代理_贡献分润额3，单位为分
    Long p3_offerFee
//    Long p3OfferFee
//    父级4层代理_贡献分润额4，单位为分
    Long p4_offerFee
//    Long p4OfferFee
//    父级5层代理_贡献分润额5，单位为分
    Long p5_offerFee
//    Long p5OfferFee
//    分润统计（保留字段）
    String shareStat
//    版本
    Long version
//    创建时间
    Date dateCreated
//    更新时间
    Date lastUpdated




    static constraints = {
    }

    static mapping = {
        table('miku_agency_share_account')
        id generator: 'identity'

    }
}

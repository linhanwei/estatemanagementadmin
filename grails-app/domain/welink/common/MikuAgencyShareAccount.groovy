package welink.common

class MikuAgencyShareAccount {

    Long id
//    ����id������Ϊ������û�id��
    Long agencyId
//    �ۼƷ����
    Long totalShareFee
//    �ۼ������ֽ��
    Long totalGotpayFee
//    δ���ֽ��
    Long noGetpayFee
//    �����н��
    Long getpayingFee
//    ֱ�ӷ������
    Long directSalesFee
//    ֱ�ӷ�����
    Long directShareFee
//    ��ӷ������
    Long indirectSalesFee
//    ��ӷ�����
    Long indirectShareFee
//    ������
    Long pTradesCount
//    ����2�����_������2
    Long p2_tradesCount
//    Long p2TradesCount
//    ����3�����_������3
    Long p3_tradesCount
//    Long p3TradesCount
//    ����4�����_������4
    Long p4_tradesCount
//    Long p4TradesCount
//    ����5�����_������5
    Long p5_tradesCount
//    Long p5TradesCount
//    �ۼ����۶��λΪ��
    Long pSalesFee
 //    ����2�����_�ۼ����۶�2����λΪ��
    Long p2_salesFee
//    Long p2SalesFee
 //   ����3�����_�ۼ����۶�3����λΪ��
    Long p3_salesFee
//    Long p3SalesFee
 //    ����4�����_�ۼ����۶�4����λΪ��
    Long p4_salesFee
//    Long p4SalesFee
 //    ����5�����_�ۼ����۶�5����λΪ��
    Long p5_salesFee
//    Long p5SalesFee
//    ���׷��󣬵�λΪ��
    Long pOfferFee
//    ����2�����_���׷����2����λΪ��
    Long p2_offerFee
//    Long p2OfferFee
//    ����3�����_���׷����3����λΪ��
    Long p3_offerFee
//    Long p3OfferFee
//    ����4�����_���׷����4����λΪ��
    Long p4_offerFee
//    Long p4OfferFee
//    ����5�����_���׷����5����λΪ��
    Long p5_offerFee
//    Long p5OfferFee
//    ����ͳ�ƣ������ֶΣ�
    String shareStat
//    �汾
    Long version
//    ����ʱ��
    Date dateCreated
//    ����ʱ��
    Date lastUpdated




    static constraints = {
    }

    static mapping = {
        table('miku_agency_share_account')
        id generator: 'identity'

    }
}

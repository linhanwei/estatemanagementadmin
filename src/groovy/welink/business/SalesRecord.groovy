package welink.business

/**
 * Created by unescc on 2015/11/23.
 */
class SalesRecord {


    Long id
    //����ȼ�����
    Long agencyId
    //����ȼ�����
    String agencyLevelName
    //����id
    Long tradeId
    //���id��������ɷ����ϵ�Ĵ����û�id��
    Long buyerId
    //�������
    String buyerName
    //��ҵ绰
    String buyerMobile
    //���ײ�Ʒid
    Long itemId
    //��Ʒ����
    String itemName
    //��������
    Integer num
    //��Ʒ���ۣ��Է�Ϊ��λ
    Long price
    //�ܽ��Է�Ϊ��λ
    Long amount
    //����ʱ��
    Date payTime
    //ȷ������
    Date confirmDate
    //�˻�����
    Date returnDate
    //������
    Long shareFee
    //���󷽰�
    String parameter
    //�汾
    Long version
    //��¼��������
    Date dateCreated
    //��¼��������
    Date lastUpdated

    //�û�������Ϣ
    String agencyName
    //�û��ĵ绰
    String agencyMoblie
    //�û���������Ϣ
    String agencyInfo

}

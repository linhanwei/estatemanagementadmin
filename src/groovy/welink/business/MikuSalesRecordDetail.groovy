package welink.business

/**
 * Created by unescc on 2015/12/11.
 */
class MikuSalesRecordDetail {
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

    //�Ƿ�����:(-1=δ���֣�0=�����У�1=������;2=�����쳣)
    //�Ƿ�����:(-1��ʧЧ  0δ����  1������  2������)
    Long isGetpay

    //status��¼������Ʒ�Ķ���״̬
    Long itemStatus

    //����ʱ��
    Date lastUpated
}

package welink.common

class MikuSalesRecord {



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
    Long isGetpay

    //�˿�״̬(-1=ɾ��;0=������;1=�����;2=�����˻������;3=�˻���;4=�˻�ȷ���ջ�;5=�˻����;6=�˻��쳣)
    Long returnStatus
    //�˻���ʱ��
    Date timeoutActionTime

    static mapping = {
        table('miku_sales_record')
        id generator: 'identity'
    }
    static constraints = {
    }
}

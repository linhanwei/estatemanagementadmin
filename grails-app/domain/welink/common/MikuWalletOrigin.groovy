package welink.common

class MikuWalletOrigin {

    //id
    Long id
    //�û�id
    Long userId
    //0�ǳ�ֵ 1���˿� 2�ǹ���ʹ��
    Long type
    //���
    Long totalFee
    //��Դid
    Long orginId
    //����״̬(-1=δ����/ɾ����0=������/����ˣ�1=������/�����;2=�����쳣)
    Long getpayStatus
    //�汾
    Long version
    //��������
    Date dateCreated
    //����ʱ��
    Date lastUpdated

    static mapping = {
        table('miku_wallet_origin')
        id generator: 'identity'
    }
    static constraints = {
    }
}

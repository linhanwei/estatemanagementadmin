package welink.common

class MikuWallet {

    //id
    Long id
    //�û�id
    Long userId
    //�绰
    String mobile
    //���
    Long balanceFee
    //�����ֽ��
    Long getpayedFee
    //�����н��
    Long getpayingFee
    //�汾
    Long version
    //��������
    Date dateCreated
    //����ʱ��
    Date lastUpdated

    static mapping = {
        table('miku_wallet')
        id generator: 'identity'
    }
    static constraints = {
    }
}

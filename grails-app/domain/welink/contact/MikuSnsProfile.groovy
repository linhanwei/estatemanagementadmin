package welink.contact

class MikuSnsProfile {
    Long id
    //�û�id
    Long profileId
    //�汾
    Long version
    //��������
    Date dateCreated
    //����ʱ��
    Date lastUpdated
    //�Ա�
    Byte sex
    //����ǩ��
    String signature
    //�û��Ļ�����Ϣ
    String userInfo
    //�������û�id
    Long createrId

    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

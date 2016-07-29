package welink.common

class MikuUserAgency {
    //id
    Long id
    //�汾
    Long version
    //�û�id
    Long userId
    //����㼶(root��Ϊ0)
    Long agencyLevel
    //���������û�id
    Long pUserId
    //����2������û�id
//    Long p2UserId
    //����3������û�id
//    Long p3UserId
    //����4������û�id
//    Long p4UserId
    //����5������û�id
//    Long p5UserId
    //�ô����Ƿ�Ϊ������(�����ô����Ƿ����Ӵ���)
    byte isParent
    //·��(v1�汾ֻ��¼4���ϵ����1��2,3)�����ã�
    String path
    //�Ƿ���֤
    byte isValidated
    //��������
    Date dateCreated
    //����ʱ��
    Date lastUpdated
    //�Ƿ�ɾ��
    Byte isDeleted

    //�޸��µ��ֶ�
    Long p2_userId
    Long p3_userId
    Long p4_userId
    Long p5_userId
    Long p6_userId
    Long p7_userId
    Long p8_userId

    //CEO�ĵȼ�
    Long ceoUserId
    Long ceo2_userId
    Long ceo3_userId
    Long ceo4_userId

    static mapping = {
        id generator: 'identity'
    }
    static constraints = {
    }
}

package welink.business

/**
 * Created by unescc on 2015/11/23.
 */
class AgencyInfo {

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
    Long p2UserId
    //����3������û�id
    Long p3UserId
    //����4������û�id
    Long p4UserId
    //����5������û�id
    Long p5UserId
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


    //�û�����
    String agencyName
    String agencyMobile
    Date agencyDateCreate
    //�Ƿ�Ϊ����
    byte isAgency
    //һ������
    String pUserName
    String pUserMobile
    String pUserLevel
    //��������
    String p2UserName
    String p2UserMobile
    String p2UserLevel
    //��������
    String p3UserName
    String p3UserMobile
    String p3UserLevel
    //�ļ�����
    String p4UserName
    String p4UserMobile
    String p4UserLevel
    //�弶����
    String p5UserName
    String p5UserMobile
    String p5UserLevel

    //�Ӽ�����Ϣ
    Long childCount

}

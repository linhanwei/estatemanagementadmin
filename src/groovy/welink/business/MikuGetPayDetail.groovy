package welink.business

/**
 * Created by unescc on 2015/11/6.
 */
class MikuGetPayDetail {

    Long id
//    ����id������Ϊ������û�id��
    Long agencyId
//    �����û��ǳ�
    String agencyNickname
//    �����û��绰
    String agencyMobile
//    ����ȼ�����
    String agencyLevelName
//    ��������
    Date applyDate
//    �������ͣ�1֧������2΢��Ǯ����3���п���
    Long getpayType
//    ������������
    String getpayTypeName
//    ���ֽ���λ��
    Long getpayFee
//    �����˺ţ�֧������΢���ʺš����п��ţ�
    String getpayAccount
//    ����������
    String getpayUserName
//    ����״̬��0������/����ˣ�1����ˣ�2�쳣��
    byte status
//    ����״̬����
    String dostatusName
//    ת��ʱ��
    Date transDate
//    �����id����̨����Աid��
    Long clerkerId
//    ������û���
    String clerkerUserName
//    ���������
    String clerkerName
//    �汾
    Long version
//    ��������
    Date dateCreated
//    ����ʱ��
    Date lastUpated
//   �����ĸ���
    Integer tradeNum
//   �ɹ�����
    Integer successNum
//   ʧ�ܸ���
    Integer failNum
//   ���ڹ���
    Integer tingNum

    //������100���ַ���
    String amount






    //Ϊ�˽��к˶�ʹ�ö����ֶ�

    //ȫ�����ֽ��
    Long totalpay
    //���������е�
    Long getpayIng
    //���ֵ��еĽ��
    Long totalgetpay
    Long getpayId



}

package welink.contact

/**
 * Created by miku09 on 2016/6/6.
 */
class MikuSnsContentDetail {
    //���µ�id
    Long cid
    //����ݵ�id
    Long dyId
    //�û���ͷ��
    String userPicUrl
    //�û���id
    String userId
    //�û��������࣬Ϊ���û�@��ʾ
    String userName
    //���¿�ʼʱ��
    Date dateCreate
    //���µĸ���ʱ��
    Date lastUpdate
    //���±���
    String contentTitle
    //���±�����
    String contentShortTitle
    //����ժҪ��ֻ���� content_create_type=1  �� ������ת��ʱ����ʾ���У�һ�б��⣬һ��ժҪ��
    String contentAbstract
    //����ͼ(��ҪС���ṩ�ߴ罨��)
    String contentSurfacePicUrl
    //����ͼ����ת���ã�
    String contenThumbPicUrl
    //��������
    String content
    //�������
    int timesOfBrowsed
    //���޴���
    int timesOfPraised
    //ת�ش���
    int timesOfReferenced
    //���۴���
    int timesOfCommented
    //�ղش���
    int timesOfCollected
}

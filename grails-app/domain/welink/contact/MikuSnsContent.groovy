package welink.contact

//ϵͳ�����û����������ݱ�
class MikuSnsContent {
      Long id
      //�û�id
      Long userId
      //�û��������࣬Ϊ���û�@��ʾ
      String userName
      //�����������ͣ�1��ϵͳ����������2���û�����������
      Byte contentCreateType
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
      //�������º����ͼƬ��Ƭ��url������΢������Ȧ��չ����ʽ��
      String picUrls
      //��������Դ���Ͷ�������:1���ͷ�/˽�˹ܼ�2������3���γ�4��˽�˶������µ�5����(content_from_type=2��Ч)
      Byte referencedGoalType
      //��������Դid
      Long referencedGoalId
      //������ʾ������������content_create_type=1����Ч
      String authorShowName
      //���ڴ����������£�0����������1���������£����߿ɼ��������û����ɼ���2������
      Byte specialFlag
      //�汾
      Long version
      //��������
      Date dateCreated
      //����ʱ��
      Date lastUpdated
    static mapping = {
        id generator: 'identity'
    }
    static constraints = {
    }
}

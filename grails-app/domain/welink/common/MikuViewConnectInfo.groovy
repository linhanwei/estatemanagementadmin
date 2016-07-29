package welink.common

class MikuViewConnectInfo {

    Long id
    //������ҳ�����
    Long viewId
    //�汾
    Long version=0L
    //������Ϣ˵��
    String info
    //ҳ��һ��ģ��״̬��ʾ״̬״̬(0ɾ��  1����  2��ʾ)
    Byte oneLevelStatus
    //ҳ�����ģ��״̬��ʾ״̬(0ɾ��  1����  2��ʾ)
    Byte twoLevelStatus
    //����
    String name
    //ҳ���һ��ģ��id
    Long oneLevelId
    //ҳ��Ķ���ģ��id
    Long twoLevelId
    //����(418, "�����λ"    419, "��Ŀ���"      420, "Ʒ�����"    421, "�ר��"  422, "��ɱר��"    423, "��Ʒר��")
    Long type
    //һ��ģ��������ݱ�ʾ(0 �������������޹�  1 һ��ģ������ӵ�����)
    Byte oneLevelFlag
    //�޸�ʱ��
    Date time
    //����һ��˳��Ĳ���
    Long weight=0L



    static mapping = {
        table('miku_view_connect_info')
        id generator: 'identity'
    }
}

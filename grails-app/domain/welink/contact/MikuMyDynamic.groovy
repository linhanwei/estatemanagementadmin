package welink.contact

//�ҵĶ�̬���������¡�������̬���ղء�.��
class MikuMyDynamic {
    Long id
    //�û�id
    Long userId
    //�û��������࣬Ϊ���û�@��ʾ
    String userName
    //������ʶ1��ԭ������2��ת������3���ղ�����
    Byte actionType
    //��������:1���ͷ�/˽�˹ܼ�2������3���γ�4��˽�˶������µ�5����(action_type=1����2   ���� 2)(action_type=3   ���� 2����4)
    Byte goalType
    //����id
    Long goalId
    //��ת�ص����ĸ��û�������(action_type=2 ��Ч��
    Long referencedProfileId
    //��ת�ص����ĸ��û�������(action_type=2 ��Ч��
    Long referencedSnsProfileId
    //1��������ҳ2��Ȧ��(action_type=1����2��ʱ����Ч)
    Byte actionPostionType
    //(action_type=1����2��ʱ�򣬲���action_postion_type=2ʱ��Ч��
    Long actionPostionId
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
    //�ö���־��0����1����
    Byte topFlag
    //��ע
    String note
    //�Ƿ�Ϊɾ��
    Byte isDelete
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

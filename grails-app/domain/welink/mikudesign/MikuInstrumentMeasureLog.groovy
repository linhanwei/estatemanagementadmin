package welink.mikudesign


//��¼�û�ʹ���������Ե�����
class MikuInstrumentMeasureLog {

    Long id
    //�û�ID
    Long userId
    //    �������ͣ�
    //    1����������
    //    2������
    Byte measureType
    //    ���������ͱ�ʶ
    //    1���׿ᶨ������Ƥ��״̬�����
    //    2������
    Byte instrumentType

    //��λ
    Byte testPosition

    //ͳ�����ڼ�
//    int createWeekDay



   //��������ֵ
//    Long measureValue

    //ˮ�ֲ���ֵ
//    Long moistureValue

    //�ͷֲ���ֵ
//    Long oilValue

    //���Բ���ֵ
//    Long resilienceValue

    //˥�ϲ���ֵ
//    Long senilityValue

    //������(Ϊ��ͳ�Ʒ���)
//    String createYear

    //������(Ϊ��ͳ�Ʒ���)
//    String createWeek

    //������(Ϊ��ͳ�Ʒ���)
//    String createMonth

    //������(Ϊ��ͳ�Ʒ���)
//    String createDay

    //����ʱ��(Ϊ��ͳ�Ʒ���)
//    String createTime

    //�汾
    Long version

    // ����ʱ��
    Date dateCreated
    // �޸�ʱ��
    Date lastUpdated

    //

    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

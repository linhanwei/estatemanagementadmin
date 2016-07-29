package welink.mikudesign

class MikuSurveyReport {

    Long id
    //�û�ID
    Long userId
    Long questionnaireId
    Long questionId
    Long questionType
    Long questionName
    //���߱����ʱ�򣬸������ӡ���Ŀ�����
    String questionPostionInreport

    //���߱����ʱ�򣬸������ӡ���������
    String questionOrderInreport

    Long optionId

    Byte optionShowStyle

    String optionValue
    //����Ҫ�������ͼƬ
    String picUrls

    //�Ƿ������ܲ������
    String instrumentMeasureDateInclude
    //���������ͱ�ʶ
    //1���׿ᶨ������Ƥ��״̬�����
    //2������
    Byte instrumentType

    //ѡȡ�����ܲ���ǲ��Կ�ʼʱ��
    Date instrumentMeasureStime

    //ѡȡ�����ܲ���ǲ��Խ���ʱ��
    Date instrumentMeasureEtime

    //����user_id
    Long serviceId

    //money
    Long money


    //�汾
    Long version

    // ����ʱ��
    Date dateCreated
    // �޸�ʱ��
    Date lastUpdated


    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }
}

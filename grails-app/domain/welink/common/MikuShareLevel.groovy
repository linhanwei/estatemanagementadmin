package welink.common

class MikuShareLevel {

    Long id

    //�汾
    Long version

    //�ȼ�����
    String levelName

    //�ȼ�˵��
    String memo

    //Ĭ�Ͽɷ������
    Double defaultShareScale

    //Ȩ�أ����ڵȼ�����
    Integer weight

    //�����û�����̨����Աid
    Long creatorId

    //��������
    Date dateCreated

    //��������
    Date lastUpdated

    //�Ƿ�ɾ��
    Byte isDeleted

    //�����û�����
    String creatorName

    //��������
    Integer shareType

    static constraints = {
    }

    static mapping = {
//        id generator: 'identity'
    }
}

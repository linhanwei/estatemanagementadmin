package welink.common

class MikuBrand {

    Long id
    //Ʒ������
    String name
    //Ʒ��ȫ��
    String fullName
    //������˾
    String company
    //Ʒ��ͼƬ
    String picture
    //Ʒ������
    String memo
    //�г�����(����)
    Long market
    //�汾
    String version
    //����ʱ��
    Date dateCreated
    //����ʱ��
    Date lastUpdated
    //�Ƿ�ɾ��
    byte isDeleted

    static mapping = {
        id generator: 'identity'
    }
}

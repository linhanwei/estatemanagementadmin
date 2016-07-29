package welink.warehouse

class MikuAdvertorial {

    Long id
    //���⣬�����ɫ������ʾ
    String advertorialTile
    //�������ͣ�
    //1����Ʒ
    //2��ƴ��
    //3������
    //4��xxxx
    Byte advertorialType
    //���±���
    String articleTile
    //��������
    String articleContent
    //ͼƬ
    String pics
    //mall_resource_url
    String mallResourceUrl
    //�ƹ㽱��
    String salesReward
    //¼����
    Long createrId
    //�汾
    Long version=0
    //��¼ʱ��
    Date dateCreated
    //����ʱ��
    Date lastUpdated

    //�Ƿ���Ч
    Byte status=1 as byte
    //�Ƿ�ɾ��
    Byte isDelete=0 as byte

    //��ת���ͣ�url-1,��ƷID-2
    Integer redirectType

    //������ͼ
    String posterPicUrl

    //�����г��ֵĲ�Ʒ
    String posterProductPicUrl

    static mapping = {
        id generator: 'identity'
    }


    static constraints = {
    }
}

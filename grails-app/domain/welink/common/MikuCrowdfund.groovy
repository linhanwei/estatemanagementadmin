package welink.common

class MikuCrowdfund {



//    idbigint(20)
//    titlevarchar(255)�ڳ�����
//    pic_urlsvarchar(2500)
//    detailvarchar(6000)
//    descriptionvarchar(2500)
//    target_amountbigint(20)
//    total_feebigint(20)
//    start_timedatetime
//    end_timedatetime
//    sold_numint(11)
//    plus_dayint(11)
//    statustinyint(4)״̬
//    weighttinyint(4)
//    versionbigint(20)
//    date_createddatetime
//    last_updateddatetime

    Long id
    //�ڳ�����
    String title
    //�ڳ�ͼƬ
    String picUrls
    //����
    String detail
    //����
    String description
    //Ŀ����
    Long targetAmount
    //�ܽ��
    Long totalFee
    //��ʼʱ��
    Date startTime
    //����ʱ��
    Date endTime
    //��ӵ�ʱ��
    Integer plusDay
    //֧����
    Long soldNum
    //״̬(-1=��Ч;0=����;1=�ɹ�;2=ʧ��)
    Byte status
    //Ȩ��
    Byte weight
    //��Ƶ����
    String video
    //�汾
    Long version=1L
    //����ʱ��
    Date dateCreated
    //����ʱ��
    Date lastUpdated


    //�ڳ�����¼�
    Byte approveStatus=1 as byte

    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
    }


}

package welink.business

/**
 * Created by unescc on 2016/1/13.
 */
class MikuReturnGoodsDetail {
    Long id
    //�汾
    Long version
    //����id
    Long tradeId
    //����id
    Long orderId
    //��Ӧ����Ʒ����������
    Long orderNum
    //��Ʒid
    Long artificialId
    //��Ʒ����
    String itemName
    //���id
    Long buyerId
    //�������
    String buyername
    //��ҵ绰
    String buyermobile
    //Ʒ������
    String name
    //ͼƬ��ַ
    String picUrl
    //�۸�
    Long price
    //�ܽ��
    Long totalFee
    //�˿���
    Long refundFee
    //����ID
    Long sellerId
    //��������
    Long sellerType
    //״̬(-1:ɾ��;0:������;1:�����˻�;2=�˻���;3=�˻����;4=�˻��쳣)
    Long status
    //����ʱ��
    Date timeoutActionTime
    //����ʱ��
    Date endTime
    //����
    String title
    //����ʱ��
    Date dateCreated
    //����ʱ��
    Date lastUpdated
    //����ʱ��
    Date consignTime
    //�˻��ɹ�ʱ��
    Date returnedTime
    //������ַ
    Long consigneeId
    //�����������ַ
    String consigneeAddress
    //��ұ�ע
    String buyerMemo
    //���ұ�ע
    String sellerMemo
    //�ƶ��豸��ʾ
    byte tradeFrom


    //����
    Long num
    //����id
    Long agencyId
    //������
    Long shareFee
    //����
    Long point

    //Ʒ������
    String brandName


    //�˻��ɹ�ʱ��
    Date finishTime
    //�˻�ԭ��
    String returnReason
    //�������ʱ��
    Date reqExamine
    //�ջ�ʱ��
    Date receiptTime
    //�Ƿ���(0=������; 1=����)
    Byte isSubsidy
    //�������
    Long subsidyFee

    //��˵���������ڵ�
    String timeOutStatement

    //trade���״̬
    Byte tradeStatus
    //�Ƿ�Ϊ����
    Byte ispassDate

}

package welink.common

class MikuReturnGoods {
    Long id
    //�汾
    Long version
    //����id
    Long tradeId
    //����id
    Long orderId
    //��Ʒid
    Long artificialId
    //���id
    Long buyerId
    //Ʒ������
//    String name
    //ͼƬ��ַ
    String picUrl
    //�۸�
    Long price
    //�ܽ��
    Long totalFee
    //�˿���
    Long refundFee
    //����ID
//    Long sellerId
    //��������
//    Long sellerType
    //״̬(-1=ɾ��;0=������;1=�����;2=�����˻������;3=�˻���;4=�˻�ȷ���ջ�;5=�˻����;6=�˻��쳣)
    Byte status
    //����ʱ��
    Date timeoutActionTime
    //����ʱ��
//    Date endTime
    //����
    String title
    //����ʱ��
    Date dateCreated
    //����ʱ��
    Date lastUpdated
    //����ʱ��
    Date consignTime
    //�˻��ɹ�ʱ��
//    Date returnedTime
    //������ַ
    Long consigneeId
    //��ұ�ע
    String buyerMemo
    //���ұ�ע
    String sellerMemo

    //����
    Long num
    //����id
//    Long agencyId
    //������
//    Long shareFee
    //����
//    Long point


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
    //trade���״̬
    Byte tradeStatus

    static mapping = {
        table('miku_return_goods')
        id generator: 'identity'
    }


}

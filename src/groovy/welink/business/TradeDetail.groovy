package welink.business

/**
 * Created by spider on 13/11/14.
 */
class TradeDetail {

    String tradeId

    String profileMobile

    String address

    String itemName

    String itemNum

    String itemPrice

    String orderPrice

    String itemSpecification

    List<OrderDetail> OrderList

    String totalPrice

    String createTime

    String consignTime

    String confirmTime

    String appointDeliveryTime

    String endTime

    String status

    String receiverName

    String receiverMobile

    String tradeMemo

    String buyerMessage

    String communityName

    String communityAddress

    String profileAlipay

    String courierName

    String modifiAddr

    String courierMobile

    //��������������ӵ��ֶ�
    //������˾
    String logisticsCompany
    //������
    String logisticsWuLiuCode
    //�ⲿ����
    String outtradeid
    //�����Ļ�����Ϣ
    String memo


    String iteminfo
    String reason

    //�˻��õı�ʾ
    Byte ispassDate


    //��Ϊ������������ӵ�
    // �����ڲ���Դ�� WAP(�ֻ�);HITAO(����);TOP(TOPƽ̨);TAOBAO(��ͨ�Ա�);JHS(�ۻ���) һ�ʶ�������ͬʱ�����϶����ǣ����Զ��ŷָ�
    Byte tradeFrom
    // ��������ʱ��������ʽ���������ǰ��������ʽ�п��ܸı䣬��ϵͳ�������ֶ�һֱ���䣩����ѡֵ��free(���Ұ���),post(ƽ��),express(���),ems(EMS),virtual(���ⷢ��)��25(���ձش�)��26(ԤԼ����)��
    Byte shippingType
    // �����޸�ʱ��(�û��Զ������κ��޸Ķ�����´��ֶ�
    Date dateCreated
    // ��Ʒ����Ʒ�۸�����������ܽ�����ȷ��2λС��;��λ:Ԫ����:200.07����ʾ:200Ԫ7��
    Long totalFee
    //�����͵�֧���ķ�ʽ��
    //1:����֧��      2.����֧��/��������   3.����֧����֧��
    //4.����΢��֧��   5.����0Ԫ֧��        6.�����ֽ�֧��
    //7.����֧����֧��  8.����΢��֧��
    Byte payType
    //��Ʒ����
    String info
    // ��Ʒ�۸񡣾�ȷ��2λС������λ��Ԫ���磺200.07����ʾ��200Ԫ7��
    Long price
    Long id
    //�й��ڵ��ڳ����Ŀ��״̬
    Byte mcstatus
    //֧���ķ�ʽ��֧����1 ���ں�΢��2  app��΢�Ű�3 ��
    Byte refundpayType
    //΢��weixinback��id
    String wxpayId

    //֧������Ϣ
    String buyerMemo
    //֧����alipayId
    String alipayNo

    //�˿�״̬
    Byte crowdfundRefundStatus


    //�ջ���
    String buyerInfo


}

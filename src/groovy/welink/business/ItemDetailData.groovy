package welink.business

/**
 * Created by unescc on 2015/12/15.
 */
class ItemDetailData {

    // ��Ʒ���
    Long id
    // ��Ŀ
    Long categoryId
    //��Ŀ����
    String categoryIdName
    // ��Ʒ����
    String title
    // ����Id
    Long sellerId
    // ��������
    Long shopId
    // ��������
    Byte sellerType
    // ��Ʒ����
    String props
    // �û������������Ŀ����ID�����ṹ��"pid1,pid2,pid3"���磺"20000"����ʾƷ�ƣ� ע��ͨ��һ����Ŀ���û�������Ĺؼ����Բ�����1��
    String inputPids
    // �û������������������������ֵ���ṹ:"������ֵ;һ����������;һ��������ֵ;������������;�Զ�������ֵ,....",�磺���Ϳ�;�Ϳ�ϵ��;�Ʊ�ϵ��;�Ʊ�ϵ��;2K5����input_str��Ҫ��input_pidsһһ��Ӧ��ע��ͨ��һ����Ŀ���û�������Ĺؼ����Բ�����1�����������Ա������������ܳ��� 3999�ֽڡ�
    String inputStr
    // ��Ʒ����
    Integer num
    // �ϼ�ʱ�� ��Ʒ�ϼܿ�ʼʱ���ĺ���ֵ
    Long onlineStartTime
    // �¼�ʱ�� ��Ʒ�����ʱ���ĺ���ֵ
    Long onlineEndTime
    // ��Ʒ�¾ɳ̶�(ȫ��:new������:unused�����֣�second)
    Byte stuffStatus
    // ��Ʒ���ڵأ�ʡ�У��о����Ǻ���Ҫ��Ԥ����
    String address
    // ������С��
    String allowCommunityIds
    // ��Ʒ����С��
    String forbiddenCommunityIds
    // �۸�
    Double price
    // �ʷ�
    Double postFee
    // ֧�ֻ�Ա����,true/false
    Byte hasDiscount
    // �˷ѳе���ʽ,seller�����ҳе�����buyer(��ҳе���
    Byte freightPayer
    // �Ƿ��з�Ʊ,true/false
    Byte hasInvoice
    // �Ƿ��б���,true/false
    Byte hasWarranty
    // �����Ƽ�,true/false
    Byte hasShowcase
    // �Ӽ۷��ȡ����Ϊ0������ϵͳ������ȡ� �ھ����У�Ϊ�˳�Խ��һ�����ۣ���Ա��Ҫ�ڵ�ǰ���������ӽ���������ǼӼ۷��ȡ������ڷ���������ʱ������Զ���Ӽ۷��ȣ�Ҳ������ϵͳ�Զ�����Ӽۡ�ϵͳ�Զ�����Ӽ۵ļӼ۷������ŵ�ǰ���۽������Ӷ����ӣ����ǽ����Աʹ��ϵͳ�Զ�����Ӽۣ���������ڳ���ǰ������Ӽ۷��ȵľ����������Ҫע���ǣ��˹���ֻ��������������Ʒ�� ������ϵͳ�Զ�����Ӽ۷��ȱ� ��ǰ�ۣ��Ӽ۷��� �� 1-40�� 1 ����41-100�� 2 ����101-200��5 ����201-500 ��10����501-1001��15����001-2000��25����2001-5000��50����5001-10000��100�� 10001���� 200
    Integer increment
    // ��Ʒ״̬
    Byte status = 1 as Byte
    // ��Ʒ�ϴ����״̬��onsale�����У�instock����
    Byte approveStatus
    // ��ƷͼƬ�б�(������ͼ)��fields��ֻ����item_img���Է���ItemImg�ṹ���������ֶΣ��������Ϊitem_img.id��item_img.url��item_img.position����ʽ��ֻ�᷵����Ӧ���ֶ�
    String picUrls
    // ��Ʒ����ͼƬ�б�fields��ֻ����prop_img���Է���PropImg�ṹ���������ֶΣ��������Ϊprop_img.id��prop_img.url��prop_img.properties��prop_img.position����ʽ��ֻ�᷵����Ӧ���ֶ�
    String propImgs
    // ������Ʒ��״̬�ֶ�
    Byte virtual
    // ��Ʒ�������ҵ����õȼ�����1��ʾ1�ģ�2��ʾ2�ġ�����ֻ�е�����Ʒ����:taobao.items.get��taobao.items.search��ʱ����ܷ���
    Integer score
    // ��ɱ��Ʒ���͡�������ɱ��ǵ���Ʒ���û�ֻ���¼ܲ��������ϼܣ������κα༭��ɾ�����������ܽ��С�����û���ȡ����ɱ��ǣ���Ҫ��ϵС�����в����������ɱ������Ҫ���ɱ༭����ϵ������ˣ�С����ȥ����ɱ��ǡ���ѡ���� web_only(ֻ��ͨ��web������ɱ) wap_only(ֻ��ͨ��wap������ɱ) web_and_wap(����ͨ��web��ɱҲ��ͨ��wap��ɱ)
    Byte secondKill
    // ��Ʒ�Ƿ�֧�����¼����:1֧��;2ȡ��֧��(��������);0(Ĭ��)������ ��������Ĭ�����¼����; �̳�����Ĭ�ϸ�������
    Byte subStock
    // ʳƷ��ȫ��Ϣ���������������֤��š���Ʒ��׼�š���������ַ��
    String foodSecurity
    // ��Ʒ�����������ڰ������Ʒѵ��˷�ģ�塣ע�⣺��λΪkg
    String itemWeight
    // ��ʾ��Ʒ����������ڰ�����Ʒѵ��˷�ģ�塣��ֵ�ĵ�λΪ�����ף�m3���� ��ֵ֧�����ָ�ʽ�����ã���ʽ1��bulk:3,��λΪ������(m3),��ʾֱ������Ϊ��Ʒ���������ʽ2��weight:10;breadth:10;height:10����λΪ�ף�m��
    String itemSize
    // ���ۿ��
    Integer soldQuantity
    // Ԥ�ۿ�棬�������������Ʒ�����ж��ٴ���δ����״̬�Ķ���
    Integer withHoldQuantity
    // Ԥ���ֶ�
    String video
    // ��Ʒ����(fixed:һ�ڼ�;auction:����)ע��ȡ���Ź�
    Byte type
    // ͼ������
    String detail
    // ��Ʒ����, ����Ҫ����5���ַ���С��25000���ַ�
    String description
    // �Ƿ���SKU
    Byte hasSku
    // Sku�б�fields��ֻ����sku���Է���Sku�ṹ���������ֶΣ��������Ϊsku.sku_id��sku.properties��sku.quantity����ʽ��ֻ�᷵����Ӧ���ֶ�
    String skus
    // ��Ʒ�������ơ���ʶ��props���������pid��vid����Ӧ�����ơ���ʽΪ��pid1:vid1:pid_name1:vid_name1;pid2:vid2:pid_name2:vid_name2����(ע�����������е�ð��":"��ת��Ϊ��"#cln#"; �ֺ�";"��ת��Ϊ
    String propsName
    // ��Ʒ����features
    String features
    // �����Ƿ�ʹ�÷���ʱ�䣬��Ʒ����sku����
    Byte needDeliveryTime
    // ����ʱ�����ͣ����Է���ʱ�������Է���ʱ��
    String deliveryTimeType
    // ��Ʒ�������õķ���ʱ�䡣��������Ʒ����ķ���ʱ�䣬��Է���ʱ�䣬����д��Է���ʱ�������������3�������Է���ʱ�䣬����дyyyy-mm-dd��ʽ����2013-11-11
    String deliveryTime
    String specification
    // ����Ǹ��Ƶ���Ʒ�����и��Ƶ���ƷId
    Long baseItemId
    // �������Ʒ����
    Byte shopType

    // ����ʱ��
    Date dateCreated
    // ����޸�ʱ��
    Date lastUpdated

    //UUID ��¼ÿ����Ʒ�ı�ʾ
    String uuid
    //brand ����Ʒ�ƹ���
    Long  brandId
    //Ʒ������
    String brandName
    //Ʒ�ƹ�˾����
    String brandCompanyName
    //������Ʒ�ı���===>��Ӧ����Ʒ�ı�ʾ����
    String code
    //��ƷȨ��    ===>��������Ʒ������
    Integer weight
    //���ۻ���    ===>��Ʒ���ۻ���
    Integer baseSoldQuantity

    //�ɱ���
    Double cbprice
    //ƽ̨����
    Double ptlirun
    //�ο���
    Double ckPrice
    //�ɷ�����
    Double kflirun
    //���������
    String itemAttribute
    //�ؼ���
    String keyWord
//    //�Ƿ���˻�
//    Byte isrefund



    //Ϊ��������ڳ��Ҫ����������ֶ�
    //�ر����� return_content
    String returnContent
    //������ʾ risk_tips
    String riskTips
    //�ر�˵�� special_note
    String specialNote
    //֧����
    Integer soldNum


    //�Ƿ���˰(0����˰  1��˰)  ��Ĭ�ϲ���˰��
    Byte isTaxFree
    //�Ƿ��˻� �Ƿ���˻��ֶ�  0 Ϊ��   1Ϊ�� ��Ĭ�Ͽ��˻���
    Byte isrefund


    //����˰���˻���˵��
    String isTaxFreeInfo
    String isrefundInfo

    //�Ǳ�Ʒ  ����Ʒ  ������
    String tagFbpinfo
    String tagRmpinfo
    String tagQtbinfo



    //�༶��Ŀid
    //������ĿID
    Long category2_id
    String category2Name

    //һ����ĿID
    Long category1_id
    String category1Name

    //3����Ŀ
    String category3Name



    //������ʷ���ɹ���

    //�ɹ���
    Double cgprice







}

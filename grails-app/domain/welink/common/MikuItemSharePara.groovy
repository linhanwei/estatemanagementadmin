package welink.common

class MikuItemSharePara {

    Long id

    //�汾
    Long version

    //���󷽰�����
    String schemeName

    //��ע˵��
    String memo

    //��Ʒid
    Long itemId

    //�ɱ�����λΪ�֣���ƽ̨������ɷ��������=��Ʒ����
    BigDecimal  itemCostFee

    //ƽ̨������
    BigDecimal  itemProfitFee

    //�ɷ�����
    BigDecimal  itemShareFee

    //�����������json-kv�ķ�ʽ���д洢����������ȼ�id:�ɵ÷����
    String parameter

    //�����û�����̨����Աid
    String creatorId

    //��������
    Date dateCreated

    //��������
    Date lastUpdated

    //�Ƿ����
    Byte isDisable

//    BigDecimal testone
//
//    BigDecimal testTwo

    static mapping = {
        id generator: 'identity'
    }

//    static constraints = {
//        testTwo(max:1000, scale:2)    //������Ƹ��˺ܾòŸ����, ӳ��ΪDECIMAL(10,6)
//    }
}

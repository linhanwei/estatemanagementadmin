package welink.warehouse

class MikuItemAndPitems {


    Long id

    Long itemId

    Long pitemId

    Long price

    Long postfee

    String uuid

    //[0δ���  1�Ѿ���� 2�Ѹ���]
    byte flag

    Long version=0L

    //    ������ʱ��
    Date date_created
    //    �޸ĵ�ʱ��
    Date last_updated


    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

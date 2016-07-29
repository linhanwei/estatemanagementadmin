package welink.warehouse

class MikuItemAndPitems {


    Long id

    Long itemId

    Long pitemId

    Long price

    Long postfee

    String uuid

    //[0未审核  1已经审核 2已更改]
    byte flag

    Long version=0L

    //    创建的时间
    Date date_created
    //    修改的时间
    Date last_updated


    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

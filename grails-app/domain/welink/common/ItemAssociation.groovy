package welink.common

class ItemAssociation {

    Long id

    Long itemId

    Long targetId

    Integer weight

    //0表示已删除，1表示有效
    Byte status

    Date lastUpdated

    Date dateCreated

    static constraints = {
    }
}

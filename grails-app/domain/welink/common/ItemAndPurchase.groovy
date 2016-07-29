package welink.common

class ItemAndPurchase {

    Long id

    Long itemId

    Long purchaseId

    Date lastUpdated

    Date dateCreated

    //-1未匹配,
    byte approveStatus

    //1表示有效
    byte status

    static constraints = {

    }

}

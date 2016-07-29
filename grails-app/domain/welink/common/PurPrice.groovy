package welink.common

class PurPrice {
    Long id

    Long purchaseId

    //规格数量
    Long specNum

    //按斤价格
    Long unitPrice

    //1表示有效，0表示无效
    byte status

    Date lastUpdated

    Date dateCreated

    static constraints = {
    }
}

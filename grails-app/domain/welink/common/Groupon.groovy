package welink.common


//团购表
class Groupon {

    Long id

    Long shopId

    Long itemId

    Long itemCategoryId

    String itemTitle

    Long purchasingPrice

    Long referencePrice

    Long price

    Long grouponPrice

    Long quantity

    Long onlineStartTime

    Long onlineEndTime

    Byte type = 3 as byte

    Byte status

    Long soldQuantity

    String bannerUrl

    // 创建时间
    Date dateCreated
//    最后修改时间
    Date lastUpdated


    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }
}

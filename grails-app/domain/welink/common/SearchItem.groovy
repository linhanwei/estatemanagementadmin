package welink.common

class SearchItem {

    Long id

    Long categoryId

    Long price

    Long promotionPrice

    Long shopId

    String title

    Byte status

    Long onlineStartTime

    Long onlineEndTime

    Integer soldCount

    Integer rank

    Integer type

    Long tagId

    String features

    Long itemLastUpdated

    Long itemDateCreated

    Date lastUpdated

    Date dateCreated

    static constraints = {
    }

    static mapping = {
        id generator: 'assigned'
    }
}

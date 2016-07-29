package welink.estate

class TradeSearch {

    Long id

    Long buyerId

    String buyerName

    String buyerMobile

    Long consigneeId

    String consigneeName

    String consigneeMobile

    Integer payType

    Integer shippingType

    String address

    Long communityId

    Long shopId

    Long totalFee

    Integer status

    Integer type

    Long dateCreated

    Long appointDeliveryTime

    Long dailyDeliveryTime

    String lbs

    Double longitude

    Double latitude


    static constraints = {
    }

    static mapping = {
        id generator: 'assigned'
        version(false)
    }
}

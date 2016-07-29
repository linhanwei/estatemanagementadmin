package welink.estate

class UserProperty {

    Long id

    Long userId

    Long communityId

    Long buildingId

    String consigneeIds

    Date dateCreated

    Date lastUpdated

    // 状态
    Byte status = 1 as Byte

    static constraints = {

    }
    static mapping = {

        id generator: 'identity'

    }
}

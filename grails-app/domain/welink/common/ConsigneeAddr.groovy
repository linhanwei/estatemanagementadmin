package welink.common

class ConsigneeAddr {
    Long id

    Long userId

    Long communityId

    String receiverName

    String communityName

    String receiverPhone

    String receiverMobile

    String receiverState

    String receiverCity

    String receiverDistrict

    String receiverAddress

    String receiverZip
    //后台修改后的地址
    String modifiAddr

    String longitude

    String latitude

    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date lastUpdated
    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date dateCreated


    static constraints = {
    }
    static mapping = {
        id generator: 'identity'
    }
}

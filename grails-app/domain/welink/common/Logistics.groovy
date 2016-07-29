package welink.common

class Logistics {
    Long id

    String contactName

    String province

    String city

    String country

    String addr

    String zipCode

    String phone

    String mobile

    String sellerCompany

    String memo

    Byte getDef

    Byte cancelDef

    Long communityId

    Long districtId

    Date lastUpdated

    Date dateCreated

    Long userId

    Long consigneeId

    String longitude

    String latitude

    //���֤����
    String idCard

    //�����������ַ
    String logicSpecificAddr

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
        cache true
    }
}

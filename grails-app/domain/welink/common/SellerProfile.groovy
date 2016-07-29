package welink.common

import groovy.transform.ToString

@ToString
class SellerProfile {

    Long id
    // 电话
    String mobile
    // 真实姓名
    String realName
    // 昵称
    String nickname
    // 柠檬昵称
    String lemonName
    // 身份证号码
    String identityCard
    // 日期
    String birthday
    // 照片名字
    String profilePic
    // 密码
    String password
    // 状态
    Byte status = 0 as Byte

    Long communityId

    Long shopId

    Date dateCreated

    Date lastUpdated

    static constraints = {
        mobile nullable: false, blank: false
        status inList: [1 as byte, 0 as byte]
    }

    static mapping = {
        table('seller_profile')
        version(false)
        id generator: 'identity'

    }
}

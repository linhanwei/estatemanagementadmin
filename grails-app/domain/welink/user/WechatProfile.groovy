package welink.user

class WechatProfile {

    Long id
    String profileId
    String wechatId
    Date dateCreated
    Date lastUpdated
    Byte status
    Long version
    String unionId

    static mapping = {
        table("wechat_profile")

    }
}

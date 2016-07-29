package welink.user

class ProfileWechat {

    Long id
    String openid
    String nickname
    String sex
    String city
    String province
    String country
    String headimgurl
    String privilege
    String mobile
    Long version

    Integer status

    Byte synchron
    String accessToken
    Integer expiresIn
    String refreshToken
    String scope
    String unionId

    Long subscribeTime
    Boolean subscribe
    String language

    Date lastUpdated
    Date dateCreated
    Date lastLoginTime

    static constraints = {
    }

    static mapping = {
        table("profile_wechat")
        openid column: "openid"

    }
}

package welink.contact

class MikuSnsProfile {
    Long id
    //用户id
    Long profileId
    //版本
    Long version
    //创建日期
    Date dateCreated
    //更新时间
    Date lastUpdated
    //性别
    Byte sex
    //个性签名
    String signature
    //用户的基本信息
    String userInfo
    //创建的用户id
    Long createrId

    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

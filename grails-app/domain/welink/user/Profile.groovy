package welink.user
/**
 * 用户表
 */
class Profile {

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
    Byte status = 1 as Byte
    // 是否安装了客户端
    Byte installedApp = 0 as Byte

    Long lastLoginBuilding

    Date dateCreated

    Date lastUpdated

    //是否为对应的代理
    byte isAgency

    static constraints = {
        mobile nullable: false, blank: false
        status inList: [1 as byte, 0 as byte]
        installedApp nullable: false, inList: [0 as byte, 1 as byte]
    }

    static mapping = {
        table('profile')
        version(false)
        id generator: 'identity'

    }
}

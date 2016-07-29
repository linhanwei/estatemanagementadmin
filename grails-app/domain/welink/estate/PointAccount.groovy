package welink.estate

class PointAccount {


    Long id

    //用户ID
    Long userId

    //账户属性
    String Attributes

    //账户可用余额
    Long availableBalance

    //冻结金额
    Long frozenBalance

    //账户状态
    Byte status

    //创建时间
    Date dateCreated
    //最后修改时间
    Date lastUpdated


    static mapping = {
        id generator: 'identity'
        version(true)
    }

    static constraints = {
    }
}

package welink.common

class UserCoupon {

    Long id

    //动作ID
    Long actionId

    //用户ID
    Long userId

    //优惠劵ID
    Long couponId

    //优惠劵类型
    Integer couponType

    //领取时间
    Date pickTime

    Date startTime

    Date endTime

    //状态
    Byte status

    //属性
    String attributes

    //创建时间
    Date dateCreated

    //最后修改时间
    Date lastUpdated

    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }

}

package welink.common

class Coupon {

    Long id

    //店铺ID
    Long shopId

    //有效起始时间
    Date startTime

    //有效结束时间
    Date endTime

    //优惠劵名称
    String name

    //描述
    String description

    //面值
    Integer value

    //优惠劵类型，满减16，抵用15
    Integer type

    //优惠劵状态,未领取1,已领取2,已关闭0
    Byte status

    //最小使用门槛
    Integer minValue

    //概率
    String probability

    //限制数量
    Long limitNum

    //属性
    String attributes

    //创建时间
    Date dateCreated

    //最后修改时间
    Date lastUpdated

    //图片信息
    String picUrl

    //过期的图片信息
    String expirationPicUrl

    //有效天数
    Long validity

    //优惠券数量
    Long giveNum


    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }
}

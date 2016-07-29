package welink.estate

/**
 * 以前是小区，现在是配送点
 */
class Community {
    // 配送点 id
    Long id
    // 配送点名字
    String name
    // 服务电话
    String phone
    // 省
    String province
    // 城市
    String city
    // 区域
    String district
    // 小区描述
    String description
    // 小区图片 for mobile
    String picUrls

    Long provinceId

    Long cityId

    Long districtId

    // 地址
    String location
    // 经纬度信息，真的是经纬度
    String lbs
    // 营业时间
    String openingHours
    // 配送范围，经纬度
    String deliveryArea
    // 云图id
    String cloudTable

    Date dateCreated

    Date lastUpdated

    /**
     * 是否有效
     */
    Byte status = 1 as Byte

    static constraints = {
        deliveryArea maxSize: 2000
    }

    static mapping = {
        table('community')
        id generator: 'identity'
        cityId index: 'idx_city_id'
    }
}

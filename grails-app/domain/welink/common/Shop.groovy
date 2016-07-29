package welink.common

class Shop {
    // 店铺Id
    Long id
    // 城市Id
    Long cityId
    // communityId
    Long shopId
    // 店铺的类型
    Byte type
    // 店铺评分Id
    Long scoreId
    // 卖家Id
    Long sellerId
    // 店铺类型，1表示物业公司；2表示自营店铺
    Byte sellerType = 1 as byte
    // 店铺标题
    String title
    // 店铺描述
    String description
    // 店铺公告
    String bulletin
    // 店标地址
    String picPath
    // 这个字段先留着
    Byte approveStatus = 1 as Byte

    String serviceClause;                //服务条款

    String tfsPath;                      // 店铺描述和公告保存在tfs中的地址

    Byte promotedStatus

    // 店铺，有效无效
    Byte status = 1 as Byte

    Integer productCount

    String theme                       //店铺风格

    String keyBiz                     //店铺简介

    String domain

    String alipayAccount

    Date dateCreated

    Date lastUpdated


    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
    }
}

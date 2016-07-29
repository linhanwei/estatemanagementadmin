package welink.common

class MikuUserAgency {
    //id
    Long id
    //版本
    Long version
    //用户id
    Long userId
    //代理层级(root层为0)
    Long agencyLevel
    //父级代理用户id
    Long pUserId
    //父级2层代理用户id
//    Long p2UserId
    //父级3层代理用户id
//    Long p3UserId
    //父级4层代理用户id
//    Long p4UserId
    //父级5层代理用户id
//    Long p5UserId
    //该代理是否为父代理(即：该代理是否还有子代理)
    byte isParent
    //路径(v1版本只记录4层关系，例1，2,3)（备用）
    String path
    //是否验证
    byte isValidated
    //创建日期
    Date dateCreated
    //更新时间
    Date lastUpdated
    //是否删除
    Byte isDeleted

    //修改新的字段
    Long p2_userId
    Long p3_userId
    Long p4_userId
    Long p5_userId
    Long p6_userId
    Long p7_userId
    Long p8_userId

    //CEO的等级
    Long ceoUserId
    Long ceo2_userId
    Long ceo3_userId
    Long ceo4_userId

    static mapping = {
        id generator: 'identity'
    }
    static constraints = {
    }
}

package welink.business

/**
 * Created by unescc on 2015/11/23.
 */
class AgencyInfo {

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
    Long p2UserId
    //父级3层代理用户id
    Long p3UserId
    //父级4层代理用户id
    Long p4UserId
    //父级5层代理用户id
    Long p5UserId
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


    //用户名称
    String agencyName
    String agencyMobile
    Date agencyDateCreate
    //是否为代理
    byte isAgency
    //一级父级
    String pUserName
    String pUserMobile
    String pUserLevel
    //二级父级
    String p2UserName
    String p2UserMobile
    String p2UserLevel
    //三级父级
    String p3UserName
    String p3UserMobile
    String p3UserLevel
    //四级父级
    String p4UserName
    String p4UserMobile
    String p4UserLevel
    //五级父级
    String p5UserName
    String p5UserMobile
    String p5UserLevel

    //子级的信息
    Long childCount

}

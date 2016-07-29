package welink.common

class MikuShareLevel {

    Long id

    //版本
    Long version

    //等级名称
    String levelName

    //等级说明
    String memo

    //默认可分润比例
    Double defaultShareScale

    //权重，用于等级排序
    Integer weight

    //创建用户，后台管理员id
    Long creatorId

    //创建日期
    Date dateCreated

    //更新日期
    Date lastUpdated

    //是否删除
    Byte isDeleted

    //创建用户名称
    String creatorName

    //分润类型
    Integer shareType

    static constraints = {
    }

    static mapping = {
//        id generator: 'identity'
    }
}

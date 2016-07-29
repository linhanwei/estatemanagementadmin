package welink.estate

class Banner {

    Long id

    //标题
    String title

    //描述
    String description

    //banner类型，首页top-1,商品介绍-2，底部列表-3，类目-4
    Integer type

    //跳转类型，url-1,商品ID-2
    Integer redirectType

    //跳转目的地
    String target

    //权重1~10,数字越大，优先级越低
    Integer weight

    //banner图片
    String picUrl

    //开始时间
    Date onlineStartTime

    //结束时间
    Date onlineEndTime

    //1表示显示，0表示不显示
    Byte showStatus

    //0表示已删除，1表示有效
    Byte status

    Date lastUpdated

    Date dateCreated

    //新添字段
    //是否呈现文字区（默认不呈现为0）
    byte showText
    //类目id,当是首页时该字段为空
    Long categoryId
    //banner模块类型，0为首页，1为分类内  3,"众筹首页"
    Long moduleType

    //关联活动的ID
    Long topicId


    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }
}

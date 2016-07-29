package welink.warehouse

class MikuActiveTopic {

    Long id
    //专场名称
    String name
    //专场图片
    String picUrls
    //专场活动比例
    String parameter
    //开始时间
    Date startTime
    //结束时间
    Date endTime
    //状态(0=无效  1=有效)
    Byte status
    //版本
    Long version
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated

    //活动类型
    Long ActiveType

    //内容的类型
    Byte type

    //内容值
    String content



    static mapping = {
        id generator: 'identity'
        table('miku_active_topic')
    }


    static constraints = {
    }
}

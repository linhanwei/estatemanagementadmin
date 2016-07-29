package welink.common

class MikuCrowdfund {



//    idbigint(20)
//    titlevarchar(255)众筹名称
//    pic_urlsvarchar(2500)
//    detailvarchar(6000)
//    descriptionvarchar(2500)
//    target_amountbigint(20)
//    total_feebigint(20)
//    start_timedatetime
//    end_timedatetime
//    sold_numint(11)
//    plus_dayint(11)
//    statustinyint(4)状态
//    weighttinyint(4)
//    versionbigint(20)
//    date_createddatetime
//    last_updateddatetime

    Long id
    //众筹名称
    String title
    //众筹图片
    String picUrls
    //详情
    String detail
    //描述
    String description
    //目标金额
    Long targetAmount
    //总金额
    Long totalFee
    //开始时间
    Date startTime
    //结束时间
    Date endTime
    //添加的时间
    Integer plusDay
    //支持数
    Long soldNum
    //状态(-1=无效;0=正常;1=成功;2=失败)
    Byte status
    //权重
    Byte weight
    //视频链接
    String video
    //版本
    Long version=1L
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated


    //众筹的上下架
    Byte approveStatus=1 as byte

    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
    }


}

package welink.complain

class Complain {

    //投诉编号
    Long id

    //小区编号
    Long communityId

    //房号
    Long buildingId

    //投诉人id
    Long profileId

    //投诉添加的图片
    String picUrls

    //标题
    String title

    //投诉内容
    String content

    //操作状态:1代表待处理，2代表处理中，3代表已经完结
    byte status = 1

    //投诉建议时间
    Date dateCreated

    Date lastUpdated


    static constraints = {
        communityId nullable: true, blank: false
        profileId nullable: false, blank: false
        content nullable: false, blank: false
        picUrls nullable: true, blank: true
        dateCreated nullable: true, blank: false

    }

    static mapping = {
        id generator: 'identity'
    }
}

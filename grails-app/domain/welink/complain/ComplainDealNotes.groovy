package welink.complain

class ComplainDealNotes {

    //记录编号id
    Long id

    //投诉id
    Long complainId

    //处理内容
    String dealContent

    //回复人
    Long replyerId

    //投诉记录添加的图片
    String picUrls

    //回复时间
    Date dateCreate

    //回复人类型,0表示未回复，1表示投诉人，2表示工作人员
    byte replyerType

    //1表示有效，0表示该记录已经无效
    byte status

    static constraints = {
        dateCreate nullable: false, blank: false
        complainId nullable: false, blank: false
    }
    static mapping = {
        id generator: 'identity'
    }
}

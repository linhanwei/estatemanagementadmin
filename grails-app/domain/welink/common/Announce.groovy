package welink.common

class Announce {
    Long id
    //小区id
    Long communityId
    //公告标题
    String title
    //内容
    String content
    //纯文本内容
    String contentTxt
    //公告图片
    String announcePic
    //发布者
    String publisher
    // 状态 有效 1，无效 0


    Integer status
    //公告创建时间
    Date dateCreated


    static constraints = {
        announcePic nullable: true
        content(maxSize: 9999999)
    }
    static mapping = {
        table('annouce')
        id generator: 'identity'
    }
}

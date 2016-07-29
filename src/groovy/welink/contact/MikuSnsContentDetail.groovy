package welink.contact

/**
 * Created by miku09 on 2016/6/6.
 */
class MikuSnsContentDetail {
    //文章的id
    Long cid
    //活动内容的id
    Long dyId
    //用户的头像
    String userPicUrl
    //用户的id
    String userId
    //用户名，冗余，为了用户@显示
    String userName
    //文章开始时间
    Date dateCreate
    //文章的更新时间
    Date lastUpdate
    //文章标题
    String contentTitle
    //文章标题简称
    String contentShortTitle
    //内容摘要（只建议 content_create_type=1  用 ）（被转发时，显示两行，一行标题，一行摘要）
    String contentAbstract
    //封面图(需要小伍提供尺寸建议)
    String contentSurfacePicUrl
    //缩略图（被转发用）
    String contenThumbPicUrl
    //具体内容
    String content
    //浏览次数
    int timesOfBrowsed
    //点赞次数
    int timesOfPraised
    //转载次数
    int timesOfReferenced
    //评论次数
    int timesOfCommented
    //收藏次数
    int timesOfCollected
}

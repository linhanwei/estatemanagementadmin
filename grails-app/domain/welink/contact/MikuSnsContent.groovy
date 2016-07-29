package welink.contact

//系统或者用户发布的内容表
class MikuSnsContent {
      Long id
      //用户id
      Long userId
      //用户名，冗余，为了用户@显示
      String userName
      //文章生成类型：1、系统发布的内容2、用户发布的内容
      Byte contentCreateType
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
      //保存文章后面的图片云片的url（类似微信朋友圈的展现形式）
      String picUrls
      //被引用资源类型对象类型:1、客服/私人管家2、文章3、课程4、私人定制线下店5、…(content_from_type=2有效)
      Byte referencedGoalType
      //被引用资源id
      Long referencedGoalId
      //文章显示的作者名仅当content_create_type=1，有效
      String authorShowName
      //用于处理特殊文章：0、正常文章1、负面文章（作者可见，其它用户不可见）2、待定
      Byte specialFlag
      //版本
      Long version
      //创建日期
      Date dateCreated
      //更新时间
      Date lastUpdated
    static mapping = {
        id generator: 'identity'
    }
    static constraints = {
    }
}

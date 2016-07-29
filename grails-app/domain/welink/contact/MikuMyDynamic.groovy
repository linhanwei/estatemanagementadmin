package welink.contact

//我的动态（发布文章、发布动态、收藏….）
class MikuMyDynamic {
    Long id
    //用户id
    Long userId
    //用户名，冗余，为了用户@显示
    String userName
    //动作标识1、原创文章2、转发文章3、收藏内容
    Byte actionType
    //对象类型:1、客服/私人管家2、文章3、课程4、私人定制线下店5、…(action_type=1或者2   对于 2)(action_type=3   对于 2或者4)
    Byte goalType
    //对象id
    Long goalId
    //被转载的是哪个用户的内容(action_type=2 有效）
    Long referencedProfileId
    //被转载的是哪个用户的内容(action_type=2 有效）
    Long referencedSnsProfileId
    //1、个人主页2、圈子(action_type=1或者2的时候有效)
    Byte actionPostionType
    //(action_type=1或者2的时候，并且action_postion_type=2时有效）
    Long actionPostionId
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
    //置顶标志：0、否1、是
    Byte topFlag
    //备注
    String note
    //是否为删除
    Byte isDelete
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

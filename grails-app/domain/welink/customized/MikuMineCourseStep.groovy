package welink.customized

//
class MikuMineCourseStep {

    Long id

    //所属课程
    Long courseId

    //步骤名
    String stepName

    //步骤名缩写，用作提示
    String stepShortName

    //步骤排序
    Integer stepOrder


    Byte stepType

    //该步骤和上一个步骤的间隔,用作视频或者没步骤之间的准备工作
    Integer stepInterval

//    产品规则-使用频率：
//    1 早晚都要
//    2 早
//    3 晚
//    4 3小时一次
//    5 每周一次
//    6 每周两次
    Byte stepUseStandardFrequency

//    产品规则-使用周期：
//    1、每天
//    2、每周
//    3、每月
//    4、有症状的时候
    Byte stepUseStandardPeriod

//    产品规则-使用条件：
//    1、周期性
//    2、突发性
    Byte stepUseStandardCondition

//    步骤使用时段 用step_use_standard_frequency代替
//    1、早晚都需要
//    2、早用
//    3、晚用
    Byte useTime

    //该步骤中使用的产品id
    Long prodId

    //产品使用提示
    String prodUseRemind

    //该步骤中使用的视频
    String videoName

    //视频名缩写
    String videoShortName

    //视频在云片上的url
    String videoUrl

    //视频时长
    Integer videoTime

    //视频使用提示
    String videoUseRemind

    //版本号
    Long version

    //创建时间
    Date dateCreated

    //修改时间
    Date lastUpdated

    static mapping = {
        id generator: 'identity'
        version(true)
    }

    static constraints = {
    }
}

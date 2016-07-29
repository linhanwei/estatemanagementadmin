package welink.customized

//私人定制经验库管理表
class MikuMineExpertDb {

    Long id

//    定制类型：
//    1、护肤定制类
//    2、私密护理类
//    3、减肥定制类
//    4、脱发定制类
//    5、待扩展
    Byte mineType

    //用户需要改善的皮肤问题id
    Long scProblemId

    //针对上述问题的解决思路id
    Long scThinkingId

    //用户肤质推断
    String skinTypeInfer

//    肤质：
//    1、油性
//    2、干性
//    3、混合型
//    4、混合型偏干
//    5、混合型偏油
    Byte envSkinType

//    适宜的年龄段：
//    0 不限
//    1 25岁及以下
//    2 26岁以上
//    3 32岁及以下（仅适用于去皱）
//    4 33岁以上（仅适用于去皱）
    Byte envAgeRegion

    //城市
    String envCity

//    区域
//    1、南方
//    2、北方
    Byte envArea

//    季节（多选）
//    0、不限
//    1、春
//    2、夏
//    3、秋
//    4、冬
    String envSeasons

    //步骤名
    String stepName

    //步骤名缩写，用作提示
    String stepShortName

//    1、普通步骤
//    2、特效步骤
    Byte stepType

    //步骤排序
    Integer stepOrder

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

//    步骤使用时段
//    1、早晚都需要
//    2、早用
//    3、晚用
//    Byte useTime

    //该步骤中使用的产品
    Long prodId

    //该步骤中使用的产品
    String prodUseRemind

    //多媒体ID
    Long multimediaResourceId

    //视频使用提示
    String multimediaUseRemind

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

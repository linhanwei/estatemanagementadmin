package welink.customized

//私人定制使用的基础产品表
class MikuMineScProduct {

    Long id

//    定制类型：
//    1、护肤定制类
//    2、私密护理类
//    3、减肥定制类
//    4、脱发定制类
//    5、待扩展
    Byte mineType

    //产品名
    String prodName

//    产品类型
//    1、基础护肤型产品
//    2、功效性产品
    Byte prodType

    //产品规格产品规格
    String prodSpec

    //产品包装
    String prodPack

    //产品成分
    String prodIngredient

    //产品可以使用的问题
    String prodAimProblemIds

    //产品功效
    String prodAimThinkingIds

    //成本价
    Long prodCostPrice

    //建议零售价
    Long prodRetailPrice

    //产品备注
    String prodNote

    //商品图片链接
    String prodPicUrls

//    产品适用肤质
//    0 不限
//    1 油性
//    2 干性
//    3 混合型偏干
//    4 混合型偏油
    String prodSkinApplys

//    产品状态
//    1 膏
//    2 水状
//    3 原液
//    4 乳
//    5 霜
//    6 面膜
    String prodShowStatus

    //产品用途
    String prodPurpose

//    产品规则-使用频率：
//    1 早晚都要
//    2 早
//    3 晚
//    4 3小时一次
//    5 每周一次
//    6 每周两次
    Long prodUseStandardFrequency

//    产品规则-使用周期：
//    1、每天
//    2、每周
//    3、每月
//    4、有症状的时候
    Long prodUseStandardPeriod

//    产品规则-使用条件：
//    1、周期性
//    2、突发性
    Long prodUseStandardCondition

    //产品效果
    String prodResult

    //对应的多媒体教学资源
    Long multimediaResId

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
        prodPicUrls(maxSize:2500)
    }
}

package welink.mikudesign

class MikuSurveyReport {

    Long id
    //用户ID
    Long userId
    Long questionnaireId
    Long questionId
    Long questionType
    Long questionName
    //出具报告的时候，该问题打印在哪块区域
    String questionPostionInreport

    //出具报告的时候，该问题打印区域的排序
    String questionOrderInreport

    Long optionId

    Byte optionShowStyle

    String optionValue
    //长度要长，多个图片
    String picUrls

    //是否有智能测肤数据
    String instrumentMeasureDateInclude
    //测试仪类型标识
    //1、米酷定制智能皮肤状态监测仪
    //2、待定
    Byte instrumentType

    //选取的智能测肤仪测试开始时间
    Date instrumentMeasureStime

    //选取的智能测肤仪测试结束时间
    Date instrumentMeasureEtime

    //美导user_id
    Long serviceId

    //money
    Long money


    //版本
    Long version

    // 创建时间
    Date dateCreated
    // 修改时间
    Date lastUpdated


    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }
}

package welink.mikudesign


//纪录用户使用仪器测试的数据
class MikuInstrumentMeasureLog {

    Long id
    //用户ID
    Long userId
    //    测试类型：
    //    1、肌肤测试
    //    2、待定
    Byte measureType
    //    测试仪类型标识
    //    1、米酷定制智能皮肤状态监测仪
    //    2、待定
    Byte instrumentType

    //部位
    Byte testPosition

    //统计星期几
//    int createWeekDay



   //基础测试值
//    Long measureValue

    //水分测试值
//    Long moistureValue

    //油分测试值
//    Long oilValue

    //弹性测试值
//    Long resilienceValue

    //衰老测试值
//    Long senilityValue

    //测试年(为了统计方便)
//    String createYear

    //测试周(为了统计方便)
//    String createWeek

    //测试月(为了统计方便)
//    String createMonth

    //测试日(为了统计方便)
//    String createDay

    //测试时间(为了统计方便)
//    String createTime

    //版本
    Long version

    // 创建时间
    Date dateCreated
    // 修改时间
    Date lastUpdated

    //

    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

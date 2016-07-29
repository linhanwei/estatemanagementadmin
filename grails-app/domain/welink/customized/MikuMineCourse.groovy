package welink.customized

//私人定制课程表
class MikuMineCourse {

    Long id

    //盒子ID
    Long boxId

//    定制类型：
//    1、护肤定制类
//    2、私密护理类
//    3、减肥定制类
//    4、脱发定制类
//    5、待扩展
    Byte mineType

    //课程名
    String courseName

    //课程简称
    String courseShortName

//    课程属性
//    1、公开课程
//    2、系统自动生成的定制课程(不能增删改)
    Byte courseProperty

//    课程类型：
//    1、单次课时(一个步骤、多个步骤)
//    2、计划课程
    Byte courseType

//    课程模板：
//    1、模板课程
//    0、普通课程
    Byte courseTemplate

    //课程介绍
    String courseIntroduce

    //课程备注
    String courseNote

    //课程播放次数
    Integer coursePlayedTimes

    //课程阶段数量
    Integer courseSectionsNum

    //课程周期时长（天）
    Integer courseDuration

    //课程归属的用户id，系统自动生成的定制课程有效，属于冗余字段(系统自动生成的定制课程有效)
    Long courseBelongUserid

    //课程开始时间，由用户在界面点击选取(系统自动生成的定制课程有效)
    Integer courseUserStime

    //课时id(公开课程+系统自动生成的定制课程有效)
    Long lessonId

    //录入者ID
    Long createrId

    //    置顶标志：
    //    0、否
    //    1、是
    Byte topFlag

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
        courseIntroduce(maxSize: 2500)
    }
}

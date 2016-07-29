package welink.customized

//私人定制课时表
class MikuMineLesson {

    Long id

    //盒子ID
    Long boxId

    //课时名称
    String lessonName

    //课时简称
    String lessonShortName

    //课时介绍
    String lessonIntroduce

    //课时备注
    String lessonNote

//    课程属性
//    1、公开课程
//    2、系统自动生成的课时
    Byte lessonProperty

    //本次课时时长
    Integer lessonTime

    //本次课时步骤数
    Integer lessonStepsNum

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
        lessonIntroduce(maxSize: 2500)
    }
}

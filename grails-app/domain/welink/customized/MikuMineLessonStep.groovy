package welink.customized

//私人定制课时步骤表
class MikuMineLessonStep {

    Long id

    //盒子ID
    Long boxId

    //所属课时
    Long lessonId

    //步骤名
    String stepName

    //步骤名缩写，用作提示
    String stepShortName

    //介绍
    String stepIntroduce

    //备注
    String stepNote

    //步骤排序
    Integer stepOrder

//        步骤类型
//    1、普通步骤
//    2、特效步骤
    Byte stepType

    //该步骤和上一个步骤的间隔,用作视频或者没步骤之间的准备工作,单位秒
    Integer stepInterval

    //该步骤中使用的产品ID
    Long prodId

    //产品使用提示
    String prodUseRemind

    //对应的多媒体教学资源id
    Long multimediaResourceId

    //多媒体使用提示
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
        stepIntroduce(maxSize: 2500)
    }
}

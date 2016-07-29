package welink.customized

//课程阶段表
class MikuMineCourseSection {

    Long id

    Long boxId

    //所属课程id
    Long courseId

    //阶段名称
    String sectionName

    //阶段名称缩写
    String sectionShortName

    //阶段时长(天)
    Integer sectionDuration

    //介绍
    String sectionIntroduce

    //备注
    String sectionNote

    //阶段序号
    Integer sectionOrder

    //该阶段第几天开始
    Integer sectionSd

    //该阶段第几天结束
    Integer sectionEd

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
        sectionIntroduce(maxSize: 500)
        sectionNote(maxSize: 300)
    }
}

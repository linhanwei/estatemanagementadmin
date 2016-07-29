package welink.customized

import java.sql.Time

//课程阶段与课时关系表
class MikuMineSectionLesson {

    Long id

    Long boxId

    //课程ID
    Long courseId

    //课程阶段ID
    Long sectionId

    //课时表天序号  如果某天为空，则表示该天需要休息  改字段最大值不能超过section_duration的值
    Integer dayOrder

    //最早这个课时什么时候用
    Time earliesttimeInDay

    //最迟这个课时什么时候用
    Time latestttimeInDay

    //建议这个课时什么时候开始  (如果用户在订阅表中设置了提醒，该字段用作提醒)
    Time suggesttimeInDay

    //使用的课时id
    Long lessonId

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

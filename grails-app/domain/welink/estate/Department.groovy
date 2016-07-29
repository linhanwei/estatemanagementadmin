package welink.estate

class Department {

    // 自增组件
    Long id

    // 小区id
    Long communityId

    // 部门名字
    String name

    // 状态，有效或者被删除，默认状态是有效
    Byte status = 1 as byte

    Date dateCreated

    Date lastUpdated

    static constraints = {
        communityId nullable: false
        name nullable: false, blank: false
        status inList: [1 as byte, 0 as byte]
    }

    static mapping = {
        table('department')
        id generator: 'identity'
    }
}

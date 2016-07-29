package welink.user

import welink.system.Role

/**
 * 物业公司员工
 */
class Employee {

    // 员工Id
    Long id

    // 用户登陆名称
    String username

    // 员工名字
    String name

    // 员工手机
    String mobile

    // 小区名字
    Long communityId

    // 公司部门
    Long departmentId

    // 员工编号
    String idNumber

    // 密码
    String password

    // 状态 有效 1，无效 0，创建但未验证 2
    Byte status

    Date dateCreated

    Date lastUpdated

    static hasMany = [role: Role, permissions: String]

    static constraints = {
    }

    static mapping = {
        table('employee')
        id generator: 'identity'
        username column: 'user_name'
    }
}

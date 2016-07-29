package welink.system

import welink.user.Employee

class Role {
    String name

    Date dateCreated

    Date lastUpdated

    static hasMany = [employees: Employee, permissions: String]
    static belongsTo = Employee

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }
}

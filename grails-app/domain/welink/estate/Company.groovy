package welink.estate

class Company {

    // 物业公司
    Long id

    // 物业公司名字
    String name

    // 物业公司的介绍
    String description

    Date dateCreated

    Date lastUpdated

    static constraints = {
        name nullable: false, blank: false
        description nullable: true, minSize: 20, maxSize: 500
    }

    static mapping = {
        table('company')
        id generator: 'identity'
    }
}

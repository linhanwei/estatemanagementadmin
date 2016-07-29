package welink.system

import grails.transaction.Transactional

import javax.annotation.PostConstruct

@Transactional
class RolePermissionService {

    static lazyInit = false

    def grailsApplication

    def serviceMethod() {

    }

    /**
     * 把所有的controller名字和permission都丢到数据库里面
     */
    @PostConstruct
    void init() {

    }
}

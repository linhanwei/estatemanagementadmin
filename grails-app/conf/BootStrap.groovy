import com.google.common.collect.Sets
import org.apache.shiro.crypto.hash.Sha512Hash
import org.slf4j.LoggerFactory
import welink.system.ControllerPermission
import welink.system.Role
import welink.system.UndeliveredTradeScheduleService
import welink.user.Employee

import static com.google.common.base.Preconditions.checkNotNull

class BootStrap {

    def grailsApplication

    UndeliveredTradeScheduleService undeliveredTradeScheduleService


    def init = { servletContext ->

        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Hong_Kong"))

        checkOrCreateSuperAdminUser()
        initPermissions()
    }

    def destroy = {
    }

    void checkOrCreateSuperAdminUser() {

        // 管理员角色
        Role.findByName("超级管理员") ?: new Role(name: "超级管理员").with {
            Set<String> adminPermissions = Sets.newHashSet('*:*')
            setPermissions(adminPermissions)
            save(failOnError: true, flush: true)
        }

        String salted = checkNotNull(grailsApplication.config.security.salted)
        Integer times = checkNotNull(Integer.valueOf(grailsApplication.config.security.iterate_times))

        Employee.findByUsername('root') ?: (new Employee(
                communityId: 1999L,
                username: 'root',
                name: 'root',
                password: new Sha512Hash('5iveL!fe', salted, times).toHex()).with {
            addToRole(Role.findByName('超级管理员'))
            Set<String> adminPermissions = Sets.newHashSet('*:*')
            setPermissions(adminPermissions)
            status = 1 as byte
            save(failOnError: true, flush: true)
        })
    }

    void initPermissions() {
        //遍历所有的controller,存入Permission
        grailsApplication.controllerClasses.each {
            def controllerArtefact ->
                ControllerPermission cp = ControllerPermission.findByControllerName(controllerArtefact.logicalPropertyName)
                if (!cp) {
                    new ControllerPermission(
                            showStatus: 1 as byte,
                            controllerName: controllerArtefact.logicalPropertyName,
                            requirePermissionName: controllerArtefact.logicalPropertyName
                    ).save(failOnError: true)
                }
        }

        // 游客账号
        Role.findByName("游客") ?: new Role(name: "游客").with {
            Set<String> guestPermissions = Sets.newHashSet('dashboard')
            setPermissions(guestPermissions)
            save(failOnError: true)
        }
    }

}

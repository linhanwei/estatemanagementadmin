package welink.system

import com.google.common.collect.Lists
import com.google.common.collect.Sets
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.estate.Community

import welink.user.Employee

class EmployeeController {

    def index() {
        def EmployeeMap = new HashMap<Long, Community>()
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)
        def c = Employee.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 1 as byte)
            if (employee.communityId!=1999L) {
                eq('communityId', employee.communityId)
            }
            order("communityId", "DESC")
        }

        pagedResultList.iterator().each {
            Employee employee1 ->
                EmployeeMap.put(employee1.id, Community.findById(employee1.communityId))
        }

        Community community = Community.findById(employee.communityId)

        return [
                EmployeeMap : EmployeeMap,
                community   : community,
                employeeList: pagedResultList,
                total       : pagedResultList?.totalCount,
                params      : params
        ]
    }

    def queryEmployeeRoles() {
        render(template: 'roles', model: [
                roleNames: Role.findAll()*.name
        ])
    }

    def deleteEmployee() {
        Long id = params.long('id')

        Employee employee = Employee.findById(id)

        // 如果这个角色存在，首先删除这个角色对应的权限，然后再删除角色
        if (employee) {
            employee.status = 0 as byte
            employee.save(failOnError: true, flush: true)
            render('true')
            return
        }
    }

    @Transactional
    def updateEmployeeRole() {
        withForm {

            Long id = params.long('selectedEmployeeId')

            List<String> roleSelects = params.roleSelect ? Lists.newArrayList(params.roleSelect) : Collections.emptyList()

            def temp = []
            Employee employee = Employee.findById(id)
            temp.addAll(employee.role)

            temp.each {
                employee.removeFromRole(it)
            }

            roleSelects.each {
                String name ->
                    Role role = Role.findByName(name)
                    employee.addToRole(role)
            }

            employee.save(failOnError: true)

            redirect(uri: '/employee/index')
            return

        }.invalidToken {
            // bad request
            response.status = 405
        }
    }

}

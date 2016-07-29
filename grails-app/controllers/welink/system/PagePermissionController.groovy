package welink.system

import com.google.common.collect.Lists
import grails.orm.PagedResultList
import org.codehaus.groovy.grails.commons.DefaultGrailsControllerClass

/**
 * 为所有页面添加访问权限，动态增加permission
 */
class PagePermissionController {

    def editControllerPermission() {
        if (params.id) {

            ControllerPermission controllerPermission = ControllerPermission.findById(params.long('id'))

            controllerPermission.title = params.title

            controllerPermission.description = params.description

            controllerPermission.save(failOnError: true, flush: true)

        } else if(params.requirePermissionName){
            ControllerPermission controllerPermission = new ControllerPermission()
            controllerPermission.controllerName = params.controllerName
            controllerPermission.title = params.title
            controllerPermission.description = params.description
            controllerPermission.showStatus = 1 as byte

            List<String> requireActionList = params.requirePermissionName ? Lists.newArrayList(params.requirePermissionName) : Collections.emptyList()

            requireActionList.iterator().each {
                if (controllerPermission.requirePermissionName != null) {
                    controllerPermission.requirePermissionName = controllerPermission.requirePermissionName + it + ';'
                } else {
                    controllerPermission.requirePermissionName = it + ';'
                }
            }
            controllerPermission.save(failOnError: true, flush: true)
        }

        redirect(controller: 'pagePermission', action: 'index')

    }

    def extendPermissionHtml() {
        List<String> controllerActionList = []

        ControllerPermission controllerPermission = ControllerPermission.findById(params.long('id'))

        grailsApplication.controllerClasses.each {
            DefaultGrailsControllerClass controller ->
                // skip controllers in plugins
                if (controller.logicalPropertyName.equals(controllerPermission.controllerName)) {
                    controller.getURIs().each {
                        String it ->
                            String actionName = controller.getMethodActionName(it)
                            if (controllerActionList.contains(actionName)) {

                            } else {
                                controllerActionList.add(actionName)
                            }
                    }
                }
        }

        return [
                controllerPermission: controllerPermission,
                controllerActionList: controllerActionList
        ]
    }

    def permissionEditHtml() {

        grailsApplication.controllerClasses.each {
            DefaultGrailsControllerClass controller ->
                // skip controllers in plugins
                if (controller.logicalPropertyName.equals('trade')) {
                    controller.getURIs().each {
                        String it ->
                            def actionMap = controller.getMethodActionName(it)
                            println(actionMap)
                    }
                }
        }

        ControllerPermission controllerPermission = ControllerPermission.findById(params.long('id'))

        return [
                controllerPermission: controllerPermission
        ]

    }

    def deletecp() {

        if (params.id) {
            ControllerPermission controllerPermission = ControllerPermission.findById(params.long('id'))
            if (controllerPermission) {
                controllerPermission.showStatus = 0
                if (controllerPermission.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405

    }

    def index() {

        def cp = ControllerPermission.createCriteria()

        PagedResultList pagedResultList = cp.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('showStatus', 1 as byte)
            order("title", "desc")
        }
        return [
                total                   : pagedResultList.totalCount,
                controllerPermissionList: pagedResultList
        ]

    }


    def updateRowPermissions() {

    }


}

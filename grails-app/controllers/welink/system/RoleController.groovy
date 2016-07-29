package welink.system

import com.google.common.collect.Lists
import com.google.common.collect.Sets
import grails.converters.JSON

class RoleController {

    def index = {
        List<Role> roleList = Role.findAll()

//        List<ControllerPermission> controllerPermissionList = ControllerPermission.findAll()
        //中文代替controlller名称
        //列表的全部值
        List<ControllerPermission> controllerPermissionList = ControllerPermission.withCriteria {
            eq('showStatus', 1 as byte)
            isNotNull("title")
        }
        List<Role> newRList
        roleList.each {
            role->
                List list =[]
                if (role.permissions.size()==1 && ('[*:*]').equals(role.permissions.toString()))
                {
                    controllerPermissionList.each {
                        permission->
                            list.add(permission.title)
                    }
                }
                else
                {
                    role.permissions.each {
                        onepermission->
                            controllerPermissionList.each {
                                permission->
                                    if (onepermission.toString().trim().equals(permission.controllerName.trim()))
                                    {
                                        list.add(permission.title)
                                    }
                            }
                    }
                }
                role.permissions=list as  String[]
        }
        return [roleList: roleList, controllerPermissionList: controllerPermissionList]
    }

    def deleteRole() {
        Long id = params.long('id')

        Role role = Role.findById(id)

        // 如果这个角色存在，首先删除这个角色对应的权限，然后再删除角色
        if (role) {
            role.permissions = Sets.newHashSet()
            role.save(failOnError: true, flash: true)
            render([])
        }
    }

    //新添加的方法
    def testMyselect()
    {
        Long id = params.long('id')
        def targetList=[]
        def pList=Role.findById(id).permissions
        List<ControllerPermission> controllerPermissionList = ControllerPermission.withCriteria {
            eq('showStatus', 1 as byte)
            isNotNull("title")
        }
        if (('[*:*]').equals(pList.toString()))
        {
            targetList=controllerPermissionList
        }
        else
        {
            pList.each {
                pp->
                    controllerPermissionList.each {
                        cplist->
                            if (cplist.controllerName.toString().equals(pp))
                            {
                                targetList.add(cplist);
                            }
                    }
            }

        }
        def JsonObj=com.alibaba.fastjson.JSON.toJSONString(targetList,true);
        render(JsonObj);

    }



    def queryRolePermissions() {
        Long id = params.long('id')
        List<ControllerPermission> controllerPermissionList = ControllerPermission.withCriteria {
            eq('showStatus', 1 as byte)
            isNotNull("title")
        }
        def pList=Role.findById(id).permissions

        pList.size()
        controllerPermissionList=docheckBoxFlag(pList, controllerPermissionList);
                render(template: 'permissions', model: [
                controllerPermissionList: controllerPermissionList
        ])
//                render(template: 'permissions', model: [
//                permissionList          : Role.findById(id).permissions,
//                controllerPermissionList: controllerPermissionList
//        ])
    }





    def createRole() {
        withForm {
            String name = params.role

            if (Role.findByName(name)) {

                flash.message = "新建角色[${name}]已经存在"

                redirect(uri: '/role/index')
                return
            }

            Role role = new Role(name: name)
            role.save(failOnError: true, flush: true)
            redirect(uri: '/role/index')

        }.invalidToken {
            // bad request
            response.status = 405
        }
    }

    def updateRolePermissions() {
        withForm {

            Long id = params.long('selectedRoleId')

            if (params.permissionSelect) {
                println(params.permissionSelect)
            }

            //id的集合
            if (params.selectedmyPermisions)
            {
                String[] strobj=params.selectedmyPermisions.split(',')
                params.permissionSelect=strobj
            }

            List<String> permissionSelects = []

            List<String> controllerpermissionSelects = params.permissionSelect ? Lists.newArrayList(params.permissionSelect) : Collections.emptyList()

            controllerpermissionSelects.iterator().each {
                ControllerPermission controllerPermission = ControllerPermission.findById(Long.parseLong(it))

                if (controllerPermission.controllerName != controllerPermission.requirePermissionName) {
                    if (controllerPermission.requirePermissionName.contains(';')) {
                        String[] actions = controllerPermission.requirePermissionName.split(';')
                        actions.each {
                            permissionSelects.add(controllerPermission.controllerName + ':' + it)
                        }
                    } else {
                        permissionSelects.add(controllerPermission.controllerName + ':' + controllerPermission.requirePermissionName)
                    }

                } else {
                    permissionSelects.add(controllerPermission.requirePermissionName)
                }
            }

            Role role = Role.findById(id)

            role.permissions = permissionSelects ? Sets.newHashSet(permissionSelects) : Sets.newHashSet()

            role.save(failOnError: true, flush: true)

            redirect(uri: '/role/index')
            return

        }.invalidToken {
            // bad request
            response.status = 405
        }
    }


    //进行对perssion与role的处理--->checkBox的处理
    //传入的参数是:permissions  +  控制器对应的名称
    def  docheckBoxFlag(def pList,List<ControllerPermission> controllerPermissionList)
    {
        if (pList.size()==1 && ('[*:*]').equals(pList.toString().trim()))
        {
            controllerPermissionList.each {
                cplist->
                    cplist.description="true"
            }
        }
        else
        {
            controllerPermissionList.each {
                cplist->
                    pList.each{
                        pp->
                            if (cplist.controllerName.toString().equals(pp))
                            {
                                cplist.description="true"
                            }
                    }
            }
        }

        return  controllerPermissionList;
    }
}

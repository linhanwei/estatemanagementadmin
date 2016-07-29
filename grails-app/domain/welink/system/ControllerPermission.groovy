package welink.system

/**
 * 每一个 controller 都有一个 permission，这个可以动态增加
 */
class ControllerPermission {

    Long id

    //权限名称
    String title

    /**
     * controller的名字
     */
    String controllerName

    /**
     * 这个controller所对应的权限
     */
    String requirePermissionName

    /**
     * 对controller的描述
     */
    String description

    //该权限是否属于配置范围，1表示show，0表示不show
    Byte showStatus

    Date dateCreated

    Date lastUpdated

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        controllerName indexColumn:[name:'idx_controller_name', unique:true]
    }
}

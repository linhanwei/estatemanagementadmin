package welink.estate
//商品标签对应关系表
class TagItem {
    Long id
    //商品ID
    Long itemId
    //标签ID
    Long tagId
    //是否显示,1表示显示，0表示不显示
    byte showStatus
    //有效1,无效0
    byte status
    // 修改时间
    Date dateCreated
    // 更新时间
    Date lastUpdated

    static constraints = {
    }
    static mapping = {
        id generator: 'identity'
        version(false)
    }
}

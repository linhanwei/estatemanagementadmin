package welink.warehouse

class MikuPclassify {
    //供应商提供商品的分类类目信息
    // 类目编号
    Long id
    // 层级
    Long level = 1
    // 父类的ID
    Long parentId
    // 类目名称
    String name
    // 该类目是否为父类目(即：该类目是否还有子类目)
    Byte isParent = 0 as Byte
    // 备注
    String memo
    // 市场类型（基础服务市场、农产品市场、虚拟市场等）
    Integer market
    // 属性（key-value 列表）
    String features
    // 权重，用来排序
    Integer weight
    // 状态[0删除  1显示  2隐藏]
    Byte status = 1 as Byte
    // 创建时间
    Date dateCreated
    // 修改时间
    Date lastUpdated
    //修改人ID
    Long changeId


    //是否删除
    Byte isDelete=0 as byte

    static mapping = {
        id generator: 'identity'
        version(false)
    }

    static constraints = {
    }
}

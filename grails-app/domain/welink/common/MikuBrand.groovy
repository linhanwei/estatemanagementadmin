package welink.common

class MikuBrand {

    Long id
    //品牌名称
    String name
    //品牌全称
    String fullName
    //所属公司
    String company
    //品牌图片
    String picture
    //品牌描述
    String memo
    //市场类型(备用)
    Long market
    //版本
    String version
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated
    //是否删除
    byte isDeleted

    static mapping = {
        id generator: 'identity'
    }
}

package welink.estate

class Tags {
    Long id
    // tagId
    String tagId
    // 标签名称
    String name
    // 标签的key
    String kv
    // 前端展示图片
    String pic
    // 可以是按位操作的，1限购，2半价，4橱窗，8不支持积分，16时令，32臻品
    Long bit
    // 排序类型1，2，3，4，5
    Integer weight
    // 类型,1000商品展示，1001逻辑处理，2000类目标，3000店铺标，4000用户标
    Integer type
    //有效并且现实2，有效但是不现1，删除0
    byte status
    // 修改时间
    Date dateCreated
    // 更新时间
    Date lastUpdated

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }
}

package welink.common

class Snapshot {
    // snapshot id
    Long id;
    // 交易 id
    Long tradeId
    // 订单 id
    Long orderId
    // 详情
    String detail;
    // 如果放到文件系统里面，就是文件路径
    String detailPath;
    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date lastUpdated
    // 交易修改时间(用户对订单的任何修改都会更新此字段
    Date dateCreated


    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
    }
}

package welink.common

class TradeCourier {

    //记录编号id
    Long id

    //订单ID
    Long tradeId

    //员工ID
    Long employeeId

    //配送点ID
    Long communityId

    //操作类型：1025快递员领单,1026快递员确认收货
    Integer type

    //订单创建时间
    Date tradeCreated

    //订单接收时间
    Date confirmTime

    //订单完成时间
    Date endTime

    //1表示有效，0表示该记录已经无效
    byte status

    //投诉建议时间
    Date dateCreated

    Date lastUpdated

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
    }
}

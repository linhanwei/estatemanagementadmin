package welink.common

class TradeEmployee {

    //记录编号id
    Long id

    //订单ID
    Long tradeId

    //员工ID
    Long employeeId

    //操作类型：1负责配送,2指定配送（调度）,3确认收货,4工作人员备注订单,5回退订单状态，6修改地址,7取消订单
    byte type

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

package welink.warehouse

import groovy.json.internal.Byt


//财务对账表
class MikuPaccoutInfo {
    // 类目编号
    Long id
    //创建时间
    Date dateCreate
    //最终更新的时间
    Date lastUpdate
    //关联订单号
    Long porderId
    //关联的供应商iD
    Long providerId
    //关联的供应商商品Id
    Long pitemId
    //用户实付的金额
    Long utotalFee
    //供应商进行提供的价格
    Long ptotalFee
    //对应的订单号
    Long tradeId
    //标示的状态
    //0代表删除   1有效的对账数据的标示
    Byte status
    //是否撤回 0代表没有撤回  1已经撤回
    Byte isRefund
    //撤回的原因
    String refundReason
    static constraints = {

    }
}

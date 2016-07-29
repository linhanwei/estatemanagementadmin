package welink.warehouse

class MikuOrdersLogistics {

    //多表进行记录着

    //id唯一的标示
    Long id
    Long version
    //物流信息的id
    Long logisticsId
    //订单号
    Long tradeId
    //order表id的集合
    String orderIds
    //物流公司名称
    String wlcompany
    //物流单号
    String wlnumber
    //物流公司简码
    String wlsnumber
    //是否是主流的公司(0不是  1是)
    Byte ismainc
    //用户操作物流状态(-1物流有异常 0未开始  1用户已操作)
    Byte status
//    0：在途，即货物处于运输过程中；
//    1：揽件，货物已由快递公司揽收并且产生了第一条跟踪信息；
//    2：疑难，货物寄送过程出了问题；
//    3：签收，收件人已签收；
//    4：退签，即货物由于用户拒签、超区等原因退回，而且发件人已经签收；
//    5：派件，即快递正在进行同城派件；
//    6：退回，货物正处于退回发件人的途中；
    Byte state
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated
    //额外信息说明
    String memo
    //对应物流号详情信息
    String logicSpecificAddr

    //是否为删除的状态
    Byte isDelete=0 as byte


    //进行对快递推送服务请求
    //签名随机字符串
    String saltCode
    //是否是已经提交推送服务的请求
    Byte istsflag=0 as byte
    //回调的url
    String callbackUrl
    //订阅服务-->返回服务类型
    String dyInfo
    String dyStatus




    static mapping = {
        id generator: 'identity'
    }

    static constraints = {
    }
}

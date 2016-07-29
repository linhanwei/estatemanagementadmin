package welink.business

/**
 * Created by unescc on 2015/10/31.
 */
class OutExcelDetail {



//    订单号
//    外部订单号
//    单据日期
//    买家
//    联系人
//    联系电话
//    快递公司
//    快递物流单号
//    送货地址
//    商品编码
//    商品单价
//    商品数量
//    买家留言
//    买家省份
//    买家城市
//    买家地区
    String tradeid
    String outtradeid
    String createTime
    String buyerid
    String buyerName
    String buyeMobile
    String logisticsCompany
    String logisticsWuLiuCode
    String buyerAddr
    String itemcode
    String itemOnePrice
    String itemNum
    String itemMsg
    String buyerProvince
    String buyerCity
    String buyerArea
    String dataJson
    String orderStrs
    //导入excel的拆单号
    String orderIdStr
    //商品编码
    String code
    //商品brandID
    String brandId


    //品牌
    String brandName
    //商品名称
    String itemName


    //销售价
    String xsprice
    //成本价
    String cbprice
    //平台利润
    String ptlrprice


    //身份证号码
    String idCard

    //拆单商品id
    Long orderId




    //邮费
    Long postFee
    //采购价
    Long cgprice

    //供应商信息
    String providerinof
    //供应商商品名称
    String providerItemName
    //供应商价格
    Long proprice


    //物流公司
    String wlcompany

    //物流订单号
    String wlnumber

}

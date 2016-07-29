package welink.supply

/**
 * Created by lin on 2016/5/11.
 * 供应商商品
 */
class SupplyGoodsInfo {
    //供应商提供的商品信息
    Long id
    // 类目id
    Long pclassifyId
    //类目名称
    String cateName
    // 商品标题
    String title
    // 库存
    Integer num
    // 价格
    Long price
    // 邮费
    Long postFee
    // 商品状态
    Byte status = 1 as Byte
    //brand 进行品牌关联
    Long  brandId
    //isrefund 是否可退换字段  0 为否   1为是
    Byte isrefund=1 as byte
    // 创建时间
    Date dateCreated
    // 修改时间
    Date lastUpdated
    //修改人ID
    Long changeId
    // 备注
    String memo
    // 评价
    String assess
    //物流说明
    String logisticDestrion
    //出库数量
    Integer cknum
    //入库数量
    Integer rknum
    //地区
    String area
    //捆绑供应商item商品的米酷唯一编码
    //每件商品对应
    String pitemCode

    //供应商品编码
    String code

    //进价
    Long jhprice

    //建议销售价
    Long xsprice

    //规格
    String type

    //评分
    Long sumFen
    //评分单数
    Integer numFen


    //绑定大类的类目
    Long classfiId

    //绑定对应的供应商分类ID
    Long providerCateId

    //绑定对应的供应商ID
    Long providerId

    //供应商名称
    String providerName

    //是否已经审核  0 为否   1为是
    Byte isCheck =0 as byte

    //关键字
    String keyword
}

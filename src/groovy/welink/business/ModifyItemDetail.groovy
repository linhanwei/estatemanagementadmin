package welink.business

/**
 * Created by unescc on 2016/1/18.
 */
//修改商品的具体信息
class ModifyItemDetail {
    String id
    String name
    String code
    String categroyName
    String brandName
    String xsPrice
    String cbPrice
    String ptLirun
    String imgInfo


    //新添加的字段
    String ckPrice
    String specification
    String video
    String num
    String baseSoldQuantity
    String description
    String itemAttribute

    //权重的修改
    String weight
    //关键字
    String keyWord


    //是否免税(0不免税  1免税)  【默认不免税】
    Byte isTaxFree
    //是否退货 是否可退换字段  0 为否   1为是 【默认可退货】
    Byte isrefund

    //对免税与退货的说明
    String isTaxFreeInfo
    String isrefundInfo


    //三级类目ID
    String categoryId
    //二级类目ID
    String twocategoryId
    //一级类目ID
    String onwcategoryId

    //采购价
    String cgprice
    //邮费
    String postFee







}

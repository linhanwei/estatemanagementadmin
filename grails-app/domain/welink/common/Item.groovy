package welink.common

import com.alibaba.fastjson.JSON
import com.google.common.collect.Maps
import groovy.transform.ToString
import org.slf4j.Logger
import org.slf4j.LoggerFactory

import javax.annotation.Resource

@ToString
class Item {
    // 商品编号
    Long id
    // 类目
    Long categoryId
    // 商品标题
    String title
    // 卖家Id
    Long sellerId
    // 店铺名称
    Long shopId
    // 卖家类型
    Byte sellerType
    // 商品属性
    String props
    // 用户自行输入的类目属性ID串。结构："pid1,pid2,pid3"，如："20000"（表示品牌） 注：通常一个类目下用户可输入的关键属性不超过1个
    String inputPids
    // 用户自行输入的子属性名和属性值，结构:"父属性值;一级子属性名;一级子属性值;二级子属性名;自定义输入值,....",如：“耐克;耐克系列;科比系列;科比系列;2K5”，input_str需要与input_pids一一对应，注：通常一个类目下用户可输入的关键属性不超过1个。所有属性别名加起来不能超过 3999字节。
    String inputStr
    // 商品数量
    Integer num
    // 上架时间 商品上架开始时间点的毫秒值
    Long onlineStartTime
    // 下架时间 商品活动结束时间点的毫秒值
    Long onlineEndTime
    // 商品新旧程度(全新:new，闲置:unused，二手：second)
    Byte stuffStatus
    // 商品所在地（省市）感觉不是很重要，预留吧
    String address
    // 允许发布小区
    String allowCommunityIds
    // 商品限售小区
    String forbiddenCommunityIds
    // 价格
    Long price
    // 邮费
    Long postFee
    // 支持会员打折,true/false
    Byte hasDiscount
    // 运费承担方式,seller（卖家承担），buyer(买家承担）
    Byte freightPayer
    // 是否有发票,true/false
    Byte hasInvoice
    // 是否有保修,true/false
    Byte hasWarranty
    // 橱窗推荐,true/false
    Byte hasShowcase
    // 加价幅度。如果为0，代表系统代理幅度。 在竞拍中，为了超越上一个出价，会员需要在当前出价上增加金额，这个金额就是加价幅度。卖家在发布宝贝的时候可以自定义加价幅度，也可以让系统自动代理加价。系统自动代理加价的加价幅度随着当前出价金额的增加而增加，我们建议会员使用系统自动代理加价，并请买家在出价前看清楚加价幅度的具体金额。另外需要注意是，此功能只适用于拍卖的商品。 以下是系统自动代理加价幅度表： 当前价（加价幅度 ） 1-40（ 1 ）、41-100（ 2 ）、101-200（5 ）、201-500 （10）、501-1001（15）、001-2000（25）、2001-5000（50）、5001-10000（100） 10001以上 200
    Integer increment
    // 商品状态
    Byte status = 1 as Byte
    // 商品上传后的状态。onsale出售中，instock库中
    Byte approveStatus = 0 as byte
    // 商品图片列表(包括主图)。fields中只设置item_img可以返回ItemImg结构体中所有字段，如果设置为item_img.id、item_img.url、item_img.position等形式就只会返回相应的字段
    String picUrls
    // 商品属性图片列表。fields中只设置prop_img可以返回PropImg结构体中所有字段，如果设置为prop_img.id、prop_img.url、prop_img.properties、prop_img.position等形式就只会返回相应的字段
    String propImgs
    // 虚拟商品的状态字段
    Byte virtual
    // 商品所属卖家的信用等级数，1表示1心，2表示2心……，只有调用商品搜索:taobao.items.get和taobao.items.search的时候才能返回
    Integer score
    // 秒杀商品类型。打上秒杀标记的商品，用户只能下架并不能再上架，其他任何编辑或删除操作都不能进行。如果用户想取消秒杀标记，需要联系小二进行操作。如果秒杀结束需要自由编辑请联系活动负责人（小二）去掉秒杀标记。可选类型 web_only(只能通过web网络秒杀) wap_only(只能通过wap网络秒杀) web_and_wap(既能通过web秒杀也能通过wap秒杀)
    Byte secondKill
    // 商品是否支持拍下减库存:1支持;2取消支持(付款减库存);0(默认)不更改 集市卖家默认拍下减库存; 商城卖家默认付款减库存
    Byte subStock
    // 食品安全信息，包括：生产许可证编号、产品标准号、厂名、厂址等
    String foodSecurity
    // 商品的重量，用于按重量计费的运费模板。注意：单位为kg
    String itemWeight
    // 表示商品的体积，用于按体积计费的运费模板。该值的单位为立方米（m3）。 该值支持两种格式的设置：格式1：bulk:3,单位为立方米(m3),表示直接设置为商品的体积。格式2：weight:10;breadth:10;height:10，单位为米（m）
    String itemSize
    // 已售库存
    Integer soldQuantity
    // 预扣库存，即付款减库存的商品现在有多少处于未付款状态的订单
    Integer withHoldQuantity
    // 预留字段
    String video
    // 商品类型(fixed:一口价;auction:拍卖)注：取消团购
    //    fixed((byte) 1, "一口价"),
    //    cod((byte) 2, "货到付款"),
    //    groupon((byte) 3, "万人团"),
    //    nopaid((byte) 4, "无付款订单"),
    //    pre_auth_type((byte) 5, "预授权0元购机交易"),
    //    one_buy_type((byte) 6, "一元购"),
    //    crowdfund_type((byte) 7, "众筹"),
    //    lotteryDraw_type((byte) 8, "抽奖"),;
    //    join_agency((byte) 9, "成为代理"),
    //    tax_free((byte) 10, "免税产品"),;
    Byte type
    // 图文详情
    String detail
    // 商品描述, 字数要大于5个字符，小于25000个字符
    String description
    // 是否有SKU
    Byte hasSku
    // Sku列表。fields中只设置sku可以返回Sku结构体中所有字段，如果设置为sku.sku_id、sku.properties、sku.quantity等形式就只会返回相应的字段
    String skus
    // 商品属性名称。标识着props内容里面的pid和vid所对应的名称。格式为：pid1:vid1:pid_name1:vid_name1;pid2:vid2:pid_name2:vid_name2……(注：属性名称中的冒号":"被转换为："#cln#"; 分号";"被转换为
    String propsName
    // 商品属性features
    String features
    // 设置是否使用发货时间，商品级别，sku级别
    Byte needDeliveryTime
    // 发货时间类型：绝对发货时间或者相对发货时间
    String deliveryTimeType
    // 商品级别设置的发货时间。设置了商品级别的发货时间，相对发货时间，则填写相对发货时间的天数（大于3）；绝对发货时间，则填写yyyy-mm-dd格式，如2013-11-11
    String deliveryTime
    //
    String specification
    // 如果是复制的商品，会有复制的商品Id
    Long baseItemId
    // 冗余的商品类型
    Byte shopType

    // 创建时间
    Date dateCreated
    // 最后修改时间
    Date lastUpdated

    //UUID 记录每条商品的标示
    String uuid
    //brand 进行品牌关联
    Long  brandId
    //进行商品的编码===>对应的商品的标示编码
    String code
    //商品权重    ===>决定的商品的排序
    Integer weight
    //销售基数    ===>商品销售基数
    Integer baseSoldQuantity
    //是否可退货
    //isrefund 是否可退换字段  0 为否   1为是
    Byte isrefund

    //关键字
    String keyWord

    //是否免税(0不免税  1免税)
    Byte isTaxFree=0 as Byte


    //二级类目ID
    Long category2_id

    //一级类目ID
    Long category1_id

    //采购价
    Long cgprice






    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }


    def messageProcessFacadeService

    def grailsApplication

    @Resource
    def eventTaskExecutor

    def afterUpdate = {
        sendMessage(id, "update")
    }

    def afterInsert = {
        sendMessage(id, "insert")
    }

    static Logger logger = LoggerFactory.getLogger(Item)

    void sendMessage(long itemId, String type) {
        eventTaskExecutor.execute(new Runnable() {
            @Override
            void run() {
                Map<String, String> params = Maps.newHashMap();
                params.put("item_id", String.valueOf(itemId));
                params.put("type", type);

                try {
                    sleep(2000)
                    String message = JSON.toJSONString(params)
                    String topic = grailsApplication.config.ons.item_update.topic
                    messageProcessFacadeService.sendMessage(topic, "item", String.valueOf(itemId), message)
                } catch (Exception e) {
                    logger.error(e.getMessage(), e)
                }
            }
        })
    }
}

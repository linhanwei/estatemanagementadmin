package welink.common

import com.tencent.common.Configure
import com.tencent.common.HttpsRequest
import com.tencent.common.XMLParser
import grails.transaction.Transactional
import welink.business.MikuReturnGoodsDetail
import welink.business.ModifyItemDetail
import welink.business.ReportTransferData
import welink.estate.ObjectTagged
import welink.user.Profile

@Transactional
class CopyItemService {

    //进行copy对应的Item数据
    def copyItemToFzNewItem(item)
    {
        Long cityId = Shop.findById(item.shopId).cityId
        Shop.findAllByCityIdAndTypeAndStatus(cityId, 1 as byte, 1 as byte).each {
            Shop stationShop ->
                copyCityItemToStationItem(item, stationShop)
        }
    }

    //进行对商品进行批量修改
    @Transactional
    def modifySomeItemInfo(ModifyItemDetail modifyItemDetail)
    {
        Item item=Item.findById(Long.parseLong(modifyItemDetail.id))
        if (item)
        {
            def map = [:]
            Category category=new Category()
            MikuBrand mikuBrand=new MikuBrand()
            //成本价
            Long purchasingPrice =new BigDecimal(modifyItemDetail.cbPrice)*100L
            //平台利润
            Long itemProfitFee=new BigDecimal(modifyItemDetail.ptLirun)*100L
            //销售价
            Long xsPrice=new BigDecimal(modifyItemDetail.xsPrice)*100L
            //参考价
            Long jyPrice=(modifyItemDetail.ckPrice)?(new BigDecimal(modifyItemDetail.ckPrice)*100L):(xsPrice*1.5)
            //可分利润
            Long kfLiRun=(xsPrice-purchasingPrice-itemProfitFee)
            //库存
            Integer num=Integer.parseInt(modifyItemDetail.num)



            //具体里面的参数
            def obj=com.alibaba.fastjson.JSON.parse(item.features)
            //类目的修改
            if (modifyItemDetail.categroyName){
                category=Category.findByName(modifyItemDetail.categroyName)
            }
            //品牌的修改
            if (modifyItemDetail.brandName){
                mikuBrand=MikuBrand.findByName(modifyItemDetail.brandName)
            }

            if (obj){
                //里面的参数【map中的ext里面的内容】
                def content=obj.get('ext')
                map.put('ext',com.alibaba.fastjson.JSON.parseObject(modifyItemDetail.itemAttribute?modifyItemDetail.itemAttribute:""))
                map.put('referencePrice',jyPrice)
                map.put('purchasingPrice',purchasingPrice)
            }
            //A.修改的是商品本身的信息
            item.with {
                it.title=modifyItemDetail.name
                it.code=modifyItemDetail.code
                it.lastUpdated=new Date()
                //销售价
                it.price=xsPrice
                it.features=com.alibaba.fastjson.JSON.toJSONString(map)
                //仓库中的商品进行显示，上架中商品进行下架
                it.approveStatus= 0 as byte
                //视频链接
                it.video=modifyItemDetail.video
                //规格
                it.specification=modifyItemDetail.specification?modifyItemDetail.specification:it.specification
                //库存
                if (num){
                    it.num=num
                }
                //销售基数
                if (modifyItemDetail.baseSoldQuantity){
                    it.baseSoldQuantity=Integer.parseInt(modifyItemDetail.baseSoldQuantity)
                }
                //商品描述
                it.description=modifyItemDetail.description
                if (category)
                {
                    it.categoryId=category.id
                }
                if (mikuBrand){
                    it.brandId=mikuBrand.id
                }
                it.save(failOnError: true, flush: true)
            }
            //在上架对应的商品
            Item baseItem=Item.findById(item.baseItemId)
            if (baseItem){
                baseItem.with {
                    it.title=modifyItemDetail.name
                    it.code=modifyItemDetail.code
                    it.lastUpdated=new Date()
                    //销售价
                    it.price=new BigDecimal(modifyItemDetail.xsPrice)*100L
                    it.features=com.alibaba.fastjson.JSON.toJSONString(map)
                    //仓库中的商品进行显示，上架中商品进行下架
                    it.approveStatus= 0 as byte
                    //视频链接
                    it.video=modifyItemDetail.video
                    //规格
                    it.specification=modifyItemDetail.specification?modifyItemDetail.specification:it.specification
                    //库存
                    if (num){
                        it.num=num
                    }
                    //销售基数
                    if (modifyItemDetail.baseSoldQuantity){
                        it.baseSoldQuantity=Integer.parseInt(modifyItemDetail.baseSoldQuantity)
                    }
                    //商品描述
                    it.description=modifyItemDetail.description
                    if (category)
                    {
                        it.categoryId=category.id
                    }
                    if (mikuBrand){
                        it.brandId=mikuBrand.id
                    }
                    it.save(failOnError: true, flush: true)
                }
                //再进行改分润信息表里面的内容【直接改对应的分润信息表的内容】
                MikuItemSharePara mkitemshare =MikuItemSharePara.findByItemId(baseItem.id)
                if (mkitemshare){
                    mkitemshare.with {
                        //平台利润
                        it.itemProfitFee=itemProfitFee
                        //成本价
                        it.itemCostFee=purchasingPrice
                        //可分利润
                        it.itemShareFee=kfLiRun
                        it.dateCreated=new Date()
                        it.save(failOnError: true, flush: true)
                    }
                }
            }
        }
    }


    @Transactional
    def copyCityItemToStationItem(Item source, Shop targetStationShop) {
        Item newItem = Item.findOrCreateByShopIdAndBaseItemId(targetStationShop.id, source.id)
        if (!newItem)
        {
            newItem=new Item()
        }
        newItem = Item.findOrCreateByShopIdAndBaseItemId(targetStationShop.id, source.id)?.with {
            it.categoryId = source?.categoryId
            it.title = source?.title
            it.sellerId = targetStationShop?.sellerId
            it.sellerType = targetStationShop?.sellerType
            it.address = source?.address
            it.specification = source?.specification
            it.video = source?.video
            it.price = source?.price
            it.features = source?.features
            it.onlineStartTime = source?.onlineStartTime
            it.onlineEndTime = source?.onlineEndTime
            it.type = source?.type
            it.picUrls = source?.picUrls
            it.detail = source?.detail
            it.baseSoldQuantity=source?.baseSoldQuantity
            it.weight = source?.weight
            it.description = source?.description
            //复制的核心，店铺ID，商品编号，店铺等级
            it.shopId = targetStationShop?.id
            it.shopType = targetStationShop?.type
            it.baseItemId = source?.id
            it.approveStatus =  1 as byte
            it.num = source?.num
            it.price = source?.price
            it.brandId = source?.brandId
            it.code = source?.code
            //是否可退货
            it.isrefund=source?.isrefund
            //关键字
            it.keyWord=source?.keyWord
            //是否免税
            it.isTaxFree=source?.isTaxFree
            //3级类目
            it.category1_id=source?.category1_id
            it.category2_id=source?.category2_id
            //邮费
            it.postFee=source?.postFee
            it.cgprice=source?.cgprice

            save(failOnError: true, flush: true)
        }

        // tag 复制
        ObjectTagged.findAllByArtificialIdAndTypeBetween(source.id, 999, 1999)?.each {
            ObjectTagged objectTagged ->
                ObjectTagged.findOrCreateByArtificialIdAndTagId(newItem.id, objectTagged.tagId)?.with {
                    it.artificialId = newItem.id
                    it.type = objectTagged?.type
                    it.kv = objectTagged?.kv
                    it.status = objectTagged?.status
                    it.startTime = objectTagged?.startTime
                    it.endTime = objectTagged?.endTime
                    it.tagId = objectTagged?.tagId
                    it.activityNum=objectTagged?.activityNum
                    it.activitySoldNum=objectTagged?.activitySoldNum
                    save(failOnError: true, flush: true)
                }
        }
    }


    //根据退款单信息来获取对应的详细信息
    def getmikureturnInfo(MikuReturnGoods mikuReturnGoods){
        MikuReturnGoodsDetail mikuReturnGoodsDetail=new MikuReturnGoodsDetail()
        mikuReturnGoodsDetail.id=mikuReturnGoods.id
        mikuReturnGoodsDetail.tradeId=mikuReturnGoods.tradeId
        mikuReturnGoodsDetail.orderId=mikuReturnGoods.orderId
        mikuReturnGoodsDetail.num=mikuReturnGoods.num
//        mikuReturnGoodsDetail.agencyId=mikuReturnGoods.agencyId
//        mikuReturnGoodsDetail.shareFee=mikuReturnGoods.shareFee
//        mikuReturnGoodsDetail.point=mikuReturnGoods.point
        mikuReturnGoodsDetail.artificialId=mikuReturnGoods.artificialId
        mikuReturnGoodsDetail.buyerId=mikuReturnGoods.buyerId
//        mikuReturnGoodsDetail.name=mikuReturnGoods.name
        mikuReturnGoodsDetail.picUrl=mikuReturnGoods.picUrl
        mikuReturnGoodsDetail.price=mikuReturnGoods.price
        mikuReturnGoodsDetail.totalFee=mikuReturnGoods.totalFee
        mikuReturnGoodsDetail.refundFee=mikuReturnGoods.refundFee
//        mikuReturnGoodsDetail.sellerId=mikuReturnGoods.sellerId
//        mikuReturnGoodsDetail.sellerType=mikuReturnGoods.sellerType
        mikuReturnGoodsDetail.status=mikuReturnGoods.status
        mikuReturnGoodsDetail.timeoutActionTime=mikuReturnGoods.timeoutActionTime
//        mikuReturnGoodsDetail.endTime=mikuReturnGoods.endTime
        mikuReturnGoodsDetail.title=mikuReturnGoods.title
        mikuReturnGoodsDetail.dateCreated=mikuReturnGoods.dateCreated
        mikuReturnGoodsDetail.lastUpdated=mikuReturnGoods.lastUpdated
        mikuReturnGoodsDetail.consignTime=mikuReturnGoods.consignTime
        mikuReturnGoodsDetail.consigneeId=mikuReturnGoods.consigneeId
        mikuReturnGoodsDetail.buyerMemo=mikuReturnGoods.buyerMemo
        mikuReturnGoodsDetail.sellerMemo=mikuReturnGoods.sellerMemo
        mikuReturnGoodsDetail.finishTime=mikuReturnGoods.finishTime
        mikuReturnGoodsDetail.returnReason=mikuReturnGoods.returnReason
        mikuReturnGoodsDetail.reqExamine=mikuReturnGoods.reqExamine
        mikuReturnGoodsDetail.receiptTime=mikuReturnGoods.receiptTime
        mikuReturnGoodsDetail.isSubsidy=mikuReturnGoods.isSubsidy
        mikuReturnGoodsDetail.subsidyFee=mikuReturnGoods.subsidyFee
        mikuReturnGoodsDetail.tradeStatus=mikuReturnGoods.tradeStatus

        //地址的查询
        ConsigneeAddr consigneeAddr=ConsigneeAddr.findById(mikuReturnGoods.consigneeId)
        if (consigneeAddr){
            String address=(consigneeAddr.receiverState+consigneeAddr.receiverCity+consigneeAddr.receiverDistrict+consigneeAddr.receiverAddress)
            mikuReturnGoodsDetail.consigneeAddress=address
        }
        //用户的姓名+mobile
        Profile profile=Profile.findById(mikuReturnGoods.buyerId)
        if (profile){
            mikuReturnGoodsDetail.buyername=profile.nickname
            mikuReturnGoodsDetail.buyermobile=profile.mobile
        }
        //移动设备标示
        Trade trade = Trade.findByTradeId(mikuReturnGoods.tradeId)
        if (trade){
            mikuReturnGoodsDetail.tradeFrom=trade.tradeFrom
        }
        //品牌
        Item item=Item.findById(mikuReturnGoods.artificialId)
        if (item){
            MikuBrand brand=MikuBrand.findById(item.brandId)
            if (brand){
                mikuReturnGoodsDetail.brandName=brand.name
            }
        }
        //是否过期的说明
        if (trade.timeoutActionTime>new Date())
        {
            mikuReturnGoodsDetail.timeOutStatement="退货限期内"
            mikuReturnGoodsDetail.ispassDate= 1 as byte
        }
        else
        {
            mikuReturnGoodsDetail.timeOutStatement="已过期"
            mikuReturnGoodsDetail.ispassDate= 0 as byte
        }
        //

        return mikuReturnGoodsDetail
    }


    def wxRefundToMoneyConfig() {
        Configure configure=new Configure();
        configure.setAppID("wx82d4b04a531ac1a3");
        configure.setCertPassword("1242526802");
        configure.setCertLocalPath("D:/cert/apiclient_cert.p12");
        configure.setIp("121.26.217.212");
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1242526802");
        configure.setSubMchID("");
    }

    //进行基本配置的参数的配置
    def getInfo(String url,ReportTransferData reportTransferData) throws Exception{
        HttpsRequest httpsRequest=new HttpsRequest();
        return httpsRequest.sendPost(url, reportTransferData);
    }



    def  wxRefundToMoneyToDo(){
        //配置前需要做的事情
        wxRefundToMoneyConfig()
        //传入对应的信息
        ReportTransferData reportTransferData=new ReportTransferData()
        String url="https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
        String str=getInfo(url, reportTransferData);
        System.out.println(str);
//        Map<String,Object> xmlObj=XMLParser.getMapFromXML(str);
//        System.out.println(xmlObj.get("return_code"));
    }
}

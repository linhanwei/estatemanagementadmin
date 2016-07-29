package welink.common

import com.alibaba.fastjson.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import welink.business.ItemDetailData
import welink.business.OutExcelDetail
import welink.estate.ObjectTagged
import welink.estate.Tags

@Transactional
class OutExcelShopItemService {

    def outAllData(Byte type){
        //全部的上架的商品信息进行excel导出
        List<Item> shopItems=new ArrayList<Item>()
        if (type == 1 as byte){
            shopItems=Item.findAllByShopIdAndTypeNotEqual(999L,7 as byte)
        }else{
            shopItems=Item.findAllByStatusAndApproveStatusAndShopTypeAndTypeNotEqual(1 as byte,1 as byte,1 as byte,7 as byte)
        }

        List<ItemDetailData> iList=new ArrayList<ItemDetailData>()
        shopItems.each {
            Item item->
                ItemDetailData data=new ItemDetailData()
                data.id=item.id
                data.num=item.num
                data.code=item.code
                data.title=item.title
                //关键字
                data.keyWord=item.keyWord
                data.price=item.price?item.price/100f:item.price
                //类目
                if (item.categoryId){
                    def  oneCategory=Category.findById(item.categoryId);
                    if (oneCategory){
                        data.categoryIdName=oneCategory.name
                    }
                }
                //品牌
                if (item.brandId){
                    def oneBrand=MikuBrand.findById(item.brandId)?MikuBrand.findById(item.brandId):new MikuBrand()
                    data.brandName=oneBrand.name
                    data.brandCompanyName=oneBrand.company
                }
                //成本价
                data.cbprice=(JSON.parseObject(item?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f
                data.ptlirun=0

                //平台利润
                MikuItemSharePara mikuItemSharePara=MikuItemSharePara.findByItemId(item.baseItemId)
                if (mikuItemSharePara){
                    data.ptlirun=mikuItemSharePara.itemProfitFee?mikuItemSharePara.itemProfitFee/100f:0
                }

                //图片信息
                data.picUrls=item.picUrls?item.picUrls.split(";")[0]:item.picUrls

                //其他信息的获取
                //规格
                data.specification=item.specification
                //具体的参数
                data.features=item.features
                //视频链接
                data.video=item.video
                //销售基数
                data.baseSoldQuantity=item.baseSoldQuantity
                //库存
                data.num=item.num
                //商品描述
                data.description=item.description
                //参考价
                data.ckPrice=(JSON.parseObject(item?.features)?.getLongValue('referencePrice') ?: 0) / 100f
                //详情的属性
                data.itemAttribute=(JSON.parseObject(item?.features)?.getString('ext'))
                //权重
                data.weight=item.weight?item.weight:0
                //已销库存
                data.soldQuantity=item.soldQuantity?item.soldQuantity:0

                //是否可退货
                data.isrefundInfo=(item.isrefund==1 as byte)?"是":"否"
                //是否免税
                data.isTaxFreeInfo=(item.isTaxFree==1 as byte)?"是":"否"

                //对应商品具有的标
                data=getItemOfTags(data)


                //采购价
                data.cgprice=item.cgprice?(item.cgprice/100f):0
                //邮费
                data.postFee=item.postFee?(item.postFee/100f):0
                //1级类目
                data.category1_id=item.category1_id
                //1级类目
                if (item.category1_id){
                    def  oneCategory1=Category.findById(item.category1_id);
                    if (oneCategory1){
                        data.category1Name=oneCategory1.name
                    }
                }
                //2级类目
                data.category2_id=item.category2_id
                //1级类目
                if (item.category2_id){
                    def  oneCategory2=Category.findById(item.category2_id);
                    if (oneCategory2){
                        data.category2Name=oneCategory2.name
                    }
                }
                //3级类目
                data.categoryId=item.categoryId
                //类目
                if (item.categoryId){
                    def  oneCategory3=Category.findById(item.categoryId);
                    if (oneCategory3){
                        data.category3Name=oneCategory3.name
                    }
                }
                //搜索关键字
                data.keyWord=item.keyWord

                iList.add(data)
        }
        return  iList
    }


    def outSomeItemInfo(List<String> idlist){
        List<ItemDetailData> iList=new ArrayList<ItemDetailData>()
        for (int i=0;i<idlist.size();i++){
            Long id=Long.parseLong(idlist.get(i))
            Item item=Item.findById(id)
            if (item){
                ItemDetailData data=new ItemDetailData()
                data.id=item.id
                data.num=item.num
                data.code=item.code
                data.title=item.title
                //关键字
                data.keyWord=item.keyWord
                data.price=item.price?item.price/100f:item.price

                //品牌
                if (item.brandId){
                    def oneBrand=MikuBrand.findById(item.brandId)?MikuBrand.findById(item.brandId):new MikuBrand()
                    data.brandName=oneBrand.name
                    data.brandCompanyName=oneBrand.company
                }
                //成本价
                data.cbprice=(JSON.parseObject(item?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f
                data.ptlirun=0

                //平台利润
                MikuItemSharePara mikuItemSharePara=MikuItemSharePara.findByItemId(item.baseItemId)
                if (mikuItemSharePara){
                    data.ptlirun=mikuItemSharePara.itemProfitFee?mikuItemSharePara.itemProfitFee/100f:0
                }

                //图片信息
                data.picUrls=item.picUrls?item.picUrls.split(";")[0]:item.picUrls
                //其他信息的获取
                //规格
                data.specification=item.specification
                //具体的参数
                data.features=item.features
                //视频链接
                data.video=item.video
                //销售基数
                data.baseSoldQuantity=item.baseSoldQuantity
                //库存
                data.num=item.num
                //商品描述
                data.description=item.description
                //参考价
                data.ckPrice=(JSON.parseObject(item?.features)?.getLongValue('referencePrice') ?: 0) / 100f
                //详情的属性
                data.itemAttribute=(JSON.parseObject(item?.features)?.getString('ext'))
                //权重
                data.weight=item.weight?item.weight:0
                //已销库存
                data.soldQuantity=item.soldQuantity?item.soldQuantity:0

                //是否可退货
                data.isrefundInfo=(item.isrefund==1 as byte)?"是":"否"
                //是否免税
                data.isTaxFreeInfo=(item.isTaxFree==1 as byte)?"是":"否"


                //采购价
                data.cgprice=item.cgprice?(item.cgprice/100f):0
                //邮费
                data.postFee=item.postFee?(item.postFee/100f):0
                //1级类目
                data.category1_id=item.category1_id
                //1级类目
                if (item.category1_id){
                    def  oneCategory1=Category.findById(item.category1_id);
                    if (oneCategory1){
                        data.category1Name=oneCategory1.name
                    }
                }
                //2级类目
                data.category2_id=item.category2_id
                //1级类目
                if (item.category2_id){
                    def  oneCategory2=Category.findById(item.category2_id);
                    if (oneCategory2){
                        data.category2Name=oneCategory2.name
                    }
                }
                //3级类目
                data.categoryId=item.categoryId
                //类目
                if (item.categoryId){
                    def  oneCategory3=Category.findById(item.categoryId);
                    if (oneCategory3){
                        data.category3Name=oneCategory3.name
                    }
                }
                //搜索关键字
                data.keyWord=item.keyWord

                data=getItemOfTags(data)



                iList.add(data)
            }
        }
        return  iList
    }





    //对应的商品进行标集合说明
    def getItemOfTags(ItemDetailData data){
        //非标品  热卖品  其他标
        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(data.id, 1 as byte)
        String fbp,rmp,qtp=""
        int i=0
        tagsOnShow.each {
            ObjectTagged obj->
                Tags tags=Tags.findById(obj.tagId)
                if(tags){
                    if("非标品".equals(tags.name)){
                        fbp="1"
                    }
                    else if ("热卖品".equals(tags.name)){
                        rmp="1"
                    }else{
                        if (tags.name){
                            i++
                            qtp+=tags.name
                            qtp+="  "
                        }
                    }
                }
        }
        data.tagFbpinfo=(fbp=="1")?"1":"0"
        data.tagQtbinfo=qtp
        data.tagRmpinfo=(rmp=="1")?"1":"0"
        return  data
    }



}

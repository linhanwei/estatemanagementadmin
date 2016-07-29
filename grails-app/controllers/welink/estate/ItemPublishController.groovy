package welink.estate

import com.baidu.ueditor.define.BaseState
import com.baidu.ueditor.define.State
import com.google.common.base.Preconditions
import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import com.welink.buy.utils.Constants
import grails.converters.JSON
import org.apache.commons.io.FilenameUtils
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.codehaus.groovy.grails.web.json.JSONObject
import org.joda.time.DateTime
import org.springframework.web.multipart.MultipartFile
import welink.common.*
import welink.user.Employee

import javax.annotation.Resource

import static com.google.common.base.Preconditions.checkNotNull

class ItemPublishController {

    @Resource
    UEditorService uEditorService

    def fileUploadService

    def copyItemService


    static ImmutableMap<String, String> ITEM_TYPE = ImmutableMap.builder() //
            .put("9", "成为代理")
            .put("10", "刮刮卡")
//            .put("10", "免税产品")
            .build()

    static ImmutableMap<String, String> All_ITEM_TYPE = ImmutableMap.builder() //
            .put("1", "正常商品")
            .put("9", "成为代理")
            .put("10", "刮刮卡")
            .put("12", "定制商品")
            .build()

    def index() {

        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)

        Purchase purchase = Purchase.findById(params?.purchaseId)

        //查出对应的Brand
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)

        def tags = Tags.findAllByTypeAndStatus(1, 1)

        render(view: 'index', model: [
                tags        : tags,
                purchase    : purchase,
                categoryList: categoryList,
                itemTypeList: ITEM_TYPE,
                mikuBrandList:mikuBrandList
        ])

    }

    def edit() {
        Item item

        Purchase purchase

        Long itemId = params.long('id')

        def tags = Tags.findAllByTypeAndStatus(1, 1)

        def oldTags

        Tags oldTag

        if (TagItem.findByItemIdAndStatusAndShowStatus(itemId, 1 as byte, 0 as byte)) {
            def TagItemList = TagItem.findAllByItemIdAndStatusAndShowStatus(itemId, 1 as byte, 0 as byte)
            oldTags = Tags.withCriteria {
                'in'("id", TagItemList*.tagId)
                eq("type", 1 as byte)
                eq("status", 1 as byte)
            }
            if (oldTags) {
                oldTag = oldTags.get(0)
            }
        }

        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)

        if (params.purchaseId) {
            if (ItemAndPurchase.findByPurchaseIdAndStatus(params.long('purchaseId'), 1 as byte)) {
                item = Item.findById(ItemAndPurchase.findByPurchaseIdAndStatus(params.long('purchaseId'), 1 as byte).itemId)
            }
            purchase = Purchase.findById(params.long('purchaseId'))
        } else {
            item = Item.findByShopIdAndId(999L, itemId)
            if (item && ItemAndPurchase.findByItemIdAndStatus(item.id, 1 as byte)) {
                purchase = Purchase.findById(ItemAndPurchase.findByItemIdAndStatus(item.id, 1 as byte).purchaseId)
            }
        }

        def itemAssociations = ItemAssociation.findAllByItemIdAndStatus(itemId, 1 as byte)

        ArrayList<Item> associationItems = Item.withCriteria {
            notEqual("approveStatus", -1 as byte)
            if (itemAssociations) {
                'in'("id", itemAssociations*.targetId)
            } else {
                eq('id', -1L)
            }
        }

        //进行拿分润的数据
        MikuItemSharePara onemsp=MikuItemSharePara.findByItemId(itemId)
        //Brand获取
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)



        render(view: 'edit', model: [
                oldTag          : oldTag,
                tags            : tags,
                purchase        : purchase,
                item            : item,
                parentId        : item.category1_id,
                twoparentId     : item.category2_id,
                threeparentId   : item.categoryId,
                categoryList    : categoryList,
                itemSharePara   : onemsp,
                associationItems: associationItems*.title,
                itemTypeList: All_ITEM_TYPE,
                mikuBrandList:mikuBrandList
        ])
    }

    def categorySelect() {

    }


    def changeEveryItemFeatures()
    {
        List<Item> Ilist=Item.findAll()
        Ilist.each {
            item->
                def obj=com.alibaba.fastjson.JSON.parse(item.features)
                if (obj)
                {
                    def content=obj.get('ext')
                    def map = [:]
                    def hashMap = [:]
                    map.put('purchasingPrice',obj.get('purchasingPrice'))
                    map.put('referencePrice', obj.get('referencePrice'))
                    hashMap.put("特别说明",content['品牌']);
                    hashMap.put("功效",content['功效']);
                    hashMap.put("保质期",content['保质期']);
                    hashMap.put("适用人群",content['适用人群']);
                    map.put('ext', hashMap)
                    String f = com.alibaba.fastjson.JSON.toJSONString(map)

                    item.features=f
                    item.save(failOnError: true, flush: true)
                }
        }
        render("true")
    }

    def publish() {

        withForm {
            String title = params.title
            //3级的分类
            Long oneLevel=params.long('level1Category')
            Long twoLevel = params.long('category')
            Long threeLevel=params.long('level3Category')
            //邮费与成本价
            Long newcbprice=new BigDecimal(params.newcgprice) * 100L
            Long postFee=new BigDecimal(params.postFee) * 100L

            List<String> itemPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
            List<String> detailPics = params.'detail-pic' ? Lists.newArrayList(params.'detail-pic') : Collections.emptyList()
            String description = params.description
            String storage = params.storage
            String taste = params.taste
            String warning = params.warning
            String address = params.address
            Byte type=params.byte('type')
            String specification = params.specification
            Long purchasingPrice = new BigDecimal(params.purchasingPrice) * 100L
            Long referencePrice = new BigDecimal(params.referencePrice) * 100L
            Long price = new BigDecimal(params.price) * 100L
            Long itemNum=params.long('num')
            if (!itemNum){
                itemNum=0
            }
            String video = params.video
            //添加对应权重
            Integer weight = params.int('weight')
            //商品销售基数
            Integer soldquantity=params.int('soldquantity')
            if (!soldquantity){
                soldquantity=0
            }

            //关联分润表
            UUID uuid = UUID.randomUUID()
            String itemShareFee=params.long('itemShareFee')
            String itemProfitFee=params.long('itemProfitFee')
            String frJson=params.frJson

            //新添加的2个值：商品编码 品牌id
            String code=params.code
            Long brandid=params.long('brandId')

            //添加新字段:是否可退货
            Byte isrefund=params.isrefund?1 as byte:0 as byte

            String pingpai=params.pingpai;
            String gongxiao=params.gongxiao;
            String baozhiqi=params.baozhiqi;
            String adpterpersons=params.adpterpersons;

            String descriptionjson=params.descriptionjson
            def descriptionmap=com.alibaba.fastjson.JSON.parseObject(descriptionjson)


            // 自营店铺，用来送菜
            Shop shop = Shop.findById(999L)
            Long sellerId = 999L;
            byte sellerType = 2 as byte

            // 店铺肯定得存在的
            Preconditions.checkNotNull(shop, "the shop should not be null ...")
            def map = [:]
            def hashMap = [:]
            map.put('purchasingPrice', purchasingPrice.toString())
            map.put('referencePrice', referencePrice.toString())
            map.put('ext', descriptionmap)

            String f = com.alibaba.fastjson.JSON.toJSONString(map)

            Long id = params.id ? params.long('id') : null
            Item item = id ? Item.findByShopIdAndId(999L, id) : new Item()
            item.with {
                //一级
                it.category1_id = oneLevel
                //二级
                it.category2_id = twoLevel
                //三级
                it.categoryId = threeLevel
                //采购价
                it.cgprice=newcbprice
                //邮费
                it.postFee=postFee
                it.title = StringUtils.trimToEmpty(title)
                it.shopId = shop.id
                it.shopType=shop.type
                it.sellerId = sellerId
                it.sellerType = sellerType
                it.address = address
                it.specification = specification
                it.video = video
                it.price = price
                it.features = f
                it.weight=weight
                it.num=itemNum
                it.isrefund=isrefund
                it.baseSoldQuantity=soldquantity
                if (type){
                    it.type = type
                }else{
                    it.type =1 as byte
                }
                //搜索关键字
                it.keyWord=params.keyWord?params.keyWord:""
                //发布完上架
                if (params.makeOnSale) {
                    if (params.num) {
                        it.onlineStartTime = System.currentTimeMillis()
                        it.onlineEndTime = new DateTime().plusYears(20).toDate().time
                        it.num = itemNum
                        it.approveStatus = Constants.ApproveStatus.ON_SALE.approveStatusId
                    }
                } else {
                    it.approveStatus = Constants.ApproveStatus.IN_STOCK.approveStatusId
                }
                it.picUrls = StringUtils.join(itemPics, ';')
                it.detail = StringUtils.join(detailPics, ';')
                it.description = description
                //分润表
                it.uuid=uuid
                //商品编码
                it.code=code
                //商品brandid
                it.brandId=brandid
                //是否免税
                if (params.isTaxFree){
                    it.isTaxFree= 1 as byte
                }
            }
            item.save(failOnError: true, flush: true)

            //进行对分润配置表数据的添加
//            Item newit=Item.findByUuid(uuid)
            Subject currentUser = SecurityUtils.getSubject()
            String name=currentUser.principals.toString()
            def user = Employee.findByUsername(name)

            //是否上架关联到分站点copy
            if (params.makeOnSale && params.num)
            {
                copyItemService.copyItemToFzNewItem(item)
            }


            Long itemShareParaId = params.itemShareParaId ? params.long('itemShareParaId') : null
            MikuItemSharePara mkitemshare = itemShareParaId ? MikuItemSharePara.findById(itemShareParaId) : new MikuItemSharePara()
            mkitemshare.with {
                it.itemCostFee=new BigDecimal(params.purchasingPrice)*100L
                it.itemProfitFee=new BigDecimal(params.itemProfitFee)*100L
                it.itemShareFee=new BigDecimal(params.itemShareFee)*100L
                it.itemId=item.id
                it.schemeName=item.title
                it.parameter="[{\"id\":1,\"value\":\"4.8\",\"title\":\"一度\"},{\"id\":2,\"value\":\"4.8\",\"title\":\"二度\"},{\"id\":3,\"value\":\"6.4\",\"title\":\"三度\"},{\"id\":4,\"value\":\"8\",\"title\":\"四度\"},{\"id\":5,\"value\":\"8\",\"title\":\"五度\"},{\"id\":6,\"value\":\"8\",\"title\":\"六度\"},{\"id\":7,\"value\":\"8\",\"title\":\"七度\"},{\"id\":8,\"value\":\"32\",\"title\":\"八度\"},{\"id\":9,\"value\":\"1\",\"title\":\"CEO4\"},{\"id\":10,\"value\":\"6\",\"title\":\"CEO3\"},{\"id\":11,\"value\":\"12\",\"title\":\"CEO2\"},{\"id\":12,\"value\":\"20\",\"title\":\"CEO1\"}]"
//                if(type==9){
//                    it.parameter="[{\"id\":13,\"value\":\"40\",\"title\":\"CEO1\"},{\"id\":14,\"value\":\"24\",\"title\":\"CEO2\"},{\"id\":15,\"value\":\"12\",\"title\":\"CEO3\"},{\"id\":16,\"value\":\"2\",\"title\":\"CEO4\"},{\"id\":17,\"value\":\"60\",\"title\":\"CEO5\"}]"
//                }else {
//                    it.parameter="[{\"id\":1,\"value\":\"4.8\",\"title\":\"一度\"},{\"id\":2,\"value\":\"4.8\",\"title\":\"二度\"},{\"id\":3,\"value\":\"6.4\",\"title\":\"三度\"},{\"id\":4,\"value\":\"8\",\"title\":\"四度\"},{\"id\":5,\"value\":\"8\",\"title\":\"五度\"},{\"id\":6,\"value\":\"8\",\"title\":\"六度\"},{\"id\":7,\"value\":\"8\",\"title\":\"七度\"},{\"id\":8,\"value\":\"32\",\"title\":\"八度\"},{\"id\":9,\"value\":\"1\",\"title\":\"CEO4\"},{\"id\":10,\"value\":\"6\",\"title\":\"CEO3\"},{\"id\":11,\"value\":\"12\",\"title\":\"CEO2\"},{\"id\":12,\"value\":\"20\",\"title\":\"CEO1\"}]"
//                }
//                it.parameter=frJson
                it.creatorId=user.id
                it.dateCreated=new Date()
                it.isDisable=0 as byte
                it.save(failOnError: true, flush: true)
            }


//            商品的进货关联
//            if (params.purchaseId) {
//                if (ItemAndPurchase.findByItemIdAndPurchaseIdAndStatus(item?.id, params.long('purchaseId'), 1 as byte)) {
//
//                } else {
//                    def ipp = ItemAndPurchase.findAllByItemIdAndStatus(item.id, 1)
//                    ipp.iterator().each {
//                        ItemAndPurchase itemAndPurchase ->
//                            itemAndPurchase.status = 0
//                            itemAndPurchase.save(failOnError: true, flush: true)
//                    }
//                    new ItemAndPurchase(purchaseId: params.long('purchaseId'),
//                            itemId: item.id, status: 1 as byte).save(failOnError: true)
//                }
//            }
            redirect(controller: 'itemInStock', action: 'index')
            return;
        }.invalidToken {

            // bad request
            response.status = 405
        }

    }

    def handle() {

        Long communityId = -1

        def action = request.getParameter('action')

        if ('config' == action) {
            forward(action: 'config')
        } else if (action.startsWith('upload')) {
            JSONObject jsonConfig = Preconditions.checkNotNull(uEditorService, 'uEditorService').standard()

            String rootPath = servletContext.getRealPath("/");

            MultipartFile file = (MultipartFile) request.getFile('upfile')

            if (file == null) {
                file = (MultipartFile) request.getFile('file')
            }

            checkNotNull(file)

            // 上传的原图文件名
            def originalName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(System.getProperty("file.separator")) + 1)

            String yunPath = fileUploadService.upload(communityId, "ITEM-PUBLISH", 0, 0, 0, originalName, file.getInputStream(), null)

            State storageState = new BaseState(true)

            storageState.putInfo("url", yunPath);
            storageState.putInfo("type", FilenameUtils.getExtension(yunPath));
            storageState.putInfo("original", FilenameUtils.getName(yunPath));

            println('上传图片的内容:' + storageState.toJSONString())
            render storageState.toJSONString()
        } else {
            response.sendError(HttpURLConnection.HTTP_INTERNAL_ERROR)
        }

    }

    def config() {
        render Preconditions.checkNotNull(uEditorService, 'uEditorService').standard() as JSON
    }

    /**
     * 依据原始文件名生成新文件名
     * @return
     */
    private String getName(String fileName, String userSpace) {
        if (userSpace) {
            return fileName = userSpace + '/' + System.currentTimeMillis() + "_" + fileName
        } else {
            Random random = new Random()
            return fileName = Integer.toHexString(random.nextInt(256)) + '/' + System.currentTimeMillis() + "_" + fileName
        }
    }

}

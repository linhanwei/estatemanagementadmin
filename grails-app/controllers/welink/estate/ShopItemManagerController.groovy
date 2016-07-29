package welink.estate

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import com.welink.buy.utils.Constants
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.joda.time.DateTime
import welink.business.FenRun
import welink.business.ItemDetailData
import welink.business.MikuReturnGoodsDetail
import welink.common.Category
import welink.common.Item
import welink.common.MikuBrand
import welink.common.MikuItemSharePara
import welink.common.MikuReturnGoods
import welink.common.Order
import welink.common.Shop
import welink.user.Employee

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import static com.welink.buy.utils.Constants.ApproveStatus.IN_STOCK

class ShopItemManagerController {


    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .put(300, "300")
            .put(500, "500")
            .put(1000, "1000")
            .build()


    def itemCopyTaskService
    def outExcelShopItemService
    @Transactional
    def makeInStockChecked() {
        if (params.copyBox) {
            def itemIds = Lists.newArrayList(params.copyBox)
            itemIds.each {
                String it ->
                    Long id = Long.parseLong(it)
                    Item item = Item.findById(id)
                    item.approveStatus = IN_STOCK.approveStatusId
                    item.onlineEndTime = System.currentTimeMillis()
                    item.save(failOnError: true, flush: true)
                    //=============
                    //进行对应的抢购标的操作[]
                    List<ObjectTagged> objectTaggedList=ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)
                    Long activityNum
                    Long activitySoldNum
                    objectTaggedList.each {
                        ObjectTagged objectTagged->
                            Tags tags =Tags.findById(objectTagged.tagId)
                            if ("抢购标".equals(tags.name)){
                                activityNum=objectTagged.activityNum
                                activitySoldNum=objectTagged.activitySoldNum
                            }
                    }
                    //=============

                    //主站点商品也相应下架
                    Item oitem=Item.findById(item.baseItemId)
                    if (oitem)
                    {

                        oitem.approveStatus=IN_STOCK.approveStatusId
                        oitem.onlineEndTime=System.currentTimeMillis()
                        oitem.save(failOnError: true, flush: true)

                        //对应抢购购标的操作
                        List<ObjectTagged> BaseobjectTaggedList=ObjectTagged.findAllByArtificialIdAndStatus(oitem.id, 1 as byte)
                        BaseobjectTaggedList.each {
                            ObjectTagged objectTagged->
                                Tags tags =Tags.findById(objectTagged.tagId)
                                if ("抢购标".equals(tags.name)){
                                    objectTagged.with {
                                        it.activityNum=activityNum
                                        it.activitySoldNum=activitySoldNum
                                        it.save(failOnError: true, flush: true)
                                    }
                                }
                        }

                    }
            }
        }

        redirect(action: 'index', controller: 'shopItemManager', params: [communityId: params.communityId, category: params.category, level1Category: params.level1Category, query: params.query])
    }

    //站点商品单独打标
    def changeTag() {

        if (StringUtils.isBlank(params.itemId) || StringUtils.isBlank(params.newTags)) {
            flash.error = "没选标签，你打毛线"
            redirect(action: 'communityItemInstock', params: [communityId: params.communityId, query: params.query, category: params.category, level1Category: params.level1Category])
            return
        }

        Item item = Item.findById(params.long('itemId'))

        Tags tags = Tags.findById(params.long('newTags'))

        def limitmap = [:]

        if (params.limitNum) {
            limitmap.put('xgLimitNum', params.int('limitNum'))
        }

        String limitKv = com.alibaba.fastjson.JSON.toJSONString(limitmap)

        item.onlineStartTime = System.currentTimeMillis()

        ObjectTagged objectTagged = ObjectTagged.findByArtificialIdAndTagId(item.id, tags.id) ?: new ObjectTagged()

        //打标的处理
//        item.save(hasShowcase:'1', flush: true)
        item.with {
            it.hasShowcase=1 as byte
            it.save(failOnError: true, flush: true)
        }

        //打特价标
        objectTagged.with {
            it.kv = limitKv
            it.artificialId = item.id
            it.tagId = tags.id
            it.startTime = new DateTime().toDate()
            it.endTime = new DateTime().plusYears(20).toDate()
            it.status = 1 as byte
            it.type = tags.type
            it.save(failOnError: true, flush: true)
        }
        redirect(action: 'communityItemInstock', params: [communityId: params.communityId, query: params.query, category: params.category, level1Category: params.level1Category])
    }

    //站点删标
    def deleteItemTag() {
        Item item = Item.findById(params.long('itemId'))
        Tags tags = Tags.findByIdAndBit(params.long('tagId'), 4L)
        if (tags && item) {
            ObjectTagged.findByArtificialIdAndTagIdAndStatus(item.id, tags.id, 1 as byte).with {
                it.status = 0 as byte
                save(failOnError: true, flush: true)
            }
            item.with {
                it.hasShowcase=0 as byte
                it.save(failOnError: true, flush: true)
            }
            render('true')
            return
        }
        response.status = 405
    }

    def copyItemToCommunityThrough() {

        Long itemId = params.long('id')

        Item item = Item.findById(itemId)

        itemCopyTaskService.pushItemToAllStation(item, true)

        render ImmutableMap.of("code", "0", "message", "强同步成功") as JSON

        return

    }

    //更新站点商品的tag页面渲染
    def updateItemTag() {
        Item item = Item.findById(params.long('id'))
        //找到所有的营销类有效标签
        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)

        def currentTags

        if (tagsOnShow) {
            currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)
        }

        //所有标签
        def allTags = Tags.withCriteria {
            eq('bit', 4L)
            'in'("status", [1, 2] as byte[])
        }

        render(template: "itemTagEdit", model: [
                currentTags: currentTags,
                allTags    : allTags,
                item       : item,
                params     : params
        ])
    }

    def copyItemToCommunity() {

        Long itemId = params.long('id')
        Item item = Item.findById(itemId)

        def result = itemCopyTaskService.checkCityItemInAllStation(item)

        if (result.size() == 0) {
            itemCopyTaskService.pushItemToAllStation(item, false)
            render ImmutableMap.of("code", "0", "message", "新商品同步成功") as JSON
            return
        } else {
            render ImmutableMap.of("code", "1", "message", "同步失败") as JSON
            return
        }

    }

    @Transactional
    def copyItem() {
        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)
        Shop shop = Shop.findByShopId(employee.communityId)
        if (employee.communityId != 1999L) {
            if (params.copyBox) {
                def itemIds = Lists.newArrayList(params.copyBox)
                itemIds.each {
                    String it ->
                        Long id = Long.parseLong(it)
                        Item item = Item.findById(id)
                        if (item && (Item.findByShopIdAndBaseItemId(employee.communityId, item.id) == null)) {
                            //复制一个新商品到站点
                            Item newItem = new Item()
                            newItem.with {
                                it.categoryId = item?.categoryId
                                it.title = item?.title
                                it.sellerId = item?.sellerId
                                it.sellerType = item?.sellerType
                                it.address = item?.address
                                it.specification = item?.specification
                                it.video = item?.video
                                it.price = item?.price
                                it.features = item?.features
                                it.onlineStartTime = item?.onlineStartTime
                                it.onlineEndTime = item?.onlineEndTime
                                it.type = item?.type
                                it.picUrls = item?.picUrls
                                it.detail = item?.detail
                                it.description = item?.description
                                //新复制的商品默认状态在库
                                it.approveStatus = Constants.ApproveStatus.IN_STOCK.approveStatusId
                                //复制的核心，店铺ID，商品编号，店铺等级
                                it.shopId = shop?.id
                                it.shopType = shop?.type
                                it.baseItemId = item?.id
                                save(failOnError: true, flush: true)
                            }
                            //把老子的标复制到小子身上
                            // tag 复制
                            ObjectTagged.findAllByArtificialIdAndTypeBetween(item.id, 1000, 1999)?.each {
                                ObjectTagged objectTagged ->
                                    ObjectTagged.findOrCreateByArtificialIdAndType(newItem.id, objectTagged.type)?.with {
                                        it.artificialId = newItem.id
                                        it.type = objectTagged?.type
                                        it.kv = objectTagged?.kv
                                        it.status = objectTagged?.status
                                        it.startTime = objectTagged?.startTime
                                        it.endTime = objectTagged?.endTime
                                        it.tagId = objectTagged?.tagId
                                        save(failOnError: true, flush: true)
                                    }
                            }
                        }
                }
            }
        }
        redirect(action: 'index', controller: 'itemOnSale', params: [category: params.category, level1Category: params.level1Category, query: params.query])
    }

    @Transactional
    def makeInStock() {
        Long itemId = params.long('id')
        Item item = Item.findById(itemId)

        item.approveStatus = IN_STOCK.approveStatusId
        item.onlineEndTime = System.currentTimeMillis()

        //进行对应的抢购标的操作[]
        List<ObjectTagged> objectTaggedList=ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)
        Long activityNum
        Long activitySoldNum
        objectTaggedList.each {
            ObjectTagged objectTagged->
                Tags tags =Tags.findById(objectTagged.tagId)
                if ("抢购标".equals(tags.name)){
                    activityNum=objectTagged.activityNum
                    activitySoldNum=objectTagged.activitySoldNum
                }
        }

        //主站点商品也相应下架
        Item oitem=Item.findById(item.baseItemId)
        if (oitem)
        {
            oitem.num=item.num
            oitem.approveStatus=IN_STOCK.approveStatusId
            oitem.onlineEndTime=System.currentTimeMillis()
            oitem.save(failOnError: true, flush: true)

            //对应抢购购标的操作
            List<ObjectTagged> BaseobjectTaggedList=ObjectTagged.findAllByArtificialIdAndStatus(oitem.id, 1 as byte)
            BaseobjectTaggedList.each {
                ObjectTagged objectTagged->
                    Tags tags =Tags.findById(objectTagged.tagId)
                    if ("抢购标".equals(tags.name)){
                        objectTagged.with {
                            it.activityNum=activityNum
                            it.activitySoldNum=activitySoldNum
                            it.save(failOnError: true, flush: true)
                        }
                    }
            }
        }


        if (item.save(failOnError: true)) {
            render('true')
            return
        }

    }

    @Transactional
    def makeOnSale() {
        withForm {
            Long itemId = params.long('itemId')
            Long num = params.long('num')
            String address=params?.address
            String specification = params?.specification
            Item item = Item.findById(itemId)
            item.onlineStartTime = System.currentTimeMillis()
            item.onlineEndTime = new DateTime().plusYears(20).toDate().time
            if(address){
                item.address=address
            }
            if(specification){
                item.specification=specification
            }
            item.type = 1 as byte
            item.approveStatus = 1 as byte
            item.num = num
            item.price = new BigDecimal(params.price) * 100L
            item.save(failOnError: true)
            redirect(action: 'communityItemInstock', params: [communityId: params.communityId, query: params.query, category: params.category, level1Category: params.level1Category])
        }.invalidToken {
            // bad request
            response.status = 405
        }
    }


    def lookItemDetail() {

        Item item = Item.findById(params.long('id'))
        //限购内容
        def xgcontent

        //找到所有的营销类有效标签
        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)

        def currentTags

        if (tagsOnShow) {
            currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)
        }

        def fatherItem = Item.findByIdAndShopId(item.baseItemId, 999L)

        def OtMap = [:]

        tagsOnShow.iterator().each {
            ObjectTagged objectTagged ->
                OtMap.put(objectTagged.tagId, objectTagged.kv)

                if ("抢购标".equals(Tags.findById(objectTagged.tagId).name))
                {
                    def onqgkvcontent=JSON.parse(objectTagged.kv)
                    if (onqgkvcontent){
                        def tagprice=onqgkvcontent['activityPrice']?onqgkvcontent['activityPrice']/100f:onqgkvcontent['activityPrice']
                        String info="(销售基数:"+onqgkvcontent['baseSoldNum']+" 活动展示倍数:"+onqgkvcontent['multiple']+" 活动价格:"+tagprice
                        info+="开始时间:"+new DateTime(objectTagged.startTime).toString("yyyy-MM-dd HH:mm")
                        info+="结束时间:"+new DateTime(objectTagged.endTime).toString("yyyy-MM-dd HH:mm")
                        info+="活动限量库存:"+objectTagged.activityNum
                        info+="活动已售:"+(objectTagged.activitySoldNum?objectTagged.activitySoldNum:0)+")"
                        xgcontent=info
                    }
                }
        }

        //品牌的获取
//        def  brandMap=MikuBrand.findAllByIsDeleted(0 as byte).collectEntries{ [it.id, it] }
        def mkBrand=MikuBrand.findById(item.brandId)
        if (mkBrand)
        {
            item.props=mkBrand.name
        }

        //分润比例内容
        String str=" "
        String ptlr=""
        String kflr=""
        List<FenRun> frlist=new ArrayList<FenRun>()
        MikuItemSharePara mikuItemSharePara=MikuItemSharePara.findByItemId(item.baseItemId)
        if (mikuItemSharePara)
        {
            ptlr=mikuItemSharePara.itemProfitFee/100f
            kflr=mikuItemSharePara.itemShareFee/100f
            def obj=JSON.parse(mikuItemSharePara.parameter)
            if (obj.size())
            {
                for (int i=0;i<obj.size();i++)
                {
                    FenRun fr=new FenRun()
                    fr.title=obj[i].title
                    String num=obj[i].value
                    DecimalFormat df = new DecimalFormat("0.0");
//                    fr.price=df.format(mikuItemSharePara.itemShareFee*(Long.parseLong(num))*0.01*0.01)
                    fr.price=df.format(mikuItemSharePara.itemShareFee*(new BigDecimal(num))*0.01*0.01)
                    frlist.add(fr)
//                    String num=obj[i].value
//                    Long price=mikuItemSharePara.itemShareFee*(Long.parseLong(num))*0.01
//                    String content=obj[i].title+"  :  "+price+"    元\b\b\b\b\b\b\b\b"
//                    str+=content
                }
                str=com.alibaba.fastjson.JSON.toJSONString(frlist,true)
            }
        }



        def parentCategory=""
        def childCategory=""
        def grandparentCategory=""
        if(Category.findById(item.categoryId))
        {
            childCategory=Category.findById(item.categoryId).name
        }
        if (Category.findById(item.category1_id)){
            //大类
            grandparentCategory=Category.findById(item.category1_id)?.name
        }

        if (Category.findById(item.category2_id)){
            parentCategory=Category.findById(item.category2_id).name
        }


        render(template: "itemDetail", model: [
                OtMap         : OtMap,
                ptlr:ptlr,
                kflr:kflr,
                xgcontent         : xgcontent,
                currentTags   : currentTags,
                fatherItem    : fatherItem,
                item          : item,
                str           : str,
                parentCategory: parentCategory,
                grandparentCategory: grandparentCategory,
                childCategory : childCategory
        ])

    }

    def index() {

//        Subject currentUser = SecurityUtils.getSubject()
//        Employee employee = Employee.findByUsername(currentUser.principal)

        //对各个字段进行排序
        String  fieldName=params.fieldName
        String  fieldstate=params.fieldstate


        Long oneLevel=params.long('level1Category')
        Long twoLevel=params.long('category')
        Long threeLevel=params.long('threelevel')


        //添加多一个商品ID的查询
        Long itemId=params.long('itemId')


        def childCategoryList
        def childList

        List<welink.common.Category> categoryList = welink.common.Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)

        if (params.level1Category) {

            childCategoryList = Category.findAllByParentId(params.long('level1Category'))

            childList = childCategoryList*.id

        }

        def c = Item.createCriteria()

        Long brandId=params.long('brandId')
        //tags  id
        Long tagId=params.long('tagId')
        //商品编码的查询
        String itemcode=params.itemcode

        if(params.query){
            List<Item> getsizelist=Item.findAllByApproveStatusAndTypeAndShopTypeAndTitleIlike(1 as byte,1 as byte,1 as byte,"%" + params.query + "%")
            params.max=getsizelist.size()
        }


        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {

//            if(childList){
//                'in'("categoryId", childList)
//            }

            if (itemId){
                eq('id',itemId)
            }


            //类目的选择
            if(threeLevel && threeLevel!=-1){
                eq("categoryId", threeLevel)
            }else if (twoLevel && twoLevel!=-1){
                eq("category2_id", twoLevel)
            }else if (oneLevel && oneLevel!=-1){
                eq("category1_id", oneLevel)
            }

            eq("approveStatus", 1 as byte)
//            eq("type", 1 as byte)
            'in'('type', [1, 9, 10] as byte[])
            eq("shopType", 1 as byte)


            //各字段排序
            if(fieldName && fieldstate){
                order(fieldName, fieldstate)
            }else{
                order('lastUpdated', 'desc')
            }
//            order("id", "desc")
//            if (employee.communityId != 1999L) {
//                Shop shop = Shop.findByShopIdAndStatus(employee.communityId, 1 as byte)
//                if (shop) {
//                    eq("shopId", shop.id)
//                }
//            } else if (params.communityId) {
//                Shop shop = Shop.findByShopIdAndStatus(params.long('communityId'), 1 as byte)
//                if (shop) {
//                    eq("shopId", shop.id)
//                }
//            } else {
//                ne('shopId', 999L)
//            }
            if (params.query) {
                ilike("title", "%" + params.query + "%")
//                eq("title",  params.query)
            }
//            if (params.category && (params.category != '-1')) {
//                eq("categoryId", params.long('category'))
//            }

            if (brandId>0)
            {
                eq("brandId",brandId)
            }

            if (itemcode){
                eq("code", itemcode)
            }

            if (tagId)
            {
                def objs=ObjectTagged.findAllByTagIdAndStatus(tagId,1 as byte)
                if (objs) {
                    'in'("id", objs*.artificialId)
                } else {
                    eq("id", -1L)
                }
            }

        }
        def itemTagMap = [:]

        //限量标Map集合
        def xlTagMap=[:]

        //抢购标的Map集合
        def xgbTagMap=[:]

        pagedResultList.each {
            Item item ->
                def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)

                tagsOnShow.each {
                    ObjectTagged obj->
                        if ("限购标".equals(Tags.findById(obj.tagId).name))
                        {
                            xlTagMap.put(item.id,obj.kv)
                        }

                        if ("抢购标".equals(Tags.findById(obj.tagId).name))
                        {
                            def str=JSON.parse(obj.kv)
                            if (str){
                                def tagprice=str['activityPrice']?str['activityPrice']/100f:str['activityPrice']
                                String info="(销售基数:"+str['baseSoldNum']+" 活动展示倍数:"+str['multiple']+" 活动价格:"+tagprice
                                info+="开始时间:"+new DateTime(obj.startTime).toString("yyyy-MM-dd HH:mm")
                                info+="结束时间:"+new DateTime(obj.endTime).toString("yyyy-MM-dd HH:mm")
                                info+="活动限量库存:"+obj.activityNum
                                info+="活动已售:"+(obj.activitySoldNum?obj.activitySoldNum:0)+")"
                                xgbTagMap.put(item.id,info)
                            }
                        }
                }

                //进行brand名称的赋值
                def brand=MikuBrand.findById(item.brandId)
                if (brand)
                {
                    item.props=brand.name
                }

                def currentTags

                if (tagsOnShow) {
                    currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)
                }
                itemTagMap.put(item.id, currentTags)

        }

        def categoryMap = welink.common.Category.findAllByIdGreaterThanAndStatus(20000000L, 1 as byte).collectEntries {
            [it.id, it]
        }

//        Community community
//        if (params.communityId) {
//            community = Community.findById(params.long('communityId'))
//        } else {
//            community = Community.findById(employee.communityId)
//        }

//        def communityList = Community.findAllByStatus(1 as byte)

        //Brand获取
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        //标签列表
        List<Tags>  tagsList=Tags.findAll()

        render(view: 'index', model: [
                itemTagMap   : itemTagMap,
                xlTagMap    : xlTagMap,
                xgbTagMap    : xgbTagMap,
                PageMap    : PageMap,
//                communityList: communityList,
//                community    : community,
                total        : pagedResultList?.totalCount,
                itemList     : pagedResultList,
                mikuBrandList     : mikuBrandList,
                tagsList:      tagsList,
                params       : params,
                categoryList : categoryList,
                categoryMap  : categoryMap
        ])

    }

    def communityItemInstock() {

        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        List<welink.common.Category> categoryList = welink.common.Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)

        def c = Item.createCriteria()

        //brand id
        Long brandId=params.long('brandId')

        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("approveStatus", 0 as byte)
            eq("type", 1 as byte)
            eq("shopType", 1 as byte)
            order("id", "desc")
            if (employee.communityId != 1999L) {
                Shop shop = Shop.findByShopIdAndStatus(employee.communityId, 1 as byte)
                if (shop) {
                    eq("shopId", shop.id)
                }
            } else if (params.communityId) {
                Shop shop = Shop.findByShopIdAndStatus(params.long('communityId'), 1 as byte)
                if (shop) {
                    eq("shopId", shop.id)
                }
            }
            if (params.query) {
                ilike("title", "%" + params.query + "%")
            }
            if (params.category && (params.category != '-1')) {
                eq("categoryId", params.long('category'))
            }

            if (brandId>0)
            {
                eq("brandId",brandId)
            }
        }
        def itemTagMap = [:]

        //限量标Map集合
        def xlTagMap=[:]

        pagedResultList.each {
            Item item ->
                def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)

                tagsOnShow.each {
                    ObjectTagged obj->
                        if (obj.tagId==2000)
                        {
                            xlTagMap.put(item.id,obj.kv)
                        }
                }

                //进行brand名称的赋值
                def brand=MikuBrand.findById(item.brandId)
                if (brand)
                {
                    item.props=brand.name
                }

                def currentTags

                if (tagsOnShow) {
                    currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)
                }
                itemTagMap.put(item.id, currentTags)

        }

        def categoryMap = welink.common.Category.findAllByIdGreaterThanAndStatus(20000000L, 1 as byte).collectEntries {
            [it.id, it]
        }

        Community community

        if (params.communityId) {
            community = Community.findById(params.long('communityId'))
        } else {
            community = Community.findById(employee.communityId)
        }

        def communityList = Community.findAllByStatus(1 as byte)

        //Brand获取
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        //品牌的获取
//        def  brandMap=MikuBrand.findAllByIsDeleted(0 as byte).collectEntries{ [it.id, it] }

        render(view: 'communityItemInstock', model: [
                itemTagMap   : itemTagMap,
                xlTagMap    : xlTagMap,
                communityList: communityList,
                community    : community,
                total        : pagedResultList?.totalCount,
                itemList     : pagedResultList,
                params       : params,
                categoryList : categoryList,
                mikuBrandList:mikuBrandList,
                categoryMap  : categoryMap
        ])
    }




    //修改对应的商品的权重
    def updateOneItemWeight()
    {
        def id=params.long('id')
        def weight=params.int('newWeight')
        Item it=Item.findById(id)
        //进行修改对应商品
        if (it)
        {
            it.weight=weight
            it.save(failOnError: true, flush: true)

            //查找对应的分站点的商品
            Item newit=Item.findById(it.baseItemId)
            if (newit)
            {
                newit.weight=weight
                newit.save(failOnError: true, flush: true)
            }
            render('true')
            return
        }
    }

    //修改对应的商品的销售基数
    def updateOneItemQuantity()
    {
        def id=params.long('id')
        def qunatity=params.int('qunatity')
        Item it=Item.findById(id)
        //进行修改对应商品
        if (it)
        {
            it.baseSoldQuantity=qunatity
            it.save(failOnError: true, flush: true)

            //查找对应的分站点的商品
            Item newit=Item.findById(it.baseItemId)
            if (newit)
            {
                newit.baseSoldQuantity=qunatity
                newit.save(failOnError: true, flush: true)
            }
            render('true')
            return
        }
    }

    def updateOneItemTitle(){
        def id=params.long('id')
        def title=params.title
        Item it=Item.findById(id)
        //进行修改对应商品
        if (it)
        {
            it.title=title
            it.save(failOnError: true, flush: true)

            //查找对应的分站点的商品
            Item newit=Item.findById(it.baseItemId)
            if (newit)
            {
                newit.title=title
                newit.save(failOnError: true, flush: true)
            }
            render('true')
            return
        }
    }




    //修改对应商品的库存
    def updateOneItemNum(){
        def id=params.long('id')
        def num=params.int('num')
        Item it=Item.findById(id)
        //进行修改对应商品
        if (it)
        {
            it.num=num
            it.save(failOnError: true, flush: true)

            //查找对应的分站点的商品
            Item newit=Item.findById(it.baseItemId)
            if (newit)
            {
                newit.num=num
                newit.save(failOnError: true, flush: true)
            }
            render('true')
            return
        }
    }


    //下载全部上架的信息
    def downloadExcel(){
        Byte type=params.byte('type')
        List<ItemDetailData> list=outExcelShopItemService.outAllData(type)
        if(type== 1 as byte){
            buildOnePoiExcel(list,"全部总仓")
        }else {
            buildOnePoiExcel(list,"上架全部")
        }

    }


    //下载某些商品Excel
    def downOnesItems(){
        def itemIds = Lists.newArrayList(params.itemShipBox)
        List<ItemDetailData> list=outExcelShopItemService.outSomeItemInfo(itemIds)
        buildOnePoiExcel(list,"列表")
    }





    def buildOnePoiExcel(List<ItemDetailData> outList,String title)
    {

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet(title);
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell  cell = row.createCell((short) 0);
        cell.setCellValue("商品id");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("商品名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("商品编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("类目");
        cell.setCellStyle(style);
        cell = row.createCell((short) 4);
        cell.setCellValue("品牌");
        cell.setCellStyle(style);
        cell = row.createCell((short) 5);
        cell.setCellValue("销售价");
        cell.setCellStyle(style);
        cell = row.createCell((short) 6);
        cell.setCellValue("成本价");
        cell.setCellStyle(style);
        cell = row.createCell((short) 7);
        cell.setCellValue("平台利润");
        cell.setCellStyle(style);
        cell = row.createCell((short) 8);
        cell.setCellValue("参考价");
        cell.setCellStyle(style);
        cell = row.createCell((short) 9);
        cell.setCellValue("规格");
        cell.setCellStyle(style);
        cell = row.createCell((short) 10);
        cell.setCellValue("视频链接");
        cell.setCellStyle(style);
        cell = row.createCell((short) 11);
        cell.setCellValue("库存");
        cell.setCellStyle(style);
        cell = row.createCell((short) 12);
        cell.setCellValue("销售基数");
        cell.setCellStyle(style);
        cell = row.createCell((short) 13);
        cell.setCellValue("商品描述");
        cell.setCellStyle(style);
        cell = row.createCell((short) 14);
        cell.setCellValue("具体描述");
        cell.setCellStyle(style);
        cell = row.createCell((short) 15);
        cell.setCellValue("权重");
        cell.setCellStyle(style);
        cell = row.createCell((short) 16);
        cell.setCellValue("关键字");
        cell.setCellStyle(style);
        cell = row.createCell((short) 17);
        cell.setCellValue("已销数量");
        cell.setCellStyle(style);

        cell = row.createCell((short) 18);
        cell.setCellValue("是否免税");
        cell.setCellStyle(style);

        cell = row.createCell((short) 19);
        cell.setCellValue("是否可退货");
        cell.setCellStyle(style);

        cell = row.createCell((short) 20);
        cell.setCellValue("非标品");
        cell.setCellStyle(style);


        cell = row.createCell((short) 21);
        cell.setCellValue("热卖品");
        cell.setCellStyle(style);


        cell = row.createCell((short) 22);
        cell.setCellValue("其他标");
        cell.setCellStyle(style);


        cell = row.createCell((short) 23);
        cell.setCellValue("图片信息");
        cell.setCellStyle(style);


        cell = row.createCell((short) 24);
        cell.setCellValue("一级类目ID");
        cell.setCellStyle(style);


        cell = row.createCell((short) 25);
        cell.setCellValue("二级类目ID");
        cell.setCellStyle(style);


        cell = row.createCell((short) 26);
        cell.setCellValue("三级类目ID");
        cell.setCellStyle(style);

        cell = row.createCell((short) 27);
        cell.setCellValue("采购价");
        cell.setCellStyle(style);

        cell = row.createCell((short) 28);
        cell.setCellValue("邮费");
        cell.setCellStyle(style);

        cell = row.createCell((short) 29);
        cell.setCellValue("搜索关键字");
        cell.setCellStyle(style);

        cell = row.createCell((short) 30);
        cell.setCellValue("一级类目");
        cell.setCellStyle(style);

        cell = row.createCell((short) 31);
        cell.setCellValue("二级类目");
        cell.setCellStyle(style);

        cell = row.createCell((short) 32);
        cell.setCellValue("三级类目");
        cell.setCellStyle(style);


        for (int i = 0; i < outList.size(); i++)
        {
            row = sheet.createRow((int) i + 1);
            ItemDetailData oneExcel=outList.get(i);
            // 第四步，创建单元格，并设置值
            row.createCell((short) 0).setCellValue(oneExcel.id);
            row.createCell((short) 1).setCellValue(oneExcel.title);
            row.createCell((short) 2).setCellValue(oneExcel.code);
            row.createCell((short) 3).setCellValue(oneExcel.category3Name);
            row.createCell((short) 4).setCellValue(oneExcel.brandName);
            row.createCell((short) 5).setCellValue(oneExcel.price.toString());
            row.createCell((short) 6).setCellValue(oneExcel.cbprice.toString());
            row.createCell((short) 7).setCellValue(oneExcel.ptlirun.toString());
            row.createCell((short) 8).setCellValue(oneExcel.ckPrice.toString());
            row.createCell((short) 9).setCellValue(oneExcel.specification.toString());
            row.createCell((short) 10).setCellValue(oneExcel.video);
            row.createCell((short) 11).setCellValue(oneExcel.num);
            row.createCell((short) 12).setCellValue(oneExcel.baseSoldQuantity);
            row.createCell((short) 13).setCellValue(oneExcel.description);
            row.createCell((short) 14).setCellValue(oneExcel.itemAttribute);
            row.createCell((short) 15).setCellValue(oneExcel.weight);
            row.createCell((short) 16).setCellValue(oneExcel.keyWord);
            row.createCell((short) 17).setCellValue(oneExcel.soldQuantity);
            row.createCell((short) 18).setCellValue(oneExcel.isTaxFreeInfo);
            row.createCell((short) 19).setCellValue(oneExcel.isrefundInfo);
            row.createCell((short) 20).setCellValue(oneExcel.tagFbpinfo);
            row.createCell((short) 21).setCellValue(oneExcel.tagRmpinfo);
            row.createCell((short) 22).setCellValue(oneExcel.tagQtbinfo);
            row.createCell((short) 23).setCellValue("");
            row.createCell((short) 24).setCellValue(oneExcel.category1_id);
            row.createCell((short) 25).setCellValue(oneExcel.category2_id);
            row.createCell((short) 26).setCellValue(oneExcel.categoryId);
            row.createCell((short) 27).setCellValue(oneExcel.cgprice);
            row.createCell((short) 28).setCellValue(oneExcel.postFee);
            row.createCell((short) 29).setCellValue(oneExcel.keyWord);
            row.createCell((short) 30).setCellValue(oneExcel.category1Name);
            row.createCell((short) 31).setCellValue(oneExcel.category2Name);
            row.createCell((short) 32).setCellValue(oneExcel.category3Name);
        }

        // 第六步，将文件存到指定位置
        try
        {
            String path=request.getSession().getServletContext().getRealPath("")
            UUID uuid = UUID.randomUUID()
            FileOutputStream fout = new FileOutputStream(path+"\\"+uuid+".xls");
            wb.write(fout);
            fout.close();


            //提供进行下载
            // 处理中文乱码
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd")
            Calendar c = Calendar.getInstance()
            int hour = c.get(Calendar.HOUR_OF_DAY);
            int minute = c.get(Calendar.MINUTE);
            int second = c.get(Calendar.SECOND);
            String sfm=hour+"时"+minute+"分"+second+"秒"
            String downloadName=df.format(new Date()).toString()+"-"+sfm+title+"商品.xls"
            def filename = URLEncoder.encode(downloadName, "UTF-8");
            response.setHeader("Content-disposition", "attachment; filename="+filename)
            response.contentType = "application/x-rarx-rar-compressed"
            System.out.println("========================================");
            System.out.println(path);
            System.out.println("========================================");
            def out = response.outputStream
            InputStream inputStream = new FileInputStream(path+"\\"+uuid+".xls")
            byte[] buffer = new byte[1024]
            int i = -1
            while ((i = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, i)
            }
            out.flush()
            out.close()
            inputStream.close()
            new File(path+"\\"+uuid+".xls").delete();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}

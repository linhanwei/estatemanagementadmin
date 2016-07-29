package welink.system

import com.alibaba.fastjson.TypeReference
import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.FenRun
import welink.common.Category
import welink.common.Groupon
import welink.common.Item
import welink.common.MikuBrand
import welink.common.MikuItemSharePara
import welink.common.Shop
import welink.estate.ObjectTagged
import welink.estate.Tags

import java.text.DecimalFormat

import static com.welink.buy.utils.Constants.ApproveStatus.IN_STOCK
import static com.welink.buy.utils.Constants.ApproveStatus.IN_STOCK

class ItemInStockController {

    final DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");
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

    def copyItemService

    //更新商品的tag页面渲染
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
            'in'("status", [1, 2] as byte[])
        }

        //获取限购标的对应的数量
        def num
        def qgbflag
        def currentMap=[:]
        tagsOnShow.each {
            ObjectTagged obj->
                if ("抢购标".equals(Tags.findById(obj.tagId).name)){
                    qgbflag=obj.tagId
                }
                if ("限购标".equals(Tags.findById(obj.tagId).name))
                {
                    num=com.alibaba.fastjson.JSON.parse(obj.kv)["xgLimitNum"]
                }
                currentMap.put(obj.tagId,"1")
        }

        //查出对应的抢购标
        ObjectTagged qgobjectTagged=ObjectTagged.findByTagIdAndArtificialId(qgbflag,item.id)
        if (!qgobjectTagged){
            qgobjectTagged=new ObjectTagged()
        }

        render(template: "itemTagEdit", model: [
                currentTags: currentTags,
                currentMap : currentMap,
                allTags    : allTags,
                num        : num,
                qgobjectTagged:qgobjectTagged,
                item       : item
        ])
    }

    def lookItemDetail() {

        Item item = Item.findById(params.long('id'))

        //找到所有的营销类有效标签
        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)

        def currentTags

        //获取对应的限购标的数量
        def xgtagNum=0
        //限购内容
        def xgcontent

        if (tagsOnShow) {
            currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)

            //进行对限购标数量的获取
            tagsOnShow.each {
                ObjectTagged objtag->
//                    "限购标".equals(Tags.findById(obj.tagId).name)
//                    if (objtag.tagId==2000 && objtag.kv && JSON.parse(objtag.kv) )
                    if ("限购标".equals(Tags.findById(objtag.tagId).name) && objtag.kv && JSON.parse(objtag.kv) )
                    {
                        xgtagNum  = JSON.parse(objtag.kv)?.get("xgLimitNum")?:0
                    }

                    if ("抢购标".equals(Tags.findById(objtag.tagId).name))
                    {
                        def str=JSON.parse(objtag.kv)
                        if (str){
                            def tagprice=str['activityPrice']?str['activityPrice']/100f:str['activityPrice']
                            String info="(销售基数:"+str['baseSoldNum']+" 活动展示倍数:"+str['multiple']+" 活动价格:"+tagprice
                            info+="开始时间:"+new DateTime(objtag.startTime).toString("yyyy-MM-dd HH:mm")
                            info+="结束时间:"+new DateTime(objtag.endTime).toString("yyyy-MM-dd HH:mm")
                            info+="活动限量库存:"+objtag.activityNum
                            info+="活动已售:"+(objtag.activitySoldNum?objtag.activitySoldNum:0)+")"
                            xgcontent=info
                        }
                    }
            }
        }
//        JSON.parse(tagsOnShow.get(0).kv.toString()).get("xgLimitNum")


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


        //品牌的获取
        def  brandMap=MikuBrand.findAllByIsDeleted(0 as byte).collectEntries{ [it.id, it] }

        //分润比例内容
        String str=" "
        List<FenRun> frlist=new ArrayList<FenRun>()
        String ptlr=""
        String kflr=""
        MikuItemSharePara mikuItemSharePara=MikuItemSharePara.findByItemId(item.id)
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


        render(template: "itemDetail", model: [
                currentTags   : currentTags,
                item          : item,
                ptlr:ptlr,
                kflr:kflr,
                mikuItemSharePara : mikuItemSharePara,
                parentCategory: parentCategory,
                grandparentCategory: grandparentCategory,
                brandMap      : brandMap,
                xgtagNum      : xgtagNum,
                xgcontent      : xgcontent,
                str           : str,
                childCategory : childCategory
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
            Item newit=Item.findByBaseItemId(id)
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
            Item newit=Item.findByBaseItemId(id)
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
            Item newit=Item.findByBaseItemId(id)
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
            Item newit=Item.findByBaseItemId(id)
            if (newit)
            {
                newit.num=num
                newit.save(failOnError: true, flush: true)
            }
            render('true')
            return
        }
    }


    def index() {

        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1)

        def c = Item.createCriteria()

        // 查询语句
        String query = params.query
        //brand id
        Long brandId=params.long('brandId')
        //tags  id
        Long tagId=params.long('tagId')
        //商品编码的查询
        String itemcode=params.itemcode
//        //新添加的一个题目的查询
//        params.max=params.query?50:params.max
        Long oneLevel=params.long('level1Category')
        Long twoLevel=params.long('category')
        Long threeLevel=params.long('threelevel')



//        def childCategoryList

        def childList

//        if (params.level1Category) {
//
//            childCategoryList = Category.findAllByParentId(params.long('level1Category'))
//
//            childList = childCategoryList*.id
//
//        }

        //对各个字段进行排序
        String  fieldName=params.fieldName
        String  fieldstate=params.fieldstate

        if(params.query){
            List<Item> getsizelist=Item.findAllByApproveStatusAndShopIdAndTitleIlike(0 as byte,999L,"%" + params.query + "%")
            params.max=getsizelist.size()
        }





        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("approveStatus", 0 as byte)
            eq("shopId", 999L)
//            eq("type", 1 as byte)
            'in'('type', [1, 9, 10] as byte[])
            if (params.query) {
                ilike("title", "%" + params.query + "%")
//                eq("title",  params.query)
            }
//            if (params.category && (params.category != '-1')) {
//                eq("categoryId", params.long('category'))
//            }
//            if(childList){
//                'in'("categoryId", childList)
//            }

            //类目的选择
            if(threeLevel && threeLevel!=-1){
                eq("categoryId", threeLevel)
            }else if (twoLevel && twoLevel!=-1){
                eq("category2_id", twoLevel)
            }else if (oneLevel && oneLevel!=-1){
                eq("category1_id", oneLevel)
            }


            if (brandId>0)
            {
                eq("brandId",brandId)
            }

            if (itemcode){
                eq("code", itemcode)
            }

            if (tagId)
            {
//                def objs=ObjectTagged.findAllByTagId(tagId)
                def objs=ObjectTagged.findAllByTagIdAndStatus(tagId,1 as byte)
                if (objs) {
                    'in'("id", objs*.artificialId)
                } else {
                    eq("id", -1L)
                }
            }

            //各字段排序
            if(fieldName && fieldstate){
                order(fieldName, fieldstate)
            }else{
                order('lastUpdated', 'desc')
            }

            //brand id的关联

//            if (query) {
//                eq("title", query)
//            } else if (params.category && (params.category != '-1')) {
//                eq("categoryId", params.long('category'))
//            } else if (childList) {
//                'in'("categoryId", childList)
//            }
        }

        def categoryMap = Category.findAllByIdGreaterThanAndStatus(20000000L, 1 as byte).collectEntries { [it.id, it] }

        //品牌的获取
        def  brandMap=MikuBrand.findAllByIsDeleted(0 as byte).collectEntries{ [it.id, it] }

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
//                        if (obj.tagId==2000)
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

                def currentTags

                if (tagsOnShow) {
                    currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)
                }
                itemTagMap.put(item.id, currentTags)



                //进行一个销售基数的变化
                Item onsalesItem=Item.findByBaseItemId(item.id)
                if (onsalesItem){
                    item.soldQuantity=onsalesItem.soldQuantity
                }

        }

        //Brand获取
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        //标签列表
        List<Tags>  tagsList=Tags.findAll()

        ObjectTagged qgobjectTagged=new ObjectTagged()

        MikuItemSharePara mikuItemSharePara=new MikuItemSharePara()


        render(view: 'index', model: [
                itemTagMap  : itemTagMap,
                xlTagMap    : xlTagMap,
                xgbTagMap    : xgbTagMap,
                PageMap    : PageMap,
                mikuItemSharePara:mikuItemSharePara,
                total       : pagedResultList?.totalCount,
                itemList    : pagedResultList,
                params      : params,
                categoryList: categoryList,
                categoryMap : categoryMap,
                brandMap    : brandMap,
                qgobjectTagged    : qgobjectTagged,
                mikuBrandList:mikuBrandList,
                tagsList:tagsList
        ])
    }


    @Transactional
    def makeGroupOn() {

        withForm {
            List<String> bannerPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()

            Long itemId = params.long('itemId')

            DateTime onlineStartTime = formatter.parseDateTime(params.onlineStartTime)

            DateTime onlineEndTime = formatter.parseDateTime(params.onlineEndTime)

            Long price = new BigDecimal(params.price) * 100L

            Long num = params.long('num')

            Item item = Item.findByShopIdAndId(999L, itemId)

            item.onlineStartTime = onlineStartTime.toDate().time
            item.onlineEndTime = onlineEndTime.toDate().time
            item.num = num

            def featureMap = com.alibaba.fastjson.JSON.parseObject(item.features, new TypeReference<Map<String, Long>>() {
            })
            featureMap.put('grouponPrice', price)
            item.features = new JSON(featureMap).toString(false)
            item.type = 3 as byte
            item.approveStatus = 1 as byte
            item.save(failOnError: true)

            Groupon groupon = new Groupon()
            groupon.bannerUrl = StringUtils.join(bannerPics, ';')
            groupon.shopId = 999L
            groupon.itemId = itemId
            groupon.itemTitle = item.title
            groupon.referencePrice = featureMap.get('referencePrice')
            groupon.purchasingPrice = featureMap.get('purchasingPrice')
            groupon.price = item.price
            groupon.grouponPrice = price
            groupon.quantity = num
            groupon.itemCategoryId = item.categoryId
            groupon.onlineStartTime = item.onlineStartTime
            groupon.onlineEndTime = item.onlineEndTime
            groupon.status = 2 as byte
            groupon.soldQuantity = 0

            groupon.save(failOnError: true)

            redirect(uri: '/groupon/index')

        }.invalidToken {
            // bad request
            response.status = 405
        }
    }

    @Transactional
    def makeOnSale() {
        withForm {
            Long itemId = params.long('itemId')

            Long num = params.long('num')

            Item item = Item.findByShopIdAndId(999L, itemId)

            item.onlineStartTime = System.currentTimeMillis()

            item.onlineEndTime = new DateTime().plusYears(20).toDate().time

            item.type = 1 as byte

            item.approveStatus = 1 as byte

            item.num = num

            item.save(failOnError: true)

            //进行对分站点数据的copy到对应的分站点
            copyItemService.copyItemToFzNewItem(item)


            redirect(uri: '/itemOnSale/index')
        }.invalidToken {
            // bad request
            response.status = 405
        }
    }



    //不弹框的上架操作
    @Transactional
    def makeShangjiaOnSale()
    {
        Long itemId = params.long('itemId')
        Item item = Item.findByShopIdAndId(999L, itemId)

        item.onlineStartTime = System.currentTimeMillis()

        item.onlineEndTime = new DateTime().plusYears(20).toDate().time
//        item.type = 1 as byte
        item.approveStatus = 1 as byte
        item.save(failOnError: true)

        //进行对分站点数据的copy到对应的分站点
        copyItemService.copyItemToFzNewItem(item)

        render('true')

    }


    //批量上架
    @Transactional
    def  makeAllShangjiaOnSale()
    {
        if (params.copyBox) {
            def itemIds = Lists.newArrayList(params.copyBox)
            itemIds.each {
                String it ->
                    Long id = Long.parseLong(it)
                    Item item = Item.findByShopIdAndId(999L, id)

                    item.onlineStartTime = System.currentTimeMillis()

                    item.onlineEndTime = new DateTime().plusYears(20).toDate().time

                    item.type = 1 as byte

                    item.approveStatus = 1 as byte

                    item.save(failOnError: true)

                    //进行对分站点数据的copy到对应的分站点
                    copyItemService.copyItemToFzNewItem(item)
            }
        }

        redirect(action: 'index', controller: 'shopItemManager')

    }



    //批量删除
    @Transactional
    def makeAllShangjiaDelete(){
        if (params.copyBox) {
            def itemIds = Lists.newArrayList(params.copyBox)
            itemIds.each {
                String it ->
                    Long id = Long.parseLong(it)
                    Item item = Item.findByShopIdAndId(999L, id)
                    item.approveStatus = -1 as byte
                    item.onlineEndTime = System.currentTimeMillis()
                    item.save(failOnError: true, flush: true)
                    //删掉对应站点的上架商品
                    Item nItem=Item.findByBaseItemId(id)
                    if (nItem)
                    {
                        nItem.approveStatus = -1 as byte
                        nItem.onlineEndTime = System.currentTimeMillis()
                        nItem.save(failOnError: true, flush: true)
                    }
            }
        }
        redirect(action: 'index', controller: 'itemInStock')
    }



    //查出对应的商品库存
    def  getItemNum()
    {
        Long id = params.long('id')
        Item it=Item.findById(id)
        render(it.num)
    }





}

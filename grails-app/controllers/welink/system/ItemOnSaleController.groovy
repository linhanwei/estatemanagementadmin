package welink.system

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import org.joda.time.DateTime
import welink.business.FenRun
import welink.common.Category
import welink.common.Item
import welink.common.MikuBrand
import welink.common.MikuItemSharePara
import welink.common.SearchItem
import welink.estate.ObjectTagged
import welink.estate.TagItem
import welink.estate.Tags

import java.text.DecimalFormat

class ItemOnSaleController {

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



    def lookItemDetail() {

        Item item = Item.findById(params.long('id'))


        //找到所有的营销类有效标签
        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)

        def currentTags
        //限购内容
        def xgcontent

        if (tagsOnShow) {
            currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)

            //进行对限购标数量的获取
            tagsOnShow.each {
                ObjectTagged objtag->
                    if ("抢购标".equals(Tags.findById(objtag.tagId).name))
                    {
                        def onqgkvcontent=JSON.parse(objtag.kv)
                        if (onqgkvcontent){
                            def tagprice=onqgkvcontent['activityPrice']?onqgkvcontent['activityPrice']/100f:onqgkvcontent['activityPrice']
                            String info="(销售基数:"+onqgkvcontent['baseSoldNum']+" 活动展示倍数:"+onqgkvcontent['multiple']+" 活动价格:"+tagprice
                            info+="开始时间:"+new DateTime(objtag.startTime).toString("yyyy-MM-dd HH:mm")
                            info+="结束时间:"+new DateTime(objtag.endTime).toString("yyyy-MM-dd HH:mm")
                            info+="活动限量数:"+objtag.activityNum+")"
                            xgcontent=info
                        }
                    }
            }
        }

        def OtMap = [:]

        tagsOnShow.iterator().each {
            ObjectTagged objectTagged ->
                OtMap.put(objectTagged.tagId, objectTagged.kv)
        }


        //需要看的是是否有对应的分类
        def parentCategory=""
        def childCategory=""
        if(Category.findById(item.categoryId))
        {
            parentCategory=Category.findById(Category.findById(item.categoryId).parentId).name
            childCategory=Category.findById(item.categoryId).name
        }

        //品牌的获取
        def  brandMap=MikuBrand.findAllByIsDeleted(0 as byte).collectEntries{ [it.id, it] }

        //分润比例内容
        String str=" "
        List<FenRun> frlist=new ArrayList<FenRun>()
        MikuItemSharePara mikuItemSharePara=MikuItemSharePara.findByItemId(item.id)
        if (mikuItemSharePara)
        {
            def obj=JSON.parse(mikuItemSharePara.parameter)
            if (obj.size())
            {
                for (int i=0;i<obj.size();i++)
                {
                    FenRun fr=new FenRun()
                    fr.title=obj[i].title
                    String num=obj[i].value
                    DecimalFormat df = new DecimalFormat("0.0");
                    fr.price=df.format(mikuItemSharePara.itemShareFee*(Long.parseLong(num))*0.01*0.01)
                    frlist.add(fr)
                }
                str=com.alibaba.fastjson.JSON.toJSONString(frlist,true)
            }
        }





        render(template: "itemDetail", model: [
                OtMap         : OtMap,
                xgcontent         : xgcontent,
                currentTags   : currentTags,
                item          : item,
                str           : str,
                parentCategory: parentCategory,
                brandMap: brandMap,
                childCategory : childCategory
        ])

    }

    def orderingRule() {

        List<Category> categoryList = Category.findAllByParentIdAndStatus(20000002L, 1 as byte)

        def categoryId = params.long("category_id") ?: 20000025L

        def searchItemMap = SearchItem.createCriteria().list {
            and {
                eq("categoryId", categoryId)
                eq("status", 1 as Byte)
                eq("type", 1)
            }
            order("rank", "desc")
        }.collectEntries { [it.id, it] }

        // 查询语句
        def itemList = Item.createCriteria().list {
            and {
                eq("approveStatus", 1 as byte)
                eq("type", 1 as byte)
                eq("categoryId", categoryId)
            }
            order("id", "desc")
        }.sort {
            it ->
                def id = it.id
                def rank = (searchItemMap.get(id)?.rank) ?: 0
                -rank
        }

        def categoryMap = Category.findAllByIdGreaterThanAndStatus(20000000L, 1 as byte).collectEntries { [it.id, it] }

        render(view: 'orderingRule', model: [
                total       : itemList?.size(),
                itemList    : itemList,
                params      : params,
                selected    : categoryId,
                categoryMap : categoryMap,
                categoryList: categoryList
        ])

    }

    def saveCategoryItemRank() {

        def arr = params.list('ids[]').collect {
            Long.parseLong(it)
        }
        def categoryId = params.long('categoryId')

        def max = arr.size()

        arr.each {
            long id ->

                def weight = max--;

                SearchItem.findById(id)?.with {
                    rank = weight;
                    save(failOnError: true, flush: true)
                }

                Item.findAllByBaseItemIdAndShopType(id, 1 as Byte)?.each {
                    Item item ->
                        SearchItem.findById(item.id)?.with {
                            rank = weight;
                            save(failOnError: true, flush: true)
                        }
                }

        }

        render([result: "ok"] as JSON)
    }

    def index() {

        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)

        //brand id
        Long brandId=params.long('brandId')
        //tags  id
        Long tagId=params.long('tagId')
        //商品编码的查询
        String itemcode=params.itemcode

        def c = Item.createCriteria()

        def childCategoryList
        def childList

        if (params.level1Category) {

            childCategoryList = Category.findAllByParentId(params.long('level1Category'))

            childList = childCategoryList*.id

        }

        //对各个字段进行排序
        String  fieldName=params.fieldName
        String  fieldstate=params.fieldstate


        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("approveStatus", 1 as byte)
            eq("type", 1 as byte)
            eq("shopId", 999L)

            if (params.query) {
                ilike("title", "%" + params.query + "%")
            }
            if (params.category && (params.category != '-1')) {
                eq("categoryId", params.long('category'))
            }
            if(childList){
                'in'("categoryId", childList)
            }

            if (brandId>0)
            {
                eq("brandId",brandId)
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

            if (itemcode){
                eq("code", itemcode)
            }


            //各字段排序
            if(fieldName && fieldstate){
                order(fieldName, fieldstate)
            }else{
                order("id", "desc")
            }

        }

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
                                info+="活动限量数:"+obj.activityNum+")"
                                xgbTagMap.put(item.id,info)
                            }
                        }
                }

                def currentTags

                if (tagsOnShow) {
                    currentTags = Tags.findAllByIdInList(tagsOnShow*.tagId)
                }
                itemTagMap.put(item.id, currentTags)

        }

        def categoryMap = Category.findAllByIdGreaterThanAndStatus(20000000L, 1 as byte).collectEntries { [it.id, it] }

        //Brand获取
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        //标签列表
        List<Tags>  tagsList=Tags.findAll()


        render(view: 'index', model: [
                itemTagMap  : itemTagMap,
                xlTagMap    : xlTagMap,
                xgbTagMap    : xgbTagMap,
                PageMap    : PageMap,
                total       : pagedResultList?.totalCount,
                itemList    : pagedResultList,
                params      : params,
                categoryList: categoryList,
                brandMap    : brandMap,
                mikuBrandList:mikuBrandList,
                tagsList:tagsList,
                categoryMap : categoryMap
        ])

    }
}

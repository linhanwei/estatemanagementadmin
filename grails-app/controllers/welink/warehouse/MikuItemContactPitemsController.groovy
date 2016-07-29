package welink.warehouse

import com.google.common.collect.ImmutableMap
import grails.orm.PagedResultList
import welink.common.Category
import welink.common.MikuBrand
import welink.estate.Tags

class MikuItemContactPitemsController {


    static ImmutableMap<String, String> ITEM_TYPE = ImmutableMap.builder() //
            .put("9", "成为代理")
            .put("10", "刮刮卡")
            .put("13", "扫码中奖")
            .put("12", "定制商品")
            .build()

    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .put(500, "500")
            .put(1000, "1000")
            .put(2000, "2000")
            .build()

    //米酷与进销存的互相关联的内容
    def index() {
        PagedResultList pagedResultList
        def iandpi=MikuItemAndPitems.createCriteria()
        pagedResultList=iandpi.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('flag',1 as  byte)
        }
        List<MikuPiteminfo> list=new ArrayList<MikuPiteminfo>()
        pagedResultList.iterator().each {
            MikuItemAndPitems mikuItemAndPitems->
                MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(mikuItemAndPitems.pitemId)
                list.add(mikuPiteminfo)
        }
        return [
                PageMap    : PageMap,
                total        : pagedResultList?.totalCount,
                params       : params,
                list         : list,
        ]
    }




    def doItemIndex(){
        Long id=params.long('id')
        MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(id)
        if (mikuPiteminfo){
            //商品页面的具体的参数
            List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)
            //查出对应的Brand
            List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
            def tags = Tags.findAllByTypeAndStatus(1, 1)
            return [
                    tags        : tags,
                    categoryList: categoryList,
                    itemTypeList: ITEM_TYPE,
                    mikuBrandList:mikuBrandList,
                    mikuPiteminfo:mikuPiteminfo
            ]
        }else{
            redirect(action: "index")
        }
    }




    //在进销存内容修改了对应的数据的状态标示的改变
    def havaDoDataindex(){
        PagedResultList pagedResultList
        def iandpi=MikuItemAndPitems.createCriteria()
        pagedResultList=iandpi.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('flag',0 as  byte)
        }
        List<MikuPiteminfo> list=new ArrayList<MikuPiteminfo>()
        pagedResultList.iterator().each {
            MikuItemAndPitems mikuItemAndPitems->
                MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(mikuItemAndPitems.pitemId)
                list.add(mikuPiteminfo)
        }
        return [
                PageMap    : PageMap,
                total        : pagedResultList?.totalCount,
                params       : params,
                list         : pagedResultList,
        ]
    }






}

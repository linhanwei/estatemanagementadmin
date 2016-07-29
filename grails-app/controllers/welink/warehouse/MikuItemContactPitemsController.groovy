package welink.warehouse

import com.google.common.collect.ImmutableMap
import grails.orm.PagedResultList
import welink.common.Category
import welink.common.MikuBrand
import welink.estate.Tags

class MikuItemContactPitemsController {


    static ImmutableMap<String, String> ITEM_TYPE = ImmutableMap.builder() //
            .put("9", "��Ϊ����")
            .put("10", "�ιο�")
            .put("13", "ɨ���н�")
            .put("12", "������Ʒ")
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

    //�׿��������Ļ������������
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
            //��Ʒҳ��ľ���Ĳ���
            List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)
            //�����Ӧ��Brand
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




    //�ڽ����������޸��˶�Ӧ�����ݵ�״̬��ʾ�ĸı�
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

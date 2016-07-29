package welink.estate

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import welink.business.PageInfo
import welink.common.Item
import welink.common.MikuBrand
import welink.common.MikuViewConnectInfo
import welink.common.MikuViewInfo

class PageManageController {

    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .build()

    static ImmutableMap<Integer, String> typeMap = ImmutableMap.builder() //
            .put(418, "顶部活动位")
            .put(419, "类目入口")
            .put(420, "品牌入口")
            .put(421, "活动专区")
            .put(422, "秒杀专区")
//            .put(423, "商品专区")
            .build()


    static  Byte DelStatus=0 as  byte
    static  Byte HideStatus=1 as  byte
    static  Byte ShowStatus=2 as  byte

    //首页
    def index() {
        String  name=params.name
        def mv=MikuViewInfo.createCriteria()
        PagedResultList pagedResultList=mv.list (max: params.max ?: 10, offset: params.offset ?: 0){
            eq('status',1 as byte)
            if (name){
//              eq('name',name)
                ilike("name", "%" + name + "%")
            }
        }
        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                mlist          : pagedResultList,
        ]

    }

    //添加页面的操作
    def addPage(){
    }

    def delete()
    {
        Long id=params.long('id')
        MikuViewInfo mikuViewInfo=MikuViewInfo.findById(id)
        mikuViewInfo.with {
            it.status=DelStatus
            it.save(failOnError: true, flush: true)
        }
        redirect(action: 'index')
    }

    //添加页面操作
    @Transactional
    def addPageDo() {
        Long id=params.long('id')
        String  name=params.name
        String  info=params.info
        MikuViewInfo mikuViewInfo=MikuViewInfo.findById(id)?MikuViewInfo.findById(id):new MikuViewInfo()
        if (name){
            mikuViewInfo.with {
                it.name=name
                it.info=info
                it.status=1 as byte
                it.otherinfo=info
                it.save(failOnError: true, flush: true)
            }
        }
        redirect(action: 'index')
    }

    //进入编辑页面
    @Transactional
    def edit(){
        Long id=params.long('id')
        MikuViewInfo mikuViewInfo=MikuViewInfo.findById(id)
        return [
                page:mikuViewInfo
        ]
    }

    def pageSetting() {
        Long id=params.long('id')
        //查询对应添加内容页面
        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAll("from MikuViewConnectInfo as m where m.viewId="+id+" and oneLevelFlag=1 and oneLevelStatus!=0")
//        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAllByViewIdAndOneLevelFlagAndOneLevelStatusNotEqual(id,HideStatus,DelStatus)
        return [
                mlist             : list as JSON,
                typelist          : typeMap as JSON,
                viewId:             id
        ]
    }

    def doBannerInfo(Banner banner,Integer type){
        PageInfo pageInfo=new PageInfo()
        pageInfo.with {
            it.id=banner.id
            it.imginfo=banner.picUrl
            it.title=banner.title
            it.type=type
            it.info="Banner信息"
        }
        return  pageInfo
    }

    def doItemInfo(Item item,Integer type){
        PageInfo pageInfo=new PageInfo()
        pageInfo.with {
            it.id=item.id
            it.imginfo=item.picUrls
            it.title=item.title
            it.type=type
            it.info="商品信息"
        }
        return  pageInfo
    }



//============================================================以下是接口内容======================================================//

    //进入配置页面的查询(一级配置)
    def selectOneLevelById(){
        Long id=params.long('id')
        //查询对应添加内容页面
        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAllByViewIdAndOneLevelFlagAndOneLevelStatusNotEqual(id,HideStatus,DelStatus)
        render(list as JSON)
    }
    //二级配置的查询
    def selectTwoLevelById(){
        Long id=params.long('id')
        Long oneLevelid=params.long('oneLevelid')
        //查询对应的二级页面
        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAllByViewIdAndOneLevelFlagAndTwoLevelStatusNotEqual(id,oneLevelid,DelStatus,DelStatus)
        render(list as JSON)
    }


    //选择项的内容的获取[全部类型的内容]
    def getContentInfo(){
        Integer type=params.int('type')
        if (type){
            List<PageInfo> list=new ArrayList<PageInfo>()
            if (type == 423){
                List<Item> itemList=Item.findAllByTypeAndApproveStatusAndShopType(HideStatus,HideStatus,HideStatus)
                itemList.each {
                    Item item->
                        PageInfo pageInfo= doItemInfo(item,type)
                        list.add(pageInfo)
                }
            }else{
                List<Banner> bannerList=Banner.findAllByStatusAndType(HideStatus,type)
                bannerList.each {
                    Banner banner->
                        PageInfo pageInfo=doBannerInfo(banner,type)
                        list.add(pageInfo)
                }
            }
            render(list as JSON)
        }else{
            render("" as JSON)
        }
    }


    //根据条件进行查询
    def getContentInfoByTitle(){
        Integer type=params.int('type')
        String title=params.title
        if (type){
            List<PageInfo> list=new ArrayList<PageInfo>()
            if (type == 423){
                List<Item> itemList=Item.findAllByApproveStatusAndShopTypeAndTypeAndTitleLike(HideStatus,HideStatus,HideStatus,"%" + title + "%")
                itemList.each {
                    Item item->
                        PageInfo pageInfo= doItemInfo(item,type)
                        list.add(pageInfo)
                }
            }else{
                List<Banner> bannerList=Banner.findAllByStatusAndTypeAndTitleLike(HideStatus,type,"%" + title + "%")
                bannerList.each {
                    Banner banner->
                        PageInfo pageInfo=doBannerInfo(banner,type)
                        list.add(pageInfo)
                }
            }
            render(list as JSON)
        }else{
            render("" as JSON)
        }
    }

    //进行添加选择项内容
    def getSelectTypeContent(){
        render(typeMap as JSON)
    }

    //添加1级大模块
    @Transactional
    def oneLevelInfo(){
        Long type=params.long('type')
        def name=params.name
        def viewId=params.long('viewId')
        MikuViewConnectInfo mikuViewConnectInfo=new MikuViewConnectInfo()
        mikuViewConnectInfo.with {
            it.twoLevelStatus=ShowStatus
            it.oneLevelStatus=ShowStatus
            //模块的添加
            it.oneLevelFlag=HideStatus
            it.name=name
            it.viewId=viewId
            it.type=type
            it.oneLevelId=-1L
            it.info=name
            it.time=new Date()
            it.save(failOnError: true, flush: true)
        }
        render(mikuViewConnectInfo as JSON)
    }


    //添加2级的小模块
    @Transactional
    def twoLevelInfo(){
        Long viewId=params.long('viewId')
        Long oneLevelId=params.long('oneLevelId')
        Long twoLevelId=params.long('twoLevelId')
        def name=params.name
        def info=params.info
        def type=params.long('type')
        MikuViewConnectInfo mikuViewConnectInfo=new MikuViewConnectInfo()
        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAllByViewIdAndOneLevelId(viewId,oneLevelId)
//        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAllByViewIdAndOneLevelIdAndTwoLevelStatusNotEqual(viewId,oneLevelId,DelStatus)
        mikuViewConnectInfo.with {
            it.twoLevelStatus=ShowStatus
            it.oneLevelStatus=ShowStatus
            //模块的添加
            it.oneLevelFlag=DelStatus
            it.name=name
            it.viewId=viewId
            it.type=type
            it.twoLevelId=twoLevelId
            it.oneLevelId=oneLevelId
            it.info=info
            it.time=new Date()
            it.weight=(list.size()+1)
            it.save(failOnError: true, flush: true)
        }
        render(mikuViewConnectInfo as JSON)
    }

    //操作大模块内容
    def DoOneLevelById(){
        Long id=params.long('id')
        Byte status=params.byte('status')
        MikuViewConnectInfo mikuViewConnectInfo=MikuViewConnectInfo.findById(id)
        mikuViewConnectInfo.with {
            if (status==DelStatus){
                it.weight=0L
            }
            it.oneLevelStatus=status
            it.time=new Date()
            it.save(failOnError: true, flush: true)
        }
        render(mikuViewConnectInfo as JSON)
    }

    //操作二级模块内容
    def DoTwoLevelById(){
        Long id=params.long('id')
        Byte status=params.byte('status')
        MikuViewConnectInfo mikuViewConnectInfo=MikuViewConnectInfo.findById(id)
        mikuViewConnectInfo.with {
            if (status==DelStatus){
                it.weight=0L
            }
            it.twoLevelStatus=status
            it.time=new Date()
            it.save(failOnError: true, flush: true)
        }
        render(mikuViewConnectInfo as JSON)
    }



    //待定
    def getSelectTypeAllInfo(){

    }

    //进行批量的添加对应的二级内容
    @Transactional
    def addsomeLevelInfo(){
        def content=params.content
        if (content){
            //json字符串数组进行变成对应的对象，批量添加
            def info=com.alibaba.fastjson.JSON.parseArray(content,MikuViewConnectInfo.class);
            for (int i=0;i<info.size();i++){
                MikuViewConnectInfo m=info.get(i)
                m.time=new Date()
                m.save(failOnError: true, flush: true)
            }
        }
        render(true)
    }


    //点击第一级的level的对象获取的它本身具有的二级的数据
    def getTwoLevelByOneLevelId(){
        Long oneLevelId=params.long('oneLevelId')
        Long viewId=params.long('viewId')
        List<MikuViewConnectInfo> list=MikuViewConnectInfo.findAllByViewIdAndOneLevelIdAndOneLevelFlag(viewId,oneLevelId,DelStatus)
        render(list as JSON)
    }



    //点击第一级的level的对象获取的它本身具有的二级的数据  + 根据类型来进行查询对应选择项的内容的获取[全部类型的内容]
    def clickOneLevelToGetContent(){
        Long oneLevelId=params.long('oneLevelId')
        Long viewId=params.long('viewId')
        Integer type=params.int('type')
        def map=[:]
        List<MikuViewConnectInfo> mInfolist=MikuViewConnectInfo.findAll("from MikuViewConnectInfo as m where m.viewId="+viewId+" and oneLevelId="+oneLevelId+" and oneLevelFlag=0 and twoLevelStatus>0 order by weight")
//        List<MikuViewConnectInfo> mInfolist=MikuViewConnectInfo.findAllByViewIdAndOneLevelIdAndOneLevelFlagAndTwoLevelStatusNotEqual(viewId,oneLevelId,DelStatus,DelStatus)
        map.put('initData',mInfolist)
        if (type){
            List<PageInfo> list=new ArrayList<PageInfo>()
            if (type == 423){
                List<Item> itemList=Item.findAllByTypeAndApproveStatusAndShopType(HideStatus,HideStatus,HideStatus)
                itemList.each {
                    Item item->
                        PageInfo pageInfo= doItemInfo(item,type)
                        list.add(pageInfo)
                }
            }else{
                List<Banner> bannerList=Banner.findAllByStatusAndType(HideStatus,type)
                for (int i=0;i<bannerList.size();i++){
                    Banner banner=bannerList.get(i)
                    PageInfo pageInfo=doBannerInfo(banner,type)
                    int mm=0
                    for (int j=0;j<mInfolist.size();j++){
                        if(mInfolist.get(j).twoLevelId==banner.id){
                            mm=1
                            break
                        }
                    }
                    if (mm){
                        pageInfo.flag=1
                    }else
                    {
                        pageInfo.flag=0
                    }
                    list.add(pageInfo)
                }
//                bannerList.each {
//                    Banner banner->
//                        PageInfo pageInfo=doBannerInfo(banner,type)
//                        list.add(pageInfo)
//                }
            }
            map.put('searchData',list)
        }
        render(map as JSON)
    }




    //当进行上下移动的时候进行调用的接口
    //参数：2个对应Banner的位置与id
    @Transactional
    def pxBannerLocation(){
        Long targetId=params.long('targetId')
        Long targetWeight=params.long('targetWeight')
        Long hwtargetId=params.long('hwtargetId')
        Long hwtargetWeight=params.long('hwtargetWeight')
        MikuViewConnectInfo target=MikuViewConnectInfo.findById(targetId)
        target.weight=hwtargetWeight
        target.save(failOnError: true, flush: true)
        MikuViewConnectInfo hwtarget=MikuViewConnectInfo.findById(hwtargetId)
        hwtarget.weight=targetWeight
        hwtarget.save(failOnError: true, flush: true)
//        def map=[:]
//        map.put(target)
//        map.put(hwtarget)
        render(true)
//        render(map as JSON)
    }

    //进行对一级类目修改:调用2个接口
    //根据一级类目id获取一级类目的内容
    //参数：id
    def getOneLevelById(){
        Long id=params.long('id')
        MikuViewConnectInfo mm=MikuViewConnectInfo.findById(id)
        render(mm as JSON)
    }

    //根据一级类目的id与名称来进行修改一级类目的值
    def modifyOneLevelCotent(){
        Long id=params.long('id')
        String name=params.name
        MikuViewConnectInfo mm=MikuViewConnectInfo.findById(id)
        mm.name=name
        mm.save(failOnError: true, flush: true)
        render(true)
//        render(mm as JSON)
    }

}

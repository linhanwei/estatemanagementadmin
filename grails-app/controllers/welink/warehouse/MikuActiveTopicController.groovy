package welink.warehouse

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.common.Category
import welink.common.Item
import welink.common.MikuBrand
import welink.estate.Banner

class MikuActiveTopicController {
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
            .build()


    static ImmutableMap<Integer, String> redirectTypeMap = ImmutableMap.builder() //
            .put(310, "Url")
            .put(311, "商品ID")
            .put(321, "满减商品Id值集合")
            .put(320, "无")
            .build()


    static ImmutableMap<Integer, String> typeMap = ImmutableMap.builder() //
            .put(418, "顶部活动位")
            .put(419, "类目入口")
            .put(420, "品牌入口")
            .put(421, "活动专区")
            .put(422, "秒杀专区")
            .put(423, "顶部栏位")
            .put(424, "橱窗位")
            .put(425, "满减活动区")
            .build()


    static ImmutableMap<Integer, String> MoudleMap = ImmutableMap.builder()
//            .put(0,"应用首页")
//            .put(1,"商品一级分类")
//            .put(2,"商品分类首页")
//            .put(3,"众筹首页")
//            .put(4,"众筹新品上市")
//            .put(5,"众筹排行榜")
            .put(6,"满减活动")
            .build()



    def modifyweight() {
        if (params.id) {
            Banner banner = Banner.findById(params.long('id'))
            if (banner && params.newWeight) {
                banner.weight = params.int('newWeight')
                if (banner.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def deleteBanner() {
        if (params.id) {
            Banner banner = Banner.findById(params.long('id'))
            if (banner) {
                banner.with {
                    it.status=0 as byte
                    it.save(failOnError: true,flush: true)
                }

                if(banner.topicId){
                    MikuActiveTopic mikuActiveTopic=MikuActiveTopic.findById(banner.topicId)
                    if (mikuActiveTopic){
                        mikuActiveTopic.with {
                            it.lastUpdated=new Date()
                            it.status=0 as byte
                            it.save(failOnError: true,flush: true)
                        }
                    }
                }

                render('true')
                return

            }
        }
        response.status = 405
    }

    def showBanner() {
        if (params.id) {
            Banner banner = Banner.findById(params.long('id'))
            if (banner) {
                banner.showStatus = 1
                if (banner.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def hideBanner() {
        if (params.id) {
            Banner banner = Banner.findById(params.long('id'))
            if (banner) {
                banner.showStatus = 0
                if (banner.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def index() {
        def c = Banner.createCriteria()

        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 1 as byte)
            if (params.queryType) {
                eq('type', params.int('queryType'))
            }
            if (params.queryMoudleType){
                eq('moduleType',params.long('queryMoudleType'))
            }

            if (params.categoryType){
                eq('categoryId',params.long('categoryType'))
            }
            order("showStatus", "desc")
            order("type", "desc")
            order("weight", "asc")
        }

        //大类名称
        List<Category> cList=Category.findAllByStatusAndParentId(1 as byte,null)
        def map=[:]
        cList.each {
            map.put(it.id,it.name)
        }

        return [
                redirectTypeMap: redirectTypeMap,
                typeMap        : typeMap,
                PageMap        : PageMap,
                MoudleMap      : MoudleMap,
                map            : map,
                bannerList     : pagedResultList,
                total          : pagedResultList.totalCount,
                params         : params,
        ]
    }

    def addBannerHtml() {
        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1 as byte)
        return [
                categoryList: categoryList,
                redirectTypeMap: redirectTypeMap,
                MoudleMap:       MoudleMap,
                typeMap        : typeMap,
        ]
    }

    @Transactional
    def addBanner() {

        withForm {
            String title = params.title
            Integer type = params.int('type')
            List<String> bannerPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
            String description = params.description
            Integer redirectType = params.int('redirectType')
            String target = params.target
            Long id = params.id ? params.long('id') : null
            Banner banner = id ? Banner.findById(id) : new Banner()
            Integer weight = params.int('weight')

            //新添加banne额外信息
            //开始时间  结束时间  文字是否展示  还有类目信息
            Long category = params.long('category')
            Long level1Category = params.long('level1Category')
            DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

            String ShowText=params.ShowText
            Long moduleType=params.long('moduleType')

            banner.with {
                it.title = title
                it.picUrl = StringUtils.join(bannerPics, ';')
                it.description = description
                it.redirectType = redirectType
                it.target = target
                it.status = 1 as byte
                it.weight = weight
                if (params.showStatus) {
                    it.showStatus = 1 as byte
                } else {
                    it.showStatus = 0 as byte
                }

                //活动与秒杀
                it.type = type
                if (type==421 || type==422){
                    //新添的信息
                    if (params.startTime)
                    {
                        DateTime startTime = formatter.parseDateTime(params.startTime)
                        it.onlineStartTime=startTime.toDate()
                    }

                    if (params.endTime)
                    {
                        DateTime endTime = formatter.parseDateTime(params.endTime)
                        it.onlineEndTime=endTime.toDate()
                    }

                    if (ShowText)
                    {
                        it.showText=1 as byte
                    } else {
                        it.showText = 0 as byte
                    }
                }else {
                    it.onlineStartTime=null
                    it.onlineEndTime=null
                    it.showText = 0 as byte
                }

                //首页
                if (moduleType==1)
                {
                    if (category  && category>0)
                    {
                        it.categoryId=category
                    }
                    else {
                        if (level1Category ){
                            it.categoryId=level1Category
                        }
                        else
                        {
                            it.categoryId=category
                        }
                    }
                    it.moduleType=1
                }
                if(moduleType==6 && type==425){
                    it.moduleType=moduleType
                    if (params.startTime)
                    {
                        DateTime startTime = formatter.parseDateTime(params.startTime)
                        it.onlineStartTime=startTime.toDate()
                    }
                    if (params.endTime)
                    {
                        DateTime endTime = formatter.parseDateTime(params.endTime)
                        it.onlineEndTime=endTime.toDate()
                    }
                }
                else
                {
                    it.moduleType=moduleType
                    it.categoryId=-1
                }
                it.topicId=-1L
                save(failOnError: true, flush: true)
            }



            //满减活动
            if(moduleType==6 && type==425){
                //进行添加专区活动
                if (target){
                    //是否为编辑的状态【标示为是否有对应的topicId】
                    Long topicId=params.long('topicId')
                    //参数比例
                    String parameters = params.activeParameters
                    String[] strArr=target.trim().split(';')
                    Date startdate=null
                    Date enddate=null
                    if (params.startTime)
                    {
                        DateTime startTime = formatter.parseDateTime(params.startTime)
                        startdate=startTime.toDate()
                    }
                    if (params.endTime)
                    {
                        DateTime endTime = formatter.parseDateTime(params.endTime)
                        enddate=endTime.toDate()
                    }
                    //专区活动的添加
                    MikuActiveTopic mikuActiveTopic=topicId?MikuActiveTopic.findById(topicId):new MikuActiveTopic()
                    mikuActiveTopic.with {
                        if(topicId){
                        }else{
                            it.dateCreated=new Date()
                        }
                        it.lastUpdated=new Date()
                        it.name=title
                        it.picUrls=StringUtils.join(bannerPics, ';')
                        it.parameter=parameters
                        it.startTime=startdate
                        it.endTime=enddate
                        it.version=1L
                        it.status=1 as byte
                        it.bannerId=banner.id
                        it.save(failOnError: true, flush: true)
                    }
                    if(topicId){
                        List<MikuTopicItem> itemList=MikuTopicItem.findAllByTopicId(topicId)
                        itemList.each {
                            it.delete()
                        }
                    }
                    //进行商品id的关联
                    for(int i=0;i<strArr.length;i++){
                        MikuTopicItem mikuTopicItem=new MikuTopicItem()
                        mikuTopicItem.with {
                            it.topicId=mikuActiveTopic.id
                            it.itemId=Long.parseLong(strArr[i])
                            it.version=1L
                            it.dateCreated=new Date()
                            it.lastUpdated=new Date()
                            it.save(failOnError: true, flush: true)
                        }
                    }
                    banner.with{
                        it.topicId=mikuActiveTopic.id
                        it.save(failOnError: true, flush: true)
                    }
                }
            }



            redirect(controller: 'banner', action: 'index')
            return;
        }.invalidToken {
            // bad request
            response.status = 405
        }

    }



    def edit()
    {
        Long id=params.long('id')
        MikuActiveTopic topicItem=MikuActiveTopic.findById(id)
        return [
                redirectTypeMap: redirectTypeMap,
                MoudleMap:       MoudleMap,
                typeMap        : typeMap,
                banner      : topicItem,
        ]
    }

    //满减的活动列表
    def list(){
        String query=params.query
        List<MikuActiveTopic> list=MikuActiveTopic.findAll()
        def cc=MikuActiveTopic.createCriteria()
        PagedResultList pagedResultList
        pagedResultList =cc.list(max: params.max ?: 10, offset: params.offset ?: 0) {
//            order('lastUpdated','desc')
            order('id','desc')
            if(query){
                ilike('name',"%" + query + "%")
            }
        }
        return [
                PageMap        : PageMap,
                goodsList: pagedResultList,
                total  : pagedResultList.totalCount,
                params : params,
        ]
    }




    def lookItemDetail() {
        Long id=params.long('id')
        List<MikuTopicItem> itemList=MikuTopicItem.findAllByTopicId(id)
        List<Item> list=new ArrayList<Item>()
        itemList.each {
            Item item = Item.findById(it.itemId)
            if(item){
                MikuBrand brand=MikuBrand.findById(item.brandId)
                item.skus=brand.name
                list.add(item)
            }
        }
        render(template: "onedetail", model: [
                list:list
        ])
    }







    def changeOneActicestatus(){
        Long id=params.long('id')
        Byte status=params.byte('flag')
        MikuActiveTopic mikuActiveTopic=MikuActiveTopic.findById(id)
        mikuActiveTopic.with {
            it.status= status
            it.lastUpdated=new Date()
            it.save(failOnError: true,flush: true)
        }
        redirect(action: "list")
    }





    //进行添加与编辑对应的活动页面
    def doEditOneActive(){
        Byte ActiveType=params.long('ActiveType')
        String name = params.name
        String content = params.content
        List<String> bannerPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        String target = params.content
        Long id = params.id ? params.long('id') : null
        String showStatus=params.showStatus
        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
        //新添加banne额外信息
        //开始时间  结束时间  文字是否展示  还有类目信息
        //参数比例
        String parameters = params.activeParameters
        String[] strArr=target.trim().split(';')
        Date startdate=null
        Date enddate=null
        if (params.startTime)
        {
            DateTime startTime = formatter.parseDateTime(params.startTime)
            startdate=startTime.toDate()
        }
        if (params.endTime)
        {
            DateTime endTime = formatter.parseDateTime(params.endTime)
            enddate=endTime.toDate()
        }
        MikuActiveTopic mikuActiveTopic = id ? MikuActiveTopic.findById(id) : new MikuActiveTopic()
        mikuActiveTopic.with {
                    if(id){
                        List<MikuTopicItem> itemList=MikuTopicItem.findAllByTopicId(id)
                        itemList.each {
                            it.delete()
                        }
                    }else{
                         it.dateCreated=new Date()
                    }
                    it.lastUpdated=new Date()
                    it.name=name
                    it.picUrls=StringUtils.join(bannerPics, ';')
                    it.parameter=parameters
                    it.startTime=startdate
                    it.endTime=enddate
                    it.version=1L
                    it.ActiveType=ActiveType
                    if (showStatus){
                        it.status=1 as byte
                    }
                    else {
                        it.status=0 as byte
                    }
                    it.content=content
                    it.save(failOnError: true, flush: true)
                }
                //进行商品id的关联
                for(int i=0;i<strArr.length;i++){
                    MikuTopicItem mikuTopicItem=new MikuTopicItem()
                    mikuTopicItem.with {
                        it.topicId=mikuActiveTopic.id
                        it.itemId=Long.parseLong(strArr[i])
                        it.version=1L
                        it.dateCreated=new Date()
                        it.lastUpdated=new Date()
                        it.save(failOnError: true, flush: true)
                    }
                }

                redirect(action: "list")

            }






}

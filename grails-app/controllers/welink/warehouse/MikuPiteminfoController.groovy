package welink.warehouse

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import welink.common.Item
import welink.common.MikuBrand
import welink.supply.SupplyGoodsInfo

class MikuPiteminfoController {
    def supplyCateList;
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

    //商品未选状态值
    static ImmutableMap<Integer, String> noCheckStatus = ImmutableMap.builder()
            .put(1, "供应商")
            .put(2, "分类")
            .put(3, "供应商与分类")
            .build()

    def index() {
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        //类目信息
        List<MikuPclassify>  list=MikuPclassify.findAllByIsDeleteAndParentIdNotEqual(0 as byte,0L)
        render(view: 'index', model: [
                mikuBrandList:mikuBrandList,
                list:list
        ])
    }


    def addPitem(){
        String title=params.title
        String area=params.area
        Byte isrefund=params.isrefund?1 as byte:0 as byte
        Integer num=params.int('num')
        Long price = new BigDecimal(params.price) * 100L
        Long postFee = new BigDecimal(params.postFee) * 100L
        Long jhprice = new BigDecimal(params.jhprice) * 100L
        Long xsprice = new BigDecimal(params.xsprice) * 100L
        String code=params.code
        String picode=params.picode
        String memo=params.memo
        String assess=params.assess
        String type=params.type
        Long brandId=params.long('brandId')
        Long pclassifyId=params.long('pclassifyId')
        Long classfiId=params.long('classfiId')
        Long providerId=params.long('providerId')
        String logisticDestrion=params.logisticDestrion
        MikuPiteminfo mikuPiteminfo=new MikuPiteminfo()
        Long id=params.long('id')
        Byte isCheck = 0 as Byte
        if(pclassifyId && providerId){
            isCheck = 1 as Byte
        }

        Byte weight = params.byte('weight')
        if(!weight){
            weight = 0 as Byte;
        }

        UUID uuid = UUID.randomUUID(); //米酷码
        def pitemCode = uuid;

        if (id){
            mikuPiteminfo=MikuPiteminfo.findById(id)

            if(mikuPiteminfo && mikuPiteminfo.pitemCode){
                pitemCode = mikuPiteminfo.pitemCode;
            }
        }
        mikuPiteminfo.with {
            it.title=title
            it.num=num
            it.memo=memo
            if(id){
                it.dateCreated=new Date()
            }
            it.lastUpdated=new Date()
            it.price=price
            it.assess=assess
            it.postFee=postFee
            it.logisticDestrion=logisticDestrion
            it.pitemCode=picode
            it.rknum=num
            it.isrefund=isrefund
            it.code=code
            it.cknum=0
            it.sumFen=0
            it.numFen=0
            it.type=type
            it.area=area
            it.brandId=brandId
            it.jhprice=jhprice
            it.xsprice=xsprice
            it.pclassifyId = pclassifyId
            it.classfiId=classfiId
            it.providerId=providerId
            it.isCheck = isCheck
            it.pitemCode = pitemCode
            it.weight = weight
            it.save(failOnError: true, flush: true)
        }

        if(isCheck == 1){
            redirect(action: "list")
        }else{
            redirect(action: "checkList")
        }

    }

    def list(){

        //查询条件
        String commodity=params.commodity
        String miic=params.miic
        String cic=params.cic


        //条件
        Byte isparent=params.byte('isparent')
        Long tid=params.long('tid')

        def c =MikuPiteminfo.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?:10, offset: params.offset ?: 0) {

            if (commodity){
                ilike('title',"%"+commodity+"%")
            }

            if (miic){
                eq("pitemCode",miic)
            }

            if (cic){
                eq("code",cic)
            }

            eq("isCheck",1 as byte)
            eq("status",1 as byte)
            if (isparent == 0 as byte){
                eq("classfiId",tid)
            }else if (isparent == 1 as byte){
                List<MikuPclassify>  list=MikuPclassify.findAllByParentId(tid)
                'in'('classfiId',list*.id )
            }
            order("lastUpdated","desc")
        }


        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList
        ]
    }

    //待审核商品列表
    def checkList(){

        String code = params.code; //供应商商品编码
        String title = params.title;//商品名称
        Integer status = params.int('status'); //未绑定状态值: 1:未绑定供应商,2:未绑定分类,3:未绑定供应商与分类

        def mikuPiteminfo = MikuPiteminfo.createCriteria()
        PagedResultList pagedResultList = mikuPiteminfo.list(max: params.max ?:10, offset: params.offset ?: 0) {
            switch (status){
                case 1:
                    eq('providerId',0L)
                    break;
                case 2:
                    eq('pclassifyId',0L)
                    break;
                case 3:
                    eq('providerId',0L)
                    eq('pclassifyId',0L)
                    break;
            }

            if(code){
                eq('code',code)
            }
            if(title){
                ilike('title',"%"+title+"%")
            }
            eq("isCheck",0 as byte)

            order("lastUpdated","desc")
        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList,
                noCheckStatus : noCheckStatus
        ]
    }

    //查询商品
    def search(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'查询失败');
        returnData.put('result' , '');
        int i=0

        //查询条件
        Long id=params.long('id')
        String words = params.words
        Byte isCheck = params.byte('ischeck')

        if(id){
            def info = MikuPiteminfo.findById(id);
            SupplyGoodsInfo supplyGoodsInfo = new SupplyGoodsInfo();

            if(info){
                supplyGoodsInfo.id = info.id;
                supplyGoodsInfo.pclassifyId = info.pclassifyId;
                supplyGoodsInfo.title = info.title;
                supplyGoodsInfo.num = info.num;
                supplyGoodsInfo.price = info.price;
                supplyGoodsInfo.postFee = info.postFee;
                supplyGoodsInfo.status = info.status;
                supplyGoodsInfo.brandId = info.brandId;
                supplyGoodsInfo.isrefund = info.isrefund;
                supplyGoodsInfo.dateCreated = info.dateCreated;
                supplyGoodsInfo.lastUpdated = info.lastUpdated;
                supplyGoodsInfo.changeId = info.changeId;
                supplyGoodsInfo.memo = info.memo;
                supplyGoodsInfo.assess = info.assess;
                supplyGoodsInfo.logisticDestrion = info.logisticDestrion;
                supplyGoodsInfo.cknum = info.cknum;
                supplyGoodsInfo.rknum = info.rknum;
                supplyGoodsInfo.area = info.area;
                supplyGoodsInfo.pitemCode = info.pitemCode;
                supplyGoodsInfo.code = info.code;
                supplyGoodsInfo.jhprice = info.jhprice;
                supplyGoodsInfo.xsprice = info.xsprice;
                supplyGoodsInfo.type = info.type;
                supplyGoodsInfo.sumFen = info.sumFen;
                supplyGoodsInfo.numFen = info.numFen;
                supplyGoodsInfo.classfiId = info.classfiId;
                supplyGoodsInfo.providerId = info.providerId;
                supplyGoodsInfo.isCheck = info.isCheck;
                supplyGoodsInfo.keyword = info.keyword;

                //查询分类名称
                if(info.pclassifyId){
                    def cateInfo = MikuPclassify.findById(info.pclassifyId);
                    if(cateInfo){
                        supplyGoodsInfo.cateName = cateInfo.name;
                    }

                }

                //查询供应商名称
                if(info.providerId){
                    def supplyInfo = MikuProvider.findById(info.providerId);
                    if(supplyInfo){
                        supplyGoodsInfo.providerName = supplyInfo.name;
                        supplyGoodsInfo.providerCateId = supplyInfo.clssfiyId;
                    }

                }
            }
            returnData.put('status' ,1);
            returnData.put('result' , supplyGoodsInfo);
            returnData.put('msg' ,'查询成功');

            render(returnData as JSON);
        }

        def c =MikuPiteminfo.createCriteria()

        PagedResultList pagedResultList = c.list(max: params.max ?:1000, offset: params.offset ?: 0) {

            if (words){
                ilike('title',"%"+words+"%")
            }

            if(isCheck){
                eq("isCheck",isCheck)
            }

            order("lastUpdated","desc")
        }

        if(pagedResultList){

            returnData.put('result' , pagedResultList);
            returnData.put('status' ,1);
            returnData.put('msg' ,'查询成功');

        }

        render(returnData as JSON);
    }

    //审核商品
    def checkGoods(){
            Map<String,Object> returnData = new HashMap<String, Object>();
            returnData.put('status' ,0);
            returnData.put('msg' ,'更改失败');
            returnData.put('result' , '');

            //已有商品信息
            Long id=params.long('id')
            MikuPiteminfo info
            if(id){
                info = MikuPiteminfo.findById(id)
            }else{
                returnData.put('msg' ,'请选择已经审核的商品ID');
                render(returnData as JSON);
            }

            UUID uuid = UUID.randomUUID(); //米酷码

            //需要修改信息id
            Long eid = params.long('eid')
            if (eid){
                MikuPiteminfo editInfo = MikuPiteminfo.findById(eid)
                if(editInfo && info){

                    if(editInfo.isCheck == 1){
                        returnData.put('msg' ,'该商品已经审核!');
                        render(returnData as JSON);
                    }

                    editInfo.with {
                        it.pclassifyId = info.pclassifyId
                        it.pitemCode = info.pitemCode ? info.pitemCode : uuid;

                        if(editInfo.providerId){
                            it.isCheck = 1 as byte
                        }

                        it.save(failOnError: true, flush: true)
                    }

                    returnData.put('status' ,1);
                    returnData.put('msg' ,'更改成功');
                    returnData.put('result' , '');
                    render(returnData as JSON);
                }else{
                    render(returnData as JSON);
                }
            }else{
                returnData.put('msg' ,'请选择需要审核的商品ID');
                render(returnData as JSON);
            }

    }

    //绑定供应商
    def bingSupplier(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'更改失败');
        returnData.put('result' , '');

        Long id = params.long('id') //商品ID
        Long pclassifyId = params.long('cateId') //商品分类ID
        Long providerId = params.long('providerId') //供应商ID

        if(id < 0){
            returnData.put('msg' ,'请选择商品');
            render(returnData as JSON);
        }

        if(providerId < 0){
            returnData.put('msg' ,'请选择供应商');
            render(returnData as JSON);
        }

        UUID uuid = UUID.randomUUID(); //米酷码
        MikuPiteminfo editInfo = MikuPiteminfo.findById(id);
        pclassifyId = pclassifyId >= 0 ? pclassifyId : editInfo.pclassifyId;

        if(editInfo){
            editInfo.with {
                it.providerId = providerId;
                it.pclassifyId = pclassifyId;

                if(!editInfo.pitemCode){
                    it.pitemCode = uuid;
                }

                //只有米酷码,供应商ID,商品分类ID都关联上才能算审核通过
                if(pclassifyId > 0 && providerId > 0){
                    it.isCheck = 1 as byte
                }

                it.save(failOnError: true, flush: true)
            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'更改成功');
            returnData.put('result' , '');

        }

        render(returnData as JSON);
    }

    //商品打码
    def hitCode(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'更改失败');
        returnData.put('result' , '');

        Long id = params.long('id') //商品ID

        if(!id){
            returnData.put('msg' ,'请选择商品');
            render(returnData as JSON);
        }

        UUID uuid = UUID.randomUUID(); //米酷码
        MikuPiteminfo editInfo = MikuPiteminfo.findById(id);

        if(editInfo){

            if(editInfo.pitemCode){
                returnData.put('msg' ,'该商品已经有米酷码!');
                render(returnData as JSON);
            }

            editInfo.with {

                if(!editInfo.pitemCode){
                    it.pitemCode = uuid;
                }

                //只有米酷码,供应商ID,商品分类ID都关联上才能算审核通过
                if(editInfo.pclassifyId && editInfo.providerId){
                    it.isCheck = 1 as byte
                }

                it.save(failOnError: true, flush: true)
            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'更改成功');
            returnData.put('result' , '');

        }

        render(returnData as JSON);
    }

    //撤销审核
    def cancelCheck(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'更改失败');
        returnData.put('result' , '');

        Long id = params.long('id') //商品ID

        if(!id){
            returnData.put('msg' ,'请选择商品');
            render(returnData as JSON);
        }

        MikuPiteminfo editInfo = MikuPiteminfo.findById(id);

        if(editInfo){
            editInfo.with {

                it.isCheck = 0 as byte

                it.save(failOnError: true, flush: true)
            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'更改成功');
            returnData.put('result' , '');

        }

        render(returnData as JSON);
    }

    def edit(){
        def cateNameList
        def providerName

        Long id=params.long('id')
        MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(id)
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)


        if(mikuPiteminfo){
            //类目信息
            if(mikuPiteminfo.pclassifyId){
                def cateInfo = MikuPclassify.findById(mikuPiteminfo.pclassifyId)
                if(cateInfo){
                    supplyCateList = ''; //初始化
                    cateNameList = searchGoodsCate(cateInfo.parentId);
                    cateNameList = cateNameList ? cateNameList+"/"+cateInfo.name : cateInfo.name;
                }
            }

            //供应商信息
            if(mikuPiteminfo.providerId){
                def providerInfo =MikuProvider.findById(mikuPiteminfo.providerId);
                if(providerInfo){
                    providerName = providerInfo.name;
                }
            }

        }
//        List<MikuPclassify>  list=MikuPclassify.findAllByIsDeleteAndParentIdNotEqual(0 as byte,0L)
        //改变一下思路做法:先查出所有的子类的节点信息
//        List<MikuProvider> plist=MikuProvider.findAllByClssfiyId(mikuPiteminfo.classfiId)
//        List<MikuProvider> plist=MikuProvider.findAllByClssfiyIdAndStatus(mikuPiteminfo.classfiId,1 as byte)

        return [
                item:mikuPiteminfo,
                mikuBrandList:mikuBrandList,
//                plist:plist,
//                list:list,
                cateNameList:cateNameList,
                providerName:providerName
        ]
    }

    //遍历查找父级所有分类获取分类名字 supplyCateList
    def searchGoodsCate(Long cateId){

        if(!cateId){
            return supplyCateList;
        }

        def cateInfo = MikuPclassify.findById(cateId)
        if(cateInfo){
            if(cateInfo.level == 1){
                if(supplyCateList){
                    return cateInfo.name+'/'+ supplyCateList;
                }else{
                    return cateInfo.name;
                }

            }else{
                if(supplyCateList){
                    supplyCateList = cateInfo.name+'/'+ supplyCateList;
                }else{
                    supplyCateList = cateInfo.name;
                }

                searchSupplyCate(cateInfo.parentId);
            }
        }else{
            return supplyCateList;
        }

    }

    //查找遍历组装所有的分类
    def searchGoodsAllCate(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'查询失败');
        returnData.put('result' , '');

        Long cateId = params.long('cateId')

        if(!cateId){
            returnData.put('msg' ,'请选择分类');
            render(returnData as JSON);
        }

        def cateInfo = MikuPclassify.findById(cateId);
        if(cateInfo){
            supplyCateList = ''; //初始化
            def cateNameList = searchGoodsCate(cateInfo.parentId);
            cateNameList = cateNameList ? cateNameList+"/"+cateInfo.name : cateInfo.name;

            returnData.put('status' ,1);
            returnData.put('msg' ,'查询成功');
            returnData.put('result' , cateNameList);
        }

        render(returnData as JSON);
    }


    def copy(){
        Long id=params.long('id')
        MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(id)
        MikuPiteminfo newp=new MikuPiteminfo()
        newp.with {
            it.title=mikuPiteminfo.title+"-复制"
            it.num=mikuPiteminfo.num
            it.memo=mikuPiteminfo.memo
            it.dateCreated=new Date()
            it.price=mikuPiteminfo.price
            it.assess=mikuPiteminfo.assess
            it.postFee=mikuPiteminfo.postFee
            it.logisticDestrion=mikuPiteminfo.logisticDestrion
            it.pitemCode=mikuPiteminfo.pitemCode
            it.dateCreated=new Date()
            it.rknum=mikuPiteminfo.rknum
            it.isrefund=mikuPiteminfo.isrefund
            it.code=mikuPiteminfo.code
            it.cknum=0
            it.sumFen=0
            it.numFen=0
            it.type=mikuPiteminfo.type
            it.area=mikuPiteminfo.area
            it.jhprice=mikuPiteminfo.jhprice
            it.xsprice=mikuPiteminfo.xsprice
            it.save(failOnError: true, flush: true)
        }
        redirect(action: "list")
    }


    //删除对应数据
    def delete(){
        Long id=params.long('id')
        MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(id)
        mikuPiteminfo.with {
            it.lastUpdated=new Date()
            it.status=0 as byte
            it.save(failOnError: true, flush: true)
        }
        redirect(action: "list")
    }



    //根据对应的类目把所有的供应商添加上去
    def queryProviderBytId(){
        Long id=params.long('id');
        List<MikuProvider> list=MikuProvider.findAllByClssfiyId(id)
        render(list as JSON)
    }



    //进行对米酷总仓的商品进行供应商的同步
    @Transactional
    def synchroItems(){
        //全部商品
        List<Item> shopItems=Item.findAllByStatusAndApproveStatusAndShopTypeAndTypeNotEqual(1 as byte,1 as byte,1 as byte,7 as byte)
        //产生对应的中间表内容
        shopItems.each {
            Item item->
            //uuid-->每个商品都产生其对应的中间表数据-->再到供应商品的信息内容
            UUID uuid = UUID.randomUUID()
            item.uuid=uuid
            Item sitem=Item.findByBaseItemId(item.id)
            if(sitem){
                    sitem.uuid=uuid
                    sitem.save(flush: true,failOnError: true)
            }
            item.save(flush: true,failOnError: true)
            //中间表操作
            MikuItemAndPitems mikuItemAndPitems=MikuItemAndPitems.findByItemId(item.id)
            if (!mikuItemAndPitems) {
                mikuItemAndPitems=new MikuItemAndPitems()
                //供应商品信息的生成
                MikuPiteminfo mikuPiteminfo=new MikuPiteminfo()
                mikuPiteminfo.with {
                    it.code=item.code
                    it.title=item.title
                    it.num=0
                    it.price=item.price
                    it.jhprice=item.price
                    it.xsprice=item.price
                    it.postFee=item.postFee
                    it.dateCreated=new Date()
                    it.lastUpdated=new Date()
                    it.brandId=item.brandId
                    it.isrefund=item.isrefund
                    it.cknum=0
                    it.rknum=0
                    it.pitemCode=uuid
                    it.type=item.specification
                    it.keyword=item.keyWord
                    it.version=1L
                    it.weight=1 as byte
                    it.isCheck=1 as byte
                    it.save(flush: true,failOnError: true)
                }
                mikuItemAndPitems.with {
                    it.uuid=uuid
                    it.date_created=new Date()
                    it.last_updated=new Date()
                    it.flag=1 as byte
                    it.itemId=item.id
                    it.postfee=item.postFee
                    it.price=item.cgprice
                    it.pitemId=mikuPiteminfo.id
                    it.version=1L
                    it.save(flush: true,failOnError: true)
                }
            }
        }
        redirect(action: "checkList")

    }
    

}

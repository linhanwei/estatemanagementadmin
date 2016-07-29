package welink.customized

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
//私人定制产品管理
class MikuCustomizedProductManageController {
    //定制类型：
    static ImmutableMap<Byte, String> mineTypeMap = ImmutableMap.builder()
            .put(0 as byte, "不限")
            .put(1 as byte, "护肤定制类")
            .put(2 as byte, "私密护理类")
            .put(3 as byte, "减肥定制类")
            .put(4 as byte, "脱发定制类")
//            .put(5, "待扩展")
            .build()

    //产品类型
    static ImmutableMap<Byte, String> prodTypeMap  = ImmutableMap.builder()
            .put(1 as byte, "基础护肤型产品")
            .put(2 as byte, "功效性产品")
            .build()

    //产品适用肤质
    static ImmutableMap<Integer, String> prodSkinApplysMap  = ImmutableMap.builder()
            .put(0, "不限")
            .put(1, "油性")
            .put(2, "干性")
            .put(3, "混合型偏干")
            .put(4, "混合型偏油")
            .build()

    //产品状态
    static ImmutableMap<Integer, String> prodShowStatusMap  = ImmutableMap.builder()
            .put(1, "膏")
            .put(2, "水状")
            .put(3, "原液")
            .put(4, "乳")
            .put(5, "霜")
            .put(6, "面膜")
            .build()

    //产品规则-使用频率：
    static ImmutableMap<Long, String> prodUseStandardFrequencyMap  = ImmutableMap.builder()
            .put(1L, "早晚都要")
            .put(2L, "早")
            .put(3L, "晚")
            .put(4L, "3小时一次")
            .put(5L, "每周一次")
            .put(6L, "每周两次")
            .build()

    //产品规则-使用周期：
    static ImmutableMap<Long, String> prodUseStandardPeriodMap  = ImmutableMap.builder()
            .put(1L, "每天")
            .put(2L, "每周")
            .put(3L, "每月")
            .put(4L, "有症状的时候")
            .build()

    //产品规则-使用条件：
    static ImmutableMap<Long, String> prodUseStandardConditionMap  = ImmutableMap.builder()
            .put(1L, "周期性")
            .put(2L, "突发性")
            .build()

    //分页数
    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder()
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

    //列表
    def index() {

        String prodName = params.prodName; //名称
        Byte prodType = params.byte('prodType');//产品类型
        String prodSkinApplys = params.prodSkinApplys;//产品适用肤质
        String prodShowStatus = params.prodShowStatus;//产品状态
        Long prodUseStandardFrequency = params.long('prodUseStandardFrequency');//产品规则-使用频率：
        Long prodUseStandardPeriod = params.long('prodUseStandardPeriod');//产品规则-使用周期：
        Long prodUseStandardCondition = params.long('prodUseStandardCondition');//产品规则-使用条件：

        def  mikuMineScProduct = MikuMineScProduct.createCriteria();
        PagedResultList pagedResultList = mikuMineScProduct.list(max: params.max ?:10, offset: params.offset ?: 0) {

            if(prodName){
                ilike('prodName',"%"+prodName+"%")
            }

            if(prodType > (0 as byte)){
                eq('prodType',prodType)
            }

            if(prodSkinApplys){
                ilike('prodSkinApplys',"%"+prodSkinApplys+"%")
            }

            if(prodShowStatus){
                eq('prodShowStatus',prodShowStatus)
            }

            if(prodUseStandardFrequency > 0L){
                eq('prodUseStandardFrequency',prodUseStandardFrequency)
            }

            if(prodUseStandardPeriod > 0L){
                eq('prodUseStandardPeriod',prodUseStandardPeriod)
            }

            if(prodUseStandardCondition > 0L){
                eq('prodUseStandardCondition',prodUseStandardCondition)
            }

            order("lastUpdated","desc")
        }

        pagedResultList.each {
            MikuMineScProduct product->

                List<Long> list=new  ArrayList<>();

                //获取问题名称列表
                def problemNameList;
                if(product.prodAimProblemIds){
                    product.prodAimProblemIds.split(',').each {
                        list.add(Long.parseLong(it))
                    }
                    def problemList = MikuMineScProblemItem.findAllByIdInList(list);
                    if(problemList){
                        problemList.each {
                            MikuMineScProblemItem problemItem ->
                                if(problemNameList){
                                    problemNameList += problemItem.scProblemName+"</br>";
                                }else {
                                    problemNameList = problemItem.scProblemName+"</br>";
                                }
                        }

                        product.prodAimProblemIds = problemNameList;
                    }

                }

                //获取解决办法名称列表
                if(product.prodAimThinkingIds){
                    def thinkingNameList;
                    list.clear();
                    product.prodAimThinkingIds.split(',').each {
                        list.add(Long.parseLong(it))
                    }
                    def thinkingList = MikuMineScThinkingItem.findAllByIdInList(list);
                    if(thinkingList){
                        thinkingList.each {
                            MikuMineScThinkingItem thinkingItem->
                                if(thinkingNameList){
                                    thinkingNameList += thinkingItem.scThinkingName+"</br>";
                                }else {
                                    thinkingNameList = thinkingItem.scThinkingName+"</br>";
                                }
                        }

                        product.prodAimThinkingIds = thinkingNameList;

                    }

                }

                //产品使用肤质
                if(product.prodSkinApplys){

                    def prodSkinNameList;
                    product.prodSkinApplys.split(',').each {
                        if(prodSkinNameList){
                            prodSkinNameList += prodSkinApplysMap.get(Integer.parseInt(it))+"</br>";
                        }else{
                            prodSkinNameList = prodSkinApplysMap.get(Integer.parseInt(it))+"</br>";
                        }
                    }

                    product.prodSkinApplys = prodSkinNameList;

                }

        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList,
                prodTypeMap:prodTypeMap,
                prodSkinApplysMap:prodSkinApplysMap,
                prodShowStatusMap:prodShowStatusMap,
                prodUseStandardFrequencyMap:prodUseStandardFrequencyMap,
                prodUseStandardPeriodMap:prodUseStandardPeriodMap,
                prodUseStandardConditionMap:prodUseStandardConditionMap,
                mineTypeMap:mineTypeMap
        ]
    }

    //添加页面
    def addView(){

        //可以解决的问题列表
//        def scProblemItemList = MikuMineScProblemItem.findAll();

        //解决问题的思路列表
//        def scThinkingItemList = MikuMineScThinkingItem.findAll();

        return [
                prodTypeMap:prodTypeMap,
                prodSkinApplysMap:prodSkinApplysMap,
                prodShowStatusMap:prodShowStatusMap,
                prodUseStandardFrequencyMap:prodUseStandardFrequencyMap,
                prodUseStandardPeriodMap:prodUseStandardPeriodMap,
                prodUseStandardConditionMap:prodUseStandardConditionMap,
                mineTypeMap:mineTypeMap
//                scProblemItemList:scProblemItemList,
//                scThinkingItemList:scThinkingItemList
        ]
    }

    //添加
    def add(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'添加失败');

        Long id = params.long('id');
        Byte mineType = params.byte('mineType');
        String prodName = params.prodName;
        Byte prodType = params.byte('prodType');
        String prodSpec = params.prodSpec;
        String prodPack = params.prodPack;
        String prodIngredient = params.prodIngredient;
        String prodAimProblemIds = params.prodAimProblemIds;
        String prodAimThinkingIds = params.prodAimThinkingIds;
        Long prodCostPrice = new BigDecimal(params.prodCostPrice) * 100L;
        Long prodRetailPrice = new BigDecimal(params.prodRetailPrice) * 100L;
        String prodNote = params.prodNote;
        String prodPicUrls = params.prodPicUrls;
        String prodSkinApplys = params.prodSkinApplys;
        String prodShowStatus = params.prodShowStatus;
        String prodPurpose = params.prodPurpose;
        Long prodUseStandardFrequency = params.long('prodUseStandardFrequency');
        Long prodUseStandardPeriod = params.long('prodUseStandardPeriod');
        Long prodUseStandardCondition = params.long('prodUseStandardCondition');
        String prodResult = params.prodResult;
        Long multimediaResId = params.long('multimediaResId');

        MikuMineScProduct mikuMineScProduct = new MikuMineScProduct();
        if(id){
            mikuMineScProduct = MikuMineScProduct.findById(id);
            returnData.put('msg' ,'修改失败');
        }

        mikuMineScProduct.with {
            it.mineType = mineType;
            it.prodName = prodName;
            it.prodType = prodType;
            it.prodSpec = prodSpec;
            it.prodPack = prodPack;
            it.prodIngredient = prodIngredient;
            it.prodAimProblemIds = prodAimProblemIds;
            it.prodAimThinkingIds = prodAimThinkingIds;
            it.prodCostPrice = prodCostPrice;
            it.prodRetailPrice = prodRetailPrice;
            it.prodNote = prodNote;
            it.prodPicUrls = prodPicUrls;
            it.prodSkinApplys = prodSkinApplys;
            it.prodShowStatus = prodShowStatus;
            it.prodPurpose = prodPurpose;
            it.prodUseStandardFrequency = prodUseStandardFrequency;
            it.prodUseStandardPeriod = prodUseStandardPeriod;
            it.prodUseStandardCondition = prodUseStandardCondition;
            it.prodResult = prodResult;
            it.multimediaResId = multimediaResId;

            if(!id){
                it.dateCreated = new Date();
            }

            it.lastUpdated = new Date();
            it.save(failOnError: true, flush: true);
        }

        if(id){
            returnData.put('status' ,1);
            returnData.put('msg' ,'修改成功');
        }else{
            returnData.put('status' ,1);
            returnData.put('msg' ,'添加成功');
        }

        render(returnData as JSON);

//        redirect(action: 'index');
    }

    //编辑页面
    def editView(){
        //可以解决的问题列表
//        def scProblemItemList = MikuMineScProblemItem.findAll();

        //解决问题的思路列表
//        def scThinkingItemList = MikuMineScThinkingItem.findAll();
        Long id = params.long('id');
        def product = MikuMineScProduct.findById(id);

        def multimediaInfo ; //多媒体信息
        List<Integer> prodSkinIdList = new  ArrayList<>();
        List<String> picList = new ArrayList<>();
        def problemNameList; //问题
        def thinkingNameList; //功效

        if(product){

//            product.prodCostPrice = new BigDecimal(prodCostPrice);
//            product.prodRetailPrice = new BigDecimal(prodRetailPrice);

            List<Long> list=new  ArrayList<>();
            //获取问题名称列表
            if(product.prodAimProblemIds){
                product.prodAimProblemIds.split(',').each {
                    list.add(Long.parseLong(it))
                }
                def problemList = MikuMineScProblemItem.findAllByIdInList(list);
                if(problemList){
                    problemList.each {
                        MikuMineScProblemItem problemItem ->
                            if(problemNameList){
                                problemNameList += problemItem.scProblemName+";";
                            }else {
                                problemNameList = problemItem.scProblemName+";";
                            }
                    }

                }

            }

            //获取解决办法名称列表
            if(product.prodAimThinkingIds){
                list.clear();
                product.prodAimThinkingIds.split(',').each {
                    list.add(Long.parseLong(it))
                }
                def thinkingList = MikuMineScThinkingItem.findAllByIdInList(list);
                if(thinkingList){
                    thinkingList.each {
                        MikuMineScThinkingItem thinkingItem->
                            if(thinkingNameList){
                                thinkingNameList += thinkingItem.scThinkingName+";";
                            }else {
                                thinkingNameList = thinkingItem.scThinkingName+";";
                            }
                    }

                }

            }

            //产品使用肤质
            if(product.prodSkinApplys){
                product.prodSkinApplys.split(',').each {
                    prodSkinIdList.add(Integer.parseInt(it));
                }
            }

            //获取多媒体信息
            if(product.multimediaResId){
                multimediaInfo = MikuMineMultimediaRes.findById(product.multimediaResId);
            }

            //图片
            if(product.prodPicUrls){
                product.prodPicUrls.split(";").each {
                    picList.add(it);
                }
            }

        }

        return [
                info:product,
                multimediaInfo:multimediaInfo,
                prodTypeMap:prodTypeMap,
                prodSkinApplysMap:prodSkinApplysMap,
                prodShowStatusMap:prodShowStatusMap,
                prodUseStandardFrequencyMap:prodUseStandardFrequencyMap,
                prodUseStandardPeriodMap:prodUseStandardPeriodMap,
                prodUseStandardConditionMap:prodUseStandardConditionMap,
                mineTypeMap:mineTypeMap,
                prodSkinIdList:prodSkinIdList,
                picList:picList,
                problemNameList:problemNameList,
                thinkingNameList:thinkingNameList
//                scProblemItemList:scProblemItemList,
//                scThinkingItemList:scThinkingItemList
        ]
    }

    //删除
    def del(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        def id = params.long('id');

        if(!id){
            returnData.put('msg' ,'请选择产品');
            render(returnData as JSON);
        }

        MikuMineScProduct info = MikuMineScProduct.findById(id);
        if(info){
            info.delete(flush: true);
            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');
        }

        render(returnData as JSON);
    }

    //获取全部的商品
    def getAllList(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,1);
        returnData.put('msg' ,'获取成功');

        def list = MikuMineScProduct.findAll();
        returnData.put('result' ,list);

        render(returnData as JSON);
    }

}

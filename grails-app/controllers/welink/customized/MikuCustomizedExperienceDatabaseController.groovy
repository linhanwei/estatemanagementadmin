package welink.customized

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList

//米酷定制经验库管理
class MikuCustomizedExperienceDatabaseController {

    //定制类型：
    static ImmutableMap<Byte, String> mineTypeMap = ImmutableMap.builder()
            .put(0 as byte, "不限")
            .put(1 as byte, "护肤定制类")
            .put(2 as byte, "私密护理类")
            .put(3 as byte, "减肥定制类")
            .put(4 as byte, "脱发定制类")
//            .put(5, "待扩展")
            .build()

    //肤质
    static ImmutableMap<Byte, String> envSkinTypeMap = ImmutableMap.builder()
            .put(1 as byte, "油性")
            .put(2 as byte, "干性")
            .put(3 as byte, "混合型")
            .put(4 as byte, "混合型偏干")
            .put(5 as byte, "混合型偏油")
            .build()

    //适宜的年龄段
    static ImmutableMap<Byte, String> envAgeRegionMap = ImmutableMap.builder()
            .put(0 as byte, "不限")
            .put(1 as byte, "25岁及以下")
            .put(2 as byte, "26岁以上")
            .put(3 as byte, "32岁及以下（仅适用于去皱）")
            .put(4 as byte, "33岁以上（仅适用于去皱）")
            .build()

    //区域
    static ImmutableMap<Byte, String> envAreaMap = ImmutableMap.builder()
            .put(1 as byte, "南方")
            .put(2 as byte, "北方")
            .build()

    //季节
    static ImmutableMap<String, String> envSeasonsMap = ImmutableMap.builder()
            .put("0", "不限")
            .put("1", "春")
            .put("2", "夏")
            .put("3", "秋")
            .put("4", "冬")
            .build()

    //步骤类型
    static ImmutableMap<Byte, String> stepTypeMap = ImmutableMap.builder()
            .put(1 as byte, "普通步骤")
            .put(2 as byte, "特效步骤")
            .build()

    //产品规则-使用频率
    static ImmutableMap<Byte, String> stepUseStandardFrequencyMap = ImmutableMap.builder()
            .put(1 as byte, "早晚都要")
            .put(2 as byte, "早")
            .put(3 as byte, "晚")
            .put(4 as byte, "3小时一次")
            .put(5 as byte, "每周一次")
            .put(6 as byte, "每周两次")
            .build()

    //产品规则-使用周期
    static ImmutableMap<Byte, String> stepUseStandardPeriodMap = ImmutableMap.builder()
            .put(1 as byte, "每天")
            .put(2 as byte, "每周")
            .put(3 as byte, "每月")
            .put(4 as byte, "有症状的时候")
            .build()

    //产品规则-使用条件
    static ImmutableMap<Byte, String> stepUseStandardConditionMap = ImmutableMap.builder()
            .put(1 as byte, "周期性")
            .put(2 as byte, "突发性")
            .build()

    //步骤使用时段
//    static ImmutableMap<Byte, String> useTimeMap = ImmutableMap.builder()
//            .put(1 as byte, "早晚都需要")
//            .put(2 as byte, "早用")
//            .put(3 as byte, "晚用")
//            .build()

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

        Byte envSkinType = params.byte('envSkinType'); //肤质
        Byte envAgeRegion = params.byte('envAgeRegion'); //年龄阶段
        Byte envArea = params.byte('envArea'); //区域
        Byte stepUseStandardFrequency = params.byte("stepUseStandardFrequency");//
        String envSeasons = params.envSeasons; //季节
        String stepShortName = params.stepShortName;//步骤名


        def mikuMineExpertDb = MikuMineExpertDb.createCriteria();

        PagedResultList pagedResultList = mikuMineExpertDb.list(max: params.max ?:10, offset: params.offset ?: 0) {

            if(envSkinType >= (0 as byte)){
                eq('envSkinType',envSkinType)
            }

            if(envAgeRegion >= (0 as byte)){
                eq('envAgeRegion',envAgeRegion)
            }

            if(envArea >= (0 as byte)){
                eq('envArea',envArea)
            }

            if(stepUseStandardFrequency > (0 as byte)){
                eq('stepUseStandardFrequency',stepUseStandardFrequency)
            }

            if(envSeasons){
                eq('envSeasons',envSeasons)
            }

            if(stepShortName){
                ilike('stepShortName',"%"+stepShortName+"%")
            }

            order("lastUpdated","desc")
        }

        //可以解决的问题列表
        def scProblemItemList = MikuMineScProblemItem.findAll().collectEntries { [it.id, it] };

        //解决问题的思路列表
        def scThinkingItemList = MikuMineScThinkingItem.findAll().collectEntries { [it.id, it] };

        //所有基础产品
        def mikuMineScProductList = MikuMineScProduct.findAll().collectEntries { [it.id, it] };

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList,
                scProblemItemList      : scProblemItemList,
                scThinkingItemList      : scThinkingItemList,
                mikuMineScProductList:mikuMineScProductList,
                envSkinTypeMap:envSkinTypeMap,
                envAgeRegionMap:envAgeRegionMap,
                envAreaMap:envAreaMap,
                envSeasonsMap:envSeasonsMap,
                stepTypeMap:stepTypeMap,
                stepUseStandardFrequencyMap:stepUseStandardFrequencyMap,
                stepUseStandardPeriodMap:stepUseStandardPeriodMap,
                stepUseStandardConditionMap:stepUseStandardConditionMap,
                mineTypeMap:mineTypeMap,
//                useTimeMap:useTimeMap
        ]
    }

    //添加页面
    def addView(){
            //可以解决的问题列表
            def scProblemItemList = MikuMineScProblemItem.findAll();

            //解决问题的思路列表
            def scThinkingItemList = MikuMineScThinkingItem.findAll();

            //所有基础产品
            def mikuMineScProductList = MikuMineScProduct.findAll();

            //所有多媒体信息
            def mikuMineMultimediaResList = MikuMineMultimediaRes.findAll();

         return  [
                 scProblemItemList      : scProblemItemList,
                 scThinkingItemList      : scThinkingItemList,
                 mikuMineScProductList:mikuMineScProductList,
                 mikuMineMultimediaResList:mikuMineMultimediaResList,
                 envSkinTypeMap:envSkinTypeMap,
                 envAgeRegionMap:envAgeRegionMap,
                 envAreaMap:envAreaMap,
                 envSeasonsMap:envSeasonsMap,
                 stepTypeMap:stepTypeMap,
                 stepUseStandardFrequencyMap:stepUseStandardFrequencyMap,
                 stepUseStandardPeriodMap:stepUseStandardPeriodMap,
                 stepUseStandardConditionMap:stepUseStandardConditionMap,
                 mineTypeMap:mineTypeMap,
//                 useTimeMap:useTimeMap

         ];
    }

    //添加
    def add(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'添加失败');
        returnData.put('result' , '');

        def dataList = com.alibaba.fastjson.JSON.parseObject(params.list);
        Byte mineType = params.byte('mineType');
        Long scProblemId = params.long("scProblemId");//
        Long scThinkingId = params.long("scThinkingId");//
        String skinTypeInfer = params.skinTypeInfer;//
        Byte envSkinType = params.byte("envSkinType");//
        Byte envAgeRegion = params.byte("envAgeRegion");//
        Byte envArea = params.byte("envArea");//
        String envSeasons = params.byte("envSeasons");//

        if(dataList){
            dataList.each {
                def stepList = it.value;
                def stepProdList = stepList.childList; //步骤中的产品与视频列表

                String stepName = stepList.stepName;
                String stepShortName = stepList.stepShortName;
                Integer stepOrder = Integer.parseInt(stepList.stepOrder);
                Byte stepType = Byte.parseByte(stepList.stepType);
                Integer stepInterval = Integer.parseInt(stepList.stepInterval);

                if(stepProdList){
                    stepProdList.each{
                        def stepProd = it.value;

                        Byte stepUseStandardCondition = Byte.parseByte(stepProd.stepUseStandardCondition);
                        Byte stepUseStandardPeriod = Byte.parseByte(stepProd.stepUseStandardPeriod);
                        Byte stepUseStandardFrequency = Byte.parseByte(stepProd.stepUseStandardFrequency);
                        Long prodId = Long.parseLong(stepProd.prodId);
                        String prodUseRemind = stepProd.prodUseRemind;
                        Long multimediaResourceId = Long.parseLong(stepProd.multimediaResourceId);
                        String multimediaUseRemind = stepProd.multimediaUseRemind;

                        MikuMineExpertDb mikuMineExpertDb = new MikuMineExpertDb();
                        mikuMineExpertDb.with {
                            it.mineType = mineType
                            it.scProblemId = scProblemId
                            it.scThinkingId = scThinkingId
                            it.skinTypeInfer = skinTypeInfer
                            it.envSkinType = envSkinType
                            it.envAgeRegion = envAgeRegion
                            it.envArea = envArea
                            it.envSeasons = envSeasons
                            it.stepName = stepName
                            it.stepShortName = stepShortName
                            it.stepType = stepType
                            it.stepOrder = stepOrder
                            it.stepInterval = stepInterval
                            it.stepUseStandardFrequency = stepUseStandardFrequency
                            it.stepUseStandardPeriod = stepUseStandardPeriod
                            it.stepUseStandardCondition = stepUseStandardCondition
                            it.prodId = prodId
                            it.prodUseRemind = prodUseRemind
                            it.multimediaResourceId = multimediaResourceId
                            it.multimediaUseRemind = multimediaUseRemind
                            it.dateCreated = new Date()
                            it.lastUpdated = new Date()

                            save(failOnError: true,flush: true)
                        }
                    }
                }
            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'添加成功');
        }

        render(returnData as JSON);
    }

    //更改页面
    def editView(){

        Long id = params.long('id');

        def info = MikuMineExpertDb.findById(id);

        //可以解决的问题列表
        def scProblemItemList = MikuMineScProblemItem.findAll();

        //解决问题的思路列表
        def scThinkingItemList = MikuMineScThinkingItem.findAll();

        //所有基础产品
        def mikuMineScProductList = MikuMineScProduct.findAll();

        //所有多媒体信息
        def mikuMineMultimediaResList = MikuMineMultimediaRes.findAll();

        return  [
                info:info,
                mikuMineMultimediaResList:mikuMineMultimediaResList,
                scProblemItemList      : scProblemItemList,
                scThinkingItemList      : scThinkingItemList,
                mikuMineScProductList:mikuMineScProductList,
                mikuMineMultimediaResList:mikuMineMultimediaResList,
                envSkinTypeMap:envSkinTypeMap,
                envAgeRegionMap:envAgeRegionMap,
                envAreaMap:envAreaMap,
                envSeasonsMap:envSeasonsMap,
                stepTypeMap:stepTypeMap,
                stepUseStandardFrequencyMap:stepUseStandardFrequencyMap,
                stepUseStandardPeriodMap:stepUseStandardPeriodMap,
                stepUseStandardConditionMap:stepUseStandardConditionMap,
                mineTypeMap:mineTypeMap,
//                useTimeMap:useTimeMap

        ];
    }

    //更改
    def edit(){

        Long id = params.long("id");
        Byte mineType = params.byte('mineType');
        Long scProblemId = params.long("scProblemId");
        Long scThinkingId = params.long("scThinkingId");
        String skinTypeInfer = params.skinTypeInfer;
        Byte envSkinType = params.byte("envSkinType");
        Byte envAgeRegion = params.byte("envAgeRegion");
        Byte envArea = params.byte("envArea");
        String envSeasons = params.byte("envSeasons");
        String stepName = params.stepName;
        String stepShortName = params.stepShortName;
        Byte stepType = params.byte("stepType");
        Integer stepOrder = params.int("stepOrder");
        Integer stepInterval = params.int("stepInterval");
        Byte stepUseStandardFrequency = params.byte("stepUseStandardFrequency");
        Byte stepUseStandardPeriod = params.byte("stepUseStandardPeriod");
        Byte stepUseStandardCondition = params.byte("stepUseStandardCondition");
        Long prodId = params.long("prodId");
        String prodUseRemind = params.prodUseRemind;
        Long multimediaResourceId = params.long("multimediaResourceId");
        String multimediaUseRemind = params.multimediaUseRemind;

        MikuMineExpertDb mikuMineExpertDb = new MikuMineExpertDb();

        if(id){
            mikuMineExpertDb = MikuMineExpertDb.findById(id);
        }

        mikuMineExpertDb.with {
            it.mineType = mineType
            it.scProblemId = scProblemId
            it.scThinkingId = scThinkingId
            it.skinTypeInfer = skinTypeInfer
            it.envSkinType = envSkinType
            it.envAgeRegion = envAgeRegion
            it.envArea = envArea
            it.envSeasons = envSeasons
            it.stepName = stepName
            it.stepShortName = stepShortName
            it.stepType = stepType
            it.stepOrder = stepOrder
            it.stepInterval = stepInterval
            it.stepUseStandardFrequency = stepUseStandardFrequency
            it.stepUseStandardPeriod = stepUseStandardPeriod
            it.stepUseStandardCondition = stepUseStandardCondition
            it.prodId = prodId
            it.prodUseRemind = prodUseRemind
            it.multimediaResourceId = multimediaResourceId
            it.multimediaUseRemind = multimediaUseRemind


            if(!id){
                it.dateCreated = new Date();
            }

            it.lastUpdated = new Date();
            it.save(failOnError: true, flush: true);
        }

        redirect(action: "index");
    }

    //删除
    def del(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        def id = params.long('id');

        if(!id){
            returnData.put('msg' ,'请选择经验信息');
            render(returnData as JSON);
        }

        MikuMineExpertDb mikuMineExpertDb = MikuMineExpertDb.findById(id);
        if(mikuMineExpertDb){
            mikuMineExpertDb.delete(flush: true);

            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');
        }

        render(returnData as JSON);
    }

}

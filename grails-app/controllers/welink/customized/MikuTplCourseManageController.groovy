package welink.customized

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.user.Employee

class MikuTplCourseManageController {

    //定制类型：
    static ImmutableMap<Byte, String> mineTypeMap = ImmutableMap.builder()
            .put(0 as byte, "不限")
            .put(1 as byte, "护肤定制类")
            .put(2 as byte, "私密护理类")
            .put(3 as byte, "减肥定制类")
            .put(4 as byte, "脱发定制类")
//            .put(5, "待扩展")
            .build()

    //课程类型
    static ImmutableMap<Byte, String> coursePropertyMap = ImmutableMap.builder()
            .put(1 as byte, "公开课程")
            .put(2 as byte, "定制课程") //这个类型的课程不能增删改
            .build()

    //课程属性
    static ImmutableMap<Byte, String> courseTypeMap = ImmutableMap.builder()
            .put(1 as byte, "单次课时")
            .put(2 as byte, "计划课程") //这个类型的课程不能增删改
            .build()

    //课程步骤
    static ImmutableMap<Byte, String> stepTypeMap = ImmutableMap.builder()
            .put(1 as byte, "普通步骤")
            .put(2 as byte, "特效步骤") //这个类型的课程不能增删改
            .build()

    //是否置顶
    static ImmutableMap<Byte, String> topFlagMap = ImmutableMap.builder()
            .put(0 as byte, "否")
            .put(1 as byte, "是")
            .build()

    //课程模板
    static ImmutableMap<Byte, String> courseTemplateMap = ImmutableMap.builder()
            .put(0 as byte, "普通课程")
            .put(1 as byte, "模板课程")
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

    //课程列表
    def index() {
        String courseName = params.courseName; //名称
        Byte courseType = params.byte('courseType'); //课程类型
        Byte mineType = params.byte("mineType");
        Byte courseProperty = params.byte("courseProperty");
        Byte courseTemplate = params.byte("courseTemplate");

        def mikuMineCourse = MikuMineCourse.createCriteria();
        PagedResultList pagedResultList = mikuMineCourse.list(max: params.max ?:10, offset: params.offset ?: 0) {

//            if(courseType > (0 as byte)){
//                eq('courseType',courseType)
//            }

//            if(courseProperty >= (0 as byte)){
//                eq('courseProperty',courseProperty)
//            }

            eq('courseType',2 as byte)
            eq('courseProperty',1 as byte)
            eq('courseTemplate',1 as byte)

            if(mineType >= (0 as byte)){
                eq('mineType',mineType)
            }

            if(courseTemplate >= (0 as byte)){
                eq('courseTemplate',courseTemplate)
            }

            if(courseName){
                ilike('courseName',"%"+courseName+"%")
            }

            order("lastUpdated","desc")
        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList,
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                courseTemplateMap:courseTemplateMap
        ]
    }

    //添加课程页面
    def  addCourseView(){

        return [
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                topFlagMap:topFlagMap,
                courseTemplateMap:courseTemplateMap

        ]
    }

    //添加课程或者编辑课程
    @Transactional
    def  addCourse(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('result','');
        returnData.put('msg' ,'添加失败');

        //接收参数
        Long courseId = params.long("courseId"); //课程ID
        String courseName = params.courseName;
        String courseShortName = params.courseShortName;
        Byte mineType = params.byte("mineType"); //定制类型
        Byte courseType = params.byte("courseType");//课程类型
        Byte courseProperty = params.byte("courseProperty");//课程属性
        String courseIntroduce = params.courseIntroduce;//课程介绍
        String courseNote = params.courseNote;//课程备注
        Integer courseSectionsNum = params.int("courseSectionsNum");//课程步骤数量
        Integer courseDuration = params.int("courseDuration");//课程周期时长
        Integer coursePlayedTimes = params.int("coursePlayedTimes");//课程播放次数
        Byte topFlag = params.byte("topFlag");//是否置顶
        Byte courseTemplate = params.byte("courseTemplate");//课程模板

        HashMap<String,Object> dataList = com.alibaba.fastjson.JSON.parseObject(params.list); //组合信息

        courseSectionsNum = dataList.size();
        courseTemplate = 1 as byte; //只能添加模板课程

        //获取当前登录
        Subject currentUser = SecurityUtils.getSubject()
        String name=currentUser.principals.toString()
        def user = Employee.findByUsername(name)

        //课程信息
        MikuMineCourse mikuMineCourse = new MikuMineCourse();
        if(courseId){
            mikuMineCourse = MikuMineCourse.findById(courseId);
        }

        mikuMineCourse.with {

            it.mineType = mineType
            it.courseName = courseName
            it.courseShortName = courseShortName
            it.courseProperty = courseProperty
            it.courseType = courseType
            it.courseIntroduce = courseIntroduce
            it.courseNote = courseNote
            it.courseSectionsNum = courseSectionsNum
//            it.courseDuration = courseDuration
//            it.courseUserStime = courseUserStime
            it.coursePlayedTimes = coursePlayedTimes
            it.topFlag = topFlag
            it.courseTemplate = courseTemplate

            if(user){
                it.createrId = user.id
            }

            if(courseId){
                it.lastUpdated = new Date()
            }else{
                it.dateCreated = new Date()
            }

            it.save(failOnError: true, flush: true);

        }

        if(dataList && mikuMineCourse.id){
            courseDuration = 0; //初始化课程时长

            dataList.each {

                MikuMineCourseSection mikuMineCourseSection = new MikuMineCourseSection();

                HashMap<String,String> listValue = it.value;

                //计算课程总时长
                Integer sectionEd = Integer.parseInt(listValue.sectionEd);
                Integer sectionSd = Integer.parseInt(listValue.sectionSd);
                Integer sectionDuration = (sectionEd - sectionSd)+1;

                courseDuration +=  sectionDuration > 0 ? sectionDuration : 0;

                if(listValue && listValue.id){
                    mikuMineCourseSection = MikuMineCourseSection.findById(listValue.id);
                }

                mikuMineCourseSection.with {

                    it.courseId = mikuMineCourse.id
                    it.sectionName = listValue.sectionName
                    it.sectionShortName = listValue.sectionShortName
                    it.sectionDuration = sectionDuration
                    it.sectionIntroduce = listValue.sectionIntroduce
                    it.sectionNote = listValue.sectionNote
                    it.sectionOrder = Integer.parseInt(listValue.sectionOrder)
                    it.sectionSd = sectionSd
                    it.sectionEd = sectionEd

                    if(listValue && listValue.id){
                        it.lastUpdated = new Date()
                    }else{
                        it.dateCreated = new Date()
                    }

                    it.save(failOnError: true, flush: true);
                }
            }

            //修改课程信息
            mikuMineCourse.with {

                it.courseDuration = courseDuration
                it.lastUpdated = new Date()

                it.save(failOnError: true, flush: true);

            }
        }

        returnData.put('status' ,1);
        if(courseId){
            returnData.put('msg' ,'编辑成功');
        }else {
            returnData.put('msg','添加成功');
        }

        render(returnData as JSON);

    }

    //编辑课程页面
    def editCourseView(){

        //课程ID
        Long id = params.long("id");

        List<MikuMineCourseSection> mikuMineCourseSectionList;

        //获取课程信息
        MikuMineCourse mikuMineCourse = MikuMineCourse.findById(id); //获取课程信息
        if(mikuMineCourse){
            //获取课程阶段信息
            mikuMineCourseSectionList = MikuMineCourseSection.findAllByCourseId(mikuMineCourse.id);
        }

        return [
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                topFlagMap:topFlagMap,
                courseTemplateMap:courseTemplateMap,
                mikuMineCourse:mikuMineCourse,
                mikuMineCourseSectionList:mikuMineCourseSectionList
        ]
    }

    //删除课程
    @Transactional
    def delCourse(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        Long id = params.long("id");//课程ID

        if(!id){
            returnData.put('msg' ,'请选择课程');
        }

        MikuMineCourse mikuMineCourse = MikuMineCourse.findById(id); //获取课程信息

        if(mikuMineCourse){
            //会员的课程阶段不能删除
            if(mikuMineCourse.boxId){
                returnData.put('msg' ,'您不能删除会员的课程!');
                render(returnData as JSON);
            }

            //获取课程阶段
            List<MikuMineCourseSection> mikuMineCourseSectionList = MikuMineCourseSection.findAllByCourseId(mikuMineCourse.id);

            if(mikuMineCourseSectionList.size() > 0){
                mikuMineCourseSectionList.each {
                    //删除阶段与课时关系信息
                    List<MikuMineSectionLesson> mikuMineSectionLessonList = MikuMineSectionLesson.findAllBySectionId(it.id);
                    if(mikuMineSectionLessonList.size() > 0){
                        mikuMineSectionLessonList.each {
                            it.delete(flush: true);
                        }

                    }

                    //删除阶段课程
                    it.delete(flush: true);
                }
            }

            //删除课程
            mikuMineCourse.delete(flush: true);

            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');

        }

        render(returnData as JSON);
    }

    //删除课程阶段
    @Transactional
    def delCourseSection(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        Long id = params.long("id");
        Long courseId = params.long("courseId"); //课程ID

        if(!id){
            returnData.put('msg' ,'请选择阶段');
            render(returnData as JSON);
        }

        if(!courseId){
            returnData.put('msg' ,'请选择课程');
            render(returnData as JSON);
        }

        MikuMineCourseSection mikuMineCourseSection = MikuMineCourseSection.findById(id);
        if(mikuMineCourseSection){
            //更改课程总时间跟总阶段数
            MikuMineCourse mikuMineCourse = MikuMineCourse.findById(courseId); //获取课程信息

            //会员的课程阶段不能删除
            if(mikuMineCourse && mikuMineCourse.boxId){
                returnData.put('msg' ,'您不能删除会员的课程阶段!');
                render(returnData as JSON);
            }

            mikuMineCourse.with {
                it.courseSectionsNum = it.courseSectionsNum-1
                it.courseDuration = it.courseDuration-mikuMineCourseSection.sectionDuration
                it.save(failOnError: true, flush: true);
            }

            mikuMineCourseSection.delete(flush: true);
            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');
        }

        render(returnData as JSON);
    }

    //课时列表
    def lessonList(){

        String lessonName = params.lessonName;

        def mikuMineLesson = MikuMineLesson.createCriteria();
        PagedResultList pagedResultList = mikuMineLesson.list(max: params.max ?:10, offset: params.offset ?: 0) {

            if(lessonName){
                ilike('lessonName',"%"+lessonName+"%")
            }

            eq('lessonProperty',1 as byte)
            order("lastUpdated","desc")
        }

        if(pagedResultList.size() > 0){
            pagedResultList.each {

                it.lessonTime = it.lessonTime ? it.lessonTime/60 : 0;
            }
        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList
        ]

    }

    //添加课时页面
    def addLessonView(){
        //获取全部的产品
        def productList = MikuMineScProduct.findAll();

        //获取教学资源

        return [
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                productList:productList
        ]
    }

    //添加或者编辑课时
    @Transactional
    def addLesson(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'添加失败');

        Long id = params.long("lessonId"); //课时Id
        String lessonName = params.lessonName;
        String lessonShortName = params.lessonShortName;
        String lessonIntroduce = params.lessonIntroduce;
        String lessonNote = params.lessonNote;
        Byte lessonProperty = params.byte("lessonProperty");
        Integer lessonTime = params.int("lessonTime");
        Integer lessonStepsNum = params.int("lessonStepsNum");

        HashMap<String,Object> dataList = com.alibaba.fastjson.JSON.parseObject(params.list); //组合信息
        lessonStepsNum = dataList ? dataList.size() : 0;

        MikuMineLesson mikuMineLesson = new MikuMineLesson();

        if(id){
            mikuMineLesson = MikuMineLesson.findById(id);
            returnData.put('msg' ,'编辑失败');
        }

        mikuMineLesson.with {
            it.lessonName = lessonName
            it.lessonShortName = lessonShortName
            it.lessonIntroduce = lessonIntroduce
            it.lessonNote = lessonNote
            it.lessonStepsNum = lessonStepsNum
            it.lessonProperty = lessonProperty

            if(!id){
                it.dateCreated = new Date()
            }

            it.lastUpdated = new Date()

            save(failOnError: true,flush: true)
        }

        //课时步骤信息
        if(dataList && mikuMineLesson.id){

            lessonTime = 0; //初始化课时时长

            dataList.each {
                MikuMineLessonStep mikuMineLessonStep = new MikuMineLessonStep();

                HashMap<String,String> listValue = it.value;

                //获取视频时长
                Integer resTime = 0;
                Integer stepInterval = listValue.stepInterval ? Integer.parseInt(listValue.stepInterval) : 0;
                if(listValue.multimediaResourceId){
                    Long multimediaResourceId = Long.parseLong(listValue.multimediaResourceId);
                    MikuMineMultimediaRes mikuMineMultimediaRes = MikuMineMultimediaRes.findById(multimediaResourceId);
                    if(mikuMineMultimediaRes && mikuMineMultimediaRes.resTime){
                        resTime = Integer.parseInt((mikuMineMultimediaRes.resTime).toString());
                    }

                }
                lessonTime += (resTime+stepInterval);

                //更改课时步骤信息
                if(listValue.id){
                    mikuMineLessonStep = MikuMineLessonStep.findById(listValue.id);
                }

                mikuMineLessonStep.with {

                    it.lessonId = mikuMineLesson.id
                    it.stepName = listValue.stepName
                    it.stepShortName = listValue.stepShortName
                    it.stepIntroduce = listValue.stepIntroduce
                    it.stepNote = listValue.stepNote
                    it.stepOrder = listValue.stepOrder ? Integer.parseInt(listValue.stepOrder) : 0
                    it.stepType = Byte.parseByte(listValue.stepType)
                    it.stepInterval = stepInterval
                    it.prodId = Long.parseLong(listValue.prodId)
                    it.prodUseRemind = listValue.prodUseRemind
                    it.multimediaResourceId = Long.parseLong(listValue.multimediaResourceId)
                    it.multimediaUseRemind = listValue.multimediaUseRemind
                    if(!listValue.id){
                        it.dateCreated = new Date()
                    }

                    it.lastUpdated = new Date()

                    it.save(failOnError: true, flush: true);
                }
            }

            //更改课时总时长
            mikuMineLesson.with {

                it.lessonTime = lessonTime
                it.lastUpdated = new Date()

                it.save(failOnError: true, flush: true);
            }
        }

        returnData.put('status' ,1);
        if(id){
            returnData.put('msg' ,'编辑成功');
        }else {
            returnData.put('msg','添加成功');
        }

        render(returnData as JSON);
    }

    //编辑课时页面
    def editLessonView(){
        //课程ID
        Long id = params.long("id");
        List<MikuMineLessonStep> mikuMineLessonStepList;//获取课时步骤

        def mikuMineLesson = MikuMineLesson.findById(id);

        if(mikuMineLesson){
            mikuMineLesson.lessonTime = mikuMineLesson.lessonTime > 0 ? mikuMineLesson.lessonTime/60 : 0;

            //获取课时步骤
            if(mikuMineLesson.id){
                mikuMineLessonStepList =  MikuMineLessonStep.findAllByLessonId(mikuMineLesson.id);
            }

        }

        //获取全部的产品
        def productList = MikuMineScProduct.findAll();

        //获取全部教学资源
        def mikuMineMultimediaResList = MikuMineMultimediaRes.findAll();

        return [
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                productList:productList,
                mikuMineLesson:mikuMineLesson,
                mikuMineLessonStepList:mikuMineLessonStepList,
                mikuMineMultimediaResList:mikuMineMultimediaResList

        ]
    }

    //删除课时
    @Transactional
    def delLesson(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        Long id = params.long('id');

        MikuMineLesson mikuMineLesson = MikuMineLesson.findById(id);

        if(mikuMineLesson){
            if(mikuMineLesson.boxId){
                returnData.put('msg' ,'您不能删除会员的课时');
                render(returnData as JSON);
            }

            //删除课时步骤信息
            List<MikuMineLessonStep> mikuMineLessonStepList = MikuMineLessonStep.findAllByLessonId(id);

            if(mikuMineLessonStepList.size() > 0){
                mikuMineLessonStepList.each {

                    it.delete(flush: true);
                }
            }

            //删除阶段与课时关系信息
            List<MikuMineSectionLesson> mikuMineSectionLessonList = MikuMineSectionLesson.findAllByLessonId(id);
            if(mikuMineSectionLessonList.size() > 0){
                mikuMineSectionLessonList.each {
                    it.delete(flush: true);
                }

            }

            mikuMineLesson.delete(flush: true);

            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');
        }

        render(returnData as JSON);
    }

    //删除课时步骤
    @Transactional
    def delLessonStep(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        Long id = params.long('id');
        Long lessonid = params.long("lessonid");

        if(!id){
            returnData.put('msg' ,'请选择步骤');
            render(returnData as JSON);
        }

        if(!lessonid){
            returnData.put('msg' ,'请选择课时');
            render(returnData as JSON);
        }

        MikuMineLessonStep mikuMineLessonStep = MikuMineLessonStep.findById(id);

        if(mikuMineLessonStep){
            Integer stepInterval = mikuMineLessonStep.stepInterval ? mikuMineLessonStep.stepInterval : 0;
            //获取视频时长
            Integer resTime = 0;
            if(mikuMineLessonStep.multimediaResourceId){
                MikuMineMultimediaRes mikuMineMultimediaRes = MikuMineMultimediaRes.findById(mikuMineLessonStep.multimediaResourceId);
                if(mikuMineMultimediaRes && mikuMineMultimediaRes.resTime){
                    resTime = Integer.parseInt((mikuMineMultimediaRes.resTime).toString());
                }

            }

            //更改课时时间与步骤数量
            MikuMineLesson mikuMineLesson = MikuMineLesson.findById(lessonid);
            if(mikuMineLesson){
                mikuMineLesson.with {
                    it.lessonStepsNum = it.lessonStepsNum-1;
                    it.lessonTime = it.lessonTime - stepInterval - resTime;
                    save(failOnError: true,flush: true);
                }
            }

            mikuMineLessonStep.delete(flush: true);

            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');
        }

        render(returnData as JSON);
    }

    //课程阶段与课时关联页面
    def relaSectionLessonView(){
        //课程ID
        Long id = params.long("id");

        List<MikuMineCourseSection> mikuMineCourseSectionList;

        //获取课程信息
        MikuMineCourse mikuMineCourse = MikuMineCourse.findById(id); //获取课程信息
        if(mikuMineCourse){
            //获取课程阶段信息
            mikuMineCourseSectionList = MikuMineCourseSection.findAllByCourseId(mikuMineCourse.id);
        }

        return [
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                mikuMineCourse:mikuMineCourse,
                mikuMineCourseSectionList:mikuMineCourseSectionList,

        ]
    }

    //关联课程阶段与课时
    @Transactional
    def relaSectionLesson(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'绑定失败');

        Long courseId = params.long("courseId");
        Long sectionId = params.long("sectionId");

        HashMap<String,Object> dataList = com.alibaba.fastjson.JSON.parseObject(params.list); //组合信息

        if(!courseId){
            returnData.put('msg' ,'请选择课程');
            render(returnData as JSON);
        }

        if(!sectionId){
            returnData.put('msg' ,'请选择课程阶段');
            render(returnData as JSON);
        }

        if(dataList){

            //查询以前已经绑定的所有关系
            List<MikuMineSectionLesson> mikuMineSectionLessonList = MikuMineSectionLesson.findAllBySectionId(sectionId);

            //直接绑定关系
            dataList.each {
                def sectionLessonInfo = it.value;

                if(sectionLessonInfo.dayOrder && sectionLessonInfo.earliesttimeInDay && sectionLessonInfo.latestttimeInDay && sectionLessonInfo.suggesttimeInDay && sectionLessonInfo.lessonId){
                    Integer dayOrder = Integer.parseInt(sectionLessonInfo.dayOrder);

                    java.sql.Time earliesttimeInDay = java.sql.Time.valueOf(sectionLessonInfo.earliesttimeInDay);
                    java.sql.Time latestttimeInDay = java.sql.Time.valueOf(sectionLessonInfo.latestttimeInDay);
                    java.sql.Time suggesttimeInDay = java.sql.Time.valueOf(sectionLessonInfo.suggesttimeInDay);

                    Long lessonId = Long.parseLong(sectionLessonInfo.lessonId);

                    MikuMineSectionLesson mikuMineSectionLesson = new MikuMineSectionLesson();
                    mikuMineSectionLesson.with {
                        it.courseId = courseId
                        it.sectionId = sectionId
                        it.dayOrder = dayOrder
                        it.earliesttimeInDay = earliesttimeInDay
                        it.latestttimeInDay = latestttimeInDay
                        it.suggesttimeInDay = suggesttimeInDay
                        it.lessonId = lessonId

                        save(failOnError: true,flush: true);
                    }

                }

            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'绑定成功');

            //删除以前绑定的关系
            if(mikuMineSectionLessonList){
                mikuMineSectionLessonList.each {
                    it.delete(flush: true);
                }
            }

        }

        render(returnData as JSON);
    }

    //根据条件查找课时
    def searchLessonList(){

        Map<String,Object> returnData = new HashMap<String, Object>();
        Map<String,Object> returnResult = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'查询失败');

        Byte lessonProperty = params.byte("lessonProperty");//课程属性
        Long sectionId = params.long("sectionId"); //课程阶段ID
//
//        if(!lessonProperty){
//            returnData.put('msg' ,'请选择课程属性!');
//            render(returnData as JSON);
//        }

        if(!sectionId){
            returnData.put('msg' ,'请选择课程阶段!');
            render(returnData as JSON);
        }

        //获取课时列表
        PagedResultList pagedResultList = getlessonList(lessonProperty);
        returnResult.put('lessonList',pagedResultList);

        //获取课程阶段与课时关系
        List<Object> sectionLessonList = new ArrayList<>();
        def mikuMineSectionLessonList = MikuMineSectionLesson.createCriteria().list(max: params.max ?:10000, offset: params.offset ?: 0){
            eq('sectionId',sectionId)
            order("dayOrder","asc")
        };

        if(mikuMineSectionLessonList.size() > 0){

            Integer key = 0;
            mikuMineSectionLessonList.each {
                Map<String,Object> sectionLessonInfoExit = new HashMap<String, Object>();

                sectionLessonInfoExit.put("dayOrder",it.dayOrder);
                sectionLessonInfoExit.put("earliesttimeInDay",it.earliesttimeInDay.toString());
                sectionLessonInfoExit.put("latestttimeInDay",it.latestttimeInDay.toString());
                sectionLessonInfoExit.put("suggesttimeInDay",it.suggesttimeInDay.toString());
                sectionLessonInfoExit.put("lessonId",it.lessonId);

                sectionLessonList[key] = sectionLessonInfoExit;

                key++;
            }
        }

        returnResult.put('sectionLessonList',sectionLessonList);

        returnData.put('status' ,1);
        returnData.put('msg' ,'查询成功');
        returnData.put('result' ,returnResult);

        render(returnData as JSON);
    }

    //课时列表
    def getlessonList(lessonProperty){
        Byte lessonPropertyByte = lessonProperty ? lessonProperty : 1 as byte;
        def MikuMineLessonModel = MikuMineLesson.createCriteria();
        PagedResultList pagedResultList = MikuMineLessonModel.list(max: params.max ?:10000, offset: params.offset ?: 0) {

            eq('lessonProperty',lessonPropertyByte)

            order("lastUpdated","desc")
        }

        return  pagedResultList;
    }

    //异步获取课时列表
    def getlessonListAjax(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,1);
        returnData.put('msg' ,'查询成功');

        Byte lessonProperty = 1 as byte;
        def returnResult = getlessonList(lessonProperty);
        returnData.put('result' ,returnResult);

        render(returnData as JSON);
    }

}

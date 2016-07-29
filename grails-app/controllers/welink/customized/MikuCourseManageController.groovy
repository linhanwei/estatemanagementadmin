package welink.customized

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.user.Employee
//米酷私人定制单次课程管理
class MikuCourseManageController {

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

        String courseName = params.courseName; //名称
        Byte courseType = params.byte('courseType'); //课程类型
        Byte mineType = params.byte("mineType");
        Byte courseProperty = params.byte("courseProperty");

        def mikuMineCourse = MikuMineCourse.createCriteria();
        PagedResultList pagedResultList = mikuMineCourse.list(max: params.max ?:10, offset: params.offset ?: 0) {

//            if(courseType > (0 as byte)){
//                eq('courseType',courseType)
//            }

            eq('courseType',1 as byte)

            if(mineType >= (0 as byte)){
                eq('mineType',mineType)
            }

            if(courseProperty >= (0 as byte)){
                eq('courseProperty',courseProperty)
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
                    stepTypeMap:stepTypeMap
                ]
    }

    //添加页面
    def addView(){

        //获取全部的产品
        def productList = MikuMineScProduct.findAll();

        //获取教学资源

        return [
                mineTypeMap:mineTypeMap,
                courseTypeMap:courseTypeMap,
                coursePropertyMap:coursePropertyMap,
                stepTypeMap:stepTypeMap,
                topFlagMap:topFlagMap,
                productList:productList
        ]
    }

    //添加
    def add(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('result','');
        returnData.put('msg' ,'添加失败');

        //接收参数
        Long courseId = params.long("courseId"); //课程ID
        Long lessonId = params.long("lessonId");//课时ID
        String courseName = params.courseName;
        String courseShortName = params.courseShortName;
        Byte mineType = params.byte("mineType"); //定制类型
        Byte courseType = params.byte("courseType");//课程类型
        Byte courseProperty = params.byte("courseProperty");//课程属性
        String courseIntroduce = params.courseIntroduce;//课程介绍
        String courseNote = params.courseNote;//课程备注
        Integer lessonStepsNum = params.int("lessonStepsNum");//课时步骤数量
        Integer lessonTime = params.int("lessonTime");//本次课时时长
        Byte topFlag = params.byte("topFlag");//是否置顶

        HashMap<String,Object> dataList = com.alibaba.fastjson.JSON.parseObject(params.list); //组合信息

        lessonStepsNum = dataList.size();

        //获取当前登录
        Subject currentUser = SecurityUtils.getSubject()
        String name=currentUser.principals.toString()
        def user = Employee.findByUsername(name)

        //课时信息
        MikuMineLesson mikuMineLesson = new MikuMineLesson();
        if(lessonId){
            mikuMineLesson = MikuMineLesson.findById(lessonId);
            returnData.put('msg' ,'编辑失败');
        }

        mikuMineLesson.with {
            it.lessonName = courseName
            it.lessonShortName = courseShortName
            it.lessonIntroduce = courseIntroduce
            it.lessonNote = courseNote
            it.lessonProperty = courseProperty
//            it.lessonTime = lessonTime*60
            it.lessonStepsNum = lessonStepsNum

            if(lessonId){
                it.lastUpdated = new Date()
            }

            it.lastUpdated = new Date();
            it.save(failOnError: true, flush: true);
        }

        lessonId = lessonId ? lessonId : mikuMineLesson.id; //重新定义课程Id

        //课时步骤信息
        if(dataList && lessonId){

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

                    it.lessonId = lessonId
                    it.stepName = listValue.stepName
                    it.stepShortName = listValue.stepShortName
                    it.stepIntroduce = listValue.stepIntroduce
                    it.stepNote = listValue.stepNote
                    it.stepOrder = listValue.stepOrder ? Integer.parseInt(listValue.stepOrder) : 0
                    it.stepType = listValue.stepType ? Byte.parseByte(listValue.stepType) : 0 as byte
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
//            it.courseSectionsNum = courseSectionsNum
//            it.courseDuration = courseDuration
//            it.courseUserStime = courseUserStime
            it.lessonId = lessonId
            it.topFlag = topFlag

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

        returnData.put('status' ,1);
        if(lessonId){
            returnData.put('msg' ,'编辑成功');
        }else {
            returnData.put('msg','添加成功');
        }

        render(returnData as JSON);

    }

    //编辑页面
    def editView(){

        //课程ID
        Long id = params.long("id");
        MikuMineLesson mikuMineLesson = new MikuMineLesson();//获取课时信息
        List<MikuMineLessonStep> mikuMineLessonStepList;//获取课时步骤

        //获取课程信息
        MikuMineCourse mikuMineCourse = MikuMineCourse.findById(id); //获取课程信息
        if(mikuMineCourse){

            if(mikuMineCourse.courseType == (1 as byte) && mikuMineCourse.lessonId > 0L){
                //获取课时信息
                mikuMineLesson = MikuMineLesson.findById(mikuMineCourse.lessonId);
                if(mikuMineLesson){
                    mikuMineLesson.lessonTime = mikuMineLesson.lessonTime/60;

                    //获取课时步骤
                    if(mikuMineLesson.id){
                        mikuMineLessonStepList =  MikuMineLessonStep.findAllByLessonId(mikuMineLesson.id);
                    }

                }

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
                topFlagMap:topFlagMap,
                productList:productList,
                mikuMineCourse:mikuMineCourse,
                mikuMineLesson:mikuMineLesson,
                mikuMineLessonStepList:mikuMineLessonStepList,
                mikuMineMultimediaResList:mikuMineMultimediaResList

        ]
    }

    //删除
    def del(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        Long courseId = params.long("id"); //课程ID

        if(!courseId){
            returnData.put('msg' ,'请选择课程');
            render(returnData as JSON);
        }

        //获取课程信息
        MikuMineCourse mikuMineCourse = MikuMineCourse.findById(courseId);

        if(mikuMineCourse){
            if(mikuMineCourse.courseType == (1 as byte) && mikuMineCourse.lessonId > 0L){
                //获取课时信息
                MikuMineLesson mikuMineLesson = MikuMineLesson.findById(mikuMineCourse.lessonId);
                if(mikuMineLesson){
                    //获取课时步骤
                    if(mikuMineLesson.id){
                        List<MikuMineLessonStep> mikuMineLessonStepList =  MikuMineLessonStep.findAllByLessonId(mikuMineLesson.id);
                        mikuMineLessonStepList.each {
                            it.delete(flush: true);
                        }
                    }

                }

                //删除课时
                mikuMineLesson.delete(flush: true);

            }

            //删除课程
            mikuMineCourse.delete(flush: true);
        }

        returnData.put('status' ,1);
        returnData.put('msg' ,'删除成功');

        render(returnData as JSON);
    }

    //删除课时步骤
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



}

<%--
Created by IntelliJ IDEA.
User: spider
Date: 26/9/14
Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    %{--datetimepicker--}%
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- ztree -->
    <asset:stylesheet src="zTreeStyle.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>

    <![endif]-->
        <title></title>
    <style>
        #lesson_list_area,#section_list_area{max-height: 200px;overflow-y: auto;}
    </style>
    </head>


<body>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1> 课程管理 <small>课程</small> </h1>
    <ol class="breadcrumb">
        <li><a href="http://120.24.102.187:8090/mikuProvider/checkList"><i class="fa fa-dashboard"></i>私人订制</a></li>
        <li class="active">课程管理</li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">课程列表</g:link></li>
                    <li><g:link action="addCourseView">添加课程</g:link></li>
                    <li><g:link action="lessonList">课时列表</g:link></li>
                    <li><g:link action="addLessonView">添加课时</g:link></li>
                    <li class="active"><a>关联课时</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">
        <form action="" name="item_form" id="item_form">
            <div class="box-header"> </div>
            <input type="hidden" name="courseId" value="${mikuMineCourse.id}" id="courseId">
            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <h4>课程基础信息：</h4>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程名称：</label>
                        <div class="col-xs-3">
                            <input type="text" id="courseName" name="courseName" value="${mikuMineCourse.courseName}" class="form-control" placeholder="课程名" disabled >
                        </div>

                        <label class="col-xs-2 control-label">课程简称：</label>
                        <div class="col-xs-3">
                            <input type="text" id="courseShortName" name="courseShortName" value="${mikuMineCourse.courseShortName}" class="form-control" placeholder="课程简称" disabled >
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程周期时长(天)：</label>
                        <div class="col-xs-3">
                            <input type="number" id="courseDuration" name="courseDuration" value="${mikuMineCourse.courseDuration}" class="form-control" placeholder="课程周期时长" disabled >
                        </div>

                        <label class="col-xs-2 control-label">课程阶段数量：</label>
                        <div class="col-xs-3">
                            <input type="number" id="courseSectionsNum" name="courseSectionsNum" value="${mikuMineCourse.courseSectionsNum}" class="form-control courseSectionsNum" placeholder="课程阶段数量" disabled >
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="courseType"
                                      class="form-control courseType" from="${courseTypeMap}" value="2"
                                      noSelection="['': '请选择']" disabled="" />
                        </div>
                        <label class="col-xs-2 control-label">课程属性：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="courseProperty"
                                      class="form-control courseProperty" from="${coursePropertyMap}" value="1"
                                      noSelection="['': '请选择']" disabled="" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程播放次数：</label>
                        <div class="col-xs-3">
                            <input type="number" id="coursePlayedTimes" name="coursePlayedTimes" value="${mikuMineCourse.coursePlayedTimes}" class="form-control coursePlayedTimes" placeholder="课程播放次数" disabled >
                        </div>

                        <label class="col-xs-2 control-label">订制类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="mineType"
                                      class="form-control mineType" from="${mineTypeMap}" value="${mikuMineCourse.mineType}"
                                      noSelection="['': '请选择']"  disabled="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程介绍：</label>
                        <div class="col-sm-3">
                            <textarea name="courseIntroduce"  rows="3" class="form-control courseIntroduce" id="courseIntroduce"  disabled >${mikuMineCourse.courseIntroduce}</textarea>
                        </div>
                        <label class="col-xs-2 control-label">课程备注：</label>
                        <div class="col-sm-3">
                            <textarea name="courseNote" rows="3" class="form-control courseNote" id="courseNote"  disabled >${mikuMineCourse.courseNote}</textarea>
                        </div>
                    </div>

                </div>
                <div class="list-group-item form-group">
                    <h4>课程阶段与课时关联信息：</h4>

                    <div class="row">

                        <div class="col-md-10" style="border: 1px solid #ddd;margin-left: 30px;margin-top: 10px;">
                            <h4>阶段：</h4>
                            <div class="row" id="section_list_area" >
                                <g:each in="${mikuMineCourseSectionList}" var="courseSection" status="i">

                                    <div class="col-md-11" style="margin-top: 5px;">
                                        <g:radio name="courseSectionId" value="" data_courseId="${courseSection.courseId}" data_id="${courseSection.id}" data_sectionDuration="${courseSection.sectionDuration}" data_sectionSd="${courseSection.sectionSd}" data_sectionEd="${courseSection.sectionEd}" class="courseSectionId" checkedFlg="1"/>${courseSection.sectionName}(培训时间:${courseSection.sectionSd} 至 ${courseSection.sectionEd})
                                    </div>

                                </g:each>
                            </div>
                        </div>

                    </div>


                </div>

                <button class="btn btn-success" type="button" id="add_step"><i class="fa fa-hand-o-down"></i>增加课时关联</button>
                <div class="list-group-item form-group lesson_list_area">

                </div>

            </div>
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="button" class="btn btn-primary" id="add_btn">确定</button>
                </div>
            </div>
            <!-- /.box-footer-->
        </form>
    </div>
</section>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
%{--datetimepicker--}%
<asset:javascript src="bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker.zh-CN.js"/>
<!-- ztree -->
<asset:javascript src="jquery.ztree.all.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>

<script>

    var lessonRelaNum = 0; //课时关系总个数
    datatimeSet();

    $(document).on('click','#add_step',function(){

        var sectionId = $('.courseSectionId:checked').attr('data_id');//阶段id

        if(sectionId){
            $('.loading').show(); //等待进度
            $.ajax({
                url: '/mikuTplCourseManage/getlessonListAjax',
                data: '',
                type: "POST",
                dataType: "json",
                success: function (data) {
                    var lessonList = data.result;

                    if(lessonList){
                        var info = '',
                            numKey = lessonRelaNum+1;
                        lessonRelation(info,lessonList,numKey);

                        datatimeSet();
                        icheck();
                    }

                    $('.loading').hide(); //等待进度
                },
                error: function (data) {

                }
            });
        }else{
            alert('请选择阶段!');
            return false;
        }


    }).on('click','.delete_step',function(){
        if(confirm('您确定要删除吗?')){
            $(this).next('.lesson_list_box').remove();
            $(this).remove();
        }

    }).on('blur','.dayOrder',function(){
        var dayOrder = $(this).val(),
            sectionSd = parseInt($('.courseSectionId:checked').attr('data_sectionSd')),
            sectionEd = parseInt($('.courseSectionId:checked').attr('data_sectionEd'));

        if((dayOrder < sectionSd || dayOrder > sectionEd) && dayOrder){
            alert('您只能填写数字:'+sectionSd+'至'+sectionEd);
            $(this).val('');
        }

    }).on('click','#add_btn',function(){
        var obj = {},
        list={},
        lesson_list_box=$('.lesson_list_box');

        $.each(lesson_list_box,function(index,element){
            var listcheck={},
                listobj={};

            listobj.dayOrder=$(element).find('.dayOrder').val();//阶段天
            listobj.earliesttimeInDay=$(element).find('#earliesttimeInDay').val();//最早这个课时什么时候用
            listobj.latestttimeInDay=$(element).find('#latestttimeInDay').val();//最迟这个课时什么时候用
            listobj.suggesttimeInDay=$(element).find('#suggesttimeInDay').val();//建议这个课时什么时候开始

            listobj.lessonId=$(element).find('input:checked').attr('data_id'); //课时ID

            list[index] = listobj;
        })

        obj.sectionId=$('.courseSectionId:checked').attr('data_id');//阶段id
        obj.courseId=$('#courseId').val();//课程id

        obj.list = JSON.stringify(list);//课时
        console.log(obj)


        ajax_call(getClassSuccess,'/mikuTplCourseManage/relaSectionLesson',obj,nf);

    }).on('ifChecked','.courseSectionId',function(){
        var lessonProperty,
                sectionId,
                data,
                numday=$(this).attr('data_sectionDuration');
        $('body').attr('data_sectionDuration',numday);
        lessonProperty=$('.courseProperty option:selected').attr('value');
        sectionId=$(this).attr('data_id');
        data={
            lessonProperty:lessonProperty,
            sectionId:sectionId

        }
        $('.loading').show(); //等待进度
        ajax_call(classHtml,'/mikuTplCourseManage/searchLessonList',data,nf);
    })

    icheck();
    %{--icheck--}%
    function icheck(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    }

    //        ajax
    function ajax_call(success,url,data,error) {
        $.ajax({
            url: url,
            data: data,
            type: "POST",
            dataType: "json",
            success: function (data) {
                success(data);
            },
            error: function (data) {
                error(data)
            }
        });
    }

    //空方法
    function nf(data){
        console.log(data.msg);
    }


    //课时循环
    function classHtml(data){
        $('.lesson_list_area').empty();

        var data=data.result,
            numday=$('body').attr('data_sectionDuration'),
            sectionLessonList = data.sectionLessonList,
            sectionLessonListLength = sectionLessonList.length,
            lessonList = data.lessonList ;

            if(sectionLessonListLength > 0){

                for(var j= 0;j<sectionLessonListLength;j++){
                    var info = sectionLessonList[j],
                        numKey = j;

                    console.log(info);
                    lessonRelation(info,lessonList,numKey);
                }

                datatimeSet();
                icheck();
            }

        $('.loading').hide(); //等待进度
    }


    function datatimeSet(){
        $(".form_datetime")
                .datetimepicker({format: 'hh:ii:ss', language: 'zh-CN', autoclose: true,startView:0,showMeridian:true})
    }

    //关联课时成功
    function getClassSuccess(data){
        console.log(data)
        alert(data.msg);
        if(data.status==1){
            window.location.href = 'index';
        }
    }

    //课时关联信息 info:课时关联信息,lessonList:课时列表,key:课时关联信息个数
    function lessonRelation(info,lessonList,key){
        lessonRelaNum = key;
        var html='<button class="btn btn-success delete_step" type="button">删除</button>',
                sectionLessonInfo = {dayOrder:'',earliesttimeInDay:'',latestttimeInDay:'',suggesttimeInDay:'',lessonId:''},
                sectionLessonInfo = info ? info : sectionLessonInfo;
        console.log(sectionLessonInfo);
        html+='<div class="list-group-item form-group lesson_list_box">';
        html+='<div class="col-xs-6">';
        html+='<div class="form-group">';
        html+='<label class="col-xs-6 control-label">阶段当前进行天数：</label>';
        html+='<div class="col-xs-6">';
        html+='<input type="number" id="dayOrder" name="dayOrder" value="'+(sectionLessonInfo.dayOrder)+'" class="form-control dayOrder" placeholder="阶段当前进行天数">';
        html+='</div>';
        html+='<label class="col-xs-6 control-label">最早这个课时什么时候用：</label>';
        html+='<div class="col-xs-6">';
        html+='<input type="text" id="earliesttimeInDay" name="earliesttimeInDay" value="'+sectionLessonInfo.earliesttimeInDay+'"  class="form-control form_datetime" placeholder="最早这个课时什么时候用" readonly/>';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-6 control-label">最迟这个课时什么时候用：</label>';
        html+='<div class="col-xs-6">';
        html+='<input type="text" id="latestttimeInDay" name="latestttimeInDay" value="'+sectionLessonInfo.latestttimeInDay+'" class="form-control form_datetime" placeholder="最迟这个课时什么时候用" readonly />';
        html+='</div>';
        html+='<label class="col-xs-6 control-label">建议这个课时什么时候开始：</label>';
        html+='<div class="col-xs-6">';
        html+='<input type="text" id="suggesttimeInDay" name="suggesttimeInDay" value="'+sectionLessonInfo.suggesttimeInDay+'" class="form-control courseSectionsNum form_datetime" placeholder="建议这个课时什么时候开始"  readonly />';
        html+='</div>';
        html+='</div>';
        html+='</div>';
        html+='<div class="col-xs-6">';
        html+='<div class="col-md-5" style="border: 1px solid #ddd;margin-left: 30px;margin-top: 10px;">';
        html+='<h4>课时：</h4>';
        html+='<div class="row" id="lesson_list_area" >';

        for(var i=0;i<lessonList.length;i++){

            html+='<div class="col-md-11" style="margin-top: 5px;">';
            if(lessonList[i].id !== sectionLessonInfo.lessonId){
                html+='<input type="radio" name="lessonId'+key+'" data_id="'+lessonList[i].id+'" class="lessonId" id="lessonId"/>'+lessonList[i].lessonName;
            }else{
                html+='<input checked="true" type="radio" name="lessonId'+key+'" data_id="'+lessonList[i].id+'" class="lessonId" id="lessonId"/>'+lessonList[i].lessonName;
            }
            html+='</div>';

        }
        html+='</div>';
        html+='</div>';
        html+='</div>';
        html+='</div>';

        $('.lesson_list_area').append(html);
    }

</script>
</body>
</html>
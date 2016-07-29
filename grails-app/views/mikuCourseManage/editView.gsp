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
    <head>
        <title></title>
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
                    <li class="active"><g:link action="addView">编辑课程</g:link></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">
        <form action="" name="item_form" id="item_form">
            <div class="box-header"> </div>

            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <h4>基础信息：</h4>
                    <input type="hidden" name="courseId" value="${mikuMineCourse.id}" id="courseId"/>
                    <input type="hidden" name="lessonId" value="${mikuMineLesson.id}" id="lessonId"/>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程名：</label>
                        <div class="col-xs-3">
                            <input type="text" id="courseName" name="courseName" value="${mikuMineCourse.courseName}" class="form-control" placeholder="课程名">
                        </div>

                        <label class="col-xs-2 control-label">课程简称：</label>
                        <div class="col-xs-3">
                            <input type="text" id="courseShortName" name="courseShortName" value="${mikuMineCourse.courseShortName}" class="form-control" placeholder="课程简称">
                        </div>
                    </div>

                    <div class="form-group">
                        %{--<label class="col-xs-2 control-label">课程周期时长(天)：</label>--}%
                        %{--<div class="col-xs-3">--}%
                        %{--<input type="number" id="courseDuration" name="courseDuration" class="form-control" placeholder="课程周期时长">--}%
                        %{--</div>--}%

                        <label class="col-xs-2 control-label">订制类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="mineType"
                                      class="form-control mineType" from="${mineTypeMap}" value="${mikuMineCourse.mineType}"
                                      noSelection="['': '请选择']"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="courseType"
                                      class="form-control courseType" from="${courseTypeMap}" value="${mikuMineCourse.courseType}"
                                      noSelection="['': '请选择']" disabled="" />
                        </div>
                        <label class="col-xs-2 control-label">课程属性：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="courseProperty"
                                      class="form-control courseProperty" from="${coursePropertyMap}" value="${mikuMineCourse.courseProperty}"
                                      noSelection="['': '请选择']" disabled="" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">本次课时时长(分)：</label>
                        <div class="col-xs-3">
                            <input type="number" id="lessonTime" name="lessonTime" value="${mikuMineLesson.lessonTime}" class="form-control lessonTime" placeholder="本次课时时长" disabled >
                        </div>
                        <label class="col-xs-2 control-label">本次课时步骤数：</label>
                        <div class="col-xs-3">
                            <input type="number" id="lessonStepsNum" name="lessonStepsNum" value="${mikuMineLesson.lessonStepsNum}" class="form-control lessonStepsNum" placeholder="本次课时步骤数" disabled >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程介绍：</label>
                        <div class="col-sm-3">
                            <textarea name="courseIntroduce" rows="3" class="form-control courseIntroduce" id="courseIntroduce">${mikuMineCourse.courseIntroduce}</textarea>
                        </div>
                        <label class="col-xs-2 control-label">课程备注：</label>
                        <div class="col-sm-3">
                            <textarea name="courseNote" rows="3" class="form-control courseNote" id="courseNote">${mikuMineCourse.courseNote}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">是否置顶：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="topFlag"
                                      class="form-control topFlag" from="${topFlagMap}" value="${mikuMineCourse.topFlag}"
                                      noSelection="['': '请选择']"/>
                        </div>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <h4>步骤：</h4>
                    <div id="section_list_arer">
                        <g:each in="${mikuMineLessonStepList}" var="lessonStep" status="i">
                        %{--<g:if test="${i > 0}">--}%
                            <button class="btn btn-success delete_step" type="button" stepid="${lessonStep.id}">删除</button>
                        %{--</g:if>--}%

                        <div class="step_box list-group-item">
                            <input type="hidden" name="stepid" class="stepid" value="${lessonStep.id}"/>
                        <div class="form-group">
                            %{--<label class="col-xs-2 control-label">步骤排序：</label>--}%
                            %{--<div class="col-sm-3">--}%
                            %{--<input value="1" type="text" class="form-control stepOrder" placeholder="步骤排序">--}%
                            %{--</div>--}%
                            <label class="col-xs-2 control-label">步骤名：</label>
                            <div class="col-sm-3">
                                <input type="text"  class="form-control stepName" name="stepName" value="${lessonStep.stepName}" placeholder="步骤名">
                            </div>
                            <label class="col-xs-2 control-label">步骤名缩写：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepShortName" name="stepShortName" value="${lessonStep.stepShortName}" placeholder="步骤名缩写">
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤类型：</label>
                            <div class="col-sm-3">
                                <g:select optionKey="key" optionValue="value" name="stepType"
                                          class="form-control stepType" from="${stepTypeMap}" value="${lessonStep.stepType}"
                                          noSelection="['': '请选择']"/>
                            </div>
                            <label class="col-xs-2 control-label">步骤间隔(秒)：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepInterval" name="stepInterval" value="${lessonStep.stepInterval}" placeholder="步骤间隔">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤排序：</label>
                            <div class="col-sm-3">
                                <input type="number" class="form-control stepOrder" name="stepOrder" value="${lessonStep.stepOrder}" placeholder="步骤排序">
                            </div>
                            <label class="col-xs-2 control-label">使用的产品：</label>
                            <div class="col-sm-3">
                                <g:select optionKey="id" optionValue="prodName" name="prodId"
                                          class="form-control prodId" from="${productList}" value="${lessonStep.prodId}"
                                          noSelection="['': '请选择']"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">产品使用提示：</label>
                            <div class="col-sm-3">
                                <textarea name="prodUseRemind" rows="3" class="form-control prodUseRemind">${lessonStep.prodUseRemind}</textarea>
                            </div>
                            <label class="col-xs-2 control-label">多媒体教学资源：</label>
                            <div class="col-sm-3" id="multimediaResourceIdhtml">
                                <g:select optionKey="id" optionValue="resName" name="multimediaResourceId"
                                          class="form-control multimediaResourceId" from="${mikuMineMultimediaResList}" value="${lessonStep.multimediaResourceId}"
                                          noSelection="['': '请选择']"/>

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤介绍：</label>
                            <div class="col-sm-3">
                                <textarea name="stepIntroduce" rows="3" class="form-control stepIntroduce">${lessonStep.stepIntroduce}</textarea>
                            </div>
                            <label class="col-xs-2 control-label">多媒体使用提示：</label>
                            <div class="col-sm-3">
                                <textarea name="multimediaUseRemind" rows="3" class="form-control multimediaUseRemind">${lessonStep.multimediaUseRemind}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">备注：</label>
                            <div class="col-sm-3">
                                <textarea name="stepNote" rows="3" class="form-control stepNote">${lessonStep.stepNote}</textarea>
                            </div>
                        </div>

                    </div>

                    </g:each>
                    </div>
                    <button class="btn btn-success" type="button" id="add_step"><i class="fa fa-hand-o-down"></i>增加步骤</button>
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

    %{--添加步骤模板开始--}%
    <div id="step_box_model" style="display: none;">

        <div class="form-group">
            %{--<label class="col-xs-2 control-label">步骤排序：</label>--}%
            %{--<div class="col-sm-3">--}%
            %{--<input value="1" type="text" class="form-control stepOrder" placeholder="步骤排序">--}%
            %{--</div>--}%
            <label class="col-xs-2 control-label">步骤名：</label>
            <div class="col-sm-3">
                <input type="text"  class="form-control stepName" placeholder="步骤名">
            </div>
            <label class="col-xs-2 control-label">步骤名缩写：</label>
            <div class="col-sm-3">
                <input type="text" class="form-control stepShortName" placeholder="步骤名缩写">
            </div>

        </div>

        <div class="form-group">
            <label class="col-xs-2 control-label">步骤类型：</label>
            <div class="col-sm-3">
                <g:select optionKey="key" optionValue="value" name="stepType"
                          class="form-control stepType" from="${stepTypeMap}" value=""
                          noSelection="['': '请选择']"/>
            </div>
            <label class="col-xs-2 control-label">步骤间隔(秒)：</label>
            <div class="col-sm-3">
                <input type="text" class="form-control stepInterval" placeholder="步骤间隔">
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-2 control-label">步骤排序：</label>
            <div class="col-sm-3">
                <input type="number" class="form-control stepOrder" placeholder="步骤排序">
            </div>
            <label class="col-xs-2 control-label">使用的产品：</label>
            <div class="col-sm-3">
                <g:select optionKey="id" optionValue="prodName" name="prodId"
                          class="form-control prodId" from="${productList}" value=""
                          noSelection="['': '请选择']"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-2 control-label">产品使用提示：</label>
            <div class="col-sm-3">
                <textarea name="prodUseRemind" rows="3" class="form-control prodUseRemind"></textarea>
            </div>
            <label class="col-xs-2 control-label">多媒体教学资源：</label>
            <div class="col-sm-3">
                <g:select optionKey="id" optionValue="resName" name="multimediaResourceId"
                          class="form-control multimediaResourceId" from="${mikuMineMultimediaResList}" value=""
                          noSelection="['': '请选择']"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-2 control-label">步骤介绍：</label>
            <div class="col-sm-3">
                <textarea name="stepIntroduce" rows="3" class="form-control stepIntroduce"></textarea>
            </div>
            <label class="col-xs-2 control-label">多媒体使用提示：</label>
            <div class="col-sm-3">
                <textarea name="multimediaUseRemind" rows="3" class="form-control multimediaUseRemind"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-2 control-label">备注：</label>
            <div class="col-sm-3">
                <textarea name="stepNote" rows="3" class="form-control stepNote"></textarea>
            </div>
        </div>

    </div>
    %{--添加步骤模板结束--}%
</section>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
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

    $(document).on('click','#add_step',function(){
        var stepType=$('.stepType_addhtml').html();
        var tp='<button class="btn btn-success delete_step" type="button">删除</button><div class="step_box list-group-item">'+$('#step_box_model').html()+'</div>';
        $('#section_list_arer').append(tp);

        var prodId=$('.prodId_addhtml').html();
        $('.form-group .stepType:last').append(stepType);
        $('.form-group .prodId:last').append(prodId);

    }).on('click','.delete_step',function(){
        if(confirm('您确定要删除吗')){

            var _this = $(this),
                stepid = _this.attr('stepid'),
                lessonid =  $('#lessonId').val();

            if(stepid){
                $.ajax({
                    url: '/mikuCourseManage/delLessonStep',
                    data: {id:stepid,lessonid:lessonid},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        alert(data.msg);
                        if(data.status == 1){
                            _this.next('.step_box').remove();
                            _this.remove();
                        }
                    },
                    error: function (data) {
                        alert('删除失败');
                    }
                });
            }else{
                _this.next('.step_box').remove();
                _this.remove();
            }

        }

    }).on('click','#add_btn',function(){
        var step_box=$('.step_box');
        var obj = {};
        var list={};

        obj.courseId = $('#courseId').val();//课程ID
        obj.lessonId = $('#lessonId').val();//课时ID
        obj.courseName=$('#courseName').val();//课程名
        obj.courseShortName=$('#courseShortName').val();//课程简称
        obj.coursePeriod=$('#coursePeriod').val();//课程周期时长(天)
        obj.mineType=$('#mineType').val();//订制类型
        obj.courseType=$('#courseType').val();//课程类型
        obj.courseProperty=$('#courseProperty').val();//课程属性
        obj.lessonTime=$('#lessonTime').val();//本次课程时长(分)
        obj.lessonStepsNum=$('#lessonStepsNum').val();//本次课程步骤数
        obj.courseIntroduce = $('#courseIntroduce').val();//课程介绍
        obj.courseNote = $('#courseNote').val();//课程备注
//        obj.courseSectionsNum = $('#courseSectionsNum').val();//课程阶段数量
        obj.courseDuration = $('#courseDuration').val();//课程周期时长
        obj.topFlag = $('#topFlag').val();

        $.each(step_box,function(index,element){
            var listobj = {};
            listobj.id = $(element).find('.stepid').val(); //步骤ID
            listobj.stepName = $(element).find('.stepName').val();//步骤名
            listobj.stepShortName = $(element).find('.stepShortName').val();//步骤名缩写
            listobj.stepType = $(element).find('.stepType').val();//步骤类型
            listobj.stepInterval = $(element).find('.stepInterval').val();//步骤间隔
            listobj.stepOrder=$(element).find('.stepOrder').val();//步骤排序
            listobj.prodId=$(element).find('.prodId').val();//使用的产品

            listobj.prodUseRemind = $(element).find('.prodUseRemind').val();//产品使用提示
            listobj.multimediaResourceId = $(element).find('.multimediaResourceId').val();//多媒体教学资源
            listobj.stepIntroduce = $(element).find('.stepIntroduce').val();//步骤介绍
            listobj.multimediaUseRemind = $(element).find('.multimediaUseRemind').val();//多媒体使用提示
            listobj.stepNote=$(element).find('.stepNote').val();//备注

            list[index] = listobj;
//            list.push(listobj);
        })

        obj.list = JSON.stringify(list);
        console.log(obj);

        ajax_call(nf,'/mikuCourseManage/add',obj,nf);

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
        alert(data.msg);
        if(data.status == 1){
            window.location.href = 'index';
        }
    }
</script>
</body>
</html>
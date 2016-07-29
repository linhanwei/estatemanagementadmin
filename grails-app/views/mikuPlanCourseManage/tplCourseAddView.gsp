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
                    <li class="active"><a>根据模板课程添加普通课程</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">
        <form action="" name="item_form" id="item_form">
            <div class="box-header"> </div>
            %{--<input type="hidden" name="courseId" value="${mikuMineCourse.id}" id="courseId">--}%
            <div class="box-body no-padding form-horizontal list-group">


                <div class="list-group-item form-group">
                    <h4>课程基础信息：</h4>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程名称：</label>
                        <div class="col-xs-3">
                            <input type="text" id="courseName" name="courseName" value="${mikuMineCourse.courseName}" class="form-control" placeholder="课程名">
                        </div>

                        <label class="col-xs-2 control-label">课程简称：</label>
                        <div class="col-xs-3">
                            <input type="text" id="courseShortName" name="courseShortName" value="${mikuMineCourse.courseShortName}" class="form-control" placeholder="课程简称">
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
                                      class="form-control courseProperty" from="${coursePropertyMap}" value="${mikuMineCourse.courseProperty}"
                                      noSelection="['': '请选择']" disabled="" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程播放次数：</label>
                        <div class="col-xs-3">
                            <input type="number" id="coursePlayedTimes" name="coursePlayedTimes" value="${mikuMineCourse.coursePlayedTimes}" class="form-control coursePlayedTimes" placeholder="课程播放次数" disabled>
                        </div>

                        <label class="col-xs-2 control-label">订制类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="mineType"
                                      class="form-control mineType" from="${mineTypeMap}" value="${mikuMineCourse.mineType}"
                                      noSelection="['': '请选择']"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程介绍：</label>
                        <div class="col-sm-3">
                            <textarea name="courseIntroduce"  rows="3" class="form-control courseIntroduce" id="courseIntroduce">${mikuMineCourse.courseIntroduce}</textarea>
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
                        <label class="col-xs-2 control-label">课程模板：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="courseTemplate"
                                      class="form-control" from="${courseTemplateMap}" value="0"
                                      noSelection="['': '请选择']" disabled="" />
                        </div>
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <h4>课程阶段与课时关联信息：</h4>

                    <div class="row">

                        <div class="col-md-10" style="border: 1px solid #ddd;margin-left: 30px;margin-top: 10px;">
                            <h4>阶段：</h4>
                            <div class="row" >
                                <g:each in="${mikuKSJdDetailList}" var="courseSectionInfo" status="i">
                                    <div class="section_list">
                                        %{--课程变量赋值开始--}%
                                            %{--课程阶段信息--}%
                                            <% courseSection = courseSectionInfo.mikuMineCourseSection %>
                                            %{--阶段与课时列表--}%
                                            <% mikuMineSectionLessonList = courseSectionInfo.mikuKsBZDetailList %>
                                        %{--课程变量赋值结束--}%

                                        %{--阶段信息开始--}%
                                        %{--<button class="btn btn-success delete_step" type="button" stepid="${courseSection.id}">删除</button>--}%
                                        <div class="list-group-item setion_info">
                                            <h4>阶段基础信息：<button class="btn btn-success add_section_lesson_rela" type="button" ><i class="fa fa-hand-o-down"></i>增加关联课时</button></h4>
                                            %{--<input type="hidden" name="sectionid" value="${courseSection.id}" class="sectionid"/>--}%
                                            <div class="form-group">

                                                <label class="col-xs-2 control-label">阶段名称：</label>
                                                <div class="col-sm-3">
                                                    <input type="text" name="sectionName" value="${courseSection.sectionName}" class="form-control sectionName" placeholder="步骤名">
                                                </div>
                                                <label class="col-xs-2 control-label">阶段名称缩写：</label>
                                                <div class="col-sm-3">
                                                    <input type="text" value="${courseSection.sectionShortName}" class="form-control sectionShortName" placeholder="步骤名缩写">
                                                </div>

                                            </div>

                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">阶段时长(天)：</label>
                                                <div class="col-sm-3">
                                                    <input type="number" name="sectionDuration" value="${courseSection.sectionDuration}" class="form-control sectionDuration" placeholder="阶段时长(天)" disabled>
                                                </div>
                                                <label class="col-xs-2 control-label">阶段排序(数字越小排前面)：</label>
                                                <div class="col-sm-3">
                                                    <input type="number" name="sectionOrder" value="${courseSection.sectionOrder}" class="form-control sectionOrder" placeholder="阶段排序">
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">该阶段第几天开始：</label>
                                                <div class="col-sm-3">
                                                    <input type="number" name="sectionSd" value="${courseSection.sectionSd}" class="form-control sectionSd" placeholder="该阶段第几天开始">
                                                </div>
                                                <label class="col-xs-2 control-label">该阶段第几天结束：</label>
                                                <div class="col-sm-3">
                                                    <input type="number" name="sectionEd" value="${courseSection.sectionEd}" class="form-control sectionEd" placeholder="该阶段第几天结束">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">阶段介绍：</label>
                                                <div class="col-sm-3">
                                                    <textarea name="sectionIntroduce" rows="3" class="form-control sectionIntroduce" id="sectionIntroduce">${courseSection.sectionIntroduce}</textarea>
                                                </div>
                                                <label class="col-xs-2 control-label">阶段备注：</label>
                                                <div class="col-sm-3">
                                                    <textarea name="sectionNote" rows="3" class="form-control sectionNote" id="sectionNote">${courseSection.sectionNote}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        %{--阶段信息结束--}%
                                        %{--课时列表信息开始--}%

                                            <g:each in="${mikuMineSectionLessonList}" var="mikuMineSectionLessonInfo" status="j">

                                                    %{--课时变量赋值开始--}%
                                                    %{--课时信息--}%
                                                        <% mikuMineLesson = mikuMineSectionLessonInfo.mikuMineLesson %>
                                                    %{--阶段与课时关系信息--}%
                                                        <% sectionLessonInfo = mikuMineSectionLessonInfo.mikuMineSectionLesson %>
                                                    %{--课时与步骤列表--}%
                                                        <% mikuMineLessonStepList = mikuMineSectionLessonInfo.mikuMineLessonStepList %>
                                                    %{--课时变量赋值结束--}%

                                                    <div class="section_lesson_list">
                                                                %{--阶段与课时信息开始--}%
                                                        <div class="list-group-item form-group section_lesson_info">
                                                            <h4>课程阶段与课时关联信息：</h4>
                                                            <div class="col-xs-6">
                                                                <div class="form-group">
                                                                    <label class="col-xs-6 control-label">阶段当前进行天数：</label>
                                                                    <div class="col-xs-6">
                                                                        <input type="number" id="dayOrder" name="dayOrder" value="${sectionLessonInfo.dayOrder}" class="form-control dayOrder" placeholder="阶段当前进行天数">
                                                                    </div>
                                                                    <label class="col-xs-6 control-label">最早这个课时什么时候用：</label>
                                                                    <div class="col-xs-6">
                                                                        <input type="text" id="earliesttimeInDay" name="earliesttimeInDay" value="${sectionLessonInfo.earliesttimeInDay}"  class="form-control form_datetime" placeholder="最早这个课时什么时候用" readonly/>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-xs-6 control-label">最迟这个课时什么时候用：</label>
                                                                    <div class="col-xs-6">
                                                                        <input type="text" id="latestttimeInDay" name="latestttimeInDay" value="${sectionLessonInfo.latestttimeInDay}" class="form-control form_datetime" placeholder="最迟这个课时什么时候用" readonly />
                                                                    </div>
                                                                    <label class="col-xs-6 control-label">建议这个课时什么时候开始：</label>
                                                                    <div class="col-xs-6">
                                                                        <input type="text" id="suggesttimeInDay" name="suggesttimeInDay" value="${sectionLessonInfo.suggesttimeInDay}" class="form-control courseSectionsNum form_datetime" placeholder="建议这个课时什么时候开始"  readonly />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-xs-6">
                                                                <div class="col-md-5" style="border: 1px solid #ddd;margin-left: 30px;margin-top: 10px;">
                                                                    <h4>课时：</h4>
                                                                    <div class="row lesson_list_area" id="lesson_list_area" >
                                                                        <g:each in="${allLessonList}" var="lessonInfo" status="k">
                                                                            <div class="col-md-11" style="margin-top: 5px;">
                                                                                <g:if test="${lessonInfo.id == sectionLessonInfo.lessonId}">
                                                                                    <input checked="true" type="checkbox" name="lessonId${j}" data_id="${lessonInfo.id}" class="lessonId" id="lessonId"/>${lessonInfo.lessonName}
                                                                                </g:if>
                                                                                <g:else>
                                                                                    <input type="checkbox" name="lessonId${j}" data_id="${lessonInfo.id}" class="lessonId" id="lessonId"/>${lessonInfo.lessonName}
                                                                                </g:else>

                                                                            </div>
                                                                        </g:each>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    %{--阶段与课时信息结束--}%

                                                    <div class="lesson_list">
                                                        %{--课时基本信息开始--}%
                                                            <div class="list-group-item form-group lesson_info">
                                                                <h4>课时基础信息：</h4>
                                                                <input type="hidden" name="lessonId" value="${mikuMineLesson.id}" id="lessonId" />
                                                                <div class="form-group">
                                                                    <label class="col-xs-2 control-label">课时名称：</label>
                                                                    <div class="col-xs-3">
                                                                        <input type="text" id="lessonName" name="lessonName" value="${mikuMineLesson.lessonName}" class="form-control" placeholder="课时名称">
                                                                    </div>

                                                                    <label class="col-xs-2 control-label">课时简称：</label>
                                                                    <div class="col-xs-3">
                                                                        <input type="text" id="lessonShortName" name="lessonShortName" value="${mikuMineLesson.lessonShortName}" class="form-control" placeholder="课时简称">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label class="col-xs-2 control-label">课时属性：</label>
                                                                    <div class="col-xs-3">
                                                                        <g:select optionKey="key" optionValue="value" name="lessonProperty"
                                                                                  class="form-control lessonProperty" from="${coursePropertyMap}" value="1"
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
                                                                    <label class="col-xs-2 control-label">课时介绍：</label>
                                                                    <div class="col-sm-3">
                                                                        <textarea name="lessonIntroduce" rows="3" class="form-control lessonIntroduce" id="lessonIntroduce">${mikuMineLesson.lessonIntroduce}</textarea>
                                                                    </div>
                                                                    <label class="col-xs-2 control-label">课时备注：</label>
                                                                    <div class="col-sm-3">
                                                                        <textarea name="lessonNote" rows="3" class="form-control lessonNote" id="lessonNote">${mikuMineLesson.lessonNote}</textarea>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        %{--课时基本信息结束--}%

                                                        %{--课时步骤列表开始--}%
                                                            <div class="list-group-item form-group">
                                                                <h4>课时步骤：</h4>
                                                                <div class="lesson_step_list">
                                                                    <g:each in="${mikuMineLessonStepList}" var="lessonStep" status="m">

                                                                    %{--<button class="btn btn-success delete_step" type="button" stepid="${lessonStep.id}">删除</button>--}%

                                                                        <div class="list-group-item lesson_step_info">
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

                                                                                <label class="col-xs-2 control-label">产品使用提示：</label>
                                                                                <div class="col-sm-3">
                                                                                    <textarea name="prodUseRemind" rows="3" class="form-control prodUseRemind">${lessonStep.prodUseRemind}</textarea>
                                                                                </div>
                                                                            </div>

                                                                        </div>

                                                                    </g:each>
                                                                </div>
                                                                <button class="btn btn-success add_step" type="button" ><i class="fa fa-hand-o-down"></i>增加步骤</button>
                                                            </div>
                                                        %{--课时步骤列表结束--}%
                                                    </div>
                                                </div>
                                            </g:each>
                                                %{--课时列表信息结束--}%
                                    </div>
                                </g:each>
                            </div>
                        </div>

                    </div>


                </div>

                <button class="btn btn-success add_lesson_rela" type="button" ><i class="fa fa-hand-o-down"></i>增加课时关联</button>

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

    datatimeSet(); //时间选择器

    $(document).on('ifChecked','.icheckbox_square-blue',function(){ //只能单选课时

        $(this).parent().siblings().find('input').attr('checked',false);
        $(this).parent().siblings().find('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    }).on('click','.add_step',function(){ //添加课时步骤
            var html = '<button class="btn btn-success del_step" type="button">删除步骤</button>',
                lessonStepInfo = $('.lesson_step_info').eq(0).html();
            html += '<div class="list-group-item lesson_step_info">';
            html += lessonStepInfo;
            html += '</div>';

            $(this).prev('.lesson_step_list').append(html);

            //初始化新添加的表单信息
            $(this).prev('.lesson_step_list').children('.lesson_step_info:last-child').find('input,textarea,select,file').not($('[type="radio"],[type="checkbox"]')).val('');
            $(this).prev('.lesson_step_list').children('.lesson_step_info:last-child').find('[type="radio"],[type="checkbox"]').attr('checked',false);
    }).on('click','.del_step',function(){//删除课时步骤
        if(confirm('您确定要删除吗?')){
            $(this).next('.lesson_step_info').remove();
            $(this).remove();
        }

    }).on('click','.add_section_lesson_rela',function(){ //添加阶段与课时关联
            var html = '',
                section_lesson_info = $('.section_lesson_info').eq(0).html(); //关联内容

                html = '<div class="section_lesson_list">';
                html += '<div class="list-group-item form-group section_lesson_info">';
                html += section_lesson_info;
                html += '</div>';
                html += '</div>';

            $(this).parents('.setion_info').next('.section_lesson_list').before(html);

            //初始化新添加的表单信息
            $(this).parents('.setion_info').next('.section_lesson_list').find('input,textarea,select,file').not($('[type="radio"],[type="checkbox"]')).val('');
            $(this).parents('.setion_info').next('.section_lesson_list').find('[type="radio"],[type="checkbox"]').attr('checked',false);

            icheck();
            datatimeSet(); //时间选择器

    }).on('click','.del_section_lesson_rela',function(){ //删除阶段与课时关联

    }).on('input','.dayOrder',function(){
        var dayOrder = $(this).val(),
                sectionSd = $('.courseSectionId:checked').attr('data_sectionSd'),
                sectionEd = $('.courseSectionId:checked').attr('data_sectionEd');

        if(!(dayOrder >= sectionSd && dayOrder <= sectionEd)){
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


        ajax_call(getClassSuccess,'/mikuPlanCourseManage/tplCourseAdd',obj,nf);

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
        ajax_call(classHtml,'/mikuPlanCourseManage/searchLessonList',data,nf);
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
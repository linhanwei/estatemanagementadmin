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
                    <li class="active"><g:link action="addView">添加课程</g:link></li>
                    <li><g:link action="lessonList">课时列表</g:link></li>
                    <li><g:link action="addLessonView">添加课时</g:link></li>
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
                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程模板：</label>
                        <div class="col-xs-4">
                            <g:select optionKey="id" optionValue="courseName" name="tplCourse"
                                      class="form-control tplCourse" from="${getAllTplCourseList}" value=""
                                      noSelection="['': '请选择']" />
                        </div>
                    </div>
                </div>
                <div id="course_info">
                    <div class="list-group-item form-group" >

                        <h4>基础信息：</h4>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">课程名称：</label>
                            <div class="col-xs-3">
                                <input type="text" id="courseName" name="courseName" class="form-control" placeholder="课程名">
                            </div>

                            <label class="col-xs-2 control-label">课程简称：</label>
                            <div class="col-xs-3">
                                <input type="text" id="courseShortName" name="courseShortName" class="form-control" placeholder="课程简称">
                            </div>
                        </div>

                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label">课程周期时长(天)：</label>--}%
                            %{--<div class="col-xs-3">--}%
                            %{--<input type="number" id="courseDuration" name="courseDuration" class="form-control" placeholder="课程周期时长">--}%
                            %{--</div>--}%

                            %{--<label class="col-xs-2 control-label">课程阶段数量：</label>--}%
                            %{--<div class="col-xs-3">--}%
                                %{--<input type="number" id="courseSectionsNum" name="courseSectionsNum" class="form-control courseSectionsNum" placeholder="课程阶段数量">--}%
                            %{--</div>--}%

                        %{--</div>--}%

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
                            %{--<label class="col-xs-2 control-label">课程播放次数：</label>--}%
                            %{--<div class="col-xs-3">--}%
                                %{--<input type="number" id="coursePlayedTimes" name="coursePlayedTimes" class="form-control coursePlayedTimes" placeholder="课程播放次数">--}%
                            %{--</div>--}%

                            <label class="col-xs-2 control-label">订制类型：</label>
                            <div class="col-xs-3">
                                <g:select optionKey="key" optionValue="value" name="mineType"
                                          class="form-control mineType" from="${mineTypeMap}" value=""
                                          noSelection="['': '请选择']"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">课程介绍：</label>
                            <div class="col-sm-3">
                                <textarea name="courseIntroduce" rows="3" class="form-control courseIntroduce" id="courseIntroduce"></textarea>
                            </div>
                            <label class="col-xs-2 control-label">课程备注：</label>
                            <div class="col-sm-3">
                                <textarea name="courseNote" rows="3" class="form-control courseNote" id="courseNote"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">是否置顶：</label>
                            <div class="col-xs-3">
                                <g:select optionKey="key" optionValue="value" name="topFlag"
                                          class="form-control topFlag" from="${topFlagMap}" value=""
                                          noSelection="['': '请选择']"/>

                            </div>
                            %{--<label class="col-xs-2 control-label">课程模板：</label>--}%
                            %{--<div class="col-xs-3">--}%
                                %{--<g:select optionKey="key" optionValue="value" name="courseTemplate"--}%
                                          %{--class="form-control" from="${courseTemplateMap}" value=""--}%
                                          %{--noSelection="['': '请选择']"/>--}%
                            %{--</div>--}%
                        </div>

                    </div>

                    <div class="list-group-item form-group" >
                    <h4>阶段：(<em style="color: red;">注意:  </em> 每个阶段的开始时间与结束时间不能重叠)</h4>
                    <div class="step_box list-group-item">

                        <div class="form-group">

                            <label class="col-xs-2 control-label">阶段名称：</label>
                            <div class="col-sm-3">
                                <input type="text"  class="form-control sectionName" placeholder="步骤名">
                            </div>
                            <label class="col-xs-2 control-label">阶段名称缩写：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control sectionShortName" placeholder="步骤名缩写">
                            </div>

                        </div>

                        <div class="form-group">
                            %{--<label class="col-xs-2 control-label">阶段时长(天)：</label>--}%
                            %{--<div class="col-sm-3">--}%
                                %{--<input type="number" name="sectionDuration"  class="form-control sectionDuration" placeholder="阶段时长(天)">--}%
                            %{--</div>--}%
                            <label class="col-xs-2 control-label">阶段排序(数字越小排前面)：</label>
                            <div class="col-sm-3">
                                <input type="number" name="sectionOrder" class="form-control sectionOrder" placeholder="阶段排序">
                            </div>

                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">该阶段第几天开始：</label>
                            <div class="col-sm-3">
                                <input type="number" name="sectionSd"  class="form-control sectionSd" placeholder="该阶段第几天开始">
                            </div>
                            <label class="col-xs-2 control-label">该阶段第几天结束：</label>
                            <div class="col-sm-3">
                                <input type="number" name="sectionEd" class="form-control sectionEd" placeholder="该阶段第几天结束">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">阶段介绍：</label>
                            <div class="col-sm-3">
                                <textarea name="sectionIntroduce" rows="3" class="form-control sectionIntroduce" id="sectionIntroduce"></textarea>
                            </div>
                            <label class="col-xs-2 control-label">阶段备注：</label>
                            <div class="col-sm-3">
                                <textarea name="sectionNote" rows="3" class="form-control sectionNote" id="sectionNote"></textarea>
                            </div>
                        </div>


                    </div>

                    <button class="btn btn-success" type="button" id="add_step"><i class="fa fa-hand-o-down"></i>增加阶段</button>
                </div>
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

    $(document).on('change','#tplCourse',function(){
        var couserId = $(this).val();

        if(couserId > 0){
            $('#course_info').hide();
        }else{
            $('#course_info').show();
        }

    }).on('click','#add_step',function(){
        var stepType=$('.stepType_addhtml').html();
        var tp='<button class="btn btn-success delete_step" type="button">删除</button><div class="step_box list-group-item">'+$('.step_box').html()+'</div>';
        $(this).prev('.step_box:last').after(tp);

        var prodId=$('.prodId_addhtml').html();
        $('.form-group .stepType:last').append(stepType);
        $('.form-group .prodId:last').append(prodId);

    }).on('click','.delete_step',function(){
        $(this).next('.step_box').remove();
        $(this).remove();
    }).on('click','#add_btn',function(){
        var step_box=$('.step_box'),
            obj = {},
            list={},
            isSub = true,
            tplCourseId = $('#tplCourse').val();

        if(tplCourseId > 0){
            obj.id = tplCourseId;
            ajax_call(nf,'/mikuPlanCourseManage/addTplCourse',obj,nf);
        }else{
            obj.courseName=$('#courseName').val();//课程名
            obj.courseShortName=$('#courseShortName').val();//课程简称
            obj.mineType=$('#mineType').val();//订制类型
            obj.courseType=$('#courseType').val();//课程类型
            obj.courseProperty=$('#courseProperty').val();//课程属性
            obj.coursePlayedTimes = $('#coursePlayedTimes').val();//课程播放次数
            obj.courseIntroduce = $('#courseIntroduce').val();//课程介绍
            obj.courseNote = $('#courseNote').val();//课程备注
            obj.topFlag = $('#topFlag').val();

            if(!obj.courseName){
                alert('课程名称不能为空!');
                isSub = false;
                return false;
            }

            $.each(step_box,function(index,element){
                var listobj = {};
                listobj.sectionName = $(element).find('.sectionName').val();//名称
                listobj.sectionShortName = $(element).find('.sectionShortName').val();//名称缩写
                listobj.sectionDuration = $(element).find('.sectionDuration').val();//天数
                listobj.sectionOrder = $(element).find('.sectionOrder').val();//排序
                listobj.sectionSd=$(element).find('.sectionSd').val();//开始时间
                listobj.sectionEd=$(element).find('.sectionEd').val();//结束时间
                listobj.sectionIntroduce = $(element).find('.sectionIntroduce').val();//介绍
                listobj.sectionNote = $(element).find('.sectionNote').val();//备注

                list[index] = listobj;

                if(!listobj.sectionName){
                    alert('阶段名称不能为空!');
                    isSub = false;
                    return false;
                }

                if(!listobj.sectionSd){
                    alert('阶段名称:'+listobj.sectionName+'开始时间不能为空!');
                    isSub = false;
                    return false;
                }

                if(!listobj.sectionEd){
                    alert('阶段名称:'+listobj.sectionName+'结束时间不能为空!');
                    isSub = false;
                    return false;
                }
            })

            obj.list = JSON.stringify(list);
            console.log(obj);

            if(isSub){
                ajax_call(nf,'/mikuPlanCourseManage/addCourse',obj,nf);
            }
        }

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
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

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程名：</label>
                        <div class="col-xs-3">
                            <input type="text" name="" class="form-control" placeholder="课程名">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">课程简称：</label>
                        <div class="col-xs-3">
                            <input type="text" name="" class="form-control" placeholder="课程简称">
                        </div>

                        <label class="col-xs-2 control-label">课程周期：</label>
                        <div class="col-xs-3">
                            <input type="text" name="" class="form-control" placeholder="课程周期">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">单次课程时长：</label>
                        <div class="col-xs-3">
                            <input type="text" name="" class="form-control" placeholder="单次课程时长">
                        </div>
                        <label class="col-xs-2 control-label">单次课程步骤数：</label>
                        <div class="col-xs-3">
                            <input type="number" name="" class="form-control" placeholder="单次课程步骤数">
                        </div>
                    </div>

                </div>

                <div class="list-group-item form-group">
                    <div class="step_box list-group-item">
                        <h4>步骤：</h4>
                        <div class="form-group">
                            %{--<label class="col-xs-2 control-label">步骤排序：</label>--}%
                            %{--<div class="col-sm-3">--}%
                                %{--<input value="1" type="text" class="form-control stepOrder" placeholder="步骤排序">--}%
                            %{--</div>--}%
                            <label class="col-xs-2 control-label">步骤名：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepName" placeholder="步骤名">
                            </div>
                            <label class="col-xs-2 control-label">步骤类型：</label>
                            <div class="col-sm-3">
                                <g:select optionKey="key" optionValue="value" name="stepType"
                                          class="form-control stepType" from="${stepTypeMap}" value=""
                                          noSelection="['': '请选择']"/>
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤名缩写：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepShortName" placeholder="步骤名缩写">
                            </div>
                            <label class="col-xs-2 control-label">步骤间隔：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepInterval" placeholder="步骤间隔">
                            </div>
                        </div>

                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label">步骤类型：</label>--}%
                            %{--<div class="col-sm-3">--}%
                                %{--<g:select optionKey="key" optionValue="value" name="stepType"--}%
                                          %{--class="form-control stepType" from="${stepTypeMap}" value=""--}%
                                          %{--noSelection="['': '请选择']"/>--}%
                            %{--</div>--}%
                        %{--</div>--}%


                        <div class="list-group-item time_box">
                            <div class="form-group">
                                <label class="col-xs-2 control-label">使用条件：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardCondition"
                                              class="form-control stepUseStandardCondition" from="${stepUseStandardConditionMap}" value=""
                                              noSelection="['': '请选择']"/>
                                    %{--<select name="" class="form-control stepUseStandardCondition">--}%
                                    %{--<option value="">请选择</option>--}%
                                    %{--<option value="1">周期性</option>--}%
                                    %{--<option value="2">突发性</option>--}%
                                    %{--</select>--}%
                                </div>
                                <label class="col-xs-2 control-label">周期：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardPeriod"
                                              class="form-control stepUseStandardPeriod" from="${stepUseStandardPeriodMap}" value=""
                                              noSelection="['': '请选择']"/>
                                    %{--<select name="" class="form-control stepUseStandardPeriod">--}%
                                    %{--<option value="">请选择</option>--}%
                                    %{--<option value="1">每天</option>--}%
                                    %{--<option value="2">每周</option>--}%
                                    %{--<option value="3">每月</option>--}%
                                    %{--<option value="3">有症状的时候</option>--}%
                                    %{--</select>--}%
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">使用规范：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardFrequency"
                                              class="form-control stepUseStandardFrequency" from="${stepUseStandardFrequencyMap}" value=""
                                              noSelection="['': '请选择']"/>
                                    %{--<select name="" class="form-control stepUseStandardFrequency">--}%
                                    %{--<option value="">请选择</option>--}%
                                    %{--<option value="1">早晚都要</option>--}%
                                    %{--<option value="2">早</option>--}%
                                    %{--<option value="3">晚</option>--}%
                                    %{--<option value="4">3小时一次</option>--}%
                                    %{--<option value="5">每周一次</option>--}%
                                    %{--<option value="6">每周两次</option>--}%
                                    %{--</select>--}%
                                </div>
                                <label class="col-xs-2 control-label">使用产品：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control prodId" placeholder="使用产品">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">产品使用提示：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control prodUseRemind" placeholder="产品使用提示">
                                </div>
                                <label class="col-xs-2 control-label">视频：</label>
                                <div class="col-sm-3">
                                    <input type="url" class="form-control videoName" placeholder="视频">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">视频名缩写：</label>
                                <div class="col-sm-3">
                                    <input type="url" class="form-control videoShortName" placeholder="视频名缩写">
                                </div>
                                <label class="col-xs-2 control-label">视频使用提示：</label>
                                <div class="col-sm-3">
                                    <input type="url" class="form-control videoUseRemind" placeholder="视频使用提示">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">视频在云片上的url：</label>
                                <div class="col-sm-3">
                                    <input type="url" class="form-control videoUrl" placeholder="视频在云片上的url">
                                </div>
                                <label class="col-xs-2 control-label">视频时长：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control videoTime" placeholder="视频时长">
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary add_time">增加</button>
                    </div>

                    <button class="btn btn-success" type="button" id="add_step"><i class="fa fa-hand-o-down"></i>增加步骤</button>
                </div>


            </div>
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="button" class="btn btn-primary" id="add_btn">确定</button>
                    <button class="btn btn-default" type="reset">取消</button>
                </div>
            </div>
            <!-- /.box-footer-->
        </form>
    </div>
</section>

<div class="stepUseStandardCondition_addhtml" style="display: none;">
    <g:select optionKey="key" optionValue="value" name="stepUseStandardCondition"
              class="form-control stepUseStandardCondition" from="${stepUseStandardConditionMap}" value=""
              noSelection="['': '请选择']"/>
</div>
<div class="stepUseStandardPeriod_addhtml" style="display:none;">
    <g:select optionKey="key" optionValue="value" name="stepUseStandardPeriod"
              class="form-control stepUseStandardPeriod" from="${stepUseStandardPeriodMap}" value=""
              noSelection="['': '请选择']"/>
</div>
<div class="stepUseStandardFrequency_addhtml" style="display:none;">
    <g:select optionKey="key" optionValue="value" name="stepUseStandardFrequency"
              class="form-control stepUseStandardFrequency" from="${stepUseStandardFrequencyMap}" value=""
              noSelection="['': '请选择']"/>
</div>
<div class="stepType_addhtml" style="display:none;">
    <g:select optionKey="key" optionValue="value" name="stepType"
              class="form-control stepType" from="${stepTypeMap}" value=""
              noSelection="['': '请选择']"/>
</div>

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
    // 增加步骤模板
    function addStepHtml(){
        var html='<button class="btn btn-success delete_step" type="button">删除</button>';
        html+='<div class="step_box list-group-item">';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">步骤排序：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepOrder" placeholder="步骤排序">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">步骤名：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepName" placeholder="步骤名">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">步骤名缩写：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepShortName" placeholder="步骤名缩写">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">步骤间隔：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepInterval" placeholder="步骤间隔">';
        html+='</div>';
        html+='</div>';

        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">步骤类型：</label>';
        html+='<div class="col-sm-3 stepType_step_html">';
//        html+='<input type="text" class="form-control stepShortName" placeholder="步骤名缩写">';
        html+='</div>';
        html+='</div>';

        html+='<div class="list-group-item time_box">';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用条件：</label>';
        html+='<div class="col-sm-3 stepUseStandardCondition_step_html">';

//        html+='<select name="" class="form-control stepUseStandardCondition">';
//        html+='<option value="0">请选择</option>';
//        html+='<option value="1">周期性</option>';
//        html+='<option value="2">突发性</option>';
//        html+='</select>';

        %{--html+="<g:select optionKey="key" optionValue="value" name="stepUseStandardCondition"--}%
        %{--class="form-control stepUseStandardCondition" from="${stepUseStandardConditionMap}" value=""--}%
        %{--noSelection="['': '请选择']"/>";--}%

        html+='</div>';
        html+='<label class="col-xs-2 control-label">周期：</label>';
        html+='<div class="col-sm-3 stepUseStandardPeriod_step_html">';


//        html+='<select name="" class="form-control stepUseStandardPeriod">';
//        html+='<option value="">请选择</option>';
//        html+='<option value="1">每天</option>';
//        html+='<option value="2">每周</option>';
//        html+='<option value="3">每月</option>';
//        html+='<option value="4">有症状的时候</option>';
//        html+='</select>';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用规范：</label>';
        html+='<div class="col-sm-3 stepUseStandardFrequency_step_html">';
//        html+='<select name="" class="form-control stepUseStandardFrequency">';
//        html+='<option value="">请选择</option>';
//        html+='<option value="1">早晚都要</option>';
//        html+='<option value="2">早</option>';
//        html+='<option value="3">晚</option>';
//        html+='<option value="4">3小时一次</option>';
//        html+='<option value="5">每周一次</option>';
//        html+='<option value="6">每周两次</option>';
//        html+='</select>';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">使用产品：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control prodId" placeholder="使用产品">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">产品使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control prodUseRemind" placeholder="产品使用提示">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoName" placeholder="视频">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">视频名缩写：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoShortName" placeholder="视频名缩写">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoUseRemind" placeholder="视频使用提示">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">视频在云片上的url：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoUrl" placeholder="视频在云片上的url">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频时长：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control videoTime" placeholder="视频时长">';
        html+='</div>';
        html+='</div>';
        html+='</div>';
        html+='<button class="btn btn-primary add_time" type="button">增加</button>';
        html+='</div>';

        return html;
    }

    // 增加时段模板
    function addTimeHtml(){
        var html='<button class="btn btn-primary delete_type" type="button">删除</button>';
        html+='<div class="list-group-item time_box">';


        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用条件：</label>';
        html+='<div class="col-sm-3 stepUseStandardCondition_time_html">';

//        html+='<select name="" class="form-control stepUseStandardCondition_time_html">';
//        html+='<option value="0">请选择</option>';
//        html+='<option value="1">周期性</option>';
//        html+='<option value="2">突发性</option>';
//        html+='</select>';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">周期：</label>';
        html+='<div class="col-sm-3 stepUseStandardPeriod_time_html">';
//        html+='<select name="" class="form-control stepUseStandardPeriod">';
//        html+='<option value="">请选择</option>';
//        html+='<option value="1">每天</option>';
//        html+='<option value="2">每周</option>';
//        html+='<option value="3">每月</option>';
//        html+='<option value="4">有症状的时候</option>';
//        html+='</select>';
        html+='</div>';



        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用规范：</label>';
        html+='<div class="col-sm-3 stepUseStandardFrequency_time_html">';
//        html+='<select name="" class="form-control stepUseStandardFrequency">';
//        html+='<option value="">请选择</option>';
//        html+='<option value="1">早晚都要</option>';
//        html+='<option value="2">早</option>';
//        html+='<option value="3">晚</option>';
//        html+='<option value="4">3小时一次</option>';
//        html+='<option value="5">每周一次</option>';
//        html+='<option value="6">每周两次</option>';
//        html+='</select>';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">使用产品：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control prodId" placeholder="使用产品">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">产品使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control prodUseRemind" placeholder="产品使用提示">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoName" placeholder="视频">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">视频名缩写：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoShortName" placeholder="视频名缩写">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoUseRemind" placeholder="视频使用提示">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">视频在云片上的url：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoUrl" placeholder="视频在云片上的url">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频时长：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control videoTime" placeholder="视频时长">';
        html+='</div>';
        html+='</div>';
        html+='</div>';

        return html;
    }


    $(document).on('click','#add_step',function(){
        var tp=addStepHtml();
        $(this).prev('.step_box:last').after(tp);

        var stepType=$('.stepType_addhtml').html();
        var stepUseStandardCondition=$('.stepUseStandardCondition_addhtml').html();
        var stepUseStandardPeriod=$('.stepUseStandardPeriod_addhtml').html();
        var stepUseStandardFrequency=$('.stepUseStandardFrequency_addhtml').html();
        $('.stepType_step_html').append(stepType);
        $('.stepUseStandardCondition_step_html:last').append(stepUseStandardCondition);
        $('.stepUseStandardPeriod_step_html:last').append(stepUseStandardPeriod);
        $('.stepUseStandardFrequency_step_html:last').append(stepUseStandardFrequency);
//        $('.step_box:last').after(tp);
    }).on('click','.add_time',function(){
        var tp=addTimeHtml();
        $(this).prev('.time_box:last').after(tp);

        var stepUseStandardCondition=$('.stepUseStandardCondition_addhtml').html();
        var stepUseStandardPeriod=$('.stepUseStandardPeriod_addhtml').html();
        var stepUseStandardFrequency=$('.stepUseStandardFrequency_addhtml').html();
        $('.stepUseStandardCondition_time_html:last').append(stepUseStandardCondition);
        $('.stepUseStandardPeriod_time_html:last').append(stepUseStandardPeriod);
        $('.stepUseStandardFrequency_time_html:last').append(stepUseStandardFrequency);
//        $('.time_box:last').after(tp);
    }).on('click','.delete_type',function(){
        $(this).next('.time_box').remove();
        $(this).remove();
    }).on('click','.delete_step',function(){
        $(this).next('.step_box').remove();
        $(this).remove();
    }).on('click','#add_btn',function(){
        var step_box=$('.step_box');
        var time_box=$('.time_box');
        var list = [];
        var obj = {};

        obj.scProblemId=$('.scProblemId').val();
        obj.scThinkingId=$('.scThinkingId').val();
        obj.envSkinType=$('.envSkinType').val();
        obj.skinTypeInfer=$('.skinTypeInfer').val();
        obj.envAgeRegion=$('.envAgeRegion').val();
        obj.envSeasons=$('.envSeasons').val();
        obj.envArea=$('.envArea').val();


        $.each(step_box,function(index,element){
            var childList = [];
            obj.stepOrder = $(element).find('.stepOrder').val();
            obj.stepName = $(element).find('.stepName').val();
            obj.stepShortName = $(element).find('.stepShortName').val();
            obj.stepInterval = $(element).find('.stepInterval').val();
            obj.stepType=$(element).find('.stepType').val();

            list.push(obj);

            $(element).children('.time_box').each(function(childIndex,childEle){

                var childObj = {};
                childObj.stepUseStandardCondition = $(childEle).find('.stepUseStandardCondition').val();
                childObj.stepUseStandardPeriod = $(childEle).find('.stepUseStandardPeriod').val();
                childObj.stepUseStandardFrequency = $(childEle).find('.stepUseStandardFrequency').val();
                childObj.prodId = $(childEle).find('.prodId').val();
                childObj.prodUseRemind = $(childEle).find('.prodUseRemind').val();
                childObj.videoName = $(childEle).find('.videoName').val();
                childObj.videoShortName = $(childEle).find('.videoShortName').val();
                childObj.videoUseRemind = $(childEle).find('.videoUseRemind').val();
                childObj.videoUrl = $(childEle).find('.videoUrl').val();
                childObj.videoTime = $(childEle).find('.videoTime').val();


                childList.push(childObj);
                console.log(childEle);
            })

            obj.childList = childList;
        })

        console.log(list);

        ajax_call(nf,'/mikuCustomizedExperienceDatabase/add',list,nf);

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
    function nf(){}
</script>
</body>
</html>
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

    <style>
        .table_head{border: 1px solid #f4f4f4;margin-top: 45px;}
        .table_head li{list-style: none;float: left;width: 33.333333%;text-align: center;line-height: 37px;font-weight: bold;}
        .table_head ul{margin-bottom: 0;padding: 0;}
        /*浮动闭合*/
        .clearfix:after {
            content: ".";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }
        *html .clearfix {
            height: 1%;
        }
        *:first-child+html .clearfix {
            zoom: 1;
        }
        /*{
            height: 1%;
            zoom:1;
        }*/
        .clearfix {
            display: inline-block;
        }
        /*Hide from IE Mac*/
        .clearfix {
            display: block;
        }
        /*End hide from IE Mac*/

        /*float 万能闭合钥匙结束*/
</style>
<head>
    <title></title>
</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1> 经验库管理 <small>经验库</small> </h1>
    <ol class="breadcrumb">
        <li><a href="http://120.24.102.187:8090/mikuProvider/checkList"><i class="fa fa-dashboard"></i>私人订制</a></li>
        <li class="active">经验库管理</li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">经验库列表</g:link></li>
                    <li class="active"><g:link action="addView">添加经验库</g:link></li>
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
                    <h4>基础问题：</h4>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">定制类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="mineType"
                                      class="form-control mineType" from="${mineTypeMap}" value=""
                                      noSelection="['': '请选择']"/>

                        </div>

                        <label class="col-xs-2 control-label">症状：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="id" optionValue="scProblemName" name="scProblemId"
                                      class="form-control scProblemId" from="${scProblemItemList}" value="" noSelection="['': '请选择']"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">治疗方案：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="id" optionValue="scThinkingName" name="scThinkingId"
                                      class="form-control scThinkingId" from="${scThinkingItemList}" value="" noSelection="['': '请选择']"/>
                        </div>

                        <label class="col-xs-2 control-label">肤质：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envSkinType"
                                      class="form-control envSkinType" from="${envSkinTypeMap}" value=""
                                      noSelection="['': '请选择']"/>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">用户肤质推断：</label>
                        <div class="col-xs-3">
                            <input type="text" name="skinTypeInfer" value="" id="skinTypeInfer" class="form-control" placeholder="用户肤质推断">
                        </div>
                        <label class="col-xs-2 control-label">年龄：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envAgeRegion"
                                      class="form-control envAgeRegion" from="${envAgeRegionMap}" value=""
                                      noSelection="['': '请选择']"/>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">季节：</label>

                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envSeasons"
                                      class="form-control envSeasons" from="${envSeasonsMap}" value=""
                                      noSelection="['': '请选择']"/>


                        </div>
                        <label class="col-xs-2 control-label">区域：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envArea"
                                      class="form-control envArea" from="${envAreaMap}" value=""
                                      noSelection="['': '请选择']"/>

                        </div>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <div class="step_box list-group-item">
                        <h4>步骤：</h4>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤名：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepName" placeholder="步骤名">
                            </div>

                            <label class="col-xs-2 control-label">步骤名缩写：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepShortName" placeholder="步骤名缩写">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤排序(数字小排前面)：</label>
                            <div class="col-sm-3">
                                <input name="stepOrder" value="" type="text" class="form-control stepOrder" placeholder="步骤排序">
                            </div>

                            <label class="col-xs-2 control-label">步骤类型：</label>
                            <div class="col-sm-3">
                                <g:select optionKey="key" optionValue="value" name="stepType"
                                          class="form-control stepType" from="${stepTypeMap}" value=""
                                          noSelection="['': '请选择']"/>
                            </div>

                        </div>

                        <div class="form-group">

                            <label class="col-xs-2 control-label">步骤间隔：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control stepInterval" placeholder="步骤间隔">
                            </div>
                        </div>

                        <div class="list-group-item time_box">
                            <div class="form-group">
                                <label class="col-xs-2 control-label">使用条件：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardCondition"
                                              class="form-control stepUseStandardCondition" from="${stepUseStandardConditionMap}" value=""
                                              noSelection="['': '请选择']"/>

                                </div>
                                <label class="col-xs-2 control-label">周期：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardPeriod"
                                              class="form-control stepUseStandardPeriod" from="${stepUseStandardPeriodMap}" value=""
                                              noSelection="['': '请选择']"/>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">使用频率：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardFrequency"
                                              class="form-control stepUseStandardFrequency" from="${stepUseStandardFrequencyMap}" value=""
                                              noSelection="['': '请选择']"/>

                                </div>
                                <label class="col-xs-2 control-label">使用产品：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="id" optionValue="prodName" name="prodId"
                                              class="form-control prodId" from="${mikuMineScProductList}" value=""
                                              noSelection="['': '请选择']"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">产品使用提示：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control prodUseRemind" placeholder="产品使用提示">
                                </div>
                                <label class="col-xs-2 control-label">视频：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="id" optionValue="resShortName" name="multimediaResourceId"
                                              class="form-control multimediaResourceId" from="${mikuMineMultimediaResList}" value=""
                                              noSelection="['': '请选择']"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">视频使用提示：</label>
                                <div class="col-sm-3">
                                    <input type="url" class="form-control videoUseRemind" placeholder="视频使用提示">
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
%{--产品--}%
<div class="prodId_addhtml" style="display: none;">
    <g:select optionKey="id" optionValue="prodName" name="prodId"
              class="form-control prodId" from="${mikuMineScProductList}" value=""
              noSelection="['': '请选择']"/>
</div>
<div class="multimediaResourceId_addhtml">
    <g:select optionKey="id" optionValue="resShortName" name="multimediaResourceId"
              class="form-control multimediaResourceId" from="${mikuMineMultimediaResList}" value=""
              noSelection="['': '请选择']"/>
</div>
<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="useproduct_show" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title">选择产品</h3>
            </div>
            <div class="modal-body">

                <div class="header-box form-inline col-lg-12">
                    <div class="col-lg-4 form-group">
                        <label class="control-label">肤质：</label>
                        <input name="" class="form-control" value="" type="text">
                    </div>
                    <div class="col-lg-4 form-group">
                        <button type="button" class="btn btn-primary" id=""><i class="fa fa-search"></i>搜索</button>
                    </div>
                </div>

                <div class="box_con">
                    <div class="table_head">
                        <ul class="clearfix">
                            <li>序号</li>
                            <li>爽肤水</li>
                            <li>爽肤</li>
                        </ul>
                    </div>
                    <div class="table-responsive box-body" style="padding: 0;">
                        <table class="table table-hover table-bordered text-center">
                            %{--<thead>--}%
                            %{--<tr>--}%
                            %{--<th>序号</th>--}%
                            %{--<th>产品名称</th>--}%
                            %{--<th>产品类型</th>--}%
                            %{--</tr>--}%
                            %{--</thead>--}%
                            <tbody>
                            <tr>
                                <td width="33.33333333%">1</td>
                                <td width="33.33333333%">sf</td>
                                <td width="33.33333333%">11</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="chang_relation">确定</button>
                %{--<button type="button" class="btn btn-primary">Save changes</button>--}%
            </div>
        </div>
    </div>
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
        html+='<label class="col-xs-2 control-label">步骤名：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepName" placeholder="步骤名">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">步骤名缩写：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepShortName" placeholder="步骤名缩写">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">步骤排序(数字小排前面)：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepOrder" placeholder="步骤排序">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">步骤类型：</label>';
        html+='<div class="col-sm-3 stepType_step_html">';
//        html+='<input type="text" class="form-control stepShortName" placeholder="步骤名缩写">';
        html+='</div>';
        html+='</div>';

        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">步骤间隔：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control stepInterval" placeholder="步骤间隔">';
        html+='</div>';
        html+='</div>';
        html+='<div class="list-group-item time_box">';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用条件：</label>';
        html+='<div class="col-sm-3 stepUseStandardCondition_step_html">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">周期：</label>';
        html+='<div class="col-sm-3 stepUseStandardPeriod_step_html">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用频率：</label>';
        html+='<div class="col-sm-3 stepUseStandardFrequency_step_html">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">使用产品：</label>';
        html+='<div class="col-sm-3 prodId_step_html">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">产品使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control prodUseRemind" placeholder="产品使用提示">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频：</label>';
        html+='<div class="col-sm-3 multimediaResourceId_step_html">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">视频使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoUseRemind" placeholder="视频使用提示">';
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
        html+='</div>';
        html+='<label class="col-xs-2 control-label">周期：</label>';
        html+='<div class="col-sm-3 stepUseStandardPeriod_time_html">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">使用频率：</label>';
        html+='<div class="col-sm-3 stepUseStandardFrequency_time_html">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">使用产品：</label>';
        html+='<div class="col-sm-3 prodId_time_html">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">产品使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="text" class="form-control prodUseRemind" placeholder="产品使用提示">';
        html+='</div>';
        html+='<label class="col-xs-2 control-label">视频：</label>';
        html+='<div class="col-sm-3 multimediaResourceId_time_html">';
        html+='</div>';
        html+='</div>';
        html+='<div class="form-group">';
        html+='<label class="col-xs-2 control-label">视频使用提示：</label>';
        html+='<div class="col-sm-3">';
        html+='<input type="url" class="form-control videoUseRemind" placeholder="视频使用提示">';
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
        var prodId=$('.prodId_addhtml').html();
        var multimediaResourceId=$('.multimediaResourceId_addhtml').html();
        $('.stepType_step_html:last').append(stepType);
        $('.stepUseStandardCondition_step_html:last').append(stepUseStandardCondition);
        $('.stepUseStandardPeriod_step_html:last').append(stepUseStandardPeriod);
        $('.stepUseStandardFrequency_step_html:last').append(stepUseStandardFrequency);
        $('.prodId_step_html:last').append(prodId);
        $('.multimediaResourceId_step_html:last').append(multimediaResourceId);
//        $('.step_box:last').after(tp);
    }).on('click','.add_time',function(){
        var tp=addTimeHtml();
        $(this).prev('.time_box:last').after(tp);

        var stepUseStandardCondition=$('.stepUseStandardCondition_addhtml').html();
        var stepUseStandardPeriod=$('.stepUseStandardPeriod_addhtml').html();
        var stepUseStandardFrequency=$('.stepUseStandardFrequency_addhtml').html();
        var prodId=$('.prodId_addhtml').html();
        var multimediaResourceId=$('.multimediaResourceId_addhtml').html();
        $('.stepUseStandardCondition_time_html:last').append(stepUseStandardCondition);
        $('.stepUseStandardPeriod_time_html:last').append(stepUseStandardPeriod);
        $('.stepUseStandardFrequency_time_html:last').append(stepUseStandardFrequency);
        $('.prodId_time_html:last').append(prodId);
        $('.multimediaResourceId_time_html:last').append(multimediaResourceId);
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
        var list = {};
        var obj = {};

        obj.mineType = $('#mineType').val();
        obj.scProblemId=$('.scProblemId').val();
        obj.scThinkingId=$('.scThinkingId').val();
        obj.envSkinType=$('.envSkinType').val();
        obj.skinTypeInfer=$('#skinTypeInfer').val();
        obj.envAgeRegion=$('.envAgeRegion').val();
        obj.envSeasons=$('.envSeasons').val();
        obj.envArea=$('.envArea').val();


        $.each(step_box,function(index,element){
            var childList = {},
                listObj = {};
            listObj.stepOrder = $(element).find('.stepOrder').val();
            listObj.stepName = $(element).find('.stepName').val();
            listObj.stepShortName = $(element).find('.stepShortName').val();
            listObj.stepInterval = $(element).find('.stepInterval').val();
            listObj.stepType=$(element).find('.stepType').val();

            $(element).children('.time_box').each(function(childIndex,childEle){

                var childObj = {};
                childObj.stepUseStandardCondition = $(childEle).find('.stepUseStandardCondition').val();
                childObj.stepUseStandardPeriod = $(childEle).find('.stepUseStandardPeriod').val();
                childObj.stepUseStandardFrequency = $(childEle).find('.stepUseStandardFrequency').val();
                childObj.prodId = $(childEle).find('.prodId').val();
                childObj.prodUseRemind = $(childEle).find('.prodUseRemind').val();
                childObj.multimediaResourceId = $(childEle).find('.multimediaResourceId').val();
                childObj.videoUseRemind = $(childEle).find('.videoUseRemind').val();

                childList[childIndex] =childObj;

            })

            listObj.childList = childList;
            list[index] = listObj;

        })
        console.log(obj);
        obj.list = JSON.stringify(list);
        ajax_call(addsuccess,'/mikuCustomizedExperienceDatabase/add',obj,nf);

    })


//    $("#useproduct").focus(function(){
//        $('#useproduct_show').modal('show');
//    });



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

    function addsuccess(data){
        alert(data.msg);
        if(data.status == 1){
            window.location.href = "index";
        }
    }
</script>
</body>
</html>
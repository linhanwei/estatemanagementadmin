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
                    <li class="active"><g:link action="addView">编辑经验库</g:link></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">

        <g:form name="item_form" useToken="true" action="edit">
            <div class="box-header"> </div>
            <input type="hidden" name="id" value="${info.id}" id="id">
            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <h4>基础问题：</h4>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">定制类型：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="mineType"
                                      class="form-control mineType" from="${mineTypeMap}" value="${info.mineType}"
                                      noSelection="['': '请选择']"/>

                        </div>

                        <label class="col-xs-2 control-label">症状：</label>
                        <div class="col-xs-3">

                            <g:select optionKey="id" optionValue="scProblemName" name="scProblemId"
                                      class="form-control envSkinType" from="${scProblemItemList}" value="${info.scProblemId}"
                                      noSelection="['': '请选择']"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">治疗方案：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="id" optionValue="scThinkingName" name="scThinkingId"
                                      class="form-control envSkinType" from="${scThinkingItemList}" value="${info.scThinkingId}"
                                      noSelection="['': '请选择']"/>
                        </div>

                        <label class="col-xs-2 control-label">肤质：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envSkinType"
                                      class="form-control envSkinType" from="${envSkinTypeMap}" value="${info.envSkinType}"
                                      noSelection="['': '请选择']"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">用户肤质推断：</label>
                        <div class="col-xs-3">
                            <input type="text" name="skinTypeInfer" value="${info.skinTypeInfer}" class="form-control" placeholder="用户肤质推断">
                        </div>
                        <label class="col-xs-2 control-label">年龄：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envAgeRegion"
                                      class="form-control envAgeRegion" from="${envAgeRegionMap}" value="${info.envAgeRegion}"
                                      noSelection="['': '请选择']"/>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label">季节：</label>

                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envSeasons"
                                      class="form-control envSeasons" from="${envSeasonsMap}" value="${info.envSeasons}"
                                      noSelection="['': '请选择']"/>

                        </div>
                        <label class="col-xs-2 control-label">区域：</label>
                        <div class="col-xs-3">
                            <g:select optionKey="key" optionValue="value" name="envArea"
                                      class="form-control envArea" from="${envAreaMap}" value="${info.envArea}"
                                      noSelection="['': '请选择']"/>

                        </div>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <div class="step_box list-group-item">
                        <h4>步骤：</h4>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤排序(数字小排前面)：</label>
                            <div class="col-sm-3">
                                <input type="text" name="stepOrder" value="${info.stepOrder}" class="form-control stepOrder" placeholder="步骤排序">
                            </div>
                            <label class="col-xs-2 control-label">步骤名：</label>
                            <div class="col-sm-3">
                                <input type="text" name="stepName" value="${info.stepName}" class="form-control stepName" placeholder="步骤名">
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤名缩写：</label>
                            <div class="col-sm-3">
                                <input type="text" name="stepShortName" value="${info.stepShortName}" class="form-control stepShortName" placeholder="步骤名缩写">
                            </div>
                            <label class="col-xs-2 control-label">步骤间隔：</label>
                            <div class="col-sm-3">
                                <input type="text" name="stepInterval" value="${info.stepInterval}" class="form-control stepInterval" placeholder="步骤间隔">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">步骤类型：</label>
                            <div class="col-sm-3">
                                <g:select optionKey="key" optionValue="value" name="stepType"
                                          class="form-control stepType" from="${stepTypeMap}" value="${info.stepType}"
                                          noSelection="['': '请选择']"/>
                            </div>
                        </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">使用条件：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardCondition"
                                              class="form-control stepUseStandardCondition" from="${stepUseStandardConditionMap}" value="${info.stepUseStandardCondition}"
                                              noSelection="['': '请选择']"/>

                                </div>
                                <label class="col-xs-2 control-label">周期：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardPeriod"
                                              class="form-control stepUseStandardPeriod" from="${stepUseStandardPeriodMap}" value="${info.stepUseStandardPeriod}"
                                              noSelection="['': '请选择']"/>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">使用规范：</label>
                                <div class="col-sm-3">
                                    <g:select optionKey="key" optionValue="value" name="stepUseStandardFrequency"
                                              class="form-control stepUseStandardFrequency" from="${stepUseStandardFrequencyMap}" value="${info.stepUseStandardFrequency}"
                                              noSelection="['': '请选择']"/>

                                </div>
                                <label class="col-xs-2 control-label">使用产品：</label>
                                <div class="col-sm-3">

                                    <g:select optionKey="id" optionValue="prodName" name="prodId"
                                              class="form-control prodId" from="${mikuMineScProductList}" value="${info.prodId}"
                                              noSelection="['': '请选择']"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-2 control-label">产品使用提示：</label>
                                <div class="col-sm-3">
                                    <input type="text" name="prodUseRemind" value="${info.prodUseRemind}" class="form-control prodUseRemind" placeholder="产品使用提示">
                                </div>
                                <label class="col-xs-2 control-label">视频：</label>
                                <div class="col-sm-3">

                                    <g:select optionKey="id" optionValue="resName" name="multimediaResourceId"
                                              class="form-control multimediaResourceId" from="${mikuMineMultimediaResList}" value="${info.multimediaResourceId}"
                                              noSelection="['': '请选择']"/>
                                </div>
                            </div>

                    </div>

                </div>

            </div>
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" id="add_btn">确定</button>
                </div>
            </div>
            <!-- /.box-footer-->
        </g:form>
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

</script>
</body>
</html>
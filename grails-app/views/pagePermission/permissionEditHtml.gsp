<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        权限编辑
        <small>权限管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>权限管理</a></li>
        <li class="active">权限编辑</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">权限展示</g:link></li>
                    <li class="active">
                        <g:link action="permissionEditHtml">权限编辑</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body no-padding form-horizontal">
        <g:form name="controllerPermission_form" useToken="true" action="editControllerPermission">

            <div class="form-group" style="display: none">
                <label class="col-xs-2 control-label"><i class="fa fa-font">权限Id</i></label>

                <div class="col-xs-8">
                    <input type="text" name="id" class="input-sm"
                           value="${controllerPermission?.id}">
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-font"></i>权限名称</label>

                <div class="col-xs-8">
                    <input type="text" name="title" class="input-sm"
                           value="${controllerPermission?.title}">
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-gamepad"></i>控制器名称</label>

                <div class="col-xs-8">
                    <input name="controllerName"
                           class="input-sm announceTime"
                           value="${controllerPermission?.controllerName}"
                           readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-tag"></i>权限操作</label>

                <div class="col-xs-8">
                    <input type="text" name="requirePermissionName" class="input-sm"
                           value="${controllerPermission?.requirePermissionName}"
                           readonly>
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-tag"></i>权限描述</label>

                <div class="col-xs-4">
                    <textarea name="description" class="form-control"
                              rows="4">${controllerPermission?.description}</textarea>
                </div>

            </div>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <div class="col-xs-offset-2">
                <button type="submit" class="btn btn-primary" type="submit">提交</button>
                <button class="btn btn-default" type="reset">取消</button>
            </div>
        </div><!-- /.box-footer-->
        </g:form>
    </div><!-- /.box -->
</section><!-- /.content -->




<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>



<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>
    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });
</script>


</body>

</html>

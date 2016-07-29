<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/23
  Time: 13:33
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
        页面管理
        <small>运营工具</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>运营工具</a></li>
        <li class="active">页面管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">页面列表</g:link></li>
                    <li class="active">
                        <g:link action="addPage">新增页面</g:link></li>
                    %{--<li>--}%
                        %{--<g:link action="pageSetting">页面配置</g:link></li>--}%
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body no-padding form-horizontal clearfix">
            <div class="container">
                <g:form class="form-horizontal" useToken="true" action="addPageDo">


                    <div class="form-group">
                        <label class="col-sm-2 control-label">页面名称：</label>

                        <div class="col-sm-5">
                            <input type="text" name="name" class="form-control">
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-2 control-label">页面说明：</label>

                        <div class="col-sm-8">

                            <textarea rows="10" name="info" class="form-control"></textarea>
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="text-center">
                            <button class="btn btn-primary" type="submit">提交</button>
                            <button class="btn btn-primary col-sm-offset-1">取消</button>
                        </div>
                    </div>

                </g:form>
            </div>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

        </div><!-- /.box-footer-->
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

<script language="javascript"
        src="http://webapi.amap.com/maps?v=1.3&key=${grailsApplication.config.amap.js_key}"></script>



<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>

</script>
</body>

</html>
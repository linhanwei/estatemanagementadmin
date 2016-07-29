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
        活动新增
        <small>活动管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>活动管理</a></li>
        <li class="active">活动新增</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">活动列表</g:link></li>
                    <li class="active">
                        <g:link action="addActivityHtml">新增活动</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="activity_form" useToken="true" action="addActivity">
        <div class="box-header">
        </div>

        <div class="box-body no-padding form-horizontal">

            <div class="form-group">
                <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-picture-o"></i>商品ID</label>

                <div class="col-xs-12 col-sm-6">
                    <input type="text" name="itemId" class="form-control"
                           placeholder="商品ID">
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-calendar"></i>开始时间</label>

                <div class="col-xs-12 col-sm-6">
                    <input value="${params.startTime}"
                           name="startTime"
                           class="form-control form_datetime"

                           readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-calendar"></i>结束时间</label>

                <div class="col-xs-12 col-sm-6">
                    <input value="${params.endTime}"
                           name="endTime"
                           class="form-control form_datetime"

                           readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-tag"></i>限购数量</label>

                <div class="col-xs-12 col-sm-6">
                    <input type="text" name="limitNum" class="form-control"
                           placeholder="限购数量">
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-dollar"></i>活动价</label>

                <div class="col-xs-12 col-sm-6">
                    <input type="text" name="activityPrice" class="form-control"
                           placeholder="活动价">
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-chain"></i>BannerID</label>

                <div class="col-xs-12 col-sm-6">
                    <input type="text" name="bannerId" class="form-control"
                           placeholder="bannerId">
                </div>
            </div>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <div class="col-sm-offset-3">
                <button type="submit" class="btn btn-primary" type="submit">发布</button>

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

    $("#decrease").click(function () {
        var now = $("#num").val();
        now = now * 1 - 1
        if (now > 0) {
            $("#num").val(now);
        }
    });
    $("#insert").click(function () {
        var now = $("#num").val();
        now = now * 1 + 1
        if (now > 0) {
            $("#num").val(now);
        }
    });

</script>


</body>

</html>

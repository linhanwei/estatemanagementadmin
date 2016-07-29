<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2015/11/3
  Time: 21:58
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
        分润等级列表
        <small>分润管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>分润等级列表</a></li>
        <li class="active">新增分润等级</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">分润等级列表</g:link></li>
                    <li>
                        <g:link action="addProfitLevel">新增分润等级</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>分润等级</th>
                    <th style="width: 80px"></i>分润比例</th>
                    <th style="width: 60px"><i class="fa fa-picture-o"></i>创建者</th>
                    <th style="width: 60px"><i class="fa  fa-sort-numeric-asc"></i>权重</th>
                    <th style="width: 60px"><i class="fa  fa-cog"></i>创建日期</th>
                    <th style="width: 60px"><i class="fa  fa-cog"></i>等级说明</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${mlist}" var="ml">
                            <tr id="${ml?.id}" class="info">
                                <td>${ml?.levelName}</td>
                                <td>${ml?.defaultShareScale}</td>
                                <td>${ml?.creatorName}</td>
                                <td style="width: 60px">
                                    ${ml?.weight}
                                </td>
                                <td>${ml?.dateCreated}</td>
                                <td>${ml?.memo}</td>
                                <td>
                                    <button type="button" class="btn btn-success btn-sm"
                                            onclick="window.location.replace('/profitManager/edit?id=${ml?.id}')">
                                        编辑
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="window.location.replace('/profitManager/deleteOneLevel?id=${ml?.id}')">
                                        删除
                                    </button>
                                </td>
                            </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="index" total="${total}"/>
                </div>
            </g:if>
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

    function modifyweight(id) {
        $("input").each(function change() {
            if (id == this.name) {
                var newWeight = this.value
                $.ajax({
                    url: '/Tags/modifyweight',
                    data: {'id': id, 'newWeight': newWeight},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        $.sticky("修改成功", {autoclose: 2000, position: "top-center", type: "st-success"});
                        window.location.reload()
                    },
                    error: function (data) {
                        $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                    }
                });
            }
        });
    }

    function deleteTag(id) {

        if (!confirm("您真的要删除这个标签么？")) {
            return;
        }
        $.ajax({
            url: '/Tags/deleteTag',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#" + id).remove()
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    function showTag(id) {

        if (!confirm("您真的要展示这个标签么？")) {
            return;
        }

        $.ajax({
            url: '/Tags/showTag',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                window.location.reload()
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    function hideTag(id) {

        if (!confirm("您真的要隐藏这个标签么？")) {
            return;
        }

        $.ajax({
            url: '/Tags/hideTag',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                window.location.reload()

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }



</script>


</body>

</html>

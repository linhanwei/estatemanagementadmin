<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2015/11/11
  Time: 16:48
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
</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        代理关系名称
        <small>分润管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>分润管理</a></li>
        <li class="active">代理关系</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">代理关系名称列表</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>ID</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>权重</th>
                    <th style="width: 150px"></i>代理名称</th>
                </tr>
                <g:if test="${list.size() > 0}">
                    <g:each status="i" in="${list}" var="ml">
                        <tr id="${ml?.id}" class="info">
                            <td>${ml?.id}</td>
                            <td>${ml?.weight}</td>
                            <td>
                                <input onchange="midifyName('${ml?.id}')" type="text"
                                       value="${ml?.levelName}" class="no-border" id="md${ml?.id}"
                                       style="width:400px;background:transparent;">
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
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




<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>
    function midifyName(id){
        var content=$("#md"+id).val();
            $.ajax({
                url: '/mikuAgencyLevel/changeName',
                data: {'id': id, 'content': content},
                type: "POST",
                dataType: "json",
                success: function (data) {
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
    }
</script>

</body>

</html>
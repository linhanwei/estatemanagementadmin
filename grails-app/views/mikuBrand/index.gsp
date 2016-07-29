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
        品牌列表
        <small>品牌管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>品牌管理</a></li>
        <li class="active">品牌列表</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">品牌列表</g:link></li>
                    <li>
                        <g:link action="addOneBrand">新增品牌</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <div class='col-xs-12'>
                <div style="margin-top: 10px"></div>
                <g:form name="stockGoodsForm" class="form-inline" action="index">
                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">品牌名称：</label>
                        <input  name="ppname" class="form-control"
                                value="${params.ppname}"
                                placeholder="品牌名称"/>
                    </div>
                    <div class="col-sm-6 col-md-4 form-group">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询</button>
                    </div>
                </g:form>
            </div>
        </div>
        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>品牌名称</th>
                    <th style="width: 150px"></i>品牌全称</th>
                    <th style="width: 60px"><i class="fa fa-picture-o"></i>所属公司</th>
                    <th style="width: 60px"><i class="fa  fa-cog"></i>创建时间</th>
                    <th style="width: 120px"><i class="fa  fa-cog"></i>品牌图片</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${mlist}" var="ml">
                        <tr id="${ml?.id}" class="info">
                            <td>${ml?.name}
                                <div style="padding-top: 10px">
                                    ${ml?.id}
                                </div>
                            </td>
                            <td>${ml?.fullName}</td>
                            <td>${ml?.company}</td>
                            <td>${ml?.dateCreated}</td>
                            <td><img src="${ml?.picture}" style="width: 90px;height: 47px"></td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location.replace('/mikuBrand/edit?id=${ml?.id}')">
                                    编辑
                                </button>
                                <button type="button" class="btn btn-danger btn-sm"
                                        onclick="window.location.replace('/mikuBrand/delete?id=${ml?.id}')">
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




<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>


</body>

</html>
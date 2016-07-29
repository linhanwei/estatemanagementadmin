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
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <link rel="stylesheet" href="http://cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css"/>




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
        商品排序
        <small>商品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>商品管理</a></li>
        <li class="active">商品排序</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">

                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <div style="margin-top: 10px"></div>

            <div class="col-sm-2">
                <g:select optionKey="id" optionValue="name" name="category" value="${selected}"
                          class="form-control" from="${categoryList}"/>
            </div>

            <div class="col-sm-3 pull-right">
                <button type="button" class="btn btn-primary" onclick="saveCategoryItemRank()"><i
                        class="fa fa-save"></i> 保存排序</button>
            </div>
        </div>

        <div class="box-body no-padding form-horizontal">
            <table class="table table-hover table-responsive" id="table">
                <tr>
                    <th>水果类目</th>
                    <th width="20%">名称</th>
                    <th>销量</th>
                    <th>市场价</th>
                    <th>销售价</th>
                    <th>限量</th>
                    <th>上架时间</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${itemList}" var="item">
                        <tr id="${item.id}">
                            <td>${categoryMap.get(item.categoryId)?.name}</td>
                            <td>${item.title}</td>
                            <td>${item.soldQuantity}</td>
                            <td>${(JSON.parseObject(item?.features)?.getLongValue('referencePrice') ?: 0) / 100f}</td>
                            <td>${(item.price ?: 0) / 100f}</td>
                            <td>${item.num}</td>
                            <td>${new DateTime(item.onlineStartTime).toString("yyyy-MM-dd HH:mm")}</td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->




<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- tablednd -->
<asset:javascript src="jquery.tablednd.js"/>
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



<script src="http://cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script type="text/javascript">

    $("#category").change(function (e) {
        var valueSelected = this.value;
        window.location.replace("${createLink(action: 'orderingRule')}" + "?category_id=" + valueSelected)
    });

    $(document).ready(function () {
        $("#table").tableDnD();
    });

    function saveCategoryItemRank(id) {
        var arr = [];
        $("#table tbody tr").each(function (index, tr) {
            var $tr = $(tr);
            if ($tr.prop('id')) {
                arr.push($tr.prop('id'));
            }
        });

        var data = {ids: arr, categoryId: ${selected}}

        $.ajax({
            url: '${createLink(action: 'saveCategoryItemRank')}',
            data: data,
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
</script>


</body>

</html>

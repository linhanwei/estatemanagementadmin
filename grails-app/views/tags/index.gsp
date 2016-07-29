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
        已有标签
        <small>标签管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>标签管理</a></li>
        <li class="active">标签新增</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">标签列表</g:link></li>
                    <li>
                        <g:link action="addTagsHtml">新增标签</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form class="form-horizontal" action="index">
                <label class="col-sm-2 control-label">标题查询</label>

                <div class="col-sm-3">
                    <input placeholder="标签名称" name="query" class="form-control" value="${params.query}">
                </div>

                <div class="col-sm-3">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询
                    </button>
                </div>
            </g:form>
        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>标题</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>图片</th>
                    <th style="width: 60px"><i class="fa  fa-sort-numeric-asc"></i>权重</th>
                    <th style="width: 60px"><i class="fa  fa-cog"></i>作用</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${tagList}" var="tag">
                        <g:if test="${tag?.status == 2 as byte}">
                            <tr id="${tag?.id}" class="info">
                                <td>${tag?.name}</td>
                                <td><img src="${tag?.pic}" style="width: 90px;height: 47px"></td>
                                <td style="width: 60px">
                                    <input onchange="modifyweight('${tag?.id}')" type="text"
                                           value="${tag?.weight}" name="${tag?.id}" class="no-border"
                                           style="width:30px;background:transparent;" disabled="disabled">
                                </td>
                                <td>${typeMap.get(tag?.type)}</td>

                                <td>
                                    <button type="button" class="btn btn-info btn-sm"
                                            onclick="hideTag(${tag?.id})">
                                        隐藏
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="deleteTag(${tag?.id})">
                                        删除
                                    </button>
                                    <button type="button" class="btn  btn-sm"
                                            onclick="editTag(${tag?.id})">
                                        编辑
                                    </button>
                                </td>
                            </tr>
                        </g:if>
                        <g:if test="${tag?.status == 1 as byte}">
                            <tr id="${tag?.id}" class="info">
                                <td>${tag?.name}</td>
                                <td><img src="${tag?.pic}" style="width: 90px;height: 47px"></td>
                                <td style="width: 60px">
                                    <input onchange="modifyweight('${tag?.id}')" type="text"
                                           value="${tag?.weight}" name="${tag?.id}" class="no-border"
                                           style="width:30px;background:transparent;" disabled="disabled">
                                </td>
                                <td>${typeMap.get(tag?.type)}</td>

                                <td>
                                    <button type="button" class="btn btn-success btn-sm"
                                            onclick="showTag(${tag?.id})">
                                        显示
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="deleteTag(${tag?.id})">
                                        删除
                                    </button>
                                    <button type="button" class="btn btn-sm"
                                            onclick="editTag(${tag?.id})">
                                        编辑
                                    </button>

                                </td>
                            </tr>
                        </g:if>
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



    function editTag(id){
//        window.location.reload('/tags/edit?id='+id);
        window.location.replace('/tags/edit?id='+id);
    }



</script>


</body>

</html>

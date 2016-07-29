<%@ page import="org.joda.time.DateTime" %>
<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 8/9/14
  Time: 18:17
--%>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <title>当前团购</title>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- Ionicons -->
    <asset:stylesheet src="ionicons.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header"></section>
<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="index">当前团购</g:link></li>
                    <li><g:link action="last">往期团购</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                <div style="margin-top: 10px"></div>
                                <g:form class="form-horizontal" action="index">
                                    <label class="col-sm-1 control-label">大类</label>

                                    <div class="col-sm-2">
                                        <g:select optionKey="id" optionValue="name" name="level1Category"
                                                  class="form-control" from="${categoryList}" value="${parentId}"
                                                  noSelection="['-1': '请选择大类...']"/>
                                    </div>

                                    <label class="col-sm-1 control-label">类目</label>

                                    <div class="col-sm-2">
                                        <select id="category" class="form-control" name="category">
                                            <option value="-1">请选择类目...</option>
                                        </select>
                                    </div>

                                    <div class="col-sm-3">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询
                                        </button>
                                    </div>
                                </g:form>
                            </div>

                            <div class="box-body table-responsive">
                                <table class="table table-condensed" id="table">
                                    <tr>
                                        <th>一级类目</th>
                                        <th>二级类目</th>
                                        <th width="20%">商品名称</th>
                                        <th>市场价</th>
                                        <th>团购价</th>
                                        <th>限量</th>
                                        <th>团购周期</th>
                                        <th>状态</th>
                                        <th>操作</th>
                                    </tr>
                                    <g:if test="${total > 0}">
                                        <g:each status="i" in="${grouponList}" var="groupon">
                                            <tr id="${groupon.id}">
                                                <td>${categoryMap.get(categoryMap.get(groupon.itemCategoryId)?.parentId)?.name}</td>
                                                <td>${categoryMap.get(groupon.itemCategoryId)?.name}</td>
                                                <td>${groupon.itemTitle}</td>
                                                <td>${groupon.referencePrice / 100f}</td>
                                                <td>${groupon.grouponPrice / 100f}</td>
                                                <td>${groupon.quantity ?: 0}</td>
                                                <td>${new DateTime(groupon.onlineStartTime).toString("yyyy-MM-dd HH:mm")} 至 ${new DateTime(groupon.onlineEndTime).toString("yyyy-MM-dd HH:mm")}</td>
                                                <td>${groupon.status == 1 ? '进行中' : "未开始"}</td>
                                                <td>
                                                    <button class="btn-sm btn-primary btn-sm"
                                                            onclick="lookItemDetail('${groupon?.itemId}');
                                                            return false;"
                                                            data-toggle="modal"
                                                            data-target="#itemDetailModel"><i
                                                            class="fa fa-info-circle"></i>详情</button>
                                                    <button type="button" class="btn btn-primary btn-sm"
                                                            onclick="makeInStock(${groupon?.itemId}, ${groupon?.id})">下架</button>
                                                <td>
                                            </tr>
                                        </g:each>
                                    </g:if>
                                </table>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                    </div><!-- /.box -->
                    <div class="box-footer clearfix">
                        <g:if test="${total > 0}">
                            <div class="pagination pull-right">
                                <g:paginate next="下一页" prev="上一页" params="${params}"
                                            maxsteps="10" action="index" total="${total}"/>
                            </div>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->

<div class="modal fade bs-example-modal-lg" id="itemDetailModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="itemId">产品ID号：</h2>
            </div>

            <div class="modal-body">
                <div id="itemDetail">
                    <g:render template="itemDetail"/>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="AdminLTE/app.js"/>
<!-- sticky -->
<asset:javascript src="plugins/sticky/sticky.js"/>

<script>
    function lookItemDetail(id) {
        $("#itemId").text('产品ID号:' + id)
        <g:remoteFunction update="itemDetail" action="lookItemDetail" options="'[asynchronous: false]'"  params="'id='+id"/>
    }

    $('#level1Category').change(function () {
        var str = "";
        $("#level1Category option:selected").each(function () {
            $('#category').find('option').remove();
            $('#category').append('<option value="-1">请选择类目...</option>');
            var id = $(this).val()
            if (id != "-1" && id != '' && id != undefined) {
                $.ajax({
                    url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId"/>', // remote datasource
                    data: {'id': id},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, m) {
                            $('#category').append('<option value="' + m.id + '">' + m.name + '</option>');
                        })

                    }, error: function (data) { // handle server errors

                    }
                });
            }
        });
    }).trigger('change');

    function makeInStock(itemId, id) {

        if (!confirm("您真的要下架这个商品么？")) {
            return;
        }

        $.ajax({
            url: '/item/makeInStock',
            data: {'id': itemId},
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
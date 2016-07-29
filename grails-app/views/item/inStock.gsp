<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference" %>
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
    <title>商品管理</title>
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
                    <li><g:link action="onSale">上架商品</g:link></li>
                    <li class="active"><g:link action="inStock">仓库商品</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box ">
                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-hover">
                                        <tr>
                                            <th>类目</th>
                                            <th>产地</th>
                                            <th width="30%">名称</th>
                                            <th>重量</th>
                                            <th>采购价</th>
                                            <th>参考价</th>
                                            <th>更新时间</th>
                                            <th>操作</th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${itemLists}" var="item">
                                                <tr id="${item.id}">
                                                    <td>${categoryMap.get(item.categoryId)}</td>
                                                    <td>${item.address}</td>
                                                    <td>${item.title}</td>
                                                    <td>${item.itemWeight}</td>
                                                    <td>${(JSON.parseObject(item.features, new TypeReference<Map<String, Long>>() {
                                                    })?.get('purchasingPrice') ?: 0) / 100f}</td>
                                                    <td>${(JSON.parseObject(item.features, new TypeReference<Map<String, Long>>() {
                                                    })?.get('referencePrice') ?: 0) / 100f}</td>
                                                    <td>${item.lastUpdated}</td>
                                                    <td>
                                                        <button type="button" class="btn btn-sm btn-primary"
                                                                data-toggle="modal" data-target="#myModal"
                                                                onclick="makeOnSale(${item.id})">
                                                            上架
                                                        </button>
                                                        <button class="btn btn-sm btn-primary"
                                                                onclick="makeEdit(${item.id})">编辑</button>
                                                        <button class="btn btn-sm btn-default"
                                                                onclick="makeDelete(${item.id})">删除</button>
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
                                                maxsteps="10" action="queryItemInStock" total="${total}"/>
                                </div>
                            </g:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">商品上架</h4>
            </div>
            <g:form useToken="true" action="makeOnSale">

                <input id="readyOnSaleItemId" name="itemId" style="display: none;">

                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group form-inline">
                            <label class="col-sm-2 control-label">上架时间</label>

                            <div class="col-sm-4">
                                <input id="onlineStartTime" name="onlineStartTime" class="form-control">
                            </div>

                            <label class="col-sm-2 control-label">下架时间</label>

                            <div class="col-sm-4">
                                <input id="onlineEndTime" name="onlineEndTime" class="form-control">
                            </div>
                        </div>

                        <div class="form-group form-inline">
                            <label class="col-sm-2 control-label">本期库存</label>

                            <div class="col-sm-4">
                                <input id="num" name="num" class="form-control">
                            </div>

                            <label class="col-sm-2 control-label">销售价格</label>

                            <div class="col-sm-4">
                                <input id="price" name="price" class="form-control">
                            </div>
                        </div>

                        <div class="form-group form-inline">
                            <label class="col-sm-2 control-label">适用小区</label>

                            <div class="col-sm-4">
                                <select name="level" class="form-control">
                                    <option value="1">低端小区</option>
                                    <option value="2">中端小区</option>
                                    <option value="3">高端小区</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
            </g:form>
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
<!-- InputMask -->
<asset:javascript src="plugins/input-mask/jquery.inputmask.js"/>
<asset:javascript src="plugins/input-mask/jquery.inputmask.date.extensions.js"/>
<asset:javascript src="plugins/input-mask/jquery.inputmask.extensions.js"/>

<script>

    $("#onlineStartTime").inputmask("datetime");
    $("#onlineEndTime").inputmask("datetime");

    function makeEdit(id) {
        alert("还在建设中")
    }

    function makeDelete(id) {
        if (!confirm("您确定要删除这个商品么，执行删除操作后不可恢复")) {
            return;
        }

        $.ajax({
            url: '/item/makeDelete',
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

    function makeOnSale(id) {
        $("#readyOnSaleItemId").val(id)
    }
</script>
</body>
</html>
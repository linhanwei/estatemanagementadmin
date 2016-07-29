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
    <asset:stylesheet src="bootstrap.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>

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
        仓库商品
        <small>站点管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>站点管理</a></li>
        <li class="active">在售商品</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">

    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form class="form-horizontal" action="communityItemInstock">
                <label class="col-sm-1 control-label">大类:</label>

                <div class="col-sm-2">
                    <g:select optionKey="id" optionValue="name" name="level1Category"
                              class="form-control" from="${categoryList}" value="${params.level1Category}"
                              noSelection="['-1': '请选择大类...']"/>
                </div>

                <label class="col-sm-1 control-label">类目:</label>

                <div class="col-sm-2">
                    <select id="category" class="form-control" name="category">
                        <option value="-1">请选择类目...</option>
                    </select>
                </div>

                <label class="col-sm-1 control-label">站点:</label>

                <div class="col-sm-2">
                    <g:select optionKey="id" optionValue="name" name="communityId"
                              value="${params.communityId}"
                              class="form-control" from="${communityList}"
                              noSelection="['': '服务站点：']"/>
                </div>

                <label class="col-sm-1 control-label">商品名称:</label>
                <div class="col-sm-2">
                    <input name="query" class="form-control" value="${params.query}">
                </div>

                <label class="col-sm-1 control-label" style="margin-top: 10px">品牌:</label>
                <div class="col-sm-2" style="margin-top: 10px">
                    <g:select optionKey="id" optionValue="name" name="brandId"
                              class="form-control" from="${mikuBrandList}"    value="${params.brandId}"
                              noSelection="['': '请选择品牌']"/>
                </div>

                <div class="col-sm-2  pull-right"  style="margin-top: 10px">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 查询</button>
                </div>
            </g:form>
        </div>

        <div class="box-body table-responsive">
            <table class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th width="15%">标签</th>
                    <th>下架时间</th>
                    <th>名称</th>
                    <th>品牌</th>
                    <th>商品编码</th>
                    <th>规格</th>
                    <th>市场价</th>
                    <th>历史参考价</th>
                    <th>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${itemList}" var="item">
                        <tr id="${item.id}" class="info">
                            <td>
                                <div>
                                    <g:if test="${itemTagMap.get(item?.id) != null}">
                                        <g:each status="j" in="${itemTagMap.get(item?.id)}" var="tag">
                                            <small class="label pull-left bg-blue">${tag?.name}
                                            <g:if test="${tag.bit == 1L}">
                                                ${JSON.parseObject(xlTagMap.get(item?.id))?.get('xgLimitNum') ?: '无'}
                                            </g:if>
                                            </small>
                                        </g:each>
                                    </g:if>
                                </div>
                            </td>
                            <td>${new DateTime(item.lastUpdated).toString("yyyy-MM-dd HH:mm")}</td>
                            <td>${item?.title}
                                <div style="padding-top: 10px">
                                    ${item?.id}
                                </div>
                            </td>
                            <td>${item?.props}</td>
                            <td>${item?.code}</td>
                            <td>${item?.specification}</td>
                            <td>${(JSON.parseObject(item.features)?.getLongValue('referencePrice') ?: 0) / 100f}</td>
                            <td>${(item.price ?: 0) / 100f}</td>


                            <td>
                                <button class="btn-sm btn-primary btn-sm"
                                        onclick="lookItemDetail('${item.id}');
                                        return false;"
                                        data-toggle="modal"
                                        data-target="#itemDetailModel"><i class="fa fa-info-circle"></i>详情</button>
                                <button type="button" class="btn btn-success btn-sm" data-toggle="modal"
                                        data-target="#myModal2" onclick="makeItOnSale('${item.id}')">
                                    上架
                                </button>
                                <button type="button" class="btn btn-warning btn-sm"
                                        onclick="updateItemTag('${item?.id}')"
                                        data-toggle="modal"
                                        data-target="#tagEditModel">
                                    橱窗打标
                                </button>
                            <td>
                        </tr>

                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="communityItemInstock" total="${total}"/>
                </div>
            </g:if>
        </div><!-- /.box-footer-->
    </div><!-- /.box -->
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

<div class="modal fade bs-example-modal-lg" id="tagEditModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="itemId2">产品ID号：</h2>
            </div>

            <div class="modal-body">
                <div id="tagEdit">
                    <g:render template="itemTagEdit"/>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel2">商品上架</h4>
            </div>
            <g:form useToken="true" action="makeOnSale" params="${params}">
                <input id="readyOnSaleItemId" name="itemId" style="display: none;">

                <div class="modal-body">
                    <div class="form-horizontal">

                        <div id="itemDetail2">
                            <g:render template="itemDetail"/>
                        </div>

                        %{--<div class="form-group form-inline">--}%
                            %{--<label class="col-sm-2 control-label">本期限量</label>--}%

                            %{--<div class="col-sm-4">--}%
                                %{--<input name="num" class="form-control">--}%
                            %{--</div>--}%

                            %{--<label class="col-sm-2 control-label">规格</label>--}%

                            %{--<div class="col-sm-4">--}%
                                %{--<input name="specification" class="form-control">--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        %{--<div class="form-group form-inline">--}%
                            %{--<label class="col-sm-2 control-label">销售价格</label>--}%

                            %{--<div class="col-sm-4">--}%
                                %{--<input name="price" class="form-control">--}%
                            %{--</div>--}%

                            %{--<label class="col-sm-2 control-label">产地</label>--}%

                            %{--<div class="col-sm-4">--}%
                                %{--<input name="address" class="form-control">--}%
                            %{--</div>--}%
                        %{--</div>--}%


                        <div class="form-group form-inline">
                        <label class="col-sm-2 control-label">本期限量</label>

                        <div class="col-sm-4">
                        <input name="num" class="form-control">
                        </div>

                        <label class="col-sm-2 control-label">销售价格</label>

                        <div class="col-sm-4">
                        <input name="price" class="form-control">
                        </div>
                    </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">提交</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </g:form>
        </div>
    </div>
</div>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>

<script>
    function updateItemTag(id) {
        $("#itemId2").text('产品ID号:' + id)
        <g:remoteFunction  update="tagEdit" action="updateItemTag" options="'[asynchronous: false]'"  params="{'id':id,'communityId':${params?.communityId?:null},'query':${params?.query? "\'"+params.query+"\'":null}, 'category': ${params?.category?:null}, 'level1Category': ${params?.level1Category?:null}}" />
    }


    function makeItOnSale(id) {
        $('#readyOnSaleItemId').val(id)
        <g:remoteFunction update="itemDetail2" action="lookItemDetail" options="'[asynchronous: false]'"  params="'id='+id"/>

    }


    function lookItemDetail(id) {
        $("#itemId").text('产品ID号:' + id)
        <g:remoteFunction update="itemDetail" action="lookItemDetail" options="'[asynchronous: false]'"  params="'id='+id"/>

    }

    var num = 0

    $(function () {
        $('#level1Category').change(function () {
            num = num + 1
            var str = "";
            $("#level1Category option:selected").each(function () {
                $('#category').find('option').remove();
                $('#category').append('<option value="-1">请选择类目...</option>');
                var id = $(this).val()
                if (id != "-1" && id != '' && id != undefined && num < 2) {
                    $.ajax({
                        url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" params="${params}"/>', // remote datasource
                        data: {'id': id},
                        type: "POST",
                        dataType: "json",
                        success: function (data) {
                            $('#category').find('option').remove();
                            $.each(data, function (index, m) {
                                $('#category').append('<option value="' + m.id + '">' + m.name + '</option>');
                            })

                        }, error: function (data) { // handle server errors
                        }
                    });
                } else {
                    $.ajax({
                        url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" />', // remote datasource
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
    })
</script>

</body>

</html>
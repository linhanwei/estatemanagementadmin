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
    <!-- select2 -->
    <asset:stylesheet src="select2/select2.min.css"/>
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
<section class="content-header">
    <h1>
        在售商品
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

            <div style="margin-top: 10px"></div>
            <g:form name="shopGoodsForm" class="form-inline" action="index">
                %{--<label class="col-sm-1 control-label">大类</label>--}%

                %{--<div class="col-sm-2">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="level1Category"--}%
                              %{--class="form-control" from="${categoryList}" value="${params.level1Category}"--}%
                              %{--noSelection="['-1': '请选择大类...']"/>--}%
                %{--</div>--}%

                %{--<label class="col-sm-1 control-label">类目</label>--}%

                %{--<div class="col-sm-2">--}%
                    %{--<select id="category" class="form-control" name="category" >--}%
                        %{--<option value="${params?.category ?: '-1'}">${categoryMap.get(params.long('category')) ?: '请选择子类目'}</option>--}%
                    %{--</select>--}%
                %{--</div>--}%



                %{--<label class="col-sm-1 control-label">站点</label>--}%

                %{--<div class="col-sm-2">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="communityId"--}%
                              %{--value="${params.communityId}"--}%
                              %{--class="form-control" from="${communityList}"--}%
                              %{--noSelection="['': '服务站点：']"/>--}%
                %{--</div>--}%

                 <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label">一级类目：</label>

                     <g:select optionKey="id" optionValue="name" name="level1Category"
                               class="form-control" from="${categoryList}" value="${params.level1Category}"
                               noSelection="['-1': '一级类目']"/>
                 </div>

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label">二级类目：</label>

                    <select id="category" class="form-control" name="category"  bsfalg="${params.category}">
                <option value="${params?.category ?: '-1'}">${categoryMap.get(params.long('category')) ?: '二级类目'}</option>
                </select>
                </div>

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label">三级类目：</label>

                    <select id="threelevel" class="form-control" name="threelevel" bsfalg="${params.threelevel}">
                    </select>

                </div>

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label">商品名称：</label>
                    <input name="query" class="form-control" value="${params.query}">
                </div>

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label">品牌：</label>
                    <g:select optionKey="id" optionValue="name" name="brandId" id="sel_menu"
                              class="form-control" from="${mikuBrandList}"    value="${params.brandId}"
                              noSelection="['': '请选择品牌']"/>
                </div>

                %{--<label class="col-sm-1 control-label">商品名称</label>--}%
                %{--<div class="col-sm-2">--}%
                    %{--<input name="query" class="form-control" value="${params.query}">--}%
                %{--</div>--}%


                 %{--<label class="col-sm-1 control-label"  style="margin-top: 10px">品牌</label>--}%
                %{--<div class="col-sm-2">--}%
                    %{--<input name="query" class="form-control" value="${params.query}">--}%
                %{--</div>--}%

                %{--<div class="col-sm-2"  style="margin-top: 10px">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="brandId"--}%
                              %{--class="form-control" from="${mikuBrandList}"    value="${params.brandId}"--}%
                              %{--noSelection="['': '请选择品牌']"/>--}%
                %{--</div>--}%

                %{--<label class="col-sm-1 control-label" style="margin-top: 10px">标签</label>--}%
                %{--<div class="col-sm-2" style="margin-top: 10px">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="tagId"--}%
                              %{--class="form-control" from="${tagsList}"    value="${params.tagId}"--}%
                              %{--noSelection="['': '请选择标签']"/>--}%
                %{--</div>--}%


                %{--<label class="col-sm-1 control-label" style="margin-top: 10px">查询页码</label>--}%
                %{--<div class="col-sm-2" style="margin-top: 10px">--}%
                    %{--<g:select optionKey="key" optionValue="value" name="max"--}%
                              %{--class="form-control" from="${PageMap}" value="${params.max}"--}%
                              %{--noSelection="['10': '请选择页码']"/>--}%
                %{--</div>--}%

                %{--<div class="col-sm-2  pull-right" style="margin-top: 10px">--}%
                    %{--<button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 查询</button>--}%

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label" style="margin-top: 10px">标签：</label>
                    <g:select optionKey="id" optionValue="name" name="tagId"
                              class="form-control" from="${tagsList}"    value="${params.tagId}"
                              noSelection="['': '请选择标签']"/>
                </div>


                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label" style="margin-top: 10px">商品编码：</label>
                    <input  name="itemcode" class="form-control"
                            value="${params.itemcode}"
                            placeholder="商品编码"/>
                </div>

                <span class="hide" id="fieldName">${params.fieldName}</span>
                <span class="hide" id="fieldstate">${params.fieldstate}</span>

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label" style="margin-top: 10px">查询页码：</label>
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '请选择页码']"/>

                </div>

                <div class="col-sm-6 col-md-4 form-group">
                    <label class="control-label" style="margin-top: 10px">商品ID：</label>
                    <input  name="itemId" class="form-control"
                            value="${params.itemId}"
                            placeholder="商品编码"/>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 查询</button>
                </div>

            </g:form>
        </div>

        <div class="box-body table-responsive">
        <g:form action="downOnesItems" params="${params}" name="downOnesItemsForm">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th width="15%">标签</th>
                    %{--<th>上架时间</th>--}%
                    <th>一级</th>
                    <th>二级</th>
                    <th>三级</th>
                    <th>名称</th>
                    <th style="position: relative">商品编码&nbsp;&nbsp;&nbsp;&nbsp;
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('code-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('code-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th>品牌</th>
                    %{--<th>规格</th>--}%
                    %{--<th>市场价</th>--}%
                    <th style="position: relative">销售价&nbsp;&nbsp;&nbsp;&nbsp;
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('price-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right: 0;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom"  onclick="paixu('price-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th style="position: relative">库存&nbsp;&nbsp;&nbsp;&nbsp;
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('num-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right: 0;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('num-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th>销售基数</th>
                    <th style="position: relative">权重&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-triangle-top" onclick="paixu('weight-asc')" aria-hidden="true" style="
                    position: absolute;
                    top: 3px;
                    right: 0;
                    cursor: pointer;
                    "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('weight-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span></th>
                    <th style="position: relative">销售数量&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-triangle-top" onclick="paixu('soldQuantity-asc')" aria-hidden="true" style="
                    position: absolute;
                    top: 3px;
                    right: 0;
                    cursor: pointer;
                    "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('soldQuantity-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span></th>
                    <th>可退货</th>
                    <th>操作</th>
                    <th>
                        <label>
                            <input type="checkbox" id="checkAll">
                        </label>
                    </th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${itemList}" var="item">
                        <tr id="${item.id}" class="info">
                            <th>
                                <div>
                                    <g:if test="${itemTagMap.get(item?.id) != null}">
                                        <g:each status="j" in="${itemTagMap.get(item?.id)}" var="tag">
                                            <small class="label pull-left bg-blue" style="white-space: normal;">${tag?.name}
                                            <g:if test="${tag.bit == 1L}">
                                                ${JSON.parseObject(xlTagMap.get(item?.id))?.get('xgLimitNum') ?: '无'}
                                            </g:if>
                                            <g:if test="${tag?.name=='抢购标'}">
                                                ${xgbTagMap.get(item?.id)}
                                            </g:if>
                                            </small>
                                        </g:each>
                                    </g:if>
                                </div>
                            </th>
                            %{--<th>${new DateTime(item.onlineStartTime).toString("yyyy-MM-dd HH:mm")}</th>--}%
                            <td>${categoryMap.get(item?.category1_id)?.name}</td>
                            <td>${categoryMap.get(item?.category2_id)?.name}</td>
                            <td>${categoryMap.get(item.categoryId)?.name}</td>
                            <th><input onchange="modixsTitle('${item?.id}')" type="text"
                                       value="${item?.title}" name="${item?.id}" class="no-border" id="title${item?.id}"
                                       style="background:transparent;width: 80%;margin: auto">
                                <div style="padding-top: 10px">
                                    ${item?.id}
                                </div>
                            </th>
                            <th>${item?.code}</th>
                            <th>${item?.props}</th>
                            %{--<th>${item?.specification}</th>--}%
                            %{--<th>${(JSON.parseObject(item.features)?.getLongValue('referencePrice') ?: 0) / 100f}</th>--}%
                            <th>${(item?.price ?: 0) / 100f}</th>
                            <th>
                                <input onchange="modixsNum('${item?.id}')" type="text"
                                       value="${item?.num}" name="${item?.id}" class="no-border" id="num${item?.id}"
                                       style="width:30px;background:transparent;">
                                </th>
                            <th>
                                <input onchange="modixsQuantity('${item?.id}')" type="text"
                                       value="${item?.baseSoldQuantity}" name="${item?.id}" class="no-border" id="qu${item?.id}"
                                       style="width:30px;background:transparent;">
                            </th>
                            <th> <input onchange="modifyweight('${item?.id}')" type="text"
                                        value="${item?.weight}" name="${item?.id}" class="no-border"  id="wi${item?.id}"
                                        style="width:30px;background:transparent;"></th>
                            <th>
                                ${item?.soldQuantity?item?.soldQuantity:0}
                            </th>
                            <th>
                                <g:if test="${item?.isrefund==1L}">
                                    是
                                </g:if>
                                <g:else>
                                    否
                                </g:else>
                            </th>
                            <th>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.open('http://miku.unesmall.com/api/h/1.0/detailPage.htm?gid='+${item.id},'_blank','width=600,height=1000,menubar=no,toolbar=no, status=no,scrollbars=yes')">
                                    预览
                                </button>
                                <button class="btn-sm btn-info btn-sm"
                                        onclick="lookItemDetail('${item.id}');
                                        return false;"
                                        data-toggle="modal"
                                        data-target="#itemDetailModel"><i class="fa fa-info-circle"></i>详情</button>
                                <button type="button" class="btn btn-warning btn-sm"
                                        onclick="makeInStock(${item.id})">下架</button>
                            </th>
                            <th>
                                <input type="checkbox" name="itemShipBox"
                                       value="${item?.id}">
                            </th>
                        </tr>
                    </g:each>
                </g:if>
            </table>
         </g:form>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                                maxsteps="10" action="index" total="${total}"/>
                </div>
            </g:if>

            <div class="row">
                <div class="col-sm-4" style="margin: 20px 0;">
                    <g:form action="makeInStockChecked" controller="shopItemManager" params="${params}">
                        <g:if test="${total > 0}">
                            <g:each status="i" in="${itemList}" var="item">
                                <div style="display: none">
                                    <input type="checkbox" name="copyBox" value="${item.id}">
                                </div>
                            </g:each>
                        </g:if>
                        <button type="submit" class="btn btn-warning "><i
                                class="fa fa-cloud-download"></i>批量下架</button>
                        <butoton  class="btn btn-success" onclick="downExcel()" >批量导出</butoton>
                        <butoton  class="btn btn-success" onclick="downsomeItemExcel()" >导出</butoton>
                        <button type="button" class="btn btn-info" id="inputPortExcelByModifyBtn">批量修改</button>
                    </g:form>
                </div>
            </div>
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

<span id="myparams" class="hide">${params}</span>

%{--打印全部的商品--}%
<g:form action="downloadExcel"  style="display: none;">
    <input type="submit"  id="outPortExcelOneModelBtn">
</g:form>

%{--导入功能--}%
<g:uploadForm action="modifyItemInfo" enctype="multipart/form-data" style="display:none" controller="trade">
    <input type="file" name="myFile" id="myFile" accept=".xls"/>
    <input type="submit" style="display: none;" id="inputPortExcelByModify">
</g:uploadForm>


<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- select2 -->
<asset:javascript src="select2/select2.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>



<script type="text/javascript">



    //点击批量导入的按钮
    $('#inputPortExcelByModifyBtn').on("click",function(){
        $('#myFile').click();
    });
    $('#myFile').on('change',function(){
        //获取其文件类型
        var fileName=$("#myFile").val();
        if(fileName.length>1 && fileName)
        {
            var  index=fileName.lastIndexOf(".");
            var type=fileName.substring(index+1);
            if(type!="xls")
            {
                alert("请上传对应Excel类型的文件");
                return;
            }
            else{
                $('#inputPortExcelByModify').click();
            }
        }
    });

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    var num = 0


    $(function () {
        $('#level1Category').change(function () {
            num = num + 1
            var str = "";
            $("#level1Category option:selected").each(function () {
                var categoryFlag=($('#category').attr("bsfalg") && $('#category').attr("bsfalg")!=-1)?1:0;
                $('#category').find('option').remove();
                $('#category').append('<option value="-1">请选择类目...</option>');
                $('#threelevel').find('option').remove();
                $('#threelevel').append('<option value="-1">请选择类目...</option>');
                var id = $(this).val()
                if (id != "-1" && id != '' && id != undefined && num < 2) {
                    $.ajax({
                        url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" params="${params}"/>', // remote datasource
                        data: {'id': id},
                        type: "POST",
                        dataType: "json",
                        success: function (data) {
                            debugger;
                            if(categoryFlag){
                                $('#category').find('option').remove();
                            }
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


        //二级类目的变化
        $('#category').change(function () {
            $("#category option:selected").each(function () {
                $('#threelevel').find('option').remove();
                $('#threelevel').append('<option value="-1">请选择类目...</option>');
                var categoryFlag=($('#threelevel').attr("bsfalg") && $('#threelevel').attr("bsfalg")!=-1)?1:0;
                var id = $(this).val()
                if (id != "-1" && id != '' && id != undefined && num < 2) {
                    $.ajax({
                        url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" params="${params}"/>', // remote datasource
                        data: {'id': id},
                        type: "POST",
                        dataType: "json",
                        success: function (data) {
                            debugger;
                            if(categoryFlag){
                                $('#threelevel').find('option').remove();
                            }
                            $.each(data, function (index, m) {
                                $('#threelevel').append('<option value="' + m.id + '">' + m.name + '</option>');
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
                                $('#threelevel').append('<option value="' + m.id + '">' + m.name + '</option>');
                            })

                        }, error: function (data) { // handle server errors
                        }
                    });
                }

            });
        });


        //添加对应的默认值
        <g:if test="${params.category && params.threelevel}">
        $.ajax({
            url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" params="${params}"/>', // remote datasource
            data: {'id': ${params.category}},
            type: "POST",
            dataType: "json",
            success: function (data) {
                debugger;
                $.each(data, function (index, m) {
                    if(m.id!=${params.category}){
                        $('#threelevel').append('<option value="' + m.id + '">' + m.name + '</option>');
                    }
                })
                <g:if test="${params.threelevel}">
                $('#threelevel > option[value="${params.threelevel}"]').prop('selected', true);
                </g:if>
            }, error: function (data) {
            }
        });
        </g:if>





    })

    %{--$(function () {--}%
        %{--$('#level1Category').change(function () {--}%
            %{--num = num + 1--}%
            %{--var str = "";--}%
            %{--$("#level1Category option:selected").each(function () {--}%
                %{--$('#category').find('option').remove();--}%
                %{--$('#category').append('<option value="-1">请选择类目...</option>');--}%
                %{--var id = $(this).val()--}%
                %{--if (id != "-1" && id != '' && id != undefined && num < 2) {--}%
                    %{--$.ajax({--}%
                        %{--url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" params="${params}"/>', // remote datasource--}%
                        %{--data: {'id': id},--}%
                        %{--type: "POST",--}%
                        %{--dataType: "json",--}%
                        %{--success: function (data) {--}%
                            %{--$('#category').find('option').remove();--}%
                            %{--$.each(data, function (index, m) {--}%
                                %{--$('#category').append('<option value="' + m.id + '">' + m.name + '</option>');--}%
                            %{--})--}%

                        %{--}, error: function (data) { // handle server errors--}%
                        %{--}--}%
                    %{--});--}%
                %{--} else {--}%
                    %{--$.ajax({--}%
                        %{--url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" />', // remote datasource--}%
                        %{--data: {'id': id},--}%
                        %{--type: "POST",--}%
                        %{--dataType: "json",--}%
                        %{--success: function (data) {--}%
                            %{--$.each(data, function (index, m) {--}%
                                %{--$('#category').append('<option value="' + m.id + '">' + m.name + '</option>');--}%
                            %{--})--}%

                        %{--}, error: function (data) { // handle server errors--}%
                        %{--}--}%
                    %{--});--}%
                %{--}--}%
            %{--});--}%
        %{--}).trigger('change');--}%
    %{--})--}%

    $("input[name='itemShipBox']").on('ifChecked', function (event) {
        var id = this.value
        $("input[name='copyBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('check');
            }
        });
    });
    $("input[name='itemShipBox']").on('ifUnchecked', function (event) {
        var id = this.value
        $("input[name='copyBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('uncheck');
            }
        });
    });

    $("#checkAll").on('ifChecked', function (event) {
        $("input[name='itemShipBox']").each(function check() {
            $(this).iCheck('check');
        });
    });

    $("#checkAll").on('ifUnchecked', function (event) {
        $("input[name='itemShipBox']").each(function check() {
            $(this).iCheck('uncheck');
        });

    });

    function lookItemDetail(id) {
        $("#itemId").text('产品ID号:' + id)
        <g:remoteFunction update="itemDetail" action="lookItemDetail" options="'[asynchronous: false]'"  params="'id='+id"/>

    }


    function makeInStock(id) {

        if (!confirm("您真的要下架这个商品么？")) {
            return;
        }

        $.ajax({
            url: '/shopItemManager/makeInStock',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
//                window.location.reload()
                window.location.replace('/shopItemManager/index?'+getParamsInfo());
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }



    //修改对应商品权重
    function modifyweight(id) {
        //旧的名称
        var newWeight = $("#wi"+id).val().trim();
        if(!newWeight)
        {
            alert("对应的权重不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(newWeight);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/shopItemManager/updateOneItemWeight',
                data: {'id': id, 'newWeight': newWeight},
                type: "POST",
                dataType: "json",
                success: function (data) {
//                        alert(data);
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的权重只能填数字类型...");
            return false;
        }
    }


    function modixsQuantity(id)
    {
        var newWeight = $("#qu"+id).val().trim();
        if(!newWeight)
        {
            alert("对应的权重不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(newWeight);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/shopItemManager/updateOneItemQuantity',
                data: {'id': id, 'qunatity': newWeight},
                type: "POST",
                dataType: "json",
                success: function (data) {
//                        alert(data);
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的权重只能填数字类型...");
            return false;
        }
    }

    //修改库存
    function modixsTitle(id)
    {
        var title=$("#title"+id).val();
        if(!title)
        {
            alert("对应名称不能设置为空...");
            return false;
        }
        if(title)
        {
            $.ajax({
                url: '/shopItemManager/updateOneItemTitle',
                data: {'id': id, 'title': title},
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


    }

    //修改名称
    function modixsNum(id){
        var num=$("#num"+id).val();
        if(!num)
        {
            alert("对应的库存不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(num);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/shopItemManager/updateOneItemNum',
                data: {'id': id, 'num': num},
                type: "POST",
                dataType: "json",
                success: function (data) {
//                        alert(data);
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的库存只能填数字类型...");
            return false;
        }
    }


    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var level1Category=$("#level1Category").val();
        var category=$("#category").val();
        var itemcode=$("input[name=itemcode]").val();
        var query=$("input[name=query]").val();
        var brandId=$("#brandId").val();
        var tagId=$("#tagId").val();
        var field=$("#fieldName").html();
        var fieldstate=$("#fieldstate").html();
        var threelevel=$("#threelevel").val();
        var str='/shopItemManager/index?max='+size+"&level1Category="+level1Category+"&category="+category+"&query="+query+"&brandId="+brandId+"&tagId="+tagId+"&itemcode="+itemcode+"&fieldName="+field+"&fieldstate="+fieldstate+"&threelevel="+threelevel;
        window.location.replace(str);
    });


    //打印下载上架商品
    function downExcel(){
        $("#outPortExcelOneModelBtn").click();
    }

    //打印部分上架的商品
    function downsomeItemExcel(){
        var size=0;
        $('input[name="itemShipBox"]:checked').each(function (index, ele) {
            size++;
        });
        if(size==0){
            alert("请选择对应的商品进行打印...");
            return false;
        }
        $("#downOnesItemsForm").submit();
    }


    //进行各类的排序
    function paixu(content){
        var flag=content;
        var stateArr=content.split("-");
        var field=stateArr[0];
        var fieldstate=stateArr[1];
        //排序的字段
        $("#fieldName").html(field);
        $("#fieldstate").html(fieldstate);
        var pagesize=$("#max").val();
        var level1Category=$("#level1Category").val();
        var itemcode=$("input[name=itemcode]").val();
        var category=$("#category").val();
        var query=$("input[name=query]").val();
        var brandId=$("#brandId").val();
        var tagId=$("#tagId").val();
        var threelevel=$("#threelevel").val();
        var str='/shopItemManager/index?max='+pagesize+"&level1Category="+level1Category+"&category="+category+"&query="+query+"&brandId="+brandId+"&tagId="+tagId+"&fieldName="+field+"&fieldstate="+fieldstate+"&itemcode="+itemcode+"&threelevel="+threelevel;
        window.location.replace(str);
    }


    //进行对params字段进行记录
    function getParamsInfo(){
        var params=$("#myparams").html(),str="",arr=[],i=0;
        params=params.substring(1,params.length-1);
        arr=params.split(",");
        $.each(arr,function(index,content){
            var onearr=content.split(":");
            if(onearr[1] && onearr[0].trim()!="controller" && onearr[0].trim()!="action"){
                str+=(onearr[0].trim()+"="+onearr[1].trim()+"&");
            }
        });
        return str;
    }

    //select搜索
    $("#sel_menu").select2({
        tags: true,
    });


</script>

</body>

</html>
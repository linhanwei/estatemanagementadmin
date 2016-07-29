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
    <!-- select2 -->
    <asset:stylesheet src="select2/select2.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
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
        仓库商品
        <small>商品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>商品管理</a></li>
        <li class="active">仓库商品</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">

    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <div class='col-xs-12'>
                <div style="margin-top: 10px"></div>
                <g:form name="stockGoodsForm" class="form-inline" action="index">
                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">一级类目：</label>

                        <g:select optionKey="id" optionValue="name" name="level1Category"
                                  class="form-control" from="${categoryList}" value="${params.level1Category}"
                                  noSelection="['-1': '一级类目...']"/>

                    </div>

                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">二级类目：</label>

                        <select id="category" class="form-control" name="category" bsfalg="${params.category}">
                        </select>

                    </div>

                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">三级类目：</label>

                        <select id="threelevel" class="form-control" name="threelevel" bsfalg="${params.threelevel}">
                        </select>

                    </div>


                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">商品名称：</label>
                        <input  name="query" class="form-control"
                                value="${params.query}"
                                placeholder="商品名称"/>
                    </div>


                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">品牌：</label>
                        <g:select optionKey="id" optionValue="name" name="brandId" id="sel_menu"
                                  class="form-control selectpicker" from="${mikuBrandList}" value="${params.brandId}"
                                  noSelection="['': '请选择品牌']"/>${params.brandId}
                    </div>


                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">标签：</label>
                        <g:select optionKey="id" optionValue="name" name="tagId"
                                  class="form-control" from="${tagsList}"    value="${params.tagId}"
                                  noSelection="['': '请选择标签']"/>
                    </div>


                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">商品编码：</label>
                        <input  name="itemcode" class="form-control"
                                value="${params.itemcode}"
                                placeholder="商品编码"/>
                    </div>

                    <div class="col-sm-6 col-md-4 form-group">
                        <label class="control-label">查询页码：</label>
                        <g:select optionKey="key" optionValue="value" name="max"
                                  class="form-control" from="${PageMap}" value="${params.max}"
                                  noSelection="['10': '请选择页码']"/>

                %{--<input type="text" class="hide" name="fieldName"/>--}%
                %{--<input type="text" class="hide" name="fieldstate"/>--}%

                    <span class="hide" id="fieldName">${params.fieldName}</span>
                    <span class="hide" id="fieldstate">${params.fieldstate}</span>

                        <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询</button>
                    </div>
                </g:form>

            %{--<div class="col-sm-2">--}%
            %{--<div class="search-form">--}%
            %{--<g:form action="index" class="text-right" useToken="true">--}%
            %{--<div class="input-group">--}%
            %{--<input id="query" name="query" class="input-sm"--}%
            %{--value="${params.query}"--}%
            %{--placeholder="商品名称:"/>--}%

            %{--<div class="input-group-btn">--}%
            %{--<button type="submit"--}%
            %{--class="btn btn-sm btn-primary"><i--}%
            %{--class="fa fa-search">搜索</i></button>--}%
            %{--</div>--}%
            %{--</div>--}%
            %{--</g:form>--}%
            %{--</div>--}%
            %{--</div>--}%
            </div>
        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th  style="width:15%;word-wrap:break-word;">标签</th>
                    <th>一级</th>
                    <th>二级</th>
                    <th>三级</th>
                    <th>名称</th>
                    <th>品牌</th>
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
                    %{--<th>市场价</th>--}%
                    %{--<th>供货价</th>--}%
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
                    <th >销售数量</th>
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
                                            <small class="label pull-left bg-blue" style="word-wrap:break-word;white-space: normal;">${tag?.name}
                                            <g:if test="${tag.bit == 1L}">
                                                ${JSON.parseObject(xlTagMap.get(item?.id))?.get('xgLimitNum') ?: '0'}
                                            %{--${JSON.parseObject(OtMap.get(tag.id))?.get('xgLimitNum') ?: '无'}--}%
                                            </g:if>
                                            <g:if test="${tag?.name=='抢购标'}">
                                                ${xgbTagMap.get(item?.id)}
                                            </g:if>
                                            </small>
                                        </g:each>

                                            </small>
                                    </g:if>

                                    %{--<g:if test="${itemTagMap.get(item?.id) != null}">--}%
                                        %{--<g:each status="j" in="${xgbTagMap.get(item?.id)}" var="tag">--}%
                                            %{--<g:if test="${tag.bit == 1L}">--}%
                                                %{--${JSON.parseObject(xgbTagMap.get(item?.id))}--}%
                                            %{--</g:if>--}%
                                            %{--</small>--}%
                                        %{--</g:each>--}%
                                    %{--</g:if>--}%
                                </div>
                            </th>
                            <td>${categoryMap.get(item?.category1_id)?.name}</td>
                            <td>${categoryMap.get(item?.category2_id)?.name}</td>
                            <td>${categoryMap.get(item.categoryId)?.name}</td>

                            <td>
                                <a
                                        onclick="lookItemDetail('${item.id}');
                                        return false;"
                                        data-toggle="modal"
                                        data-target="#itemDetailModel">${item.title}
                                </a>
                                %{--<div style="padding-top: 10px">--}%
                                    %{--${item?.id}--}%
                                %{--</div>--}%
                            </td>
                            <td>${brandMap.get(item.brandId)?.name}</td>
                            <td>${item.code}</td>
                            %{--<td>${(JSON.parseObject(item.features)?.getLongValue('referencePrice') ?: 0) / 100f}</td>--}%
                            %{--<td>${(JSON.parseObject(item.features)?.getLongValue('purchasingPrice') ?: 0) / 100f}</td>--}%
                            <td>${(item.price ?: 0) / 100f}</td>
                            <td>
                                <input onchange="modixsNum('${item?.id}')" type="text"
                                       value="${item?.num}" name="${item?.id}" class="no-border" id="num${item?.id}"
                                       style="width:30px;background:transparent;">
                            </td>
                            <td>
                                <input onchange="modixsQuantity('${item?.id}')" type="text"
                                       value="${item?.baseSoldQuantity}" name="${item?.id}" class="no-border" id="qu${item?.id}"
                                       style="width:30px;background:transparent;">
                            </td>

                            <td>
                                <input onchange="modifyweight('${item?.id}')" type="text"
                                       value="${item?.weight}" name="${item?.id}" class="no-border"  id="wi${item?.id}"
                                       style="width:30px;background:transparent;">
                            </td>

                            <th>
                                ${item?.soldQuantity?item?.soldQuantity:0}
                            </th>

                            <td>
                                <g:if test="${item?.isrefund==1L}">
                                    是
                                </g:if>
                                <g:else>
                                    否
                                </g:else>
                            </td>
                            <td>
                                %{--备用：弹框写入对应库存上架--}%
                                %{--<button type="button" class="btn btn-success btn-sm" data-toggle="modal"--}%
                                %{--data-target="#myModal2" onclick="makeItOnSale(${item.id})">--}%
                                %{--上架--}%
                                %{--</button>--}%

                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.open('http://miku.unesmall.com/api/h/1.0/detailPage.htm?gid='+${item.id},'_blank','width=600,height=1000,menubar=no,toolbar=no, status=no,scrollbars=yes')">
                                   预览
                                </button>

                                <button type="button" class="btn btn-info btn-sm" onclick="shangJiaItem(${item.id})">
                                    上架
                                </button>

                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-warning btn-sm" data-toggle="modal"
                                        data-target="#myModal" onclick="makeItGroupOn(${item.id})"
                                        style="display: none">
                                    开团
                                </button>

                                <button type="button" class="btn btn-warning btn-sm"
                                        onclick="updateItemTag(${item.id})"
                                        data-toggle="modal"
                                        data-target="#tagEditModel">
                                    打标
                                </button>

                                <button type="button" class="btn btn-danger btn-sm"
                                        onclick="deleteItem(${item.id})">
                                    删除
                                </button>
                            </td>
                            <th>
                                <input type="checkbox" name="itemShipBox"
                                       value="${item?.id}">
                            </th>
                        </tr>
                    </g:each>
                </g:if>
            </table>
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
                    <g:form action="makeAllShangjiaOnSale" controller="itemInStock" params="${params}">
                        <g:if test="${total > 0}">
                            <g:each status="i" in="${itemList}" var="item">
                                <div style="display: none">
                                    <input type="checkbox" name="copyBox" value="${item.id}">
                                </div>
                            </g:each>
                        </g:if>
                        <button type="submit" class="btn btn-success "><i
                                class="fa fa-cloud-download"></i>批量上架</button>
                        <button type="button" class="btn btn-warning" id="deleSomeItems">批量删除</button>
                    </g:form>
                </div>
            </div>



            <g:form action="makeAllShangjiaDelete" controller="itemInStock" params="${params}">
                <g:if test="${total > 0}">
                    <g:each status="i" in="${itemList}" var="item">
                        <div style="display: none">
                            <input type="checkbox" name="copyBox" value="${item.id}">
                        </div>
                    </g:each>
                </g:if>
                <input type="submit" id="deleItemBtns" style="display: none">
            </g:form>

        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->
%{--<asset:javascript src="bootstrap.js"/>--}%
%{--<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>--}%
%{--<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>--}%

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
            <g:form useToken="true" action="makeOnSale">

                <input id="readyOnSaleItemId" name="itemId" style="display: none;">

                <div class="modal-body">
                    <div class="form-horizontal">

                        <div class="form-group form-inline">
                            <label class="col-sm-2 control-label">本期限量</label>

                            <div class="col-sm-4">
                                <input name="num" class="form-control" id="bqxlNum">
                            </div>

                        </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="sjBtnOnsale">提交</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </g:form>
        </div>
    </div>
</div>
<span id="myparams" class="hide">${params}</span>

%{--导入功能--}%
<g:uploadForm action="modifyItemInfo" enctype="multipart/form-data" style="display:none" controller="trade">
    <input type="file" name="myFile" id="myFile" accept=".xls"/>
    <input type="submit" style="display: none;" id="inputPortExcelByModify">
</g:uploadForm>




<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- select2 -->
<asset:javascript src="select2/select2.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>


<script>


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

    function updateItemTag(id) {
        $("#itemId2").text('产品ID号:' + id)
        <g:remoteFunction update="tagEdit" action="updateItemTag" options="'[asynchronous: false]'" params="{'id':id,'query':${params?.query?:null}, 'category': ${params?.category?:null}, 'level1Category': ${params?.level1Category?:null}}"/>
        <g:remoteFunction update="tagEdit" action="updateItemTag" options="'[asynchronous: false]'" params="{'id':id}"/>
    }

    function bindPicEdit() {
        /**
         * Created by saarixx on 12/11/14.
         */
        (function ($) {
            // 当domReady的时候开始初始化
            $(function () {
                // 初始化Web Uploader
                var uploader = WebUploader.create({

                    // 选完文件后，是否自动上传。
                    auto: true,

                    // swf文件路径
                    swf: "assets/ueditor-1.4.3/third-party/webuploader/Uploader.swf",

                    // 文件接收服务端。
                    server: '/itemPublish/handle?action=uploadImage',

                    // 选择文件的按钮。可选。
                    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                    pick: '#filePicker2',

                    // 只允许选择图片文件。
                    accept: {
                        title: 'Images',
                        extensions: 'gif,jpg,jpeg,bmp,png',
                        mimeTypes: 'image/*'
                    }
                });

                var $ = jQuery,
                        $list = $('#fileList2'),
                // 优化retina, 在retina下这个值是2
                        ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                        thumbnailWidth = 100 * ratio,
                        thumbnailHeight = 100 * ratio,

                // Web Uploader实例
                        uploader;

                // 当有文件添加进来的时候
                uploader.on('fileQueued', function (file) {
                    addFile(file)
                });


                // 文件上传成功，给item添加成功class, 用样式标记上传成功。
                uploader.on('uploadSuccess', function (file) {
                    $('#' + file.id).addClass('state-complete');
                    $('#' + file.id).append('<span class="success"></span>');
                });

                uploader.on('uploadAccept', function (file, response) {
                    console.log($('#' + file.file.id).find('p.imgWrap'))
                    $('#' + file.file.id).find('p.imgWrap').html('<img src="' + response.url + '"><input name="detail-pic" value="' + response.url + '" style="display: none">');
                });

                // 文件上传失败，显示上传出错。
                uploader.on('uploadError', function (file) {
                    var $li = $('#' + file.id),
                            $error = $li.find('div.error');

                    // 避免重复创建
                    if (!$error.length) {
                        $error = $('<div class="error"></div>').appendTo($li);
                    }

                    $error.text('上传失败');
                });

                // 完成上传完了，成功或者失败，先删除进度条。
                uploader.on('uploadComplete', function (file) {
                    $('#' + file.id).find('.progress').remove();
                });

                // 当有文件添加进来时执行，负责view的创建
                function addFile(file) {
                    var $li = $('<li id="' + file.id + '">' +
                                    '<p class="title">' + file.name + '</p>' +
                                    '<p class="imgWrap"></p>' +
                                    '</li>'),

                            $btns = $('<div class="file-panel">' +
                                    '<span class="cancel">删除</span>' +
                                    '<span class="rotateLeft">向左移动</span>' +
                                    '<span class="rotateRight">向右移动</span>' +
                                    '</div>').appendTo($li),

                            $wrap = $li.find('p.imgWrap'),
                            $info = $('<p class="error"></p>')


                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        var img;
                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }
                        img = $('<img src="' + src + '">');
                        $wrap.empty().append(img);
                    }, thumbnailWidth, thumbnailHeight);

                    $li.on('mouseenter', function () {
                        $btns.stop().animate({height: 30});
                    });

                    $li.on('mouseleave', function () {
                        $btns.stop().animate({height: 0});
                    });

                    $btns.on('click', 'span', function () {

                        var index = $(this).index(),
                                deg;

                        switch (index) {
                            case 0:
                                removeFile(file);
                                return;
                            case 1:
                                moveDown($('#' + file.id))
                                break;
                            case 2:
                                moveUp($('#' + file.id))
                                break;

                        }

                    });

                    // $list为容器jQuery实例
                    $list.append($li);
                }

                // 负责view的销毁
                function removeFile(file) {
                    var $li = $('#' + file.id);
                    $li.off().find('.file-panel').off().end().remove();
                }


                function moveUp($item) {
                    $before = $item.prev();
                    $item.insertBefore($before);
                }

                function moveDown($item) {
                    $after = $item.next();
                    $item.insertAfter($after);
                }

            });

        })(jQuery);
    }

    function bindPicCreate() {
        /**
         * Created by saarixx on 12/11/14.
         */
        (function ($) {
            // 当domReady的时候开始初始化
            $(function () {
                // 初始化Web Uploader
                var uploader = WebUploader.create({

                    // 选完文件后，是否自动上传。
                    auto: true,

                    // swf文件路径
                    swf: "assets/ueditor-1.4.3/third-party/webuploader/Uploader.swf",

                    // 文件接收服务端。
                    server: '/itemPublish/handle?action=uploadImage',

                    // 选择文件的按钮。可选。
                    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                    pick: '#filePicker',

                    // 只允许选择图片文件。
                    accept: {
                        title: 'Images',
                        extensions: 'gif,jpg,jpeg,bmp,png',
                        mimeTypes: 'image/*'
                    }
                });

                var $ = jQuery,
                        $list = $('#fileList'),
                // 优化retina, 在retina下这个值是2
                        ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                        thumbnailWidth = 100 * ratio,
                        thumbnailHeight = 100 * ratio;

                // Web Uploader实例
                //uploader;

                // 当有文件添加进来的时候
                uploader.on('fileQueued', function (file) {
                    addFile(file)
                });


                // 文件上传成功，给item添加成功class, 用样式标记上传成功。
                uploader.on('uploadSuccess', function (file) {
                    $('#' + file.id).addClass('state-complete');
                    $('#' + file.id).append('<span class="success"></span>');
                });

                uploader.on('uploadAccept', function (file, response) {
                    $('#' + file.file.id).find('p.imgWrap').html('<img src="' + response.url + '"><input name="item-pic" value="' + response.url + '" style="display: none">');
                });

                // 文件上传失败，显示上传出错。
                uploader.on('uploadError', function (file) {
                    var $li = $('#' + file.id),
                            $error = $li.find('div.error');

                    // 避免重复创建
                    if (!$error.length) {
                        $error = $('<div class="error"></div>').appendTo($li);
                    }

                    $error.text('上传失败');
                });

                // 完成上传完了，成功或者失败，先删除进度条。
                uploader.on('uploadComplete', function (file) {
                    $('#' + file.id).find('.progress').remove();
                });

                // 当有文件添加进来时执行，负责view的创建
                function addFile(file) {
                    var $li = $('<li id="' + file.id + '">' +
                                    '<p class="title">' + file.name + '</p>' +
                                    '<p class="imgWrap"></p>' +
                                    '</li>'),

                            $btns = $('<div class="file-panel">' +
                                    '<span class="cancel">删除</span>' +
                                    '<span class="rotateLeft">向左移动</span>' +
                                    '<span class="rotateRight">向右移动</span>' +
                                    '</div>').appendTo($li),

                            $wrap = $li.find('p.imgWrap'),
                            $info = $('<p class="error"></p>')


                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        var img;
                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }
                        img = $('<img src="' + src + '">');
                        $wrap.empty().append(img);
                    }, thumbnailWidth, thumbnailHeight);

                    $li.on('mouseenter', function () {
                        $btns.stop().animate({height: 30});
                    });

                    $li.on('mouseleave', function () {
                        $btns.stop().animate({height: 0});
                    });

                    $btns.on('click', 'span', function () {

                        var index = $(this).index(),
                                deg;

                        switch (index) {
                            case 0:
                                removeFile(file);
                                return;
                            case 1:
                                moveDown($('#' + file.id))
                                break;
                            case 2:
                                moveUp($('#' + file.id))
                                break;

                        }

                    });

                    // $list为容器jQuery实例
                    $list.append($li);
                }

                // 负责view的销毁
                function removeFile(file) {
                    var $li = $('#' + file.id);
                    $li.off().find('.file-panel').off().end().remove();
                }


                function moveUp($item) {
                    $before = $item.prev();
                    $item.insertBefore($before);
                }

                function moveDown($item) {
                    $after = $item.next();
                    $item.insertAfter($after);
                }

            });

        })(jQuery);
    }


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
//                            if(categoryFlag){
//                                $('#threelevel').find('option').remove();
//                            }
                            $.each(data, function (index, m) {
                                $('#threelevel').append('<option value="' + m.id + '">' + m.name + '</option>');
                            })

                        }, error: function (data) { // handle server errors
                        }
                    });
                }
                else {
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
                    $.each(data, function (index, m) {
                        if(m.id!=${params.category}){
                            $('#threelevel').append('<option value="' + m.id + '">' + m.name + '</option>');
                        }
                    })

                    <g:if test="${params.threelevel}">
                    $('#threelevel > option[value="${params.threelevel}"]').prop('selected', true);
                    </g:if>

                }, error: function (data) { // handle server errors
                }
            });
        </g:if>




    })

    function deleteItem(id) {
        if (!confirm("您真的要删除这个商品么，删除商品后分站点商品消失！！")) {
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

    function makeItOnSale(id) {
        //进行ajax的回调
        $.ajax({
            url: '/itemInStock/getItemNum',
            data: {'id': id},
            type: "POST",
            success: function (num) {
                var data=num.trim();
                if(data && data!="null")
                {
                    $("#bqxlNum").val(data)
                }
                else
                {
                    $("#bqxlNum").val(0)
                }
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });

        $('#readyOnSaleItemId').val(id)
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
                url: '/itemInStock/updateOneItemWeight',
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
                url: '/itemInStock/updateOneItemQuantity',
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
    function modixsNum(id)
    {
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
                url: '/itemInStock/updateOneItemNum',
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



    //进行上架商品的限制
    $("#sjBtnOnsale").on('click',function(){
        var content=$("#bqxlNum").val();
        if(!content)
        {
            alert("请填好对应的库存...");
            return false;
        }
        else{
            content=parseInt(content);
            if(content<=0)
            {
                alert("请填好大于0库存...");
                return false;
            }
        }
    });

    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var level1Category=$("#level1Category").val();
        var category=$("#category").val();
        var query=$("input[name=query]").val();
        var brandId=$("#brandId").val();
        var tagId=$("#tagId").val();
        var itemcode=$("input[name=itemcode]").val();
        var field=$("#fieldName").html();
        var fieldstate=$("#fieldstate").html();
        var threelevel=$("#threelevel").val();
//        Long oneLevel=params.long('level1Category')
//        Long twoLevel=params.long('category')
//        Long threeLevel=params.long('threelevel')

        var str='/itemInStock/index?max='+size+"&level1Category="+level1Category+"&category="+category+"&query="+query+"&brandId="+brandId+"&tagId="+tagId+"&fieldName="+field+"&fieldstate="+fieldstate+"&itemcode="+itemcode+"&threelevel="+threelevel;
        window.location.replace(str);
    });

    //进行上架的操作
    function shangJiaItem(id){
        $.ajax({
            url: '/itemInStock/makeShangjiaOnSale',
            data: {'itemId': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location.replace('/itemInStock/index?'+getParamsInfo());
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
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
        var str='/itemInStock/index?max='+pagesize+"&level1Category="+level1Category+"&category="+category+"&query="+query+"&brandId="+brandId+"&tagId="+tagId+"&fieldName="+field+"&fieldstate="+fieldstate+"&itemcode="+itemcode+"&threelevel="+threelevel;
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

    //deleSomeItems
    $("#deleSomeItems").click(function(){
        $("#deleItemBtns").click();
    });



</script>

</body>

</html>

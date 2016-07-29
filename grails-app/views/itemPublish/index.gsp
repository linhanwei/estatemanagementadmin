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

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>

    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <style>
    .lineDiv
    {
        position: relative;
        border-bottom: 1px solid #eee;
        height: 30px;
        margin: 10px 0;
    }

    .title
    {
        position: absolute;
        width: 200px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        left: 50%;
        top: -3px;
        /*background-color: #fff;*/
        margin-left: -100px;
        font-size: large;
        font-weight: 200;
    }

    .tipeHide{display: none;color: red}

    /*搜索*/
    ::-webkit-scrollbar-track {
        background-color: rgba(0, 0, 0, 0);
    }

    ::-webkit-scrollbar {
        width: 0px;
        background-color: rgba(0, 0, 0, 0);
    }

    ::-webkit-scrollbar-thumb {
        background-color: rgba(0, 0, 0, 0);
    }

    .row{position: relative;}
    .searchBox{border:1px solid #e5e5e5;padding:5px;position:absolute;
        top:34px;
        width:92.5%;z-index: 9;background-color: #fff;
    }
    .searchBox dl{max-height:100px;overflow-y: auto;margin-bottom: 0}
    .searchBox dd{padding:2px 3px;font-size: 14px;}
    .searchBox .close{position:absolute;top:5px;right:5px}
    .searchBox dd:hover{background-color: #1094fa;
        color: #fff;}


    .inputClose{ position: absolute; right: 22px;top: 6px;font-size: 18px;cursor: pointer;}
    </style>

</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        发布商品
        <small>商品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>商品管理</a></li>
        <li class="active">发布商品</li>
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
        <g:form name="item_form" useToken="true" action="publish">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">商品类型:</label>

                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="type"
                                  class="form-control" from="${itemTypeList}"
                                  noSelection="['1': '正常商品']"/>
                    </div>

                    <label class="col-xs-2 control-label">是否免税</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <g:checkBox name="isTaxFree" class="input-sm jstree-checkbox"/>
                        </div>
                    </div>

                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-list-ul"></i>一级目录<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <g:select optionKey="id" optionValue="name" name="level1Category"
                                  class="form-control" from="${categoryList}"
                                  noSelection="['': '请选择一级目录']"/>
                        <span class="tipeHide" id="level1CategoryTip">请选择一级目录</span>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-list"></i>二级目录<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <select id="category" class="form-control" name="category">
                            <option value="-1">请选择二级目录</option>
                        </select>
                        %{--<span style="display: none;" id="level1CategoryTip">请选择二级目录</span>--}%
                        <span class="tipeHide" id="categoryTip">请选择二级目录</span>
                    </div>
                </div>

                %{--<input type="text" class="hide" name="brandId" id="tagetBrand"/>--}%
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-list-ul"></i>三级目录<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <select id="level3Category" class="form-control" name="level3Category">
                            <option value="-1">请选择三级目录</option>
                        </select>
                        <span class="tipeHide" id="level3CategoryTip">请选择三级目录</span>
                    </div>


                    <label class="col-xs-2 control-label"><i class="fa fa-list"></i>品牌<span style="color: red">*</span>:</label>

                    %{--<div class="col-xs-3 brandRow inputSeac">--}%
                        %{--<input type="text" class="form-control searchInput" id="aa" placeholder="品牌"/><span class="inputClose">×</span>--}%
                        %{--<div class="searchBox hide" >--}%
                            %{--<dl>--}%
                                %{--<g:each status="i" in="${mikuBrandList}" var="list">--}%
                                    %{--<dd targetValue="${list.id}">${list.name}</dd>--}%
                                %{--</g:each>--}%
                            %{--</dl>--}%
                            %{--<div class="close">×</div>--}%
                        %{--</div>--}%
                    %{--</div>--}%

                    <div class="col-xs-3">
                        <g:select optionKey="id" optionValue="name" name="brandId"
                                  class="form-control" from="${mikuBrandList}"
                                  noSelection="['': '请选择品牌']"/>
                        <span class="tipeHide" id="brandIdTip">请选择品牌</span>
                    </div>


                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>商品主图</label>

                    <div class="col-sm-8">
                        %{--<!--dom结构部分-->--}%
                        <div id="uploader" class="queueList">

                            <!--用来存放item-->

                            <ul id="fileList" class="filelist">

                            </ul>

                            <div id="filePicker">选择图片</div>
                        </div>
                        <span style="display:none;color:red" id="MainImgTip">至少上传一张选择商品主图</span>
                    </div>

                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>标题<span style="color: red">*</span></label>

                    <div class="col-xs-8">
                        <input type="text" name="title" class="form-control"
                        %{--placeholder="标题" value="${purchase?.title}">--}%
                               placeholder="标题" >
                        <span class="tipeHide" id="titleTip">请写入对应的标题</span>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">搜索关键字</label>

                    <div class="col-xs-8">
                        <input type="text" name="keyWord" class="form-control"
                               placeholder="搜索关键字" >
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>商品编码<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <input type="text" name="code" class="form-control" placeholder="商品编码">
                        <span class="tipeHide" id="codeTip">请写入对应商品编码</span>
                    </div>


                    <label class="col-sm-2 control-label"><i class="fa fa-sort-numeric-asc">权重:</i></label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                            &nbsp;
                            <input type="text" placeholder="权重" value="9" id="num" name="weight"
                                   readonly style="width: 30px">
                            <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                        </div>
                    </div>

                    %{--<label class="col-xs-2 control-label"><i class="fa fa-list"></i>品牌</label>--}%

                    %{--<div class="col-xs-3">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="brandId"--}%
                    %{--class="form-control" from="${mikuBrandList}"--}%
                    %{--noSelection="['': '请选择品牌']"/>--}%
                    %{--</div>--}%
                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-truck"></i>采购价<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="tel" id="newcgprice" name="newcgprice" class="form-control"
                            %{--value="${(purchase?.price ?: 0) / 10000f}">--}%
                                   value="">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="newcgpriceTip">请写入对应采购价</span>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-money"></i>邮费<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="tel" name="postFee" class="form-control" id="postFee" >
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="postFeeTip">请写入对应邮费</span>
                    </div>
                </div>





                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-truck"></i>成本价<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" id="purchasingPrice" name="purchasingPrice" class="form-control" readonly
                            %{--value="${(purchase?.price ?: 0) / 10000f}">--}%
                                   value="">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="purchasingPriceTip">请写入对应成本价</span>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-money"></i>参考价<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="tel" name="referencePrice" class="form-control" >
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="referencePriceTip">请写入对应参考价</span>
                    </div>
                </div>



                <div class="list-group-item form-group">


                    <label class="col-xs-2 control-label"><i class="fa fa-gavel"></i>销售价<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="price" class="form-control"  id="xsprice">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="priceTip">请写入对应销售价</span>
                    </div>
                </div>




                %{--<div class="form-group">--}%
                %{--<label class="col-xs-2 control-label"><i class="fa fa-gavel"></i>建议销售价</label>--}%

                %{--<div class="col-xs-3">--}%
                %{--<div class="input-group">--}%
                %{--<span class="input-group-addon"><i class="fa fa-rmb"></i></span>--}%
                %{--<input type="text" name="price" class="form-control" value="0.01">--}%
                %{--<span class="input-group-addon">元</span>--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</div>--}%

                <div class="list-group-item disabled form-group">
                    <div class="lineDiv">
                        <h2 class="title"><b>分润</b></h2>
                    </div>
                %{--<label class="col-xs-12 text-center" style="color: red;margin-bottom: 10px;">(平台利润:米酷商城所得利润&nbsp;&nbsp;可分利润:可分给代理商的利润基数)</label>--}%
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">平台利润</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="itemProfitFee" class="form-control" placeholder="平台利润" id="itemProfitFee">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span id="lrtipcontent"></span>
                        <span id="lrtipfalg" class="hide"></span>
                        <span class="tipeHide" id="itemProfitFeeTip">请写入对应平台利润</span>
                    </div>



                    <label class="col-xs-2 control-label">可分利润<span style="color: red">*</span>:</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="itemShareFee" class="form-control" placeholder="可分利润" readonly>
                            <span class="input-group-addon">元</span>
                        </div>
                    </div>

                </div>




                <div id="mikuItemShareContent">
                    %{--<div class="form-group">--}%
                    %{--<label class="col-xs-2 control-label">品牌</label>--}%
                    %{--<div class="col-xs-3">--}%
                    %{--<input type="text" name="pingpai" class="form-control" placeholder="品牌" value="优理氏">--}%
                    %{--</div>--}%
                    %{--</div>--}%
                </div>

                <div class="list-group-item disabled form-group"  id="mstitle">
                    <div class="lineDiv">
                        <h2 class="title"><b>描述</b></h2>
                    </div>
                </div>
                %{--lineDiv--}%
                %{--<div class="form-group">--}%
                %{--<hr/>--}%
                %{--</div>--}%

                <div id="categroyDescription"></div>
                <input type="text" name="descriptionjson" class="hide" id="descriptionjson"/>

                %{--<div class="list-group-item form-group">--}%
                    %{--<label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>特别说明</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="pingpai" class="form-control" placeholder="特别说明" value="优理氏">--}%
                    %{--</div>--}%

                    %{--<label class="col-xs-2 control-label"><i class="fa fa-suitcase"></i>功效</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="gongxiao" class="form-control" placeholder="功效" value="美肤美白">--}%
                        %{--<input type="text" name="gongxiao" class="form-control" placeholder="功效">--}%
                    %{--</div>--}%
                %{--</div>--}%

                %{--<div class="list-group-item form-group">--}%
                    %{--<label class="col-xs-2 control-label"><i class="fa fa-smile-o"></i>适用人群</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="adpterpersons" class="form-control" placeholder="适用人群" value="年青人">--}%
                        %{--<input type="text" name="adpterpersons" class="form-control" placeholder="适用人群">--}%
                    %{--</div>--}%


                    %{--<label class="col-xs-2 control-label"><i class="fa fa-warning"></i>保质期</label>--}%

                    %{--<div class="col-xs-3" style="width: 235px">--}%
                        %{--<input type="text" name="baozhiqi" class="form-control" placeholder="保质期">--}%
                        %{--<input type="text" name="baozhiqi" class="form-control" placeholder="保质期" value="2年">--}%
                    %{--</div>--}%
                %{--</div>--}%

                <div class="list-group-item form-group">

                    <label class="col-xs-2 control-label"><i class="fa fa-flask"></i>规格<span style="color: red">*</span>:</label>

                    <div class="col-xs-3" style="width: 235px">
                        %{--<input value="${(purchase?.specNum ?: 0) / 100f + (purchase?.specification ?: '')}"--}%
                        <input value=""
                               type="text" name="specification" class="form-control" placeholder="规格">
                    </div>
                </div>


                <div class="list-group-item disabled form-group">
                    <div class="lineDiv">
                        <h2 class="title"><b>详情</b></h2>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">商品描述</label>

                    <div class="col-xs-8">
                        <textarea name="description" class="form-control" rows="5">化妆品</textarea>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">视频链接</label>

                    <div class="col-xs-8">
                        <input type="text" name="video" class="form-control"
                               placeholder="视频链接" value="http://baidu.com">
                        %{--placeholder="视频链接">--}%
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-sm-2 control-label">图文详情</label>

                    <div class="col-sm-8">
                        <div id="uploader2" class="queueList">
                            <!--用来存放item-->
                            <ul id="fileList2" class="filelist">
                            </ul>

                            <div id="filePicker2">选择图片</div>
                        </div>
                    </div>
                </div>

                <input type="text" name="frJson" id="frJson" class="hide"/>
                %{--<div class="form-group">--}%
                %{--<label class="col-sm-2 control-label"><i class="fa fa-tag">属性标签:</i></label>--}%

                %{--<div class="col-sm-8">--}%
                %{--<div class="input-group" style="width: 235px">--}%
                %{--<g:each in="${tags}" var="tag" status="i">--}%
                %{--<input type="radio" name="attributeTag" value="${tag?.id}">${tag?.tagText}--}%
                %{--</g:each>--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</div>--}%

                %{--<div class="form-group">--}%
                %{--<label class="col-xs-2 control-label" style="color: #ff0000">*发布完上架</label>--}%

                %{--<div class="col-xs-3">--}%
                %{--<div class="input-group" style="width: 235px">--}%
                %{--<g:checkBox name="makeOnSale" class="input-sm jstree-checkbox"/>--}%
                %{--</div>--}%
                %{--</div>--}%

                %{--<label class="col-xs-2 control-label" style="color: orangered">*上架数量</label>--}%

                %{--<div class="col-xs-3">--}%
                %{--<div class="input-group" style="width: 235px">--}%
                %{--<input name="num" class="form-control" style="width: 100px" value="12"/>--}%
                %{--<input name="num" class="form-control" style="width: 100px"/>--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</div>--}%


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label" >库存<span style="color: red">*</span></label>

                    <div class="col-xs-3">
                        <input name="num" class="form-control" placeholder="库存"  value="0" />
                        %{--<input name="num" class="form-control" style="width: 100px"/>--}%
                        <span class="tipeHide" id="numTip">请写入对应库存</span>
                    </div>

                    <label class="col-xs-2 control-label" >销售基数<span style="color: red">*</span></label>

                    <div class="col-xs-3">
                        <input type="text" name="soldquantity" class="form-control"  placeholder="销售基数" value="0" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">发布完上架</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <g:checkBox name="makeOnSale" class="input-sm jstree-checkbox"/>
                        </div>
                    </div>


                    <label class="col-xs-2 control-label">是否可退货</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <g:checkBox name="isrefund" class="input-sm jstree-checkbox" />
                        </div>
                    </div>
                </div>

            %{--<div class="list-group-item form-group inputSeac">--}%
                %{--<label class="col-xs-2 control-label">这里这里</label>--}%
                %{--<div class="col-xs-3 row">--}%
                    %{--<input type="text" class="form-control " id="aa" placeholder="品牌"/>--}%
                    %{--<div class="searchBox hide" style="height: 120px; overflow-y: auto">--}%
                        %{--<dl>--}%
                            %{--<g:each status="i" in="${mikuBrandList}" var="list">--}%
                                %{--<dd targetValue="${list.id}">${list.name}</dd>--}%
                            %{--</g:each>--}%
                        %{--</dl>--}%
                        %{--<div class="close">×</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%





            </div>

            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit" id="fbBtn">发布</button>
                    <button class="btn btn-default" type="reset">取消</button>
                </div>
            </div><!-- /.box-footer-->
        </g:form>

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
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>


    $('.inputSeac').on('input','#aa',function(){
        $('.searchBox').addClass('show').removeClass('hide');
        if($(this).val() == ''){
            $('.searchBox').addClass('hide').removeClass('show');
        }
    }).on('click','.searchBox dl dd',function(){
        $(this).parents('.brandRow').find('.form-control').val($(this).text());
        $("#tagetBrand").val($(this).attr("targetValue"));
        $('.searchBox ').addClass('hide');
    }).on('click','.searchBox .close',function(){
        $(this).parent('.searchBox').addClass('hide').removeClass('show');
    }).on('focus','.searchInput',function(){
        $('.searchBox ').removeClass('hide').find('dd').show();
    }).on('keyup','.searchInput',function(){
        $keytext=new RegExp($('.searchInput').val());
        $('.searchBox ').removeClass('hide');

        var $allmobli=$('.searchBox dl dd');
        for(var lz=0;lz<$allmobli.length;lz++){
            var $deptcontent=$($allmobli[lz]).text();
            //进行文字的匹配
            if($keytext.test($deptcontent)){
                $($allmobli[lz]).addClass('show').removeClass('hide');
            }else{
                $($allmobli[lz]).addClass('hide').removeClass('show');
            }
        }
        if($('.searchBox dl').find('.show').length == 0){
            //$('.searchBox ').addClass('hide').removeClass('show');
//            $('.searchBox dl').append('<dd>没有这个哦</dd>');
        }
    }).on('click','.inputClose',function(){
        $('.searchInput').val('');
        $('.searchBox ').removeClass('hide').find('dd').show();
    })


    //$('#aa').on('focus',function(){
//        alert(0);
//        $('.searchBox').addClass('show').removeClass('hide');
//        if($(this).val() == ''){
//            $('.searchBox').addClass('hide').removeClass('show');
//        }
//    })





    //*************************************************
    var ids=[];

    //进行分润的处理
    $("input[name=itemProfitFee]").on("change",function(){
        //销售价
        var xsprice=$("input[name=price]").val().trim();
        //成本价
        var cbprice=$("input[name=purchasingPrice]").val().trim();
        //平台利润
        var ptlr=$("input[name=itemProfitFee]").val();
        if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice) && ptlr && !isNaN(ptlr)){
            var sumlr=parseFloat(xsprice)-parseFloat(cbprice);
            var newptlr=sumlr-parseFloat(ptlr);
            if(sumlr<0 || newptlr<0){
                $("input[name=itemShareFee]").val(0);
                $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                lrtipcontent.html("请填入对应的平台利润").css("color","red");
                lrtipfalg.html("0");
            }else{
                $("input[name=itemShareFee]").val(newptlr);
//                if(sumlr<ptlr){
//                    //新的需求：1.如果平台利润大于1块
//                    $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
//                    if(sumlr>1){
//                        $("input[name=itemShareFee]").val(1);
//                        $("input[name=itemProfitFee]").val((sumlr-1).toFixed(2));
//                    }else{
//                        $("input[name=itemShareFee]").val(sumlr);
//                        $("input[name=itemProfitFee]").val(0);
//                    }
//                }else{
//                    $("input[name=itemProfitFee]").val(ptlr.toFixed(2));
//                    $("input[name=itemShareFee]").val((sumlr-ptlr).toFixed(2));
//                }
                $("#lrtipfalg").html("1");
            }
        }






//        if(xsprice &&　cbprice　&& ptlr){
//            getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//        }
        %{--//提示对象--}%
        %{--var lrtipcontent=$("#lrtipcontent");--}%
        %{--var lrtipfalg=$("#lrtipfalg");--}%
        %{--debugger;--}%
        %{--if(!ptlr && isNaN(ptlr))--}%
        %{--{--}%
        %{--lrtipcontent.html("请填入对应的平台利润").css("color","red");--}%
        %{--lrtipfalg.html("0");--}%
        %{--frAllContent.html("");--}%
        %{--return;--}%
        %{--}--}%
        %{--//进行计算值--}%
        %{--var sylr=parseFloat(xsprice)-parseFloat(cbprice)-parseFloat(ptlr);--}%
        %{--var frAllContent=$("#mikuItemShareContent");--}%
        %{--if(!isNaN(ptlr) && sylr>=0)--}%
        %{--{--}%
        %{--$("input[name=itemShareFee]").val(sylr);--}%
        %{--//进行查询所有等级--}%
        %{--$.ajax({--}%
        %{--url: '<g:createLink controller="mikuItemSharePara" action="getAllFrLevel"/>', // remote datasource--}%
        %{--type: 'POST',--}%
        %{--success: function (data) {--}%
        %{--ids=[];--}%
        %{--var arr=eval(data);--}%
        %{--var allStr="";--}%
        %{--for(var i=0;i<arr.length;i++)--}%
        %{--{--}%
        %{--allStr+=getOneDiv(arr[i],sylr);--}%
        %{--ids.push(arr[i].id);--}%
        %{--}--}%
        %{--frAllContent.html(allStr);--}%
        %{--lrtipfalg.html("1");--}%
        %{--lrtipcontent.html("");--}%
        %{--}, error: function (data) {--}%
        %{--$("#frAllContent").html("");--}%
        %{--lrtipcontent.html("无法分润,请找管理员...").css("color","red");--}%
        %{--frAllContent.html("");--}%
        %{--lrtipfalg.html("0");--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--else{--}%
        %{--var num=parseFloat(xsprice)-parseFloat(cbprice);--}%
        %{--lrtipcontent.html("请填入少于"+num+"元的平台利润").css("color","red");--}%
        %{--lrtipfalg.html("0");--}%
        %{--frAllContent.html("");--}%
        %{--}--}%



    });

    function getOneDiv(obj,sum)
    {
//        var pricenum=sum*(obj.defaultShareScale)*0.01;
        var str="<div class='form-group' style='padding-left:45%;'>";
        str+="<label class='col-xs-2 control-label'>";
        str+=obj.levelName;
        str+="</label><div class='col-xs-5'><div class='input-group'><span class='input-group-addon'><i class='fa fa-rmb'></i></span>";
        str+="<input type='text' name='id"+obj.id+"' id='id"+obj.id+"' value='"+obj.defaultShareScale+"' titlecontent='"+obj.levelName+"'  class='form-control'>" ;
        str+="<span class='input-group-addon'>"+"%"+"</span>";
        str+="</div></div></div>";
        return str;
    }

    //进行提交
    $("#fbBtn").on('click',function(){



        debugger;
        //主图的限制
        var itemmainpic=$("input[name=item-pic]");
        if(itemmainpic && itemmainpic.length>10)
        {
            alert("主图只能上传10张");
            return false;
        }
        if(itemmainpic.length==0)
        {
            alert("至少需要上传一张主图.");
            $("#MainImgTip").show();
            return false;
        }
        //详情图的限制
        var deilPic=$("input[name=detail-pic]");
        if(deilPic && deilPic.length>60)
        {
            alert("详情图只能上传60张");
            return false;
        }

        //进行对各项限制
        var tipflag=showAllTips();
        if(!tipflag){
            alert("请填入对应的必填字段...");
            return false;
        }


        var arrstr=[];
        //标示的计算
//        var flag=$("#lrtipfalg");
//        var frsum=0;
//        if(ids.length &&　flag.html().trim()=="1")
//        {
//            //标示的为小数
//            var  pointflg=0;
//            for(var i=0;i<ids.length && pointflg==0;i++)
//            {
//                var oneobj={};
//                oneobj.id=ids[i];
//                oneobj.value=$("#id"+ids[i]).val();
//                oneobj.title=$("#id"+ids[i]).attr("titlecontent");
//                var percent=$("#id"+ids[i]).val();
////                if(percent.indexOf(".")==(-1) && !isNaN(parseInt(percent)))
//                if(!isNaN(parseFloat(percent)))
//                {
//                    frsum+=parseInt(percent);
//                    arrstr.push(oneobj);
//                }
//                else{
//                    pointflg=1;
//                }
//            }
//
//            if(pointflg)
//            {
//                alert("请填入的分润等级的百分比例.");
//                return false;
//            }
//            $("#frJson").val(JSON.stringify(arrstr));
//            //进行可分利润的计算
////            var itemShareFee=$("input[name=itemShareFee]").val();
////            if(itemShareFee && parseFloat(itemShareFee)>=frsum.toFixed(2))
////            if(frsum<=100)
////            {
////                $("#frJson").val(JSON.stringify(arrstr));
////            }
////            else{
//////                alert("各级分润的金额大于可分利润");
////                alert("各级分润的比例大于100%");
////                return false;
////            }
//        }
//        else
//        {
//            alert("请选择填写对应的分润...");
//            return false;
//        }

        //商品属性进行json的封装
        $("#descriptionjson").val(dobeJson());

    });

    //进行对各项限制
    function showAllTips()
    {
        //全部都隐藏
        $(".tipeHide").hide();
        //主图的提示隐藏
        $("#MainImgTip").hide();

        //[input]
        //var arr=["title","code","purchasingPrice","referencePrice","price","itemProfitFee","num"];
        var inputarr=["title","code","purchasingPrice","referencePrice","price","itemProfitFee","num","newcgprice","postFee"];
        //[select]
        var selectarr=["level1Category","category"];
        var inputnumarr=[];
        var selectnumarr=[];
        //进行校验 input
        for(var i=0;i<inputarr.length;i++){
            var content=$("input[name="+inputarr[i]+"]").val();
            if(!content){
                inputnumarr.push(i);
            }
        }
        //进行校验 select
        for(var i=0;i<selectarr.length;i++){
            var content=$("select[name="+selectarr[i]+"]").val();
            if(content=="-1" || !content){
                selectnumarr.push(i);
            }
        }
        //遍历进行处理对应的dom[input]
        for(var j=0;j<inputnumarr.length;j++){
            $("#"+inputarr[inputnumarr[j]]+"Tip").show();
        }

        //遍历进行处理对应的dom[select]
        for(var j=0;j<selectnumarr.length;j++){
            $("#"+selectarr[selectnumarr[j]]+"Tip").show();
        }


        if(inputnumarr.length>0 || selectnumarr.length>0){
            return false;
        }else{
            return true;
        }
    }




    //*************************************************

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
    });

    $("#purchaseTitle").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: '<g:createLink controller="purchasesManger" action="searchByTitle"/>', // remote datasource
                data: request,
                type: 'POST',
                success: function (data) {
                    response(data); // set the response
                }, error: function (data) { // handle server errors
                    console.log(data)
                }
            });
        },
        messages: {
            noResults: '',
            results: function () {
            }
        },
        minLength: 1, // triggered only after minimum 2 characters have been entered.
        select: function (event, ui) { // event handler when user selects a company from the list.
            console.log($('#purchaseId').val())
            console.log(ui.item.id)
            $('#purchaseId').val(ui.item.id); // update the hidden field.
            getprice(ui.item.id)
            console.log($('#purchaseId').val())
        }
    }).addClass("form-control").removeClass("ui-autocomplete-input");

    function getprice(id) {

        $.ajax({
            url: '<g:createLink controller="purchasesManger" action="getTitleById"/>', // remote datasource
            data: {'id': id},
            type: 'POST',
            success: function (data) {
                $('#purchasingPrice').val(data);
            }, error: function (data) { // handle server errors
                $('#purchasingPrice').val(data);
            }
        });
    }

    $('.dropdown-toggle').dropdown()

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


    //二级类目改变之后就出现的是对应的类目属性
    $('#category').on("change",function(){
        var id = $(this).val()
        $.ajax({
            url: '<g:createLink controller="itemCategory" action="queryOneCategoryContent"/>', // remote datasource
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                var features=data.data.features;
                ContentStrToPing(features);

                //进行添加对应的元素
                buildThirdCategory(data.list);
            }, error: function (data) { // handle server errors

            }
        });
    });



    $("#decrease").click(function () {
        var now = $("#num").val();
        now = now * 1 - 1
        if (now > 0) {
            $("#num").val(now);
        }
    });
    $("#insert").click(function () {
        var now = $("#num").val();
        now = now * 1 + 1
        if (now > 0) {
            $("#num").val(now);
        }
    });

    //销售价与采购价进行分润的控制
    //销售价
    $("#xsprice").on("change",function(){
        //销售价
        var xsprice=$("input[name=price]").val();
        //成本价
        var cbprice=$("input[name=purchasingPrice]").val();
        //参考价
        if(xsprice && !isNaN(xsprice) )
        {
//            $("input[name=referencePrice]").val((parseFloat(xsprice)*1.5).toFixed(2));
        }
        //===Add=====//
        var type=$("select[name=type]").val();
        if(type=="1" || type=="10"){
            //添加对应的默认值
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
                //原来的需求是总利润的百分之10
//                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))*0.1).toFixed(1));

                //now：如果销售价的百分之10，如果这个值大于利润的话，则可分利润为0  否则利润值为总利润-平台利润
                var sumlr=parseFloat(xsprice)-parseFloat(cbprice);
                var ptlr=(parseFloat(xsprice))*0.1;
                if(sumlr<0){
                    $("input[name=itemShareFee]").val(0);
                    $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                    lrtipcontent.html("请填入对应的平台利润").css("color","red");
                    lrtipfalg.html("0");
                }else{
                    if(sumlr<ptlr){
                        //新的需求：1.如果平台利润大于1块
                        $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                        if(sumlr>1){
                            $("input[name=itemShareFee]").val(1);
                            $("input[name=itemProfitFee]").val((sumlr-1).toFixed(2));
                        }else{
                            $("input[name=itemShareFee]").val(sumlr.toFixed(2));
                            $("input[name=itemProfitFee]").val(0);
                        }
                    }else{
                        $("input[name=itemProfitFee]").val(ptlr.toFixed(2));
                        $("input[name=itemShareFee]").val((sumlr-ptlr).toFixed(2));
                    }
                    $("#lrtipfalg").html("1");
                }
            }
            //平台利润
            var ptlr=$("input[name=itemProfitFee]").val();
            //修改3者的变化
//            if(xsprice &&　cbprice　&& ptlr){
//                getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//                $("#mikuItemShareContent").hide();
//            }
        }else if(type=="9"){
            //itemShareFee
            //添加对应的默认值
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
//                $("input[name=itemShareFee]").val(10);
                $("input[name=itemShareFee]").val(50);
                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))-50).toFixed(1));
                //平台利润
                var ptlr=$("input[name=itemProfitFee]").val();
                if(ptlr>0){
                    //修改3者的变化
//                    if(xsprice &&　cbprice　&& ptlr){
//                        getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//                        $("#mikuItemShareContent").hide();
//                    }
                }else{
                    var lrtipcontent=$("#lrtipcontent");
                    var lrtipfalg=$("#lrtipfalg");
                    lrtipcontent.html("请填入对应的平台利润").css("color","red");
                    lrtipfalg.html("0");
                    frAllContent.html("");
                    return;
                }

            }
        }
        //===Add=====//



    });







    //成本价
    $('#purchasingPrice').on("change",function(){

        //销售价
        var xsprice=$("input[name=price]").val();
        //成本价
        var cbprice=$("input[name=purchasingPrice]").val();
        //平台利润
        var ptlr=$("input[name=itemProfitFee]").val();
        var type=$("select[name=type]").val();
        if(type=="1" || type=="10"){
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
//                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))*0.1).toFixed(1));
                //now：如果销售价的百分之10，如果这个值大于利润的话，则可分利润为0  否则利润值为总利润-平台利润
                var sumlr=parseFloat(xsprice)-parseFloat(cbprice);
                var ptlr=(parseFloat(xsprice))*0.1;
                if(sumlr<0){
                    $("input[name=itemShareFee]").val(0);
                    $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                    lrtipcontent.html("请填入对应的平台利润").css("color","red");
                    lrtipfalg.html("0");
                }else{
                    if(sumlr<ptlr){
                        //新的需求：1.如果平台利润大于1块
                        $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                        if(sumlr>1){
                            $("input[name=itemShareFee]").val(0);
                            $("input[name=itemProfitFee]").val((sumlr-1).toFixed(2));
                        }else{
                            $("input[name=itemShareFee]").val(sumlr);
                            $("input[name=itemProfitFee]").val(0);
                        }
                    }else{
                        $("input[name=itemProfitFee]").val(ptlr.toFixed(2));
                        $("input[name=itemShareFee]").val((sumlr-ptlr).toFixed(2));
                    }
                    $("#lrtipfalg").html("1");
                }
            }
//            if(xsprice &&　cbprice　&& ptlr){
//                getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//                $("#mikuItemShareContent").hide();
//            }
        }
        else if(type="9"){
            //添加对应的默认值
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
//                $("input[name=itemShareFee]").val(10);
                $("input[name=itemShareFee]").val(50);
                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))-50).toFixed(1));
//                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))-10).toFixed(1));
                //平台利润
                var ptlr=$("input[name=itemProfitFee]").val();
                if(ptlr>0){
                    //修改3者的变化
//                    if(xsprice &&　cbprice　&& ptlr){
//                        getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//                        $("#mikuItemShareContent").hide();
//                    }
                }else{
                    $("#mikuItemShareContent").hide();
                    var lrtipcontent=$("#lrtipcontent");
                    var lrtipfalg=$("#lrtipfalg");
                    lrtipcontent.html("请填入对应的平台利润").css("color","red");
                    lrtipfalg.html("0");
                    frAllContent.html("");
                    return;
                }
            }
        }

        //成本价
//        var cbprice=$("input[name=purchasingPrice]").val();
//        //参考价
//        if(cbprice && !isNaN(parseFloat(cbprice))){
//            $("input[name=price]").val((parseFloat(cbprice)*1.5).toFixed(2));
//        }
//        //销售价
//        var xsprice=$("input[name=price]").val();
//        //添加对应的默认值
//        if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
//        {
//            $("input[name=itemProfitFee]").val((parseFloat(xsprice)*0.1).toFixed(1));
//        }
//        //平台利润
//        var ptlr=$("input[name=itemProfitFee]").val();
//        if(xsprice &&　cbprice　&& ptlr){
//            getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//        }
    });

    //分润ajax的调用
    function getChaangePriceAajxContent(xsprice,cbprice,ptlr){
        //提示对象
        var lrtipcontent=$("#lrtipcontent");
        var lrtipfalg=$("#lrtipfalg");
        //对应的商品类型
        var type=$("select[name=type]").val();
        debugger;
        if(!ptlr && isNaN(ptlr))
        {
            lrtipcontent.html("请填入对应的平台利润").css("color","red");
            lrtipfalg.html("0");
            frAllContent.html("");
            return;
        }
        //进行计算值
        var sylr=parseFloat(xsprice)-parseFloat(cbprice)-parseFloat(ptlr);
        var frAllContent=$("#mikuItemShareContent");
        if(!isNaN(ptlr) && sylr>=0)
        {
            if(type=="1" || type=="10"){
                $("input[name=itemShareFee]").val(sylr.toFixed(2));
            }
            //进行查询所有等级
            $.ajax({
                %{--url: '<g:createLink controller="mikuItemSharePara" action="getAllFrLevel"/>', // remote datasource--}%
                url: '/mikuItemSharePara/getAllFrLevel', // remote datasource
                data:{"type":type},
                type: 'POST',
                success: function (data) {
                    ids=[];
                    var arr=eval(data);
                    var allStr="";
                    for(var i=0;i<arr.length;i++)
                    {
                        allStr+=getOneDiv(arr[i],sylr);
                        ids.push(arr[i].id);
                    }
                    frAllContent.html(allStr);
                    lrtipfalg.html("1");
                    lrtipcontent.html("");
                }, error: function (data) {
                    $("#frAllContent").html("");
                    lrtipcontent.html("无法分润,请找管理员...").css("color","red");
                    frAllContent.html("");
                    lrtipfalg.html("0");
                }
            });
        }
        else{
            var num=parseFloat(xsprice)-parseFloat(cbprice);
            if(num>=0){
                lrtipcontent.html("请填入少于"+num+"元的平台利润").css("color","red");
                lrtipfalg.html("0");
                frAllContent.html("");
            }else{
                lrtipcontent.html("可分润金额小于0，无法分润").css("color","red");
                lrtipfalg.html("0");
                frAllContent.html("");
            }

        }

    }

    //进行字符串的拼接
    function ContentStrToPing(str){
        $("#mstitle").show();
        $("#categroyDescription").html("");
        var arr=str.split(" "),
             i = 0,
             htmlstr="<div class='list-group-item form-group'>";

        $.each(arr,function(index,content){
//            htmlstr+="<label class='col-xs-2 control-label'>";
            htmlstr+="<input  type='text' value='";
            htmlstr+=content;
//            htmlstr+="</label>";
            htmlstr+="' name='descriptionName'  style='background:transparent;'  class='col-xs-2 control-label no-border' >";
            htmlstr+="<div class='col-xs-3'>";
            htmlstr+="<input type='text' name='descriptionValue' class='form-control' placeholder='";
            htmlstr+=content;
            htmlstr+="'></div>";
            i++;
            if(i==arr.length){
                htmlstr+="</div>";
            }else{
                if(i>0 && i%2==0){
                    htmlstr+="</div>";
                    htmlstr+="<div class='list-group-item form-group'>";
                }
            }
        });
        $("#categroyDescription").append(htmlstr);
    }


    //对类目属性进行json处理
    function dobeJson(){
       var descriptionName = $("input[name=descriptionName]");
       var descriptionValue = $("input[name=descriptionValue]");
       var obj={};
       for(var i=0;i<descriptionName.length;i++){
           var name=$(descriptionName[i]).val();
           var value=$(descriptionValue[i]).val();
           obj[name]=value;
       }
        var aToStr = JSON.stringify(obj);
       return aToStr;
    }





    //商品类型：正常商品还是成为代理
    $("select[name=type]").change(function(){
        var type=$(this).val();
        if(type=="1" || type=="10"){
            $("input[name=itemProfitFee]").attr("readonly",false);
        }else if(type=="9"){
            $("input[name=itemProfitFee]").attr("readonly",true);
        }
    });



    //进行对采购价与邮费进行的比对
    //采购价
    $("#newcgprice").on('change',function(){
        cbAndPostFee();
    });
    //邮费
    $("#postFee").on('change',function(){
        cbAndPostFee();
    });


    //进行3级列表信息的获取
    function buildThirdCategory(data){
        if(data.length==0){
            $('#level3Category').find('option').remove();
            $('#level3Category').append('<option value="-1">请选择类目...</option>');
        }else{
            $.each(data, function (index, m) {
                $('#level3Category').append('<option value="' + m.id + '">' + m.name + '</option>');
            })
        }
    }


    //成本与邮费的分开
    function cbAndPostFee(){
        var newcgprice=$("#newcgprice").val();
        var postFee=$("#postFee").val();
        if(newcgprice && postFee){
            $("#purchasingPrice").val(parseFloat(newcgprice)+parseFloat(postFee));
        }

        //销售价
        var xsprice=$("input[name=price]").val();
        //成本价
        var cbprice=$("input[name=purchasingPrice]").val();
        //平台利润
        var ptlr=$("input[name=itemProfitFee]").val();
        var type=$("select[name=type]").val();
        if(type=="1" || type=="10"){
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
                //now：如果销售价的百分之10，如果这个值大于利润的话，则可分利润为0  否则利润值为总利润-平台利润
                var sumlr=parseFloat(xsprice)-parseFloat(cbprice);
                var ptlr=(parseFloat(xsprice))*0.1;
                if(sumlr<0){
                    $("input[name=itemShareFee]").val(0);
                    $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                    lrtipcontent.html("请填入对应的平台利润").css("color","red");
                    lrtipfalg.html("0");
                }else{
                    if(sumlr<ptlr){
                        //新的需求：1.如果平台利润大于1块
                        $("input[name=itemProfitFee]").val(sumlr.toFixed(2));
                        if(sumlr>1){
                            $("input[name=itemShareFee]").val(1);
                            $("input[name=itemProfitFee]").val((sumlr-1).toFixed(2));
                        }else{
                            $("input[name=itemShareFee]").val(sumlr.toFixed(2));
                            $("input[name=itemProfitFee]").val(0);
                        }
                    }else{
                        $("input[name=itemProfitFee]").val(ptlr.toFixed(2));
                        $("input[name=itemShareFee]").val((sumlr-ptlr).toFixed(2));
                    }
                    $("#lrtipfalg").html("1");
                }

            }
        }
        else if(type="9"){
            //添加对应的默认值
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
                $("input[name=itemShareFee]").val(50);
                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))-50).toFixed(1));
                //平台利润
                var ptlr=$("input[name=itemProfitFee]").val();
                if(ptlr>0){
                    //修改3者的变化
                }else{
                    $("#mikuItemShareContent").hide();
                    var lrtipcontent=$("#lrtipcontent");
                    var lrtipfalg=$("#lrtipfalg");
                    lrtipcontent.html("请填入对应的平台利润").css("color","red");
                    lrtipfalg.html("0");
                    frAllContent.html("");
                    return;
                }
            }
        }
    }


</script>

</body>

</html>

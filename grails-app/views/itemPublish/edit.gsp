<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.apache.commons.lang3.StringUtils; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>

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
        height: 10px;
        margin: 20px 0;
    }

    .title
    {
        position: absolute;
        width: 200px;
        height: 30px;
        text-align: center;
        left: 50%;
        top: -3px;
        background-color: #fff;
        margin-left: -100px;
        font-size: large;
        font-weight: 200;
    }

    </style>


    <style type="text/css" >
    .tipeHide{display: none;color: red}

    </style>

</head>

<body>


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
                        <div class="input-group" style="width: 235px">
                        <g:select optionKey="key" optionValue="value" name="type" value="${item.type}"
                                  class="form-control" from="${itemTypeList}"
                        />
                        </div>
                    </div>


            <label class="col-xs-2 control-label">是否免税</label>

            <DIV class="col-xs-3">
                <DIV class="input-group" style="width: 235px">
                    <g:if test="${item.isTaxFree==1 as byte}">
                        <g:checkBox name="isTaxFree" class="input-sm jstree-checkbox"  checked="true"/>
                    </g:if>
                    <g:else>
                        <g:checkBox name="isTaxFree" class="input-sm jstree-checkbox" />
                    </g:else>

                </DIV>
            </div>


            </div>

                <div class="form-group" style="display: none">
                    <input name="id" value="${item.id}">
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-list-ul"></i>一级目录<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <g:select optionKey="id" optionValue="name" name="level1Category"
                                  class="form-control" from="${categoryList}" value="${parentId}"
                                  noSelection="['-1': '请选择一级目录...']"/>
                        <span class="tipeHide" id="level1CategoryTip">请选择一级目录</span>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-list"></i>二级目录<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <select id="category" class="form-control" name="category">
                            <option value="-1">请选择二级目录</option>
                        </select>
                        <span class="tipeHide" id="categoryTip">请选择二级目录</span>
                    </div>
                </div>

                <div class="list-group-item form-group">

                    <label class="col-xs-2 control-label"><i class="fa fa-list-ul"></i>三级目录<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <select id="level3Category" class="form-control" name="level3Category">
                            <option value="-1">请选择三级目录</option>
                        </select>
                        <span class="tipeHide" id="level3CategoryTip">请选择三级目录</span>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-list"></i>品牌<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <g:select optionKey="id" optionValue="name" name="brandId" value="${item.brandId}"
                                  class="form-control" from="${mikuBrandList}"
                                  noSelection="['': '请选择品牌']"/>
                        <span class="tipeHide" id="brandIdTip">请选择品牌</span>
                    </div>


                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>商品主图<span style="color: red">*</span>:</label>

                    <div class="col-sm-8">
                        %{--<!--dom结构部分-->--}%
                        <div id="uploader" class="queueList">

                            <!--用来存放item-->

                            <ul id="fileList" class="filelist">
                                <g:each status="i" in="${StringUtils.split(item.picUrls, ';')}" var="picUrl">
                                    <li id="WU_FILE_11${i}" class="state-complete">
                                        <p class="title"></p>

                                        <p class="imgWrap">
                                            <img src="${picUrl}">
                                            <input name="item-pic" value="${picUrl}" style="display: none">
                                        </p>

                                        <div class="file-panel">
                                            <span class="cancel">删除</span>
                                            <span class="rotateLeft">向左移动</span>
                                            <span class="rotateRight">向右移动</span>
                                        </div>
                                        <span class="success"/>
                                    </li>
                                </g:each>
                            </ul>

                            <div id="filePicker">选择图片</div>
                        </div>
                        <span style="display:none;color:red" id="MainImgTip">至少上传一张选择商品主图</span>
                    </div>
                </div>




                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>标题<span style="color: red">*</span>:</label>

                    <div class="col-xs-8">
                        <input type="text" name="title" class="form-control" value="${item.title}">
                        <span class="tipeHide" id="titleTip">请写入对应的标题</span>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">搜索关键字</label>

                    <div class="col-xs-8">
                        <input type="text" name="keyWord" class="form-control" value="${item.keyWord}"
                               placeholder="搜索关键字" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>商品编码</label>

                    <div class="col-xs-3">
                        <input type="text" name="code" class="form-control" placeholder="商品编码" value="${item.code}">
                        <span class="tipeHide" id="codeTip">请写入对应商品编码</span>
                    </div>

                    <label class="col-sm-2 control-label"><i class="fa fa-sort-numeric-asc">权重:</i></label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                        &nbsp;
                            <g:if test="${item.weight!=null}">
                                <input type="text" placeholder="数量" value="${item.weight}" id="num" name="weight"
                                       readonly style="width: 30px">
                            </g:if>
                            <g:if test="${item.weight==null}">
                                <input type="text" placeholder="数量" value="9" id="num" name="weight"
                                       readonly style="width: 30px">
                            </g:if>
                            <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                        </div>
                    </div>

                    %{--<label class="col-xs-2 control-label"><i class="fa fa-list"></i>品牌</label>--}%

                    %{--<div class="col-xs-3">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="brandId" value="${item.brandId}"--}%
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
                                   value="${(item.cgprice?:0)/100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="newcgpriceTip">请写入对应商品编码</span>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-money"></i>邮费<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="tel" name="postFee" class="form-control" id="postFee" value="${(item.postFee?:0)/ 100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="postFeeTip">请写入对应参考价</span>
                    </div>
                </div>




                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-truck"></i>成本价</label>

                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>

                            <input type="text" id="purchasingPrice" name="purchasingPrice" class="form-control" readonly
                                   value="${(JSON.parseObject(item?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                    </div>

                    <label class="col-xs-2 control-label"><i class="fa fa-money"></i>参考价</label>

                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="referencePrice" class="form-control"
                                   value="${(JSON.parseObject(item?.features)?.getLongValue('referencePrice') ?: 0) / 100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="referencePriceTip">请写入对应参考价</span>
                    </div>
                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-gavel"></i>建议销售价</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="price" class="form-control" id="xsprice"
                                   value="${(item.price ?: 0) / 100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="priceTip">请写入对应销售价</span>
                    </div>

                    %{--<label class="col-xs-2 control-label"><i class="fa fa-flask"></i>规格</label>--}%

                    %{--<div class="col-xs-3">--}%
                    %{--<input type="text" name="specification" class="form-control"--}%
                    %{--value="${item.specification}">--}%
                    %{--</div>--}%
                </div>



                <div class="lineDiv">
                    <h2 class="title"><b>分润</b></h2>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"></i>平台利润<span style="color: red">*</span>:</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="itemProfitFee" class="form-control" placeholder="平台利润" id="itemProfitFee" value="${itemSharePara.itemProfitFee?(itemSharePara.itemProfitFee/100f):0}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span id="lrtipcontent"></span>
                        <span id="lrtipfalg" class="hide">1</span>
                        <span class="tipeHide" id="itemProfitFeeTip">请写入对应平台利润</span>
                    </div>



                    <label class="col-xs-2 control-label"></i>可分利润</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="itemShareFee" class="form-control" placeholder="可分利润" readonly value="${itemSharePara.itemShareFee/100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                    </div>

                </div>

                <div id="mikuItemShareContent">

                </div>

                <div class="lineDiv">
                <h2 class="title"><b>描述</b></h2>
                </div>

                %{--<div class="list-group-item disabled form-group"  id="mstitle">--}%
                    %{--<div class="lineDiv">--}%
                        %{--<h2 class="title"><b>描述</b></h2>--}%
                    %{--</div>--}%
                %{--</div>--}%
                %{--lineDiv--}%
                %{--<div class="form-group">--}%
                %{--<hr/>--}%
                %{--</div>--}%

                <div id="categroyDescription"></div>
                <span class="hide" id="itemfeatures">${item?.features}</span>
                <input type="text" name="descriptionjson" class="hide" id="descriptionjson"/>


                %{--<div class="lineDiv">--}%
                    %{--<h2 class="title"><b>描述</b></h2>--}%
                %{--</div>--}%

                %{--<div class="form-group">--}%
                    %{--<label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>特别说明</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="pingpai" class="form-control" placeholder="特别说明" value="${JSON.parseObject(item?.features)?.get('ext')?.get('特别说明') ?: '无'}">--}%
                    %{--</div>--}%

                    %{--<label class="col-xs-2 control-label"><i class="fa fa-suitcase"></i>功效</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="gongxiao" class="form-control" placeholder="功效" value="${JSON.parseObject(item?.features)?.get('ext')?.get('功效') ?: '无'}">--}%
                    %{--</div>--}%
                %{--</div>--}%

                %{--<div class="form-group">--}%
                    %{--<label class="col-xs-2 control-label"><i class="fa fa-smile-o"></i>适用人群</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="adpterpersons" class="form-control" placeholder="适用人群" value="${JSON.parseObject(item?.features)?.get('ext')?.get('适用人群') ?: '无'}">--}%
                    %{--</div>--}%


                    %{--<label class="col-xs-2 control-label"><i class="fa fa-warning"></i>保质期</label>--}%

                    %{--<div class="col-xs-3" style="width: 235px">--}%
                        %{--<input type="text" name="baozhiqi" class="form-control" placeholder="保质期" value="${JSON.parseObject(item?.features)?.get('ext')?.get('保质期') ?: '无'}">--}%
                    %{--</div>--}%
                %{--</div>--}%


                <div class="list-group-item form-group">

                    <label class="col-xs-2 control-label"><i class="fa fa-flask"></i>规格<span style="color: red">*</span>:</label>

                    <div class="col-xs-3" style="width: 235px">
                        %{--<input value="${(purchase?.specNum ?: 0) / 100f + (purchase?.specification ?: '')}"--}%
                        <input value="${item.specification}"
                               type="text" name="specification" class="form-control" placeholder="份">
                    </div>
                </div>



                <div class="lineDiv">
                    <h2 class="title"><b>详情</b></h2>
                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">商品描述</label>

                    <div class="col-xs-8">
                        <textarea name="description" class="form-control"
                                  rows="5">${item.description}</textarea>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">视频链接</label>

                    <div class="col-xs-8">
                        <input type="text" name="video" class="form-control" value="${item.video}">
                    </div>
                </div>



                <div class="list-group-item form-group">
                    <label class="col-sm-2 control-label">图文详情</label>

                    <div class="col-sm-8">
                        <div id="uploader2" class="queueList">
                            <!--用来存放item-->
                            <ul id="fileList2" class="filelist">
                                <g:each status="i" in="${StringUtils.split(item.detail, ';')}" var="picUrl">
                                    <li id="WU_FILE_99${i}" class="state-complete">
                                        <p class="title"></p>

                                        <p class="imgWrap">
                                            <img src="${picUrl}">
                                            <input name="detail-pic" value="${picUrl}" style="display: none">
                                        </p>

                                        <div class="file-panel">
                                            <span class="cancel">删除</span>
                                            <span class="rotateLeft">向左移动</span>
                                            <span class="rotateRight">向右移动</span>
                                        </div>
                                        <span class="success"/>
                                    </li>
                                </g:each>
                            </ul>

                            <div id="filePicker2">选择图片</div>
                        </div>
                    </div>
                </div>

                %{--<div class="form-group">--}%
                %{--<label class="col-sm-2 control-label"><i class="fa fa-tag">属性标签:</i></label>--}%

                %{--<div class="col-sm-8">--}%
                %{--<div class="input-group" style="width: 235px">--}%
                %{--<g:each in="${tags}" var="tag" status="i">--}%
                %{--<g:if test="${tag?.id == oldTag?.id}">--}%
                %{--<input type="radio" name="attributeTag" value="${oldTag?.id}"--}%
                %{--checked>${oldTag?.tagText}--}%
                %{--</g:if>--}%
                %{--<g:if test="${tag?.id != oldTag?.id}">--}%
                %{--<input type="radio" name="attributeTag" value="${tag?.id}">${tag?.tagText}--}%
                %{--</g:if>--}%
                %{--</g:each>--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</div>--}%

                <input type="text" name="frJson" id="frJson" class="hide" value=""/>
                <input type="text" name="itemShareParaId"  class="hide" value="${itemSharePara.id}"/>
                <span id="frJsoncontent" class="hide">${itemSharePara.parameter}</span>

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
                %{--<input name="num" class="form-control" style="width: 100px"/>--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</div>--}%



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label" >库存<span style="color: red">*</span></label>

                    <div class="col-xs-3">
                        <div class="input-group">
                            <input name="num" class="form-control" value="${item.num}"/>
                            %{--<input name="num" class="form-control" style="width: 100px"/>--}%
                        </div>
                        <span class="tipeHide" id="numTip">请写入对应库存</span>
                    </div>

                    <label class="col-xs-2 control-label" >销售基数<span style="color: red">*</span></label>
                    <div class="col-xs-3">
                        <input type="text" name="soldquantity" class="form-control"  placeholder="销售基数" value="${item.baseSoldQuantity}">
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
                            <g:if test="${item.isrefund==1L}">
                                <g:checkBox name="isrefund" class="input-sm jstree-checkbox"  checked="true"/>
                            </g:if>
                            <g:else>
                                <g:checkBox name="isrefund" class="input-sm jstree-checkbox" />
                            </g:else>
                        </div>
                    </div>

                </div>




            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit"  id="fbBtn">发布</button>
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
    var ids=[];
    //*************************************************
    $(function(){
        //进行初始化的时候进行把对应的分润的信息进行
        var initFrdata=$("#frJsoncontent").html();
        var frAllContent=$("#mikuItemShareContent");
        var objs=eval(initFrdata);
        var allStr="";
        for(var i=0;i<objs.length;i++)
        {
            allStr+=initDiv(objs[i]);
            ids.push(objs[i].id);
        }
        frAllContent.html(allStr);


        //类目属性的初始化
        var itemfeatures=$("#itemfeatures").html();
        viewToPingInit(itemfeatures);
        $("#mikuItemShareContent").hide();

    });



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
            if(sumlr<0){
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
//                        $("input[name=itemShareFee]").val(sumlr.toFixed(2));
//                        $("input[name=itemProfitFee]").val(0);
//                    }
//                }else{
//                    $("input[name=itemProfitFee]").val(ptlr.toFixed(2));
//                    $("input[name=itemShareFee]").val((sumlr-ptlr).toFixed(2));
//                }
                $("#lrtipfalg").html("1");
            }
        }




        %{--//平台利润--}%
        %{--var ptlr=$("input[name=itemProfitFee]").val();--}%
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
            %{--debugger;--}%
            %{--var num=parseFloat(xsprice)-parseFloat(cbprice);--}%
            %{--lrtipcontent.html("请填入少于"+num+"元的平台利润").css("color","red");--}%
            %{--lrtipfalg.html("0");--}%
            %{--frAllContent.html("");--}%
        %{--}--}%



    });

    function initDiv(obj)
    {
        var str="<div class='form-group' style='padding-left:45%;'>";
        str+="<label class='col-xs-2 control-label'>";
        str+=obj.title;
        str+="</label><div class='col-xs-5'><div class='input-group'><span class='input-group-addon'><i class='fa fa-rmb'></i></span>";
        str+="<input type='text' name='id"+obj.id+"' id='id"+obj.id+"' value='"+obj.value+"' titlecontent='"+obj.title+"' class='form-control'>" ;
        str+="<span class='input-group-addon'>"+"%"+"</span>";
        str+="</div></div></div>";
        return str;
    }

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

//        var arrstr=[];
//        //标示的计算
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
//                if(!isNaN(parseFloat(percent)))
////                if(percent.indexOf(".")==(-1) && !isNaN(parseInt(percent)))
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



    //*************************************************


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
        var selectarr=["level1Category","category","brandId"];
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










    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
    });

    $('.dropdown-toggle').dropdown()

    $("[id^='WU_FILE_']").each(function () {

        var id = this.id
        var $btn = $(this).find('.file-panel')

        $(this).on('mouseenter', function () {
            $btn.stop().animate({height: 30});
        });

        $(this).on('mouseleave', function () {
            $btn.stop().animate({height: 0});
        });

        $btn.on('click', 'span', function () {

            var index = $(this).index(),
                    deg;

            switch (index) {
                case 0:
                    $('#' + id).remove()
                    return;
                case 1:
                    console.log(id)
                    moveDown($('#' + id))
                    break;
                case 2:
                    moveUp($('#' + id))
                    break;

            }

        });

        function moveUp($item) {
            $before = $item.prev();
            $item.insertBefore($before);
        }

        function moveDown($item) {
            $after = $item.next();
            $item.insertAfter($after);
        }
    });

    var first = true
    var firsttwo = true

    $('#level1Category').change(function () {
        var str = "";
        $("#level1Category option:selected").each(function () {
            $('#category').find('option').remove();
            $('#category').append('<option value="-1">请选择类目...</option>');
            $('#level3Category').find('option').remove();
            $('#level3Category').append('<option value="-1">请选择类目...</option>');
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
                        if (first) {
                            <g:if test="${item.category2_id}">
                            $('#category > option[value="${item.category2_id}"]').prop('selected', true);
                            </g:if>
                            first = false

                            $.ajax({
                                url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId"/>', // remote datasource
                                data: {'id': ${item.category2_id}},
                                type: "POST",
                                dataType: "json",
                                success: function (data) {
                                    $.each(data, function (index, m) {
                                        $('#level3Category').append('<option value="' + m.id + '">' + m.name + '</option>');
                                    })
                                    if(firsttwo){
                                        <g:if test="${item.categoryId}">
                                        $('#level3Category > option[value="${item.categoryId}"]').prop('selected', true);
                                        </g:if>
                                        firsttwo=false;
                                    }
                                }, error: function (data) { // handle server errors

                                }
                            });
                        }


                        %{--//3级进行联动--}%
                        %{--$('#category').change(function () {--}%
                            %{--var str = "";--}%
                            %{--$("#category option:selected").each(function () {--}%
                                %{--$('#level3Category').find('option').remove();--}%
                                %{--$('#level3Category').append('<option value="-1">请选择类目...</option>');--}%
                                %{--var id = $(this).val()--}%
                                %{--if (id != "-1" && id != '' && id != undefined) {--}%
                                    %{--$.ajax({--}%
                                        %{--url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId"/>', // remote datasource--}%
                                        %{--data: {'id': id},--}%
                                        %{--type: "POST",--}%
                                        %{--dataType: "json",--}%
                                        %{--success: function (data) {--}%
                                            %{--$.each(data, function (index, m) {--}%
                                                %{--$('#level3Category').append('<option value="' + m.id + '">' + m.name + '</option>');--}%
                                            %{--})--}%
                                            %{--if (first) {--}%
                                                %{--<g:if test="${item.categoryId}">--}%
                                                %{--$('#level3Category > option[value="${item.categoryId}"]').prop('selected', true);--}%
                                                %{--</g:if>--}%
                                                %{--first = false--}%
                                            %{--}--}%
                                        %{--}, error: function (data) { // handle server errors--}%

                                        %{--}--}%
                                    %{--});--}%
                                %{--}--}%
                            %{--});--}%
                        %{--}).trigger('change');--}%

                    }, error: function (data) { // handle server errors

                    }
                });
            }
        });
    }).trigger('change');









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
        if(type=="1"  || type=="10"){
            //添加对应的默认值
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
//                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))*0.1).toFixed(1));
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
//            //平台利润
//            var ptlr=$("input[name=itemProfitFee]").val();
//            //修改3者的变化
//            if(xsprice &&　cbprice　&& ptlr){
//                getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//            }
        }else if(type=="9"){
            //itemShareFee
            //添加对应的默认值
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
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
                    $("#mikuItemShareContent").hide();
                    return;
                }

            }
        }
        //===Add=====//
    });



//    //销售价与采购价进行分润的控制
//    //销售价
//    $("#xsprice").on("change",function(){
//        //销售价
//        var xsprice=$("input[name=price]").val();
//        //成本价
//        var cbprice=$("input[name=purchasingPrice]").val();
//
//        //添加对应的默认值
//        if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
//        {
//            $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))*0.1).toFixed(1));
//        }
//        //参考价
//        if(xsprice && !isNaN(xsprice) )
//        {
////            $("input[name=referencePrice]").val((parseFloat(xsprice)*1.5).toFixed(2));
//        }
//
//        //平台利润
//        var ptlr=$("input[name=itemProfitFee]").val();
//        if(xsprice &&　cbprice　&& ptlr){
//            getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//        }
//
//
//    });

    //成本价
    $('#purchasingPrice').on("change",function(){
        //销售价
        var xsprice=$("input[name=price]").val();
        //成本价
        var cbprice=$("input[name=purchasingPrice]").val();
        //平台利润
        var ptlr=$("input[name=itemProfitFee]").val();
        if(type=="1"  || type=="10"){
            if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
            {
//                $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))*0.1).toFixed(1));
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
//            if(xsprice &&　cbprice　&& ptlr){
//                getChaangePriceAajxContent(xsprice,cbprice,ptlr);
//            }
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
                    if(xsprice &&　cbprice　&& ptlr){
                        getChaangePriceAajxContent(xsprice,cbprice,ptlr);
                        $("#mikuItemShareContent").hide();
                    }
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
//        //成本价
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
            if(type=="1"  || type=="10"){
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
    %{--function getChaangePriceAajxContent(xsprice,cbprice,ptlr){--}%
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
                %{--url: '/mikuItemSharePara/getAllFrLevel', // remote datasource--}%
                %{--data:{"type":type},--}%
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
            %{--if(num>=0){--}%
                %{--lrtipcontent.html("请填入少于"+num+"元的平台利润").css("color","red");--}%
                %{--lrtipfalg.html("0");--}%
                %{--frAllContent.html("");--}%
            %{--}else{--}%
                %{--lrtipcontent.html("可分润金额小于0，无法分润").css("color","red");--}%
                %{--lrtipfalg.html("0");--}%
                %{--frAllContent.html("");--}%
            %{--}--}%

        %{--}--}%

    %{--}--}%


    //当edit页面进行修改的时候[页面初始化]
    //参数为feature参数
    function viewToPingInit(str){
        var data=JSON.parse(str);
        var htmlstr="<div class='list-group-item form-group'>";
        var objattrsize= 0,y=0;
        if(data){
            data=data.ext;
            //这个对对象属性的遍历
            for(var i in data){
                objattrsize++;
            }
            for(var i in data){
                y++;
                htmlstr+="<input  type='text' value='";
                htmlstr+=i;
                htmlstr+="' name='descriptionName'  style='background:transparent;'  class='col-xs-2 control-label no-border' >";
                htmlstr+="<div class='col-xs-3'>";
                htmlstr+="<input type='text' name='descriptionValue' class='form-control' value='";
                htmlstr+=data[i];
                htmlstr+="'></div>";
                if(y==objattrsize){
                    htmlstr+="</div>";
                }else{
                    if(y>0 && y%2==0){
                        htmlstr+="</div>";
                        htmlstr+="<div class='list-group-item form-group'>";
                    }
                }
            }
            $("#categroyDescription").append(htmlstr);
        }

    }





    //进行字符串的拼接[初始化的时候]
    function ContentStrToPing(str){
        $("#mstitle").show();
        $("#categroyDescription").html("");
        var arr=str.split(" "),
                i = 0,
                htmlstr="<div class='list-group-item form-group'>";

        $.each(arr,function(index,content){
            htmlstr+="<input  type='text' value='";
            htmlstr+=content;
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



    //商品类型：正常商品还是成为代理
    $("select[name=type]").change(function(){
        var type=$(this).val();
        if(type=="1"  || type=="10"){
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
        if(type=="1"  || type=="10"){
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

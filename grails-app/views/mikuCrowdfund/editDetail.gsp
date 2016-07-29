<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/23
  Time: 10:48
--%>
<%@ page import="org.joda.time.DateTime;org.apache.commons.lang3.StringUtils; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>


    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <asset:stylesheet src="skins/skin-blue.css"/>
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
    .hide{display: none}
    </style>

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
        支持项名称: ${title}
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>众筹管理</a></li>
        <li class="active">众筹配置:新增支持项</li>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="list">页面列表</g:link>
                    </li>
                    <li>
                        <g:link action="add">新增众筹</g:link>
                    </li>
                    <li class="active">
                        <a href="/mikuCrowdfund/set?id=${id}&title=${title}">支持项配置</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="row">
            <div class='col-xs-12'>
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li>
                            <a href="/mikuCrowdfund/set?id=${id}&title=${title}">支持项列表</a>
                        </li>
                        <li  class="active">
                            <a href="/mikuCrowdfund/addDetail?id=${id}&title=${title}">新增支持项</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <g:form name="item_form" useToken="true" action="toBeOneDetailData">
            <div class="box-header">
            </div>
            <input type="text" name="id" class="form-control"  value="${item.id}" style="display:none;">
            <input type="text" name="cid" class="form-control"  value="${id}" style="display:none;">
            <input type="text" name="ctitle" class="form-control"  value="${title}"  style="display:none;">
            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>支持项主图<span style="color: red">*</span>:</label>

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
                        <span style="display:none;color:red" id="MainImgTip">至少上传一张选择支持项主图</span>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>支持项名称<span style="color: red">*</span></label>

                    <div class="col-xs-8">
                        <input type="text" name="title" class="form-control" value="${item.title}"
                               placeholder="众筹商品名称" >
                        <span class="tipeHide" id="titleTip">请写入对应的支持项名称</span>
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
                    <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>支持项编码<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <input type="text" name="code" class="form-control" placeholder="支持项编码"  value="${item.code}">
                        <span class="tipeHide" id="codeTip">请写入对应支持项编码</span>
                    </div>


                    <label class="col-sm-2 control-label"><i class="fa fa-sort-numeric-asc">权重:</i></label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                            &nbsp;
                            <input type="text" placeholder="权重"  id="num" name="weight"  value="${item.weight}"
                                   readonly style="width: 30px">
                            <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                        </div>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-truck"></i>采购价<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" id="purchasingPrice" name="purchasingPrice" class="form-control"
                                   value="${(JSON.parseObject(item?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="purchasingPriceTip">请写入对应采购价</span>
                    </div>
                    <label class="col-xs-2 control-label"><i class="fa fa-gavel"></i>支持价<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="price" class="form-control"  id="xsprice"  value="${(item.price ?: 0) / 100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="priceTip">请写入对应支持价</span>
                    </div>
                </div>

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
                            <input type="text" name="itemProfitFee" class="form-control" placeholder="平台利润" id="itemProfitFee"  value="${itemSharePara.itemProfitFee/100}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span id="lrtipcontent"></span>
                        <span id="lrtipfalg" class="hide">1</span>
                        <span class="tipeHide" id="itemProfitFeeTip">请写入对应平台利润</span>
                    </div>



                    <label class="col-xs-2 control-label">可分利润<span style="color: red">*</span>:</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="itemShareFee" class="form-control" placeholder="可分利润" readonly value="${itemSharePara.itemShareFee/100}">
                            <span class="input-group-addon">元</span>
                        </div>
                    </div>

                </div>




                <div id="mikuItemShareContent">

                </div>

                <div class="list-group-item disabled form-group"  id="mstitle">
                    <div class="lineDiv">
                        <h2 class="title"><b>描述</b></h2>
                    </div>
                </div>

                <div id="categroyDescription"></div>
                <input type="text" name="descriptionjson" class="hide" id="descriptionjson"/>
                <div class="list-group-item form-group">

                    <label class="col-xs-2 control-label"><i class="fa fa-flask"></i>规格<span style="color: red">*</span>:</label>

                    <div class="col-xs-3" style="width: 235px">
                        %{--<input value="${(purchase?.specNum ?: 0) / 100f + (purchase?.specification ?: '')}"--}%
                        <input
                               type="text" name="specification" class="form-control" value="${item.specification}">
                    </div>
                </div>


                <div class="list-group-item disabled form-group">
                    <div class="lineDiv">
                        <h2 class="title"><b>详情</b></h2>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label" >限量数<span style="color: red">*</span></label>

                    <div class="col-xs-3">
                        <input name="num" class="form-control" placeholder="限量数"  value="${item.num}"/>
                        %{--<input name="num" class="form-control" style="width: 100px"/>--}%
                        <span class="tipeHide" id="numTip">请写入对应限量数</span>
                    </div>

                    <label class="col-xs-2 control-label" >基础支持数<span style="color: red">*</span></label>

                    <div class="col-xs-3">
                        <input type="text" name="soldquantity" class="form-control"  placeholder="基础支持数" value="${item.baseSoldQuantity}" >
                    </div>
                </div>


                <input type="text" name="frJson" id="frJson" class="hide" value=""/>
                <input type="text" name="itemShareParaId"  class="hide" value="${itemSharePara.id}"/>
                <span id="frJsoncontent" class="hide">${itemSharePara.parameter}</span>


                %{--<div class="list-group-item form-group">--}%
                    %{--<label class="col-xs-2 control-label">回报说明</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="returnContent" class="form-control" value="${item.returnContent}"--}%
                               %{--placeholder="回报说明" >--}%
                        %{--<span class="tipeHide" id="returnContentTip">请写入对应回报说明</span>--}%
                    %{--</div>--}%
                    %{--<label class="col-xs-2 control-label">风险提示</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<input type="text" name="riskTips" class="form-control" value="${item.riskTips}"--}%
                               %{--placeholder="风险提示" >--}%
                        %{--<span class="tipeHide" id="riskTipsTip">请写入对应风险提示</span>--}%
                    %{--</div>--}%
                %{--</div>--}%

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">是否显示</label>
                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px">
                            <g:if test="${item.approveStatus==1 as byte}">
                                <g:checkBox name="makeOnSale" class="input-sm jstree-checkbox"  checked="true"/>
                            </g:if>
                            <g:else>
                                <g:checkBox name="makeOnSale" class="input-sm jstree-checkbox" />
                            </g:else>
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

                %{--<div class="list-group-item form-group">--}%
                    %{--<label class="col-xs-2 control-label">是否免税</label>--}%

                    %{--<div class="col-xs-3">--}%
                        %{--<div class="input-group" style="width: 235px">--}%
                            %{--<g:if test="${item.isTaxFree==1 as byte}">--}%
                                %{--<g:checkBox name="isTaxFree" class="input-sm jstree-checkbox"  checked="true"/>--}%
                            %{--</g:if>--}%
                            %{--<g:else>--}%
                                %{--<g:checkBox name="isTaxFree" class="input-sm jstree-checkbox" />--}%
                            %{--</g:else>--}%

                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">回报说明</label>

                    <div class="col-xs-8">
                        <textarea name="returnContent" class="form-control" rows="3">${item.returnContent}</textarea>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">风险提示</label>

                    <div class="col-xs-8">
                        <textarea name="riskTips" class="form-control" rows="3">${item.riskTips}</textarea>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">商品描述</label>

                    <div class="col-xs-8">
                        <textarea name="description" class="form-control" rows="2">${item.description}</textarea>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">特别说明</label>

                    <div class="col-xs-8">
                        <textarea name="specialNote" class="form-control" rows="2">${item.specialNote}</textarea>
                    </div>
                </div>



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

    //*************************************************
    var ids=[];

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
        if(xsprice &&　cbprice　&& ptlr){
            getChaangePriceAajxContent(xsprice,cbprice,ptlr);
        }

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
//
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
//        $("#descriptionjson").val(dobeJson());

    });

    //进行对各项限制
    function showAllTips()
    {
        //全部都隐藏
        $(".tipeHide").hide();
        //主图的提示隐藏
        $("#MainImgTip").hide();
        //var arr=["title","code","purchasingPrice","referencePrice","price","itemProfitFee","num"];
//        var inputarr=["title","returnContent","riskTips","code","purchasingPrice","price","itemProfitFee","num"];
        var inputarr=["title","code","purchasingPrice","price","itemProfitFee","num"];
        var inputnumarr=[];
        //进行校验 input
        for(var i=0;i<inputarr.length;i++){
            var content=$("input[name="+inputarr[i]+"]").val();
            if(!content){
                inputnumarr.push(i);
            }
        }
        //遍历进行处理对应的dom[input]
        for(var j=0;j<inputnumarr.length;j++){
            $("#"+inputarr[inputnumarr[j]]+"Tip").show();
        }
        if(inputnumarr.length>0){
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
            $("input[name=referencePrice]").val((parseFloat(xsprice)*1.5).toFixed(2));
        }

        //添加对应的默认值
        if(xsprice && cbprice && !isNaN(xsprice) && !isNaN(cbprice))
        {
            $("input[name=itemProfitFee]").val(((parseFloat(xsprice)-(parseFloat(cbprice)))*0.1).toFixed(1));
        }

        //平台利润
        var ptlr=$("input[name=itemProfitFee]").val();


        //修改3者的变化
        if(xsprice &&　cbprice　&& ptlr){
            getChaangePriceAajxContent(xsprice,cbprice,ptlr);
            $("#mikuItemShareContent").hide();
        }


    });

    //成本价
    $('#purchasingPrice').on("change",function(){

        //销售价
        var xsprice=$("input[name=price]").val();
        //成本价
        var cbprice=$("input[name=purchasingPrice]").val();
        //平台利润
        var ptlr=$("input[name=itemProfitFee]").val();
        if(xsprice &&　cbprice　&& ptlr){
            getChaangePriceAajxContent(xsprice,cbprice,ptlr);
            $("#mikuItemShareContent").hide();
        }

    });

    //分润ajax的调用
    function getChaangePriceAajxContent(xsprice,cbprice,ptlr){
        //提示对象
        var lrtipcontent=$("#lrtipcontent");
        var lrtipfalg=$("#lrtipfalg");
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
            $("input[name=itemShareFee]").val(sylr.toFixed(2));
            //进行查询所有等级
            $.ajax({
                %{--url: '<g:createLink controller="mikuItemSharePara" action="getAllFrLevel"/>', // remote datasource--}%
                url: '/mikuItemSharePara/getAllFrLevel', // remote datasource
                data:{"type":1},
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


</script>
</body>

</html>

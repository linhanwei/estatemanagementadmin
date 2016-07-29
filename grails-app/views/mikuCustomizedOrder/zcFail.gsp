<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 14/11/10
  Time: 下午1:20
--%>
<%@ page import="org.joda.time.DateTime;org.apache.commons.lang3.StringUtils" contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">

    <title>私人订制订单管理</title>
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
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- validation -->
    <asset:stylesheet src="bootstrapValidator/bootstrapValidator.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>

</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        待发货订单
        <small>订单管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>订单管理</a></li>
        <li class="active">待发货订单</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>

            <div class="nav-tabs-custom">

                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="nopay" controller="mikuCustomizedOrder">未付款</g:link></li>
                    <li><g:link action="zcSuccess" controller="mikuCustomizedOrder">未处理订单</g:link></li>
                    <li><g:link action="dfhuo" controller="mikuCustomizedOrder">待发货</g:link></li>
                    <li><g:link action="shipped" controller="mikuCustomizedOrder">已发货/待收货</g:link></li>
                    <li class="active"><g:link action="zcFail" controller="mikuCustomizedOrder">失败订单</g:link></li>
                    <li><g:link action="index" controller="mikuCustomizedOrder">全部订单(售后)</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">

                                <g:form action="zcFail" class="form-inline" useToken="true">
                                    <g:textField name="mapKey" style="display: none" value="${params.mapKey}"/>
                                    <table style="width:100%">
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label for="query">
                                                        <i class="fa fa-mobile-phone"></i>手机号码：
                                                    </label>
                                                    <input id="query" name="query" class="form-control"
                                                           data-inputmask='"mask": "999-9999-9999"'
                                                           data-mask="true"
                                                           value="${params.query}"
                                                           style="width: 120px"
                                                           placeholder="用户号码:"/>
                                                </div>


                                                <div class="form-group">
                                                    <label for="tradeCode">订单号：</label>
                                                    <input  name="tradeCode" class="form-control"
                                                            style="width: 190px" value="${params.tradeCode}"
                                                            placeholder="订单号"/>
                                                </div>


                                                <div class="form-group">
                                                    <label>请选择页码：</label>
                                                    <g:select optionKey="key" optionValue="value" name="max"
                                                              class="form-control" from="${PageMap}" value="${params.max}"
                                                              noSelection="['10': '请选择页码']"/>
                                                </div>
                                                <div class="form-group">

                                                    <button type="submit"
                                                            class="btn btn-primary"><i
                                                            class="fa fa-search" >查询</i></button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </g:form>
                            </div>

                            <div class="box-body table-responsive no-padding">
                                <g:form action="shipTradeChecked" params="${params}" id="shipBox">
                                    <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                                        <tr>
                                            <th><i class="fa fa-flag"></i>订单号</th>
                                            <th><i class="fa fa-clock-o"></i>下单时间</th>
                                            <th><i class="fa fa-user"></i>收货人</th>
                                            <th style="width: 17%"><i class="fa fa-map-marker"></i>地址</th>
                                            <th><i class="fa fa-money"></i>订单金额</th>
                                            <th style="width: 20%"><i class="fa fa-indent"></i>订单明细</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${tradeList}" var="trade">
                                                <tr id="${trade.tradeId}" class="info">
                                                    <th>
                                                        %{--TODO--}%
                                                        <a href="#"
                                                           onclick="lookTradeDetail('${trade.tradeId}');
                                                           return false;"
                                                           data-toggle="modal"
                                                           data-target="#tradeDetailModel">${trade.tradeId}
                                                        </a>
                                                        <g:if test="${trade.tradeMemo != null}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: brown">${"公司处理：" + trade?.tradeMemo}</span>
                                                            </div>
                                                        </g:if>
                                                        <g:if test="${trade.buyerMessage != null}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: orangered">${"用户要求：" + trade?.buyerMessage}</span>
                                                            </div>
                                                        </g:if>
                                                        <g:if test="${trade?.payType == 2 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: purple">货到付款</span>
                                                            </div>
                                                        </g:if>
                                                        <g:else>
                                                            <div style="padding-top: 10px">
                                                                <span style="color: mediumvioletred">已付款</span>
                                                            </div>
                                                        </g:else>

                                                        <g:if test="${trade?.shippingType == 1 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: cornflowerblue">用户自提</span>
                                                            </div>
                                                        </g:if>

                                                        <g:if test="${trade?.tradeFrom == 1 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">IOS</span>
                                                            </div>
                                                        </g:if>

                                                        <g:if test="${trade?.tradeFrom == 2 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">Android</span>
                                                            </div>
                                                        </g:if>

                                                        <g:if test="${trade?.tradeFrom == 3 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">微信</span>
                                                            </div>
                                                        </g:if>

                                                        <g:if test="${trade?.tradeFrom == 4 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">未知</span>
                                                            </div>
                                                        </g:if>
                                                    </th>
                                                    <th style="width: 110px"> ${new DateTime(trade?.dateCreated).toString("yyyy-MM-dd HH:mm:ss")}</th>
                                                    <th>
                                                        ${trade?.receiverName}
                                                        <div style="padding-top: 10px">
                                                            <i class="fa fa-mobile-phone"></i>:
                                                        ${trade?.receiverMobile}
                                                        </div>
                                                    </th>
                                                    <th>
                                                        ${trade?.address}
                                                    </th>
                                                    <th style="color: #ff0000">
                                                        ${"原价：" + trade.price / 100f}元
                                                        <g:if test="${trade.totalFee != null}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: brown">${"实付：" + trade.totalFee / 100 + "元"}</span>
                                                            </div>
                                                        </g:if>
                                                    </th>

                                                    <th>
                                                        ${trade?.info}
                                                    </th>
                                                    <th>
                                                        %{--//状态(-1=无效;0=正常;1=成功;2=失败)--}%
                                                        <g:if test="${trade?.mcstatus == 0 as byte}">
                                                            正常
                                                        </g:if>
                                                        <g:elseif test="${trade?.mcstatus == 1 as byte}">
                                                            成功
                                                        </g:elseif>
                                                        <g:elseif test="${trade?.mcstatus == 2 as byte}">
                                                            失败
                                                        </g:elseif>
                                                    </th>
                                                    <th>
                                                        <g:if test="${trade?.refundpayType == -1 as byte}">
                                                            不明支付
                                                        </g:if>
                                                        <g:elseif test="${trade?.refundpayType == 1 as byte && !(trade?.alipayNo.equals("") || trade?.alipayNo==null)}">
                                                            <button type="button" class="btn btn-success btn-sm"
                                                                    onclick="refundToGetMoneyByParames('${trade?.alipayNo}',${trade?.totalFee/100f},${trade?.tradeId},'${trade?.buyerMemo}')">
                                                                支付宝退款
                                                            </button>
                                                        </g:elseif>
                                                        <g:elseif test="${trade?.refundpayType == 2 as byte}">
                                                            <button type="button" class="btn btn-info btn-sm"
                                                                    onclick="wxRefund('${trade?.wxpayId}')">
                                                                [公众号]微信退款
                                                            </button>
                                                        </g:elseif>
                                                        <g:elseif test="${trade?.refundpayType == 3 as byte}">
                                                        %{--APP的微信版支付，暂不提供退款【给功能待定】--}%
                                                            <button type="button" class="btn btn-info btn-sm"
                                                                    onclick="appWxRefund('${trade?.wxpayId}')">
                                                                [APP]微信退款
                                                            </button>
                                                        </g:elseif>
                                                        <g:else>
                                                            不明支付
                                                        </g:else>
                                                    </th>
                                                </tr>

                                            </g:each>
                                        </g:if>
                                    </table>
                                </g:form>

                            </div><!-- /.box-body -->


                            <div class="box-footer clearfix">
                                <div class="total pull-left">
                                    <i class="fa fa-check"></i>共计
                                    <span style="color: red">${total}</span>个订单
                                </div>

                                <div class="pagination pull-right">
                                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                                maxsteps="10" action="zcFail" total="${viewTotal}"/>
                                </div>

                            </div>
                        </div><!-- /.box -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->


%{--表单的提交--}%
<g:form action="alipay"  method="post" target="_blank" class="hide" controller="mikuCrowdfund">
    <input size="30" name="WIDseller_email" value="service@unescn.com"/>
    <input size="30" name="WIDrefund_date" id="WIDrefund_date"/>
    <input size="30" name="WIDbatch_no" id="WIDbatch_no"/>
    <input size="30" name="WIDbatch_num" value="1"/>
    <input size="30" name="WIDbatch_tradeId" id="WIDbatch_tradeId"/>
    <input size="30" name="WIDdetail_data" id="WIDdetail_data"/>
    <input type="submit" id="aliPayBtn">
</g:form>

<div id="printerDiv" style="display:none"></div>
<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- InputMask -->
<asset:javascript src="input-mask/jquery.inputmask.js"/>
<asset:javascript src="input-mask/jquery.inputmask.date.extensions.js"/>
<asset:javascript src="input-mask/jquery.inputmask.extensions.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>


<script>


    function wxRefund(id){
        $.ajax({
            url: '/mikuCrowdfund/wxpayRefund',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert("退款成功...");
                $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                window.location.replace("/mikuCrowdfundTrade/zcFail");
            },
            error: function (data) {
                alert(data.responseText);
                $.sticky("调用微信接口失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    function appWxRefund(id){
        $.ajax({
            url: '/mikuCrowdfund/mikuAppwxpayRefund',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert("退款成功...");
                $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                window.location.replace("/mikuCrowdfundTrade/zcFail");
            },
            error: function (data) {
                alert(data.responseText);
                $.sticky("调用微信接口失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    function refundToGetMoneyByParames(alipayNo,totalFee,tradeId,buyerMemo){
        $("#WIDrefund_date").val(CurentTime(0));
        $("#WIDbatch_no").val(CurentTime(1));
        $("#WIDbatch_tradeId").val(tradeId);
        $("#WIDdetail_data").val(getDetail(alipayNo,totalFee,buyerMemo));
        $("#aliPayBtn").click();
    }

    function getDetail(alipayNo,totalFee,buyerMemo){
        var str=alipayNo;
        str+="^";
        str+=totalFee;
        str+="^";
        str+="退款";
        return str
    }


    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
//        var payType=$("#payType").val();
//        var totalFeeOp=$("#totalFeeOp").val();
//        var targetTotalFee=$("#targetTotalFee").val();
        var query=$("#query").val();
        var tradeCode=$("input[name=tradeCode]").val();
        var str='/mikuCrowdfundTrade/zcFail?max='+size+"&tradeCode="+tradeCode+"&query="+query;
        window.location.replace(str);
    });

    //flag为0的时候
    function CurentTime(flag)
    {
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        if(flag==0)
        {
            var clock = year + "-";
            if(month < 10)
                clock += "0";
            clock += month + "-";
            if(day < 10)
                clock += "0";
            clock += day + " ";
            if(hh < 10)
                clock += "0";
            clock += hh + ":";
            if (mm < 10) clock += '0';
            clock += mm;
            //秒
            clock+=":00";
            return(clock);
        }
        else
        {
            var clock = year;
            var content="";
            if(month < 10)
                clock += "0";
            clock += month;
            if(day < 10)
                clock += "0";
            clock += day;
            content=clock;
            clock +="10000";
            clock +=content;
            if(hh < 10)
                clock += "0";
            clock += hh;
            if (mm < 10) clock += '0';
            clock += mm;
            return(clock);
        }
    }





</script>
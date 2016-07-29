<%@ page import="org.apache.commons.lang3.StringUtils" contentType="text/html;charset=UTF-8" %>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">

    <title>平台支出</title>
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
        平台退款
        <small>平台支出</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>平台支出</a></li>
        <li class="active">平台退款</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="getRefund" controller="mikuPayMoney">平台退款详情</g:link></li>
                    <li><g:link action="getSharePay" controller="mikuPayMoney">平台分润提现支出</g:link></li>
                    <li><g:link action="index" controller="mikuPayMoney">平台支出详情</g:link></li>
                    <li><g:link action="list" controller="mikuPayMoney">平台统计信息</g:link></li>
                    <li><g:link action="operTradeData" controller="mikuPayMoney">统计</g:link></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                <g:form action="index" class="form-inline" useToken="true">
                                    <table style="width:100%">
                                        <tr>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">共${alipayNum+WxNum+AppWxNum}笔退款,共计${SumFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">${alipayNum}笔支付宝退款,共计${alipayFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">${WxNum}笔微信公众号退款,共计${WxFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">${AppWxNum}笔App微信支付退款,共计${AppWxFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                        </tr>
                                    </table>
                                </g:form>
                            </div>
                            <div class="box-body table-responsive no-padding">
                                <g:form action="changeSumGetPayStatusMethod" params="${params}"  id="shipBox">
                                    <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                                        <tr>
                                            <th><i class="fa fa-flag"></i>订单数</th>
                                            <th><i class="fa fa-flag"></i>类型</th>
                                            <th><i class="fa fa-clock-o"></i>退款人</th>
                                            <th><i class="fa fa-clock-o"></i>退款电话</th>
                                            <th ><i class="fa fa-map-marker"></i>退款金额</th>
                                            <th ><i class="fa fa-money"></i>退款项目</th>
                                            <th ><i class="fa fa-indent"></i>退款订单号</th>
                                            <th ><i class="fa fa-indent"></i>交易号</th>
                                            <th><i class="fa fa-flag"></i>退款时间</th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${list}" var="getPay">
                                                <tr id="${getPay.id}" class="info">
                                                    <th>${i+1}</th>
                                                    <th>
                                                        <g:if test="${getPay.payType == 1 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">支付宝</span>
                                                            </div>
                                                        </g:if>
                                                        <g:if test="${getPay.payType == 2 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">App微信支付</span>
                                                            </div>
                                                        </g:if>
                                                        <g:if test="${getPay.payType == 3 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #a47e3c">微信公众号支付</span>
                                                            </div>
                                                        </g:if>
                                                    </th>
                                                    <th >${getPay.info}</th>
                                                    <th >${getPay.courierMobile}</th>
                                                    <th>
                                                        ${(getPay?.price ?: 0) / 100f}元
                                                    </th>
                                                    <th style="word-wrap:break-word;white-space: normal;">
                                                        ${getPay.memo}
                                                    </th>
                                                    <th>
                                                        ${getPay.tradeId}
                                                    </th>
                                                    <th  style="word-wrap:break-word;white-space: normal;">
                                                        ${getPay.alipayNo}
                                                    </th>
                                                    <th style="color: #fb4c90;">
                                                        ${new DateTime(getPay.dateCreated).toString("yyyy-MM-dd HH:mm")}
                                                    </th>
                                                </tr>
                                            </g:each>
                                        </g:if>
                                    </table>
                                </g:form>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->
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
</script>
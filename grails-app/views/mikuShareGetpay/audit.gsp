<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2015/11/10
  Time: 12:08
--%>

<%@ page import="org.apache.commons.lang3.StringUtils" contentType="text/html;charset=UTF-8" %>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">

    <title>提现管理</title>
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
        未审核提现
        <small>提现管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>未审核提现</a></li>
        <li class="active">全部提现信息</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>

            <div class="nav-tabs-custom">

                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index" controller="mikuShareGetpay">未审核提现</g:link></li>
                    <li><g:link action="alipayindex" controller="mikuShareGetpay">支付宝未审核提现</g:link></li>
                    <li><g:link action="wxindex" controller="mikuShareGetpay">微信未审核提现</g:link></li>
                    <li><g:link action="allInfo" controller="mikuShareGetpay">全部提现</g:link></li>
                    <li class="active"><g:link action="audit" controller="mikuShareGetpay">审核数据</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                <g:form action="audit" class="form-inline" useToken="true">
                                    <table style="width:100%">
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label>分润记录ID:</label>
                                                    <input id="query" name="getpayId" class="form-control"
                                                           data-mask="true"
                                                           value="${params.getpayId}"
                                                           style="width: 120px"
                                                           placeholder="分润记录ID"/>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit"
                                                            class="btn btn-primary"><i
                                                            class="fa fa-search">查询</i></button>
                                                </div>

                                            </td>
                                        </tr>
                                    </table>
                                </g:form>
                            </div>

                            <div class="box-body table-responsive no-padding">
                                <g:form action="changeSumGetPayStatusMethod" params="${params}"  id="shipBox">
                                    <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                                        <g:if test="${proFitGetPay}">
                                        <tr>
                                            <td>分润账号id:${mikuAgencyShareAccount.id}</td>
                                            <td>总分润:${mikuAgencyShareAccount.totalShareFee/100f}</td>
                                            <td>提现当中数据:${mikuAgencyShareAccount.getpayingFee/100f}</td>
                                            <td colspan="2">已提现数据:${mikuAgencyShareAccount.totalGotpayFee/100f}</td>
                                        </tr>
                                        <tr>
                                            <td>用户名:${proFitGetPay.agencyNickname}</td>
                                            <td>用户手机号:${proFitGetPay.agencyMobile}</td>
                                            <td>金额:${proFitGetPay.getpayFee/100f}</td>
                                            <td>提现账户:${proFitGetPay.getpayAccount}</td>
                                            <td>提现方式:${auditstr}</td>
                                        </tr>
                                        <tr>
                                            <td>审核情况</td>
                                            <td colspan="4">
                                                ${str}
                                            </td>
                                        </tr>
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
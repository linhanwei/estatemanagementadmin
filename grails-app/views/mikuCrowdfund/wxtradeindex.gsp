<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/23
  Time: 10:48
--%>
<%@ page import="org.joda.time.DateTime;com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
        支付宝的退款操作
        <small>众筹管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>众筹</a></li>
        <li class="active">众筹</li>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">页面列表</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form action="index" class="form-inline">
                %{--<div class="form-group">--}%
                    %{--<label>页面名称：</label>--}%
                    %{--<input  name="name" class="form-control"--}%
                            %{--style="width: 190px" value="${params.name}"--}%
                            %{--placeholder="页面名称"/>--}%
                %{--</div>--}%

                    %{--<button type="submit"--}%
                            %{--class="btn btn-primary"><i--}%
                            %{--class="fa fa-search">查询</i></button>--}%
                %{--</div>--}%
            </g:form>
        </div>

        <div class="box-body table-responsive no-padding">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center text-justify">
                <tr>
                    <th><i class="fa fa-list-ul"></i>支付类型</th>
                    <th><i class="fa fa-list-ul"></i>交易号</th>
                    <th><i class="fa fa-reorder"></i>支付的金额</th>
                    <th><i class="fa fa-question-circle"></i>订单号</th>
                    <th><i class="fa fa-question-circle"></i>用户名称</th>
                    <th><i class="fa fa-question-circle"></i>联系号码</th>
                    <th><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${tradeList}" var="ml">
                        <tr id="${ml?.id}" class="info">
                            <td>
                                ${ml?.payType}
                                <g:if test=" ${ml?.payType == 3}">
                                    支付宝
                                </g:if>
                            </td>
                            <td class="alipayNo" value="${ml?.alipayNo}">
                                ${ml?.alipayNo}
                            </td>
                            <td calss="totalFee" value="${ml?.totalFee/100f}">
                                ${ml?.totalFee/100f}
                            </td>
                            <td class="tradeId" value="${ml?.tradeId}">
                                ${ml?.tradeId}
                            </td>
                            <td class="buyerMemo" value="${ml?.buyerMemo}">
                                ${ml?.buyerMemo}
                            </td>
                            <td>
                                ${ml?.promotion}
                            </td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="wxRefund('${ml?.categoryId}')">
                                    退款
                                </button>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
</section><!-- /.content -->

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>


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
                },
                error: function (data) {
                    alert(data.responseText);
                    $.sticky("调用微信接口失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
</script>
</body>
</html>
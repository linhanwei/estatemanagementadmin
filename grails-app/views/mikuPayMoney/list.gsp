<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2015/11/11
  Time: 16:48
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
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        平台统计信息
        <small>平台信息</small>
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="getRefund" controller="mikuPayMoney">平台退款详情</g:link></li>
                    <li><g:link action="getSharePay" controller="mikuPayMoney">平台分润提现支出</g:link></li>
                    <li><g:link action="index" controller="mikuPayMoney">平台支出详情</g:link></li>
                    <li class="active"><g:link action="list" controller="mikuPayMoney">平台统计信息</g:link></li>
                    <li><g:link action="operTradeData" controller="mikuPayMoney">统计</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>序号</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>说明</th>
                    <th style="width: 150px"></i>总数</th>
                    <th style="width: 150px"></i>总金额</th>
                </tr>
                <tr>
                    <td> 1</td>
                    <td>交易订单总数</td>
                    <td>${tradeSum}</td>
                    <td>${tradeFee/100f}</td>
                </tr>

                <tr>
                    <td> 2</td>
                    <td>分润总金额</td>
                    <td>${frsum}</td>
                    <td>${frfee/100f}</td>
                </tr>


                <tr>
                    <td>3</td>
                    <td>现提现金额总数</td>
                    <td>${ktxsum}</td>
                    <td>${ktxfee/100f}</td>
                </tr>


                <tr>
                    <td>4</td>
                    <td>支付宝提现总数</td>
                    <td>${alipaysum}</td>
                    <td>${alipayfee/100f}</td>
                </tr>

                <tr>
                    <td>5</td>
                    <td>微信提现总数</td>
                    <td>${wxktxsum}</td>
                    <td>${wxktxfee/100f}</td>
                </tr>

                <tr>
                    <td>6</td>
                    <td>支付宝审核中</td>
                    <td>${shalipaynum}</td>
                    <td>${shalipayfee/100f}</td>
                </tr>

                <tr>
                    <td>7</td>
                    <td>微信审核中</td>
                    <td>${shwxnum}</td>
                    <td>${shwxfee/100f}</td>
                </tr>

                <tr>
                    <td>8</td>
                    <td>支付宝已提现</td>
                    <td>${yjtxaliapaynum}</td>
                    <td>${yjtxaliapayfee/100f}</td>
                </tr>

                <tr>
                    <td>9</td>
                    <td>微信已提现</td>
                    <td>${yjtxwxnum}</td>
                    <td>${yjtxwxfee/100f}</td>
                </tr>


            </table>
        </div><!-- /.box-body -->
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
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>




<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>
    function midifyName(id){
        var content=$("#md"+id).val();
            $.ajax({
                url: '/mikuAgencyLevel/changeName',
                data: {'id': id, 'content': content},
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
</script>

</body>

</html>
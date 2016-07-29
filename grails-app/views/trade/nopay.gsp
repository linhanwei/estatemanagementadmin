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
        未付款订单
        <small>订单管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>订单管理</a></li>
        <li class="active">未付款订单</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="nopay" controller="trade">没付款</g:link></li>
                    <li><g:link action="index" controller="tradeNoShip">未处理</g:link></li>
                    <li><g:link action="index" controller="trade">待发货</g:link></li>
                    <li><g:link action="shipped" controller="trade">已发货/待收货</g:link></li>
                    <li><g:link action="allTrade" controller="trade">全部订单(售后)</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form action="nopay" class="form-inline">
                <table style="width:100%">
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>
                                    <i class="fa fa-mobile-phone"></i>手机号码：
                                </label>
                                <input id="query" name="query" class="form-control"
                                       data-inputmask='"mask": "999-9999-9999"'
                                       data-mask="true"
                                       value="${params.query}"
                                       style="width: 120px"
                                       placeholder="用户号码:"/>
                            </div>
                            %{--<div class="form-group">--}%
                                %{--<label>服务站点：</label>--}%
                                %{--<g:select optionKey="id" optionValue="name" name="communityId"--}%
                                          %{--value="${params.communityId}"--}%
                                          %{--class="form-control" from="${communityList}"--}%
                                          %{--noSelection="['': '服务站点：']"/>--}%
                            %{--</div>--}%

                            <div class="form-group">
                                <label>订单号：</label>
                                <input  name="tradeCode" class="form-control"
                                        style="width: 190px" value="${params.tradeCode}"
                                        placeholder="订单号"/>

                                <button type="submit"
                                        class="btn btn-primary"><i
                                        class="fa fa-search">查询</i></button>
                            </div>

                        </td>
                    </tr>
                </table>
            </g:form>
        </div>

        <div class="box-body">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th><i class="fa fa-flag"></i>订单号</th>
                    <th><i class="fa fa-user"></i>收货人</th>
                    <th style="width: 20%"><i class="fa fa-map-marker"></i>地址</th>
                    <th><i class="fa fa-money"></i>总价</th>
                    <th><i class="fa fa-clock-o"></i>下单时间</th>
                    <th>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${tradeList}" var="trade">
                        <tr id="${trade.id}" class="info">
                            <th>
                                <a href="#"
                                   onclick="lookTradeDetail('${trade.tradeId}');
                                   return false;"
                                   data-toggle="modal"
                                   data-target="#tradeDetailModel">${tradeMap.get(trade.id)?.tradeId}
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
                                <g:if test="${trade?.type == 2 as byte}">
                                    <div style="padding-top: 10px">
                                        <span style="color: purple">货到付款</span>
                                    </div>
                                </g:if>

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
                            <th>${tradeMap.get(trade.id)?.receiverName}
                                <div style="padding-top: 10px">
                                    <i class="fa fa-mobile-phone"></i>:${tradeMap.get(trade.id)?.receiverMobile}
                                </div>
                            </th>
                            <th>
                                ${tradeMap.get(trade.id)?.address}
                            </th>
                            <th style="color: #ff0000">${Long.parseLong(tradeMap.get(trade.id)?.totalPrice) / 100f}元</th>
                            <th>${tradeMap.get(trade.id)?.createTime}</th>
                            <th>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="cancelTradeInfoTOsd('${trade.tradeId}');return false; ">
                                    取消订单
                                </button>
                            </th>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <div class="total pull-left">
                <i class="fa fa-check"></i>共计
                <span style="color: red">${total}</span>个订单
            </div>

            <div class="pagination pull-right">
                <g:paginate next="下一页" prev="上一页" params="${params}"
                            maxsteps="10" action="nopay" total="${total}"/>
            </div>
        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->

<div class="modal fade bs-example-modal-lg" id="tradeDetailModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="tradeId">订单号：</h2>
            </div>

            <div class="modal-body">
                <div id="tradeDetail">
                    <g:render template="tradeDetail"/>
                </div>
            </div>

        </div>
    </div>
</div>



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



<script type="text/javascript">

    function lookTradeDetail(id) {
        $("#sendId").val(id)

        $("#tradeId").text('订单号:' + id)

        jQuery.ajax({
            type: 'POST', data: {'tradeId': id}, url: '/trade/lookTradeDetail', success: function (data, textStatus) {
                jQuery('#tradeDetail').html(data);
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    $("#query").inputmask();



   function cancelTradeInfoTOsd(id){
           $.ajax({
               url: '/trade/cancelOneTrade',
               data: {'id': id},
               type: "POST",
               dataType: "json",
               success: function (data) {
                   var str='/trade/nopay';
                   window.location.replace(str);
               },
               error: function (data) {
                   $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
               }
           });
   }

</script>

</body>

</html>
<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>

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
        全部订单
        <small>订单管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>订单管理</a></li>
        <li class="active">全部订单</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="nopay" controller="trade">没付款</g:link></li>
                    <li><g:link action="index" controller="tradeNoShip">未处理</g:link></li>
                    <li><g:link action="index" controller="trade">待发货</g:link></li>
                    <li><g:link action="shipped" controller="trade">已发货/待收货</g:link></li>
                    <li class="active"><g:link action="allTrade" controller="trade">全部订单(售后)</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form action="allTrade" class="form-inline">
                %{--<g:select optionKey="id" optionValue="name" name="communityId"--}%
                          %{--value="${params.communityId}"--}%
                          %{--class="form-control" from="${communityList}" noSelection="['': '选择站点']"/>--}%

                <div class="form-group">
                    <label>
                        <i class="fa fa-money"></i>订单状态：
                    </label>
                    <g:select optionKey="key" optionValue="value" name="queryStatus"
                              class="form-control" from="${statusList}"
                              value="${params.queryStatus}"
                              noSelection="['': '请选择订单状态']"/>
                </div><!-- /.input group -->

                <div class="form-group">
                    <label>下单时间：</label>
                    <div class="input-group no-padding">
                        <div class="input-group-addon">
                            <i class="fa fa-clock-o"></i>
                        </div><input value="${params.startTime}"
                                     name="startTime"
                                     class="form-control form_datetime"
                                     style="width: 130px"
                                     readonly/>
                    </div><!-- /.input group -->
                    <span>至</span>

                    <div class="input-group no-padding">
                        <div class="input-group-addon">
                            <i class="fa fa-clock-o"></i>
                        </div><input value="${params.endTime}"
                                     name="endTime"
                                     class="form-control form_datetime"
                                     style="width: 130px"
                                     readonly/>
                    </div><!-- /.input group -->
                </div>



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


                <div class="form-group">
                    <label>订单号：</label>
                    <input  name="tradeCode" class="form-control"
                            style="width: 190px" value="${params.tradeCode}"
                            placeholder="订单号"/>
                </div>

                <div class="form-group">
                    <label>请选择页码：</label>
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '请选择页码']"/>


                    <button type="submit"
                            class="btn btn-primary"><i
                            class="fa fa-search">查询</i></button>
                </div>
            </g:form>
            <div class="form-group">
                <button class="btn btn-primary btn-info " id="outExport">打印</button>
            </div>
        </div>

        <div class="box-body table-responsive no-padding">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center text-justify">
                <tr>
                    <th style="width: 130px"><i class="fa fa-flag"></i>订单号</th>
                    <th style="width: 120px"><i class="fa fa-user"></i>收货人</th>
                    <th style="width: 200px"><i class="fa fa-map-marker"></i>地址(支持修正)</th>
                    <th style="width: 80px"><i class="fa fa-money"></i>总价</th>
                    <th style="width: 135px"><i class="fa fa-clock-o"></i>下单时间</th>
                    <th style="width: 135px"><i class="fa fa-clock-o"></i>结束时间</th>
                    %{--<th style="width: 135px"><i class="fa fa-clock-o"></i>配送时间</th>--}%
                    <th style="width: 135px"><i class="fa fa-truck"></i>发货信息</th>
                    <th style="width: 80px"><i class="fa fa-truck"></i>状态</th>
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
                                <g:if test="${trade?.tradeMemo != null}">
                                    <div style="padding-top: 10px">
                                        <span style="color: brown">${"公司处理：" + trade?.tradeMemo}</span>
                                    </div>
                                </g:if>
                                <g:if test="${trade?.buyerMessage != null}">
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
                            <th style="color: #ff0000">
                                ${"原价：" + trade.price / 100f}元
                                <g:if test="${trade.totalFee != null}">
                                    <div style="padding-top: 10px">
                                        <span style="color: brown">${"实付：" + trade.totalFee / 100 + "元"}</span>
                                    </div>
                                </g:if>
                                %{--${Long.parseLong(tradeMap.get(trade.id)?.totalPrice) / 100f}元--}%
                            </th>
                            <th>${tradeMap.get(trade.id)?.createTime}</th>
                            <th>
                                ${trade.endTime?new org.joda.time.DateTime(trade.endTime).toString("yyyy-MM-dd HH:mm"):trade.endTime}
                            </th>
                            %{--<th>${tradeMap.get(trade.id)?.consignTime}</th>--}%
                            <th>
                            <g:if test="${tradeMap.get(trade.id)?.memo != null  && tradeMap.get(trade.id)?.memo!=""}">

                                <g:if test="${tradeMap.get(trade.id)?.buyerInfo}">
                                    ${tradeMap.get(trade.id)?.buyerInfo}
                                </g:if>
                                <g:else>
                                    ${JSON.parseObject(tradeMap.get(trade.id)?.memo)?.get('物流公司') ?: '无'}
                                    <div style="padding-top: 10px">
                                        <i class="fa fa-clock-o"></i>:${JSON.parseObject(tradeMap.get(trade.id)?.memo)?.get('物流单号') ?: ''}
                                    </div>
                                </g:else>

                            </g:if>
                            </th>
                            <g:if test="${tradeMap.get(trade.id)?.status == '2'}">
                                <th style="color: orange"><i class="fa fa-dollar"></i>没付款</th>
                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.status == '4'}">
                                <th style="color: #ff0000"><i class="fa fa-spinner"></i>未处理</th>
                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.status == '6'}">
                                <th style="color: orangered"><i class="fa fa-suitcase"></i>待发货</th>
                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.status == '5'}">
                                <th style="color: indigo"><i class="fa fa-truck"></i>配送中</th>
                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.status == '7'}">
                                <th style="color: limegreen"><i class="fa fa-check"></i>交易完成</th>
                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.status == '9'}">
                                <th style="color: #000000"><i class="fa fa-times"></i>已关闭</th>
                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.status == '20'}">
                                <th style="color: limegreen"><i class="fa fa-check"></i>交易完成,分润完成</th>
                            </g:if>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <div class="pull-left total">
                <i class="fa fa-check"></i>共计
                <span style="color: red">${total}</span>个订单
            </div>

            <div class="pagination pull-right">
                <g:paginate next="下一页" prev="上一页" params="${params}"
                            maxsteps="10" action="allTrade" total="${total}"/>
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


<g:form action="outPortAllExcelByTrade" controller="tradeNoShip" style="display: none;">
    <input type="text" name="type" value="20"/>
    %{--默认是全部的订单--}%
    <input type="text" name="status" id="targetStatus"/>
    <input type="submit"  id="outPortAllExcelByTradeFormsubmit">
</g:form>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- InputMask -->
<asset:javascript src="input-mask/jquery.inputmask.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>



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

    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });


    //进行页码数的分页
    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var startTime=$("input[name=startTime]").val();
        var endTime=$("input[name=endTime]").val();
        var query=$("#query").val();
        var tradeCode=$("input[name=tradeCode]").val();
        var queryStatus=$("#queryStatus").val();
        var str='/trade/allTrade?max='+size+"&startTime="+startTime+"&endTime="+endTime+"&tradeCode="+tradeCode+"&query="+query+"&queryStatus="+queryStatus;
        window.location.replace(str);
    });



    //打印各种类型
    $("#outExport").click(function(){
        $("#targetStatus").val($('#queryStatus').val());
        $("#outPortAllExcelByTradeFormsubmit").click();
    });


</script>

</body>

</html>
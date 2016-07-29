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
        待收货订单
        <small>订单管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>订单管理</a></li>
        <li class="active">待收货订单</li>
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
                <li class="active"><g:link action="shipped" controller="trade">已发货/待收货</g:link></li>
                <li><g:link action="allTrade" controller="trade">全部订单(售后)</g:link></li>
            </ul>
        </div>
    </div>
</div>

<!-- Default box -->
<div class="box">
<div class="box-header">
    <g:form action="shipped" class="form-inline">
        <table style="width:100%">
            <tr>
                <td>
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
                        <label>支付方式：</label>
                        %{--<g:select optionKey="id" optionValue="name" name="communityId"--}%
                        %{--value="${params.communityId}"--}%
                        %{--class="form-control" from="${communityList}"--}%
                        %{--noSelection="['': '服务站点：']"/>--}%

                        <g:select optionKey="key" optionValue="value" name="payType"
                                  value="${params.payType}"
                                  class="form-control" from="${payTypeMap?.entrySet()}"
                                  noSelection="['': '支付方式：']"/>
                    </div>



                    <div class="form-group">
                        <label>排序方式：</label>
                        <g:select optionKey="key" optionValue="value" name="order"
                                  value="${params.order ?: "-"}"
                                  class="form-control" from="${orderMap.entrySet()}"/>
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

                </td>
            </tr>

            %{--<tr>--}%
                %{--<td>--}%
                    %{--<g:select optionKey="id" optionValue="name" name="communityId"--}%
                              %{--value="${params.communityId}"--}%
                              %{--class="form-control" from="${communityList}"--}%
                              %{--noSelection="['': '服务站点：']"/>--}%

                    %{--<g:select optionKey="key" optionValue="value" name="payType"--}%
                              %{--value="${params.payType}"--}%
                              %{--class="form-control" from="${payTypeMap?.entrySet()}"--}%
                              %{--noSelection="['': '支付方式：']"/>--}%

                    %{--<g:select optionKey="key" optionValue="value" name="shippingType"--}%
                              %{--value="${params.shippingType}"--}%
                              %{--class="form-control" from="${shippingTypeMap?.entrySet()}"--}%
                              %{--noSelection="['': '配送方式：']"/>--}%
                %{--</td>--}%
            %{--</tr>--}%

            %{--<tr>--}%
                %{--<td>--}%
                    %{--排序方式：--}%
                    %{--<g:select optionKey="key" optionValue="value" name="orderEntry"--}%
                              %{--value="${params.orderEntry ?: "id"}"--}%
                              %{--class="form-control" from="${orderEntryMap.entrySet()}"/>--}%

                    %{--<g:select optionKey="key" optionValue="value" name="order"--}%
                              %{--value="${params.order ?: "-"}"--}%
                              %{--class="form-control" from="${orderMap.entrySet()}"/>--}%

                    %{--<button type="submit"--}%
                            %{--class="btn btn-primary"><i--}%
                            %{--class="fa fa-search">查询</i></button>--}%
                %{--</td>--}%
            %{--</tr>--}%

        </table>
    </g:form>
</div>

<div class="box-body clearfix">
    <g:form action="confirmTradeChecked" controller="trade" params="${params}">
        <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
            <tr>
                <th><i class="fa fa-flag"></i>订单号</th>
                <th><i class="fa fa-user"></i>收货人</th>
                <th style="width: 20%"><i class="fa fa-map-marker"></i>地址(支持修正)</th>
                <th><i class="fa fa-money"></i>总价</th>
                <th><i class="fa fa-clock-o"></i>下单时间</th>
                %{--<th><i class="fa fa-clock-o"></i>预约上门</th>--}%
                %{--<th><i class="fa fa-clock-o"></i>后台调度</th>--}%
                %{--<th><i class="fa fa-clock-o"></i>物流公司</th>--}%
                <th><i class="fa fa-truck"></i>发货信息</th>
                <th><i class="fa fa-hand-o-down"></i>操作
                    <label>
                        <input type="checkbox" id="checkAll">
                    </label>
                </th>
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
                            <g:if test="${tradeMap.get(trade.id)?.modifiAddr != null}">

                                <textarea class="addrTextArea" name="${trade.id}"
                                          onchange="modifyaddr('${trade.id}')"
                                          style="color:limegreen">${tradeMap.get(trade.id)?.modifiAddr}</textarea>

                            </g:if>
                            <g:if test="${tradeMap.get(trade.id)?.modifiAddr == null}">

                                <textarea class="addrTextArea" name="${trade.id}"
                                          onchange="modifyaddr('${trade.id}')"
                                          style="">${tradeMap.get(trade.id)?.address}</textarea>

                            </g:if>
                        </th>
                        <th style="color: #ff0000">
                            %{--${Long.parseLong(tradeMap.get(trade.id)?.totalPrice) / 100f}元--}%
                            ${"原价：" + trade.price / 100f}元
                            <g:if test="${trade.totalFee != null}">
                                <div style="padding-top: 10px">
                                    <span style="color: brown">${"实付：" + trade.totalFee / 100 + "元"}</span>
                                </div>
                            </g:if>
                        </th>
                        <th>${tradeMap.get(trade.id)?.createTime}</th>
                        %{--<th style="width: 110px">${tradeMap.get(trade.id)?.appointDeliveryTime}</th>--}%
                        %{--<th>${tradeMap.get(trade.id)?.consignTime}</th>--}%
                        %{--${JSON.parseObject(item?.features)?.get('ext')?.get('保质期') ?: '无'}--}%
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
                        %{--<th>--}%
                            %{--${tradeMap.get(trade.id)?.confirmTime}--}%
                            %{--${tradeMap.get(trade.id)?.courierName}--}%
                            %{--<div style="padding-top: 10px">--}%
                                %{--<i class="fa fa-clock-o"></i>:${tradeMap.get(trade.id)?.confirmTime}--}%
                            %{--</div>--}%
                        %{--</th>--}%
                        <th>
                            <label>
                                <input type="checkbox" name="tradeConfirmBox"
                                       value="${trade?.id}">
                            </label>
                        </th>
                    </tr>
                </g:each>
            </g:if>
        </table>

        <div class="pull-right order-handle">
            %{--<button onclick="return confirm('请确认客户真的..真的..真的..收到货！')" type="submit"--}%
                    %{--class="btn btn-sm btn-primary"><i--}%
                    %{--class="fa fa-truck"></i>批量确认!</button>--}%
            &nbsp;
            <button type="button" id="goCancel"
                    class="btn btn-sm  btn-primary pull-left"><i
                    class="fa fa-print">撤回到待发货</i></button>
            &nbsp;
        </div>
    </g:form>

    %{--撤销--}%
    <g:form action="goCancel"  style="display: none;">
        <input type="text" id="goCancelids" name="goCancelids" />
        <input type="submit"  id="goCancelsubmit">
    </g:form>

</div><!-- /.box-body -->
<div class="box-footer clearfix">
    <div class="total pull-left">
        <i class="fa fa-check"></i>共计
        <span style="color: red">${total}</span>个订单
    </div>

    <div class="pagination pull-right">
        <g:paginate next="下一页" prev="上一页" params="${params}"
                    maxsteps="10" action="shipped" total="${total}"/>
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


    //撤销
    $("#goCancel").click(function(){
        var tradeArr=[];
        $('input[name="tradeConfirmBox"]:checked').each(function (index, ele) {
            tradeArr.push($(this).val());
        });
        if(!tradeArr.length)
        {
            alert("请选中对应的订单信息");
            return;
        }
        $("#goCancelids").val(tradeArr.join(","));
        //进行表单的提交
        $("#goCancelsubmit").click();
    });

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    function modifyaddr(id) {
        $("textarea").each(function change() {
            if (id == this.name) {
                var modifyaddr = this.value
                $.ajax({
                    url: '/trade/modifyAddr',
                    data: {'id': id, 'modifyaddr': modifyaddr},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        $.sticky("修改地址成功", {autoclose: 2000, position: "top-center", type: "st-success"});
                    },
                    error: function (data) {
                        $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                    }
                });
            }
        });
    }

    $("input[name='tradeConfirmBox']").on('ifChecked', function (event) {
        var id = this.value
        $("input[name='exportBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('check');
            }
        });
    });

    $("input[name='tradeConfirmBox']").on('ifUnchecked', function (event) {
        var id = this.value
        $("input[name='exportBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('check');
            }
        });
    });

    $("#checkAll").on('ifChecked', function (event) {
        $("input[name='tradeConfirmBox']").each(function check() {
            $(this).iCheck('check');
        });
    });

    $("#checkAll").on('ifUnchecked', function (event) {
        $("input[name='tradeConfirmBox']").each(function check() {
            $(this).iCheck('uncheck');
        });

    });

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

    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });

    $("#query").inputmask();

    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var payType=$("#payType").val();
        var startTime=$("input[name=startTime]").val();
        var endTime=$("input[name=endTime]").val();
        var order=$("#order").val();
        var query=$("#query").val();
        var tradeCode=$("input[name=tradeCode]").val();
        var str='/trade/shipped?max='+size+"&payType="+payType+"&startTime="+startTime+"&endTime="+endTime+"&tradeCode="+tradeCode+"&query="+query+"&order="+order;
        window.location.replace(str);
    });

</script>

</body>

</html>
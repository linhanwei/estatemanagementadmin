<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.welink.commons.Utils; org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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

    <asset:stylesheet src="daterangepicker/daterangepicker-bs3.css"/>

    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
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

    <div class="box callout callout-info no-margin bring-up">
        <div class="box-header ">
            <h3 class="box-title">注意</h3>

            <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i
                        class="fa fa-minus"></i></button>
                <button class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i
                        class="fa fa-times"></i></button>
            </div>
        </div>

        <div class="box-body">
            只能查询3个月内的交易成功的订单
        </div><!-- /.box-body -->
    </div><!-- /.box -->

</section>

<!-- Main content -->
<section class="content">

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form action="index" class="form-inline" useToken="true">

                <div class="form-group">
                    <input type="text" style="width: 200px"
                           class="form-control" name="daterange" value="${params.daterange}" placeholder="交易成功时间"/>
                </div>

                <div class="form-group">
                    <g:select optionKey="id" optionValue="name" name="communityId"
                              value="${params.communityId}"
                              class="form-control" from="${communityList}"
                              noSelection="['': '服务站点：']"/>
                </div>

                <div class="form-group">
                    <label >交易订单订单号</label>
                    <input type="text" style="width: 200px"
                           class="form-control" name="tradeId" value="${params.tradeId}" placeholder="交易订单订单号"/>
                </div>




            %{--<div class="form-group">--}%
                    %{--<g:select optionKey="key" optionValue="value" name="payType"--}%
                              %{--value="${params.payType}"--}%
                              %{--class="form-control" from="${payTypeMap.entrySet()}"--}%
                              %{--noSelection="['': '支付方式：']"/>--}%
                %{--</div>--}%

                %{--<g:select optionKey="key" optionValue="value" name="shippingType"--}%
                          %{--value="${params.shippingType}"--}%
                          %{--class="form-control" from="${shippingTypeMap.entrySet()}"--}%
                          %{--noSelection="['': '配送方式：']"/>--}%

                %{--<div class="form-group">--}%
                    %{--<g:select id="courierList" name="courierId" class="form-control"--}%
                              %{--from="${courierList}" optionKey="id" value="${params?.courierId}"--}%
                              %{--optionValue="name"--}%
                              %{--noSelection="['': '选择配送员']"/>--}%
                %{--</div>--}%

                %{--<div class="checkbox">--}%
                    %{--<label>--}%
                        %{--<g:checkBox name="noCourier" value="${params?.noCourier}"/>--}%
                        %{--无配送人员订单--}%
                    %{--</label>--}%
                %{--</div>--}%

                <button type="submit"
                        class="btn btn-primary"><i
                        class="fa fa-search">查询</i></button>
            </g:form>
        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th><i class="fa fa-flag"></i>订单号</th>
                    <th><i class="fa fa-money"></i>商品总价</th>
                    <th><i class="fa fa-money"></i>商品优惠</th>
                    <th><i class="fa fa-money"></i>实收</th>
                    <th><i class="fa fa-clock-o"></i>下单时间</th>
                    <th><i class="fa fa-clock-o"></i>调度时间</th>
                    <th><i class="fa fa-clock-o"></i>揽收时间</th>
                    <th><i class="fa fa-clock-o"></i>确认收货</th>
                    %{--<th><i class="fa fa-user-secret"></i>送货兄弟</th>--}%
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${tradeList}" var="trade">
                        <tr id="${trade?.id}" class="info">
                            <th>
                                <a href="#"
                                   onclick="lookTradeDetail('${trade.tradeId}');
                                   return false;"
                                   data-toggle="modal"
                                   data-target="#tradeDetailModel">${trade?.tradeId}
                                </a>

                                <g:if test="${trade?.type == 2 as byte}">
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

                            </th>
                            <th>${((trade?.price) ?: 0) / 100f}
                            </th>
                            <th>
                                ${((trade?.discountFee) ?: 0) / 100f}
                            </th>
                            <th style="color: #ff0000">${((trade?.totalFee) ?: 0) / 100f}</th>
                            <th>${new DateTime(trade?.dateCreated.time).toString(Utils.Minute_FORMATTER)}</th>
                            <th>${trade?.consignTime == null ? "未设置" : new DateTime(trade?.consignTime.time).toString(Utils.Minute_FORMATTER)}</th>
                            <th>${trade?.confirmTime == null ? "未设置" : new DateTime(trade?.confirmTime.time).toString(Utils.Minute_FORMATTER)}</th>
                            <th>${trade?.endTime == null ? "未设置" : new DateTime(trade?.endTime.time).toString(Utils.Minute_FORMATTER)}</th>
                            %{--<th>${tradeMap.get(trade?.id)?.courierName}</th>--}%
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
                            maxsteps="10" action="index" total="${total}"/>
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
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- bootstrap time -->
<asset:javascript src="moment/moment.min.js"/>
<asset:javascript src="daterangepicker/daterangepicker.js"/>
<asset:javascript src="daterangepicker/locales/bootstrap-datepicker.zh-CN.js"/>
%{--<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>--}%
%{--<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>--}%


<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- InputMask -->
<asset:javascript src="input-mask/jquery.inputmask.js"/>
<asset:javascript src="input-mask/jquery.inputmask.date.extensions.js"/>
<asset:javascript src="input-mask/jquery.inputmask.extensions.js"/>



<script type="text/javascript">

    $(document).ready(function () {
        $('input[name="daterange"]').daterangepicker({
            format: 'YYYY-MM-DD',
            language: 'zh-CN'
        });
//        $('input[name="daterange"]')
//                .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
//                .on('changeDate', function (ev) {
//                    var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
//                    $('#acceptTime').val(value)
//                });


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

    $("#query").inputmask();
</script>

</body>

</html>
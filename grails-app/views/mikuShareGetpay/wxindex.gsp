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
                    <li class="active"><g:link action="wxindex" controller="mikuShareGetpay">微信未审核提现</g:link></li>
                    <li><g:link action="allInfo" controller="mikuShareGetpay">全部提现</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                <table style="width:100%">
                                    <tr>
                                        <td>
                                            <form action="wxindex">
                                                <div class="form-group  col-md-2">
                                                    <g:select optionKey="key" optionValue="value" name="max"
                                                              class="form-control" from="${PageMap}" value="${params.max}"
                                                              noSelection="['10': '请选择页码']"/>
                                                </div>
                                                <div class="form-group  col-md-4">
                                                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询</button>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="box-body table-responsive no-padding">
                                <g:form action="changeSumGetPayStatusMethod" params="${params}"  id="shipBox">
                                    <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                                        <tr>
                                            <th><i class="fa fa-flag"></i>用户名</th>
                                            %{--<th><i class="fa fa-flag"></i>类型</th>--}%
                                            <th><i class="fa fa-clock-o"></i>用户手机号</th>
                                            <th ><i class="fa fa-map-marker"></i>金额</th>
                                            <th ><i class="fa fa-money"></i>提现账户</th>
                                            <th ><i class="fa fa-indent"></i>提现时间</th>
                                            <th ><i class="fa fa-indent"></i>订单数</th>
                                            <th ><i class="fa fa-indent"></i>申请状态</th>
                                            <th class=" myth"><i class="fa fa-indent "></i>提现</th>
                                            <th style="width: 8%"><i class="fa fa-hand-o-down"></i>操作
                                                <label>
                                                    <input type="checkbox" id="checkAll">
                                                </label>
                                            </th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${getPayList}" var="getPay">
                                                <tr id="${getPay.id}" class="info">
                                                    <th>
                                                        ${getPay.agencyNickname}[微信]
                                                    </th>
                                                    %{--<th>--}%
                                                        %{--<g:if test="${getPay.getpayType == 1 as byte}">--}%
                                                            %{--<div style="padding-top: 10px">--}%
                                                                %{--<span style="color: #a47e3c">支付宝</span>--}%
                                                            %{--</div>--}%
                                                        %{--</g:if>--}%
                                                        %{--<g:if test="${getPay.getpayType == 2 as byte}">--}%
                                                            %{--<div style="padding-top: 10px">--}%
                                                                %{--<span style="color: #a47e3c">微信钱包</span>--}%
                                                            %{--</div>--}%
                                                        %{--</g:if>--}%
                                                        %{--<g:if test="${getPay.getpayType == 3 as byte}">--}%
                                                            %{--<div style="padding-top: 10px">--}%
                                                                %{--<span style="color: #a47e3c">银行卡</span>--}%
                                                            %{--</div>--}%
                                                        %{--</g:if>--}%
                                                    %{--</th>--}%
                                                    <th >${getPay.agencyMobile}</th>
                                                    %{--<th>--}%
                                                        %{--<g:if test="${getPay.lastUpated}">--}%
                                                            %{--${new DateTime(getPay.lastUpated).toString("yyyy-MM-dd HH:mm")}--}%
                                                        %{--</g:if>--}%
                                                    %{--</th>--}%
                                                    <th>
                                                        ${(getPay?.getpayFee ?: 0) / 100f}元
                                                    </th>
                                                    <th style="word-wrap:break-word;white-space: normal;">
                                                        ${getPay.getpayAccount}
                                                    </th>

                                                    <th style="color: #fb4c90;">
                                                        ${new DateTime(getPay.dateCreated).toString("yyyy-MM-dd HH:mm")}
                                                    </th>
                                                    %{--<th>--}%
                                                    %{--${getPay.clerkerName}--}%
                                                    %{--</th>--}%
                                                    %{--<th>--}%
                                                    %{--<g:if test="${getPay.transDate}">--}%
                                                    %{--${new DateTime(getPay.transDate).toString("yyyy-MM-dd HH:mm")}--}%
                                                    %{--</g:if>--}%
                                                    %{--</th>--}%

                                                    <th>
                                                        <a
                                                                onclick="lookItemDetail('${getPay.id}');
                                                                return false;"
                                                                data-toggle="modal"
                                                                data-target="#itemDetailModel">
                                                            <g:if test="${getPay.tradeNum}">
                                                                ${getPay.tradeNum}个
                                                            </g:if>
                                                            <g:if test="${getPay.successNum>0 || getPay.tingNum>0 || getPay.failNum>0}">
                                                                [
                                                                <g:if test="${getPay.successNum}">
                                                                    成功:${getPay.successNum}
                                                                </g:if>
                                                                <g:if test="${getPay.tingNum}">
                                                                    交易:${getPay.tingNum}
                                                                </g:if>
                                                                <g:if test="${getPay.failNum}">
                                                                    失败:${getPay.failNum}
                                                                </g:if>
                                                                ]
                                                            </g:if>
                                                        </a>
                                                    </th>

                                                    <th>
                                                        <g:if test="${getPay.status == 0 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #265a88">提现中</span>
                                                            </div>
                                                        </g:if>

                                                        <g:if test="${getPay.status == 1 as byte}">
                                                            <div style="padding-top: 10px">
                                                                <span style="color: #ff0000">已审核</span>
                                                            </div>
                                                        </g:if>
                                                    </th>

                                                    <th class="myth">
                                                        <g:if test="${getPay.tradeNum>0 && (getPay.tradeNum==getPay.successNum || getPay.tradeNum==(getPay.successNum+getPay.failNum)) && getPay.getpayType == 2 as byte}">
                                                            <input type="button" class="btn btn-default" value="微信付款" onclick="getPayMoneyByWx('${getPay?.id}',${(getPay?.getpayFee)})"/>
                                                        </g:if>
                                                    </th>

                                                    <th>
                                                        <g:if test="${getPay.tradeNum>0 && (getPay.tradeNum==getPay.successNum || getPay.tradeNum==(getPay.successNum+getPay.failNum))}">
                                                            <label>
                                                                <input type="checkbox" name="modelShipBox"
                                                                       value="${getPay?.id}">
                                                            </label>
                                                        </g:if>
                                                    </th>
                                                </tr>

                                            </g:each>
                                        </g:if>
                                    </table>


                                    <div class="pull-right order-handle">
                                        <button type="button" id="outPortExcelByTradebtn"
                                                class="btn btn-sm btn-primary pull-left"><i
                                                class="fa fa-print">批量导出</i></button>
                                        %{--<button type="submit" class="btn btn-sm btn-primary"><i class="fa fa-truck">&nbsp;审核</i></button>--}%
                                    </div>
                                </g:form>
                            %{--测试打印--}%
                                <g:form action="outPortExcel" controller="proFitGetPay"  style="display: none;">
                                    <input type="text" name="type" value="1"/>
                                    <input type="text" id="TradeExcelids" name="TradeExcelids" />
                                    <input type="submit"  id="outPortExcelByTradeFormsubmit">
                                </g:form>

                            %{--全部打印--}%
                                <g:form action="outPortAllExcel"  style="display: none;">
                                    <input type="submit"  id="outPortAllExcelByTradeFormsubmit">
                                </g:form>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->


                        <div class="box-footer clearfix">
                            <div class="pull-left total">
                                <i class="fa fa-check"></i>共计
                                <span style="color: red">${total}</span>个订单
                            </div>

                            <div class="pagination pull-right">
                                <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                                            maxsteps="10" action="wxindex" total="${viewTotal}"/>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->



<div class="modal fade bs-example-modal-lg" id="itemDetailModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h2 class="modal-title h2" id="itemId">分润订单信息</h2>
            </div>

            <div class="modal-body">
                <div id="itemDetail">
                    %{--<g:render template="detail"/>--}%
                </div>
            </div>
        </div>
    </div>
</div>
%{--<input type="button" onclick="showMyth()"  value="显示对应列"/>--}%

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

    function lookItemDetail(id) {
        $("#itemId").text('分润订单信息:' + id)
        <g:remoteFunction update="itemDetail" action="lookDetail" options="'[asynchronous: false]'"  params="'id='+id"/>
    }


    %{--打印Excel的操作--}%
    //============================================================
    $("#outPortExcelByTradebtn").on('click',function(){
        var tradeArr=[];
        debugger;
        $('input[name="modelShipBox"]:checked').each(function (index, ele) {
            tradeArr.push($(this).val());
        });
        if(!tradeArr.length)
        {
            alert("请选中对应的订单信息");
            return;
        }
        $("#TradeExcelids").val(tradeArr.join(","));
        //进行表单的提交
        $("#outPortExcelByTradeFormsubmit").click();
    })

    //全选的功能
    $("#ExcelAllBtn").on('click',function(){
        $("#outPortAllExcelByTradeFormsubmit").click();
    })

    //============================================================

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    var submitBtn = $('#multiPrint').on('click', function (event) {
        printTrades()
        return false;
    });

    function printTrades() {
        $('input[name="tradeShipBox"]:checked').each(function (index, ele) {
            var tradeId = $(this).val();
            printExternal("/printTrade/index?id=" + tradeId)
        });
    }

    function printExternal(url) {
        var printWindow = window.open(url);
        printWindow.addEventListener('load', function () {
            printWindow.print();
            printWindow.close();
        }, true);
    }


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

    $("input[name='tradeShipBox']").on('ifChecked', function (event) {
        var id = this.value
        $("input[name='exportBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('check');
            }
        });
    });
    $("input[name='tradeShipBox']").on('ifUnchecked', function (event) {
        var id = this.value
        $("input[name='exportBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('check');
            }
        });
    });

    $("#checkAll").on('ifChecked', function (event) {
        $("input[name='modelShipBox']").each(function check() {
            $(this).iCheck('check');
        });
    });

    $("#checkAll").on('ifUnchecked', function (event) {
        $("input[name='modelShipBox']").each(function check() {
            $(this).iCheck('uncheck');
        });

    });


    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });

    $("#query").inputmask();


    //进行审核的id的选取
    function sendCheckIds()
    {
        var tradeArr=[];
        debugger;
        $('input[name="modelShipBox"]:checked').each(function (index, ele) {
            tradeArr.push($(this).val());
        });
        if(!tradeArr.length)
        {
            alert("请选中对应的提现信息");
            return false;
        }
        if(confirm('请确认是否进行审核'))
        {
            //进行ajax的提交
            jQuery.ajax({
                type: 'POST',
                data: {'ids':tradeArr.join("&&") },
                url: '/mikuShareGetpay/changeGetPayStatus', success: function (data, textStatus) {
                    $('#subBtn').click();
//                    alert(data)
//                    jQuery('#tradeDetail').html(data);
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("审核不成功，请找对应的管理员");
                }
            });
        }
        else{
            return false;
        }
    }

    //进行提现的时候进行ajax的调用
    function getPayMoneyByWx(id,price){
        $.ajax({
            url: '/mikuShareGetpay/changeSumGetPayStatusMethodBywxService',
            data: {'id': id,'price':price},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $.sticky("已成功审核微信用户", {autoclose: 2000, position: "top-center", type: "st-success"});
                window.location.replace('/mikuShareGetpay/wxindex');
            },
            error: function (data) {
                alert(data.responseText);
                $.sticky("调用微信接口失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

</script>
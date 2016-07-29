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
        平台支出详情
        <small>平台支出</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>平台支出</a></li>
        <li class="active">平台支出详情</li>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="getRefund" controller="mikuPayMoney">平台退款详情</g:link></li>
                    <li><g:link action="getSharePay" controller="mikuPayMoney">平台分润提现支出</g:link></li>
                    <li class="active"><g:link action="index" controller="mikuPayMoney">平台支出详情</g:link></li>
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
                                                <span style="font-size:20px;color:red">共${txalipayNum+txWxNum+alipayNum+WxNum+AppWxNum}笔支出,共计${AllSum/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:20px;color:red">${alipayNum+txalipayNum}笔支付宝支出,共计${(alipayFeel+txalipayFeel)/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:20px;color:red">${WxNum+txWxNum+AppWxNum}笔微信支出,共计${(AppWxFeel+WxFeel+txWxFeel)/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                        </tr>

                                        <br/>
                                        <tr>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">共${txalipayNum+txWxNum}笔提现,共计${txSumFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">${txalipayNum}笔支付宝提现,共计${txalipayFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                            <div class="form-group">
                                                <span style="font-size:17px;color:red">${txWxNum}笔微信提现,共计${txWxFeel/100f}元</span>&nbsp;&nbsp;
                                            </div>
                                        </tr>
                                        <br/>
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
                        </div><!-- /.box -->
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
    function getPayMoneyByWx(id){
        $.ajax({
            url: '/mikuShareGetpay/changeSumGetPayStatusMethodBywxService',
            data: {'id': id},
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
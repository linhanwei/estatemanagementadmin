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
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
</head>
<body>
<section class="content-header">
    <h1>
        支付宝未审核提现
        <small>提现管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>支付宝未审核提现</a></li>
        <li class="active">全部提现信息</li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index" controller="mikuShareGetpay">未审核提现</g:link></li>
                    <li  class="active"><g:link action="alipayindex" controller="mikuShareGetpay">支付宝未审核提现</g:link></li>
                    <li><g:link action="wxindex" controller="mikuShareGetpay">微信未审核提现</g:link></li>
                    <li><g:link action="allInfo" controller="mikuShareGetpay">全部提现</g:link></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                    <table style="width:100%">
                                        <tr>
                                            <td>
                                                <form action="alipayindex">
                                                <div class="form-group  col-md-2">
                                                <g:select optionKey="key" optionValue="value" name="max"
                                                class="form-control" from="${PageMap}" value="${params.max}"
                                                noSelection="['10': '请选择页码']"/>

                                                </div>
                                                <div class="form-group  col-md-4">
                                                <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询</button>
                                                </div>
                                                </form>


                                                <div class="form-group" >
                                                    <span style="font-size:20px;color:red">${count}笔支付宝,共计${sum/100f}元</span>&nbsp;&nbsp;
                                                    <g:if test="${count>0}">
                                                        <button class="btn btn-sm btn-primary" onclick="refundToGetMoneyByParames()"><i class="fa fa-truck">&nbsp;支付宝付款审核</i></button>
                                                    </g:if>
                                                </div>

                                            </td>
                                        </tr>
                                        %{--<tr>--}%
                                            %{--<td>--}%
                                                %{--<form action="alipayindex">--}%
                                                %{--<div class="form-group  col-md-3">--}%
                                                        %{--<g:select optionKey="key" optionValue="value" name="max"--}%
                                                                  %{--class="form-control" from="${PageMap}" value="${params.max}"--}%
                                                                  %{--noSelection="['10': '请选择页码']"/>--}%

                                                %{--</div>--}%
                                                    %{--<div class="form-group  col-md-4">--}%
                                                        %{--<button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询</button>--}%
                                                    %{--</div>--}%
                                                %{--</form>--}%
                                            %{--</td>--}%
                                        %{--</tr>--}%
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

                                            <th ><i class="fa fa-indent"></i>账户姓名</th>
                                            <th ><i class="fa fa-indent"></i>订单数</th>
                                            <th ><i class="fa fa-indent"></i>申请状态</th>
                                            <th ><i class="fa fa-indent"></i>提现时间</th>
                                            <th style="width: 8%"><i class="fa fa-hand-o-down"></i>操作
                                                <label>
                                                    <input type="checkbox" id="checkAll">
                                                </label>
                                            </th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${getPayList}" var="getPay">
                                                <tr id="${getPay.id}" class="info oneDetailTr" detail="${getPay.getpayAccount}^${getPay.getpayUserName}^${(getPay?.getpayFee ?: 0) / 100f}"  payfee="${(getPay?.getpayFee ?: 0) / 100f}">
                                                    <th>
                                                        ${getPay.agencyNickname}[支付宝]
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
                                                    <th>
                                                        ${(getPay?.getpayFee ?: 0) / 100f}元
                                                    </th>
                                                    <th style="word-wrap:break-word;white-space: normal;">
                                                        ${getPay.getpayAccount}
                                                    </th>

                                                    <th style="color: #fb4c90;">
                                                        ${getPay.getpayUserName}
                                                    </th>
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
                                                    <th style="color: #fb4c90;">
                                                        ${new DateTime(getPay.dateCreated).toString("yyyy-MM-dd HH:mm")}
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
                                            maxsteps="10" action="alipayindex" total="${viewTotal}"/>
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
                </div>
            </div>
        </div>
    </div>
</div>




%{--表单的提交--}%
<g:form action="alipay"  method="post" target="_blank" class="hide" controller="mikuShareGetpay">
    <input size="30" name="WIDemail" value="service@unescn.com"/>
    <input size="30" name="WIDaccount_name" value="东莞市丽元堂化妆品有限公司"/>
    <input size="30" name="WIDpay_date" id="WIDpay_date"/>
    <input size="30" name="WIDbatch_no" id="WIDbatch_no"/>
    <input size="30" name="WIDbatch_fee" id="WIDbatch_fee" value=""/>
    %{--<input size="30" name="WIDbatch_fee" id="WIDbatch_fee" value="${sum/100f}"/>--}%
    %{--<input size="30" name="WIDbatch_num" id="WIDbatch_num" value="${count}"/>--}%
    <input size="30" name="WIDbatch_num" id="WIDbatch_num" value=""/>
    <input size="30" name="WIDdetail_data" id="WIDdetail_data"/>
    <input name="ids" id="idsArr"/>
    <input name="lshids" id="lshids"/>
    <input type="submit" id="aliPayBtn">
</g:form>

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




    //进行对支付宝参数的封装
    function refundToGetMoneyByParames(){
//        if(getDetail().length){
            $("#WIDrefund_date").val(CurentTime(0));
            $("#WIDpay_date").val(CurentTime(1));
            $("#WIDbatch_no").val(CurentTime(2));
            $("#WIDdetail_data").val(getDetail());
            $("#aliPayBtn").click();
//        }else{
//            alert('没有对应的分润信息');
//            return false;
//        }
    }


//    流水号1^收款方账号1^收款账号姓名1^付款金额1^备注说明1|流水号2^收款方账号2^收款账号姓名2^付款金额2^备注说明2。 每条记录以“|”间隔。
    function getDetail(){
        var tradeArr=[];
        var num= 0,fee=0;
        $('input[name="modelShipBox"]:checked').each(function (index, ele) {
            tradeArr.push($(this).parent().parent().parent().parent());
        });

        //获取tr里面的数据
//        var trs=$(".oneDetailTr");
        var str="",arr=[],idArr=[],lshidsArr=[];
        $.each(tradeArr,function(index,comntent){
            debugger;
            num++;
            var detail=$(comntent).attr("detail");
            var payfee=$(comntent).attr("payfee");
            var time=CurentTime(3)+index;
            detail=$(comntent).attr("id")+"^"+detail;
            detail+="^米酷推广奖励提现";
            arr.push(detail);
            idArr.push($(comntent).attr("id"));
            lshidsArr.push(time);
            fee+=parseFloat(payfee);
        });
        str=arr.join("|");
        $("#idsArr").val(idArr.join("##"));
        $("#WIDbatch_fee").val(fee);
        $("#WIDbatch_num").val(num);
        $("#lshids").val(lshidsArr.join("##"));
        debugger;
        return str;
    }

    //flag为0的时候
    function CurentTime(flag)
    {
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        var second = now.getSeconds();          //分
        if(flag==0)
        {
            var clock = year + "-";
            if(month < 10)
                clock += "0";
            clock += month + "-";
            if(day < 10)
                clock += "0";
            clock += day + " ";
            if(hh < 10)
                clock += "0";
            clock += hh + ":";
            if (mm < 10) clock += '0';
            clock += mm;
            //秒
            clock+=":00";
            return(clock);
        }
        else if(flag==1){
            var clock = year;
            if(month < 10)
                clock += "0";
            clock += month;
            if(day < 10)
                clock += "0";
            clock += day;
            return(clock);
        }
        else if(flag==3){
            var clock = year;
            var content="";
            if(month < 10)
                clock += "0";
            clock += month;
            if(day < 10)
                clock += "0";
            clock += day;
            if(hh < 10)
                clock += "0";
            clock += hh;
            if (mm < 10) clock += '0';
            clock += mm;
            clock=second;
            return(clock);
        }
        else
        {
            var clock = year;
            var content="";
            if(month < 10)
                clock += "0";
            clock += month;
            if(day < 10)
                clock += "0";
            clock += day;
            content=clock;
            clock +="10000";
            clock +=content;
            if(hh < 10)
                clock += "0";
            clock += hh;
            if (mm < 10) clock += '0';
            clock += mm;
            return(clock);
        }
    }


</script>
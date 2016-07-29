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

    <title>代理关系</title>
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
        代理关系
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>

            <div class="nav-tabs-custom">
                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">

                                <g:form action="index" class="form-inline" useToken="true">
                                    <table style="width:100%">
                                        <tr>
                                            <td>
                                                %{--确认日期：--}%
                                                %{--<div class="input-group no-padding">--}%
                                                    %{--<div class="input-group-addon">--}%
                                                        %{--<i class="fa fa-clock-o"></i>--}%
                                                    %{--</div><input value="${params.startTime}"--}%
                                                                 %{--name="startTime"--}%
                                                                 %{--class="input-sm form_datetime"--}%
                                                                 %{--style="width: 130px"--}%
                                                                 %{--readonly/>--}%
                                                %{--</div>--}%
                                                %{--<span>至</span>--}%

                                                %{--<div class="input-group no-padding">--}%
                                                    %{--<div class="input-group-addon">--}%
                                                        %{--<i class="fa fa-clock-o"></i>--}%
                                                    %{--</div><input value="${params.endTime}"--}%
                                                                 %{--name="endTime"--}%
                                                                 %{--class="input-sm form_datetime"--}%
                                                                 %{--style="width: 130px"--}%
                                                                 %{--readonly/>--}%
                                                %{--</div>--}%


                                                %{--<span>分润金额：</span>--}%
                                                %{--<g:select optionKey="key" optionValue="value" name="totalFeeOp"--}%
                                                          %{--value="${params.totalFeeOp ?: '>'}"--}%
                                                          %{--class="form-control" from="${totalFeeOpMap.entrySet()}"/>--}%

                                                %{--<g:textField name="targetTotalFee" value="${params.targetTotalFee}"/>--}%
                                                <div class="form-group">
                                                    <label>代理ID:</label>
                                                    <input type="text" class="form-control" value="${params.puserId}" name="puserId" style="width: 130px"/>
                                                </div>


                                                <div class="form-group">
                                                    <label>上级ID:</label>
                                                    <input type="text" class="form-control" value="${params.parentId}" name="parentId" style="width: 130px"/>
                                                </div>

                                                <div class="form-group">
                                                    <label>联系电话:</label>
                                                    <input id="query" name="mobile" class="form-control"
                                                           data-inputmask='"mask": "999-9999-9999"'
                                                           data-mask="true"
                                                           value="${params.mobile}"
                                                           style="width: 120px"
                                                           placeholder="用户号码"/>
                                                </div>


                                                <div class="form-group">

                                                    <div class="input-group no-padding">
                                                        <g:select optionKey="key" optionValue="value" name="max"
                                                                  class="form-control" from="${PageMap}" value="${params.max}"
                                                                  noSelection="['10': '请选择页码']"/>
                                                    </div>
                                                    %{--<span>排序方式:</span>--}%
                                                    %{--<g:select optionKey="key" optionValue="value" name="order"--}%
                                                    %{--value="${params.order ?: "-"}"--}%
                                                    %{--class="form-control" from="${orderMap.entrySet()}" />--}%


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
                                <g:form action="shipTradeChecked" params="${params}" id="shipBox">
                                    <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                                        <tr>
                                            <th><i class="fa fa-flag"></i>代理ID</th>
                                            <th><i class="fa fa-flag"></i>上级ID</th>
                                            <th><i class="fa fa-flag"></i>代理姓名</th>
                                            <th><i class="fa fa-flag"></i>代理等级</th>
                                            <th>联系电话</th>
                                            <th><i class="fa fa-user"></i>是否为代理</th>
                                            <th>创建时间</th>
                                            <th>下级代理</th>
                                            <th>
                                                <i class="fa fa-hand-o-down"></i>代理详情
                                            </th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${profileList}" var="profile">
                                                <tr id="${profile.id}" class="info">
                                                    <th>
                                                        ${profile.id}
                                                    </th>
                                                    <th>
                                                        <g:if test="${profile.pUserId==null || profile.pUserId==""}">
                                                            无
                                                        </g:if>
                                                        <g:if test="${profile.pUserId!=null && profile.pUserId!=""}">
                                                            ${profile.pUserId}
                                                        </g:if>
                                                    </th>
                                                    <th>
                                                        ${profile.agencyName}
                                                        %{--<input onchange="modifyName('${profile.id}')" type="text"--}%
                                                               %{--value=" ${profile.agencyName}" name="${profile.id}" class="no-border"--}%
                                                               %{--style="width:30px;background:transparent;">--}%
                                                    </th>
                                                    <th>
                                                        <g:if test="${profile.agencyLevel==0}">
                                                            总代
                                                        </g:if>
                                                        <g:if test="${profile.agencyLevel>0}">
                                                            ${profile.agencyLevel}
                                                        </g:if>
                                                    </th>
                                                    <th>
                                                        ${profile.agencyMobile}
                                                    </th>
                                                    <th>
                                                        <g:if test="${profile.isAgency==0}">
                                                            消费者
                                                        </g:if>
                                                        <g:if test="${profile.isAgency==1}">
                                                            代理
                                                        </g:if>
                                                    </th>
                                                    <th>
                                                        ${new DateTime(profile.agencyDateCreate).toString("yyyy-MM-dd HH:mm")}
                                                    </th>
                                                    <th>${profile.childCount}</th>
                                                    <th>
                                                        <button class="btn-sm btn-info btn-sm"
                                                                onclick="lookItemDetail('${profile.id}');
                                                                return false;"
                                                                data-toggle="modal"
                                                                data-target="#itemDetailModel"><i class="fa fa-info-circle"></i>代理详情</button>
                                                    </th>
                                                </tr>

                                            </g:each>
                                        </g:if>
                                    </table>
                                </g:form>

                            <div class="box-footer clearfix">
                                <div class="pull-left total">
                                    <i class="fa fa-check"></i>共计
                                    <span style="color: red">${total}</span>个用户
                                </div>

                                <div class="pagination pull-right">
                                    <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                                                maxsteps="10" action="index" total="${viewTotal}"/>
                                </div>

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

                <h2 class="modal-title h2" id="itemId">查看对应等级:</h2>
            </div>

            <div class="modal-body">
                <div id="agencyDetail">
                    <g:render template="agencyDetail"/>
                </div>
            </div>

        </div>
    </div>
</div>



%{--<div class="modal fade bs-example-modal-lg" id="tradeDetailModel" tabindex="-1" role="dialog"--}%
%{--aria-labelledby="myModalLabel"--}%
%{--aria-hidden="true">--}%
%{--<div class="modal-dialog">--}%
%{--<div class="modal-content">--}%

%{--<div class="modal-header bg-blue-gradient">--}%
%{--<button type="button" class="close" data-dismiss="modal"><span--}%
%{--aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--}%

%{--<h2 class="modal-title h2" id="tradeId">订单号：</h2>--}%
%{--</div>--}%

%{--<div class="modal-body">--}%
%{--<div id="tradeDetail">--}%
%{--<g:render template="tradeDetail"/>--}%
%{--</div>--}%
%{--</div>--}%

%{--<div class="modal-footer">--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%


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
        $("#itemId").text('代理信息:'+id);
        <g:remoteFunction update="agencyDetail" action="agencyDetail" options="'[asynchronous: false]'"  params="'id='+id"/>
    }
</script>


<script>


    function modifyName(id){

    }


    %{--打印Excel的操作--}%
    %{--//============================================================--}%
    %{--$("#outPortExcelByTradebtn").on('click',function(){--}%
        %{--var tradeArr=[];--}%
        %{--debugger;--}%
        %{--$('input[name="modelShipBox"]:checked').each(function (index, ele) {--}%
            %{--tradeArr.push($(this).val());--}%
        %{--});--}%
        %{--if(!tradeArr.length)--}%
        %{--{--}%
            %{--alert("请选中对应的订单信息");--}%
            %{--return;--}%
        %{--}--}%
        %{--$("#TradeExcelids").val(tradeArr.join(","));--}%
        %{--//进行表单的提交--}%
        %{--$("#outPortExcelByTradeFormsubmit").click();--}%
    %{--})--}%

    %{--//全选的功能--}%
    %{--$("#ExcelAllBtn").on('click',function(){--}%
        %{--$("#outPortAllExcelByTradeFormsubmit").click();--}%
    %{--})--}%

    %{--//============================================================--}%

    %{--$('input').iCheck({--}%
        %{--checkboxClass: 'icheckbox_square-blue',--}%
        %{--radioClass: 'iradio_square-blue',--}%
        %{--increaseArea: '20%' // optional--}%
    %{--});--}%

    %{--var submitBtn = $('#multiPrint').on('click', function (event) {--}%
        %{--printTrades()--}%
        %{--return false;--}%
    %{--});--}%

    %{--function printTrades() {--}%
        %{--$('input[name="tradeShipBox"]:checked').each(function (index, ele) {--}%
            %{--var tradeId = $(this).val();--}%
            %{--printExternal("/printTrade/index?id=" + tradeId)--}%
        %{--});--}%
    %{--}--}%

    %{--function printExternal(url) {--}%
        %{--var printWindow = window.open(url);--}%
        %{--printWindow.addEventListener('load', function () {--}%
            %{--printWindow.print();--}%
            %{--printWindow.close();--}%
        %{--}, true);--}%
    %{--}--}%


    %{--function modifyaddr(id) {--}%
        %{--$("textarea").each(function change() {--}%
            %{--if (id == this.name) {--}%
                %{--var modifyaddr = this.value--}%
                %{--$.ajax({--}%
                    %{--url: '/trade/modifyAddr',--}%
                    %{--data: {'id': id, 'modifyaddr': modifyaddr},--}%
                    %{--type: "POST",--}%
                    %{--dataType: "json",--}%
                    %{--success: function (data) {--}%
                        %{--$.sticky("修改地址成功", {autoclose: 2000, position: "top-center", type: "st-success"});--}%
                    %{--},--}%
                    %{--error: function (data) {--}%
                        %{--$.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});--}%
                    %{--}--}%
                %{--});--}%
            %{--}--}%
        %{--});--}%
    %{--}--}%

    %{--$("input[name='tradeShipBox']").on('ifChecked', function (event) {--}%
        %{--var id = this.value--}%
        %{--$("input[name='exportBox']").each(function check() {--}%
            %{--if (id == this.value) {--}%
                %{--$(this).iCheck('check');--}%
            %{--}--}%
        %{--});--}%
    %{--});--}%
    %{--$("input[name='tradeShipBox']").on('ifUnchecked', function (event) {--}%
        %{--var id = this.value--}%
        %{--$("input[name='exportBox']").each(function check() {--}%
            %{--if (id == this.value) {--}%
                %{--$(this).iCheck('check');--}%
            %{--}--}%
        %{--});--}%
    %{--});--}%

    %{--$("#checkAll").on('ifChecked', function (event) {--}%
        %{--$("input[name='tradeShipBox']").each(function check() {--}%
            %{--$(this).iCheck('check');--}%
        %{--});--}%
    %{--});--}%

    %{--$("#checkAll").on('ifUnchecked', function (event) {--}%
        %{--$("input[name='tradeShipBox']").each(function check() {--}%
            %{--$(this).iCheck('uncheck');--}%
        %{--});--}%

    %{--});--}%

    %{--function lookTradeDetail(id) {--}%
        %{--$("#sendId").val(id)--}%

        %{--$("#tradeId").text('订单号:' + id)--}%

        %{--jQuery.ajax({--}%
            %{--type: 'POST', data: {'tradeId': id}, url: '/trade/lookTradeDetail', success: function (data, textStatus) {--}%
                %{--jQuery('#tradeDetail').html(data);--}%
            %{--}, error: function (XMLHttpRequest, textStatus, errorThrown) {--}%
            %{--}--}%
        %{--});--}%
    %{--}--}%

    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });

    %{--$("#query").inputmask();--}%



    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var puserId=$("input[name=puserId]").val();
        var parentId=$("input[name=parentId]").val();
        var mobile=$("input[name=mobile]").val();
        var str='/mikuUserAgency/index?max='+size+"&puserId="+puserId+"&parentId="+parentId+"&mobile="+mobile;
        window.location.replace(str);
    });
</script>
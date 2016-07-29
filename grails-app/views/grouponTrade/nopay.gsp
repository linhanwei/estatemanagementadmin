<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 14/11/10
  Time: 下午1:20
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">

    <title>团购订单管理</title>
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


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header"></section>

<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="nopay">未付款</g:link></li>
                    <li><g:link action="index">未派单</g:link></li>
                    <li><g:link action="shipped">已派单</g:link></li>
                    <li><g:link action="history">历史订单</g:link></li>
                    <li><g:link action="close">已关闭</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">

                                <g:form action="nopay" class="text-left">
                                    <div class="col-sm-3">

                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-clock-o"></i>时间:
                                            </div><input value="${new Date().format('yyyy-MM-dd')}"
                                                         name="acceptTime"
                                                         readonly/>
                                        </div><!-- /.input group -->

                                    </div>

                                    <div class="col-sm-5">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-home"></i>小区:
                                            </div> <g:select id="communityList" name="communityId"
                                                             value="${params.communityId}"
                                                             placeholder="小区" class="input-sm"
                                                             from="${communityList}" optionKey="id" optionValue="name"
                                                             noSelection="['': '全部小区']"/>
                                            <input type="submit" value="查看" class="btn btn-sm btn-primary"/>
                                        </div><!-- /.input group -->
                                    </div>
                                </g:form>

                                <div class="col-sm-4">
                                    <div class="search-form">
                                        <g:form action="nopay" class="text-right" useToken="true">
                                            <div class="input-group">
                                                <input id="query" name="query" class="input-sm"
                                                       data-inputmask='"mask": "999-9999-9999"' data-mask="true"
                                                       value="${params.query}"
                                                       placeholder="用户号码:"/>

                                                <div class="input-group-btn">
                                                    <button type="submit"
                                                            class="btn btn-sm btn-primary"><i
                                                            class="fa fa-search">电话搜索</i></button>
                                                </div>
                                            </div>
                                        </g:form>
                                    </div>
                                </div>
                            </div>

                            <div class="box-body table-responsive no-padding">
                                <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                                    <tr>
                                        <th style="width: 130px"><i class="fa fa-flag"></i>订单号</th>
                                        <th style="width: 160px"><i class="fa fa-home"></i>小区名称</th>
                                        <th style="width: 150px"><i class="fa fa-user"></i>收货人</th>
                                        <th style="width: 80px"><i class="fa fa-tags"></i>总价</th>
                                        <th style="width: 150px"><i class="fa fa-tags"></i>下单时间</th>
                                        <th><i class="fa fa-hand-o-down"></i>操作</th>
                                    </tr>
                                    <g:if test="${total > 0}">
                                        <g:each status="i" in="${tradeList}" var="trade">
                                            <tr class="info">
                                                <th id="tabletradeId">${tradeMap.get(trade.id)?.tradeId}</th>
                                                <th>${tradeMap.get(trade.id)?.communityName}</th>
                                                <th>${tradeMap.get(trade.id)?.receiverName + ':' + tradeMap.get(trade.id)?.receiverMobile}</th>
                                                <th>${Long.parseLong(tradeMap.get(trade.id)?.totalPrice) / 100f}元</th>
                                                <th>${tradeMap.get(trade.id)?.createTime}</th>
                                                <th>
                                                    <a href="#" class="btn-sm btn-primary"
                                                       onclick="lookTradeDetail('${trade.tradeId}');
                                                       return false;"
                                                       data-toggle="modal"
                                                       data-target="#tradeDetailModel"><i
                                                            class="fa fa-info-circle"></i>查看详情</a>
                                                </th>
                                            </tr>
                                        </g:each>
                                    </g:if>
                                </table>
                            </div><!-- /.box-body -->
                            <div class="box-footer clearfix">

                                <g:if test="${total > 0}">

                                    <div>
                                        <i class="fa fa-check"></i><span>共计<span
                                            style="color: red">${total}</span>个订单
                                    </span>
                                    </div>

                                    <div class="pagination pull-right">
                                        <g:paginate next="下一页" prev="上一页" params="${params}"
                                                    maxsteps="10" action="nopay" total="${total}"/>
                                        <g:form action="exportExcel">
                                            <input name="communityId" value="${params.communityId}"
                                                   style="display: none"/>
                                            <input name="query" style="display: none" value="${params.query}"/>
                                            <input name="status" value="2" style="display: none"/>
                                            <button type="submit" class="btn btn-info pull-right"><i
                                                    class="fa fa-cloud-download"></i>导出Excel</button>
                                        </g:form>
                                    </div>

                                </g:if>
                            </div>
                        </div><!-- /.box -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
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


<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jquery-ui-1.10.3.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="AdminLTE/app.js"/>
<!-- InputMask -->
<asset:javascript src="plugins/input-mask/jquery.inputmask.js"/>
<asset:javascript src="plugins/input-mask/jquery.inputmask.date.extensions.js"/>
<asset:javascript src="plugins/input-mask/jquery.inputmask.extensions.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="plugins/bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<!-- sticky -->
<asset:javascript src="plugins/sticky/sticky.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<!-- notify -->
<asset:javascript src="bootstrap-growl.min.js"/>


<script>

    function lookTradeDetail(id) {
        $("#sendId").val(id)

        $("#tradeId").text('订单号:' + id)

        jQuery.ajax({
            type: 'POST',
            data: {'tradeId': id},
            url: '/trade/lookTradeDetail',
            success: function (data, textStatus) {
                jQuery('#tradeDetail').html(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    $("#query").inputmask();

</script>
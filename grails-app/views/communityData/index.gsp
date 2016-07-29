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
        站点数据
        <small>数据统计</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>数据统计</a></li>
        <li class="active">站点数据</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">

                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form action="index" class="form-inline">
                <div class="form-group input-group no-padding">
                    <div class="input-group-addon">
                        <i class="fa fa-clock-o"></i>起:
                    </div><input value="${params.startTime}"
                                 name="startTime"
                                 class="form-control form_datetime"
                                 style="width: 130px"
                                 readonly/>
                </div><!-- /.input group -->

                <div class="form-group input-group no-padding">
                    <div class="input-group-addon">
                        <i class="fa fa-clock-o"></i>末:
                    </div><input value="${params.endTime}"
                                 name="endTime"
                                 class="form-control form_datetime"
                                 style="width: 130px"
                                 readonly/>
                </div><!-- /.input group -->

                <div class="form-group">
                    <g:select optionKey="id" optionValue="name" name="communityId"
                              value="${params.communityId}"
                              class="form-control" from="${communityList}" noSelection="['': '选择站点']"/>

                    <button type="submit"
                            class="btn btn-primary"><i
                            class="fa fa-search">查询</i></button>
                </div>

            </g:form>
        </div>

        <div class="box-body table-responsive no-padding">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th style="width: 100px"><i class="fa fa-flag"></i>日期</th>
                    <th style="width: 120px">站点名称</th>
                    <th style="width: 80px"><i class="fa fa-user"></i>用户总数</th>
                    <th style="width: 90px"><i class="fa fa-user"></i>新增用户</th>
                    <th style="width: 80px"><i class="fa fa-clock-o"></i>订单量</th>
                    <th style="width: 60px">转化率</th>
                    <th style="width: 80px">GMV</th>
                    <th style="width: 70px">客单价</th>
                    <th style="width: 70px">发货量</th>
                    <th style="width: 70px">签收量</th>
                    <th style="width: 70px">理念</th>
                </tr>

                <g:if test="${total > 0}">
                    <g:each status="i" in="${communityDataList}" var="communityData">
                        <tr class="info">
                            <th>${communityData?.calcuDate.toString().substring(0, 10)}</th>
                            <th>${communityMap.get(communityData?.communityId)?.name}</th>
                            <th>${communityData?.userTotal}</th>
                            <th>${communityData?.newUsers}</th>
                            <th>${communityData?.tradeNums}</th>
                            <th>${communityData?.ConversionRate / 100f}%</th>
                            <th>${communityData?.actualPayment / 100f}</th>
                            <th>${communityData?.guestUnitPrice / 100f}</th>
                            <th>${communityData?.shipments}</th>
                            <th>${communityData?.receivingNums}</th>
                            <th>${communityMap.get(communityData?.communityId)?.description}</th>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="index" total="${total}"/>
                </div>
            </g:if>
        </div><!-- /.box-footer-->
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
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>
    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });
</script>

</body>

</html>

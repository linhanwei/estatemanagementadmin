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
        ${community?.name}
        <small><h2>未发货统计：${(params.startTime ?: '所') + '-' + (params.endTime ?: '有')}</h2></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>订单统计</a></li>
        <li class="active">未发货商品统计</li>
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
            <g:form action="NoShipItemCalcu" class="form-inline">
                下单时间：
                <div class="input-group no-padding">
                    <div class="input-group-addon">
                        <i class="fa fa-clock-o"></i>
                    </div><input value="${params.startTime}"
                                 name="startTime"
                                 class="input-sm form_datetime"
                                 style="width: 130px"
                                 readonly/>
                </div><!-- /.input group -->
                <span>至</span>

                <div class="input-group no-padding">
                    <div class="input-group-addon">
                        <i class="fa fa-clock-o"></i>
                    </div><input value="${params.endTime}"
                                 name="endTime"
                                 class="input-sm form_datetime"
                                 style="width: 130px"
                                 readonly/>
                </div><!-- /.input group -->

                <g:select optionKey="id" optionValue="name" name="communityId"
                          value="${params.communityId}"
                          class="form-control" from="${communityList}" noSelection="['': '选择站点']"/>

                <button type="submit"
                        class="btn btn-primary"><i
                        class="fa fa-search">查询</i></button>

            </g:form>
            <div class="row">
                <div class="col-sm-3">订单数量:</div>

                <div class="col-sm-3">${TradesNum}</div>

                <div class="col-sm-3">订单总额:</div>

                <div class="col-sm-3"><span style="color: #ff0000">￥${(TradesTotal ?: 0) / 100f}元</span></div>
            </div>
        </div>

        <div class="box-body table-responsive no-padding">
            <table class="table text-center table-striped table-bordered">
                <thead>
                <tr>
                    <td>商品名称</td>
                    <td>规格</td>
                    <td>商品数量</td>
                    <td>总价</td>
                </tr>
                </thead>
                <tbody>
                <g:each status="g" in="${itemList}" var="item">
                    <g:if test="${item.title != null}">
                        <tr>
                            <td style="color:#0000ff">${itemMap.get(item.id).itemName}</td>
                            <td>${itemMap.get(item.id).itemSpecification}</td>
                            <td>${itemMap.get(item.id).itemNum}</td>
                            <td>${itemMap.get(item.id).orderPrice / 100f}元</td>
                        </tr>
                    </g:if>
                </g:each>
                </tbody>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

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

<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<%@ page import="org.apache.commons.lang3.StringUtils; org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
        优惠券管理
        <small>运营工具</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>运营工具</a></li>
        <li class="active">优惠劵管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">优惠劵列表</g:link></li>
                    <li>
                        <g:link action="addCouponHtml">发放优惠</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 100px"><i class="fa fa-tasks"></i>名称</th>
                    <th style="width: 80px"><i class="fa fa-gavel"></i>类型</th>
                    <th style="width: 80px"><i class="fa fa-dollar"></i>面值</th>
                    %{--<th style="width: 80px"><i class="fa fa-calculator">概率</i></th>--}%
                    <th style="width: 100px"><i class="fa fa-dollar"></i>使用门槛</th>
                    <th style="width: 80px"><i class="fa fa-bookmark"></i>有效天数</th>
                    <th style="width: 80px"><i class="fa fa-bookmark"></i>发放量</th>
                    %{--<th style="width: 80px"><i class="fa fa-bookmark">属性</i></th>--}%
                    %{--<th style="width: 100px"><i class="fa fa-home"></i>适用店铺</th>--}%
                    %{--<th style="width: 130px"><i class="fa fa-calendar">开始时间</i></th>--}%
                    %{--<th style="width: 130px"><i class="fa fa-calendar">结束时间</i></th>--}%
                    %{--<th style="width: 80px"><i class="fa fa-tag">限量</i></th>--}%
                    <th style="width: 80px"><i class="fa fa-tag"></i>有效图片</th>
                    <th style="width: 80px"><i class="fa fa-tag"></i>过期图片</th>
                    <th style="width: 80px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${couponList}" var="coupon">
                        <tr id="${coupon?.id}" class="info">
                            <td>${coupon?.name}</td>
                            <g:if test="${coupon?.type == 2001}">
                                <td style="color: orange">满减扣</td>
                            </g:if>
                            <g:if test="${coupon?.type == 2002}">
                                <td style="color: #ff0000">新人</td>
                            </g:if>
                            <g:if test="${coupon?.type == 2003}">
                                <td style="color: #337ab7">邀请</td>
                            </g:if>
                            <g:if test="${coupon?.type == 2004}">
                                <td style="color: green">注册</td>
                            </g:if>
                            <td>
                                <g:if test="${coupon?.value}">
                                    ${coupon?.value/100f}
                                </g:if>
                                </td>
                            %{--<td>${coupon?.probability}</td>--}%
                            <td>
                            <g:if test="${coupon?.minValue}">
                                ${coupon?.minValue/100f}
                            </g:if>
                            </td>
                            %{--<td>${coupon?.attributes}</td>--}%
                            %{--<td>${coupon?.shopId}</td>--}%
                            %{--<td>--}%
                                %{--${coupon.startTime?new DateTime(coupon.startTime).toString("yyyy-MM-dd HH:mm"):""}--}%
                                %{--${new DateTime(coupon.startTime).toString("yyyy-MM-dd HH:mm")}</td>--}%
                            %{--<td>--}%
                                %{--${coupon.endTime?new DateTime(coupon.endTime).toString("yyyy-MM-dd HH:mm"):""}--}%
                                %{--${new DateTime(coupon.endTime).toString("yyyy-MM-dd HH:mm")}--}%
                            %{--</td>--}%
                            <td>${coupon?.validity}</td>
                            <td>${coupon?.giveNum}</td>
                            <td>
                                <g:if test="${coupon?.picUrl}">
                                    <img src="${coupon?.picUrl}" style="width: 80px;height: 40px">
                                </g:if>
                            </td>
                            <td>
                                <g:if test="${coupon?.expirationPicUrl}">
                                    <img src="${coupon?.expirationPicUrl}" style="width: 80px;height: 40px">
                                </g:if>
                            </td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location.replace('/coupon/edit?id=${coupon?.id}')">
                                    编辑
                                </button>
                                <button type="button" class="btn btn-danger btn-sm"
                                        onclick="deleteCoupon(${coupon?.id})">
                                    删除
                                </button>
                            </td>
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
<<asset:javascript src="iCheck/icheck.min.js"/>
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

    function deleteCoupon(id) {

        if (!confirm("您真的要删除该批次优惠劵么？")) {
            return;
        }

        $.ajax({
            url: '/coupon/deleteCoupon',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#" + id).remove()
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

</script>


</body>

</html>

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
        z
        <small>f</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>f</a></li>
        <li class="active">z</li>
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
            <g:form action="index" class="text-left" useToken="true">

                <select id="province" name="province" class="col-sm-4"
                        style="display: none">
                    <option value="-1">请选择省...</option>
                </select>
                <select id="city" name="city" class="col-sm-4" style="display: none">
                    <option value="-1">请选择市...</option>
                </select>
                <select id="area" name="area" class="col-sm-4" style="display: none">
                    <option value="-1">请选择区/县...</option>
                </select>

                <div class="input-group">

                    <g:select id="communityList" name="communityId"
                              value="${params.communityId}"
                              placeholder="小区" class="input-sm"
                              from="${communityList}" optionKey="id" optionValue="name"
                              noSelection="['': '全部小区']"/>


                    <div class="input-group-btn">
                        <button type="submit"
                                class="btn btn-sm btn-primary"><i
                                class="fa fa-search">按小区查看</i></button>
                    </div>

                </div>

            </g:form>
        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered" style="table-layout: fixed" id="table">
                <tr>
                    <th style="width: 140px">小区名</th>
                    <th style="width: 120px">手机号</th>
                    <th style="width: 180px">注册时间</th>
                    <th style="width: 250px">收货信息</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${profileList}" var="profile">
                        <tr class="info">
                            <td>${profileMap.get(profile.id)?.communityName}</td>
                            <td>${profileMap.get(profile.id)?.mobile}</td>
                            <td>${profileMap.get(profile.id)?.registerTime}</td>
                            <td>${profileMap.get(profile.id)?.address}</td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">

                <div class="row text-left">

                    <g:form action="index">
                        <input name="communityId" value="${params.communityId}"
                               style="display: none"/>
                        <input name="query" value="${params.query}" style="display: none"/>
                        <input name="max" value="${params.max}" style="display: none"/>
                        <input name="offset" value="${params.offset}" style="display: none"/>
                        <input name="exportCurrent" value="println" style="display: none"/>
                        <button type="submit" class="btn btn-sm btn-primary pull-left" style="margin-left: 10px;"><i
                                class="fa fa-download">当前页</i></button>
                    </g:form>

                    <g:form action="exportCommunityProfile">
                        <input id="communityList" name="communityId" value="${params.communityId}"
                               style="display: none"/>
                        <button type="submit"
                                class="btn btn-sm btn-primary pull-left" style="margin-left: 10px;"><i
                                class="fa fa-download">${communityName ?: 未选择小区}</i></button>
                    </g:form>
                </div>

                <div class="pull-left total">
                    <i class="fa fa-check"></i><span>共计<span style="color: red">${total}</span>个用户
                </span>
                    <span>今日新增<span style="color: red">${todayTotal}</span>个用户
                    </span>
                </div>

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

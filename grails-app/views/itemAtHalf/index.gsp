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
        半价活动
        <small>活动管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>活动管理</a></li>
        <li class="active">半价活动</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">活动列表</g:link></li>
                    <li>
                        <g:link action="addActivityHtml">新增活动</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <div style="margin-top: 10px"></div>
            <g:form class="form-inline" action="index">
                <div class="form-group">
                    <label>
                        <i class="fa fa-clock-o"></i>日期：
                    </label><input value="${params.announceTime}"
                                   name="announceTime"
                                   class="form-control form_datetime"
                                   readonly/>
                </div><!-- /.input group -->

                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询
                    </button>
                </div>
            </g:form>
        </div>

        <div class="box-body no-padding form-horizontal">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 100px"><i class="fa fa-picture-o"></i>商品</th>
                    <th style="width: 80px"><i class="fa fa-tag"></i>限购</th>
                    <th style="width: 80px"><i class="fa fa-tag"></i>活动价</th>
                    <th style="width: 100px"><i class="fa fa-clock-o"></i>开始时间</th>
                    <th style="width: 100px"><i class="fa fa-clock-o"></i>结束时间</th>
                    <th style="width: 150px"><i class="fa fa-chain"></i>Banner</th>
                    <th style="width: 80px"><i class="fa fa-hand-o-down"></i>状态</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${activityList}" var="activity">
                        <tr id="${activity?.id}" class="info">
                            <td>
                                ${activityMap.get(activity?.id)?.itemId}
                                <div style="padding-top: 10px">
                                    ${activityMap.get(activity?.id)?.itemName}
                                </div>
                            </td>
                            <td>${activityMap.get(activity?.id)?.limitNum}</td>
                            <td style="color: #ff0000">${activityMap.get(activity?.id)?.activityPrice}</td>
                            <td>${activityMap.get(activity?.id)?.startTime}</td>
                            <td>${activityMap.get(activity?.id)?.endTime}</td>
                            <td>${activityMap.get(activity?.id)?.bannerId}
                                <div style="padding-top: 10px">
                                    <img src="${activityMap.get(activity?.id)?.bannerPicUrls}"
                                         style="width: 128px;height: 42px">
                                </div>
                            </td>

                            <g:if test="${activity?.activeStatus == 0}">
                                <th style="color: rosybrown"><i class="fa fa-circle-o">未展示</i></th>
                            </g:if>
                            <g:if test="${activity?.activeStatus == 7}">
                                <th style="color: orangered"><i class="fa fa-warning">已展示</i></th>
                            </g:if>
                            <g:if test="${activity?.activeStatus == 15}">
                                <th style="color: forestgreen"><i class="fa fa-bomb">开卖了</i></th>
                            </g:if>
                            <g:if test="${activity?.activeStatus == 12}">
                                <th style="color: blueviolet"><i class="fa fa-ban">卖完了</i></th>
                            </g:if>
                            <g:if test="${activity?.activeStatus == 1}">
                                <th style="color: forestgreen"><i class="fa fa-times">展示结束</i></th>
                            </g:if>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="startActivity(${activity?.id})">
                                    开始
                                </button>
                                <button type="button" class="btn btn-danger btn-sm"
                                        onclick="deleteActivity(${activity?.id})">
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
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>



<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>


    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    function startActivity(id) {

        if (!confirm("启动该活动前请确保只有一场有效")) {
            return;
        }

        $.ajax({
            url: '/ItemAtHalf/startActivity',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location.reload()
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    $(".form_datetime")

            .datetimepicker({autoclose: true, format: 'yyyy-mm-dd', minView: 'month', language: 'zh-CN'})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD")
            });

    function deleteActivity(id) {

        if (!confirm("您真的要删除这个Activity么？")) {
            return;
        }

        $.ajax({
            url: '/ItemAtHalf/deleteActivity',
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

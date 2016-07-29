<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime;com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>

    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>

    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>




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
        添加
        <small>添加软文</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>标签管理</a></li>
        <li class="active">新增标签</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="list">软文列表</g:link></li>
                    <li>
                        <g:link action="add">添加软文</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="box-header">

            <g:form class="form-inline" action="list">
                <div class="form-group">
                    <label class="control-label">红色标题：</label>
                    <input name="btitle" class="form-control" value="${params.btitle}">
                </div>

                <div class="form-group">
                    <label class="control-label">文本标题：</label>
                    <input name="query" class="form-control" value="${params.query}">
                </div>

                <div class="form-group">
                    <label class="control-label" >查询页码：</label>
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '页码']"/>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询
                    </button>
                </div>

            </g:form>

        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>发布时间</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>活动名称</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>活动内容</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>推广奖励</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>推广链接</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>海报图片</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>


                <g:each status="i" in="${list}" var="li">
                    <tr>
                        <td>${li.dateCreated?new DateTime(li.dateCreated).toString("yyyy-MM-dd HH:mm"):li.dateCreated}
                            <div style="padding-top: 10px;color: red">
                                ${li.id}
                            </div>
                        </td>
                        <td>
                            <span style="color: red">${li.advertorialTile}</span>
                            <div style="padding-top: 10px">
                            ${li.articleTile}
                            </div>
                        </td>
                        <td>${li.articleContent}</td>
                        <td>${li.salesReward}</td>
                        <td>
                            商品:${li.mallResourceUrl}
                            %{--<div style="padding-top: 10px">--}%
                               %{--海报:${li.posterProductPicUrl}--}%
                            %{--</div>--}%
                        </td>
                        <td>
                            <img src="${li?.posterPicUrl}" style="width: 90px;height: 47px">
                        </td>
                        <td>
                            %{--<button type="button" class="btn btn-success"--}%
                                    %{--onclick="window.open('_blank','width=600,height=1000,menubar=no,toolbar=no, status=no,scrollbars=yes')">--}%
                                %{--预览--}%
                            %{--</button>--}%
                            <button class="btn btn-warning" onclick="window.location.replace('/mikuOfficWriter/edit?id=${li.id}')">编辑</button>
                            <button class="btn btn-danger" onclick="window.location.replace('/mikuOfficWriter/delete?id=${li.id}')">删除</button>
                            <g:if test="${li?.status == 1 as byte}">
                                <button class="btn btn-info" onclick="window.location.replace('/mikuOfficWriter/dostatus?flag=0&id=${li.id}')">无效</button>
                            </g:if>
                            <g:elseif test="${li?.status == 0 as byte}">
                                <button class="btn btn-primary" onclick="window.location.replace('/mikuOfficWriter/dostatus?flag=1&id=${li.id}')">有效</button>
                            </g:elseif>
                        </td>
                    </tr>
                </g:each>


            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="list" total="${total}"/>
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
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>



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
    $("#decrease").click(function () {
        var now = $("#num").val();
        now = now * 1 - 1
        if (now > 0) {
            $("#num").val(now);
        }
    });
    $("#insert").click(function () {
        var now = $("#num").val();
        now = now * 1 + 1
        if (now > 0) {
            $("#num").val(now);
        }
    });

    $('.dropdown-toggle').dropdown()

</script>

</body>

</html>

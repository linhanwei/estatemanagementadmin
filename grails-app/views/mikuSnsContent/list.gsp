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
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>

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
        发现:文章列表
        <small>文章列表</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>发现管理</a></li>
        <li class="active">文章列表</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li  class="active">
                        <g:link action="list">发现文章列表</g:link></li>
                    <li>
                        <g:link action="add">添加发现文章</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="box-header">

            <g:form class="form-inline" action="list">
                %{--<div class="form-group">--}%
                    %{--<label class="control-label">红色标题：</label>--}%
                    %{--<input name="btitle" class="form-control" value="${params.btitle}">--}%
                %{--</div>--}%

                %{--<div class="form-group">--}%
                    %{--<label class="control-label">文本标题：</label>--}%
                    %{--<input name="query" class="form-control" value="${params.query}">--}%
                %{--</div>--}%

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
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>用户</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>操作时间</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>文章标题</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>标题简称</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>内容摘要</th>
                    %{--<th style="width: 130px"><i class="fa fa-picture-o"></i>具体内容</th>--}%
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>数据</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>


                <g:each status="i" in="${list}" var="li">
                    <tr>
                        <td>
                            ${li.userName}
                            <div style="padding-top: 10px;color: red">
                                ${li.cid}
                            </div>
                        </td>
                        <td>
                            开始:${li.dateCreate?new DateTime(li.dateCreate).toString("yyyy-MM-dd HH:mm"):li.dateCreate}
                            更新:${li.lastUpdate?new DateTime(li.lastUpdate).toString("yyyy-MM-dd HH:mm"):li.lastUpdate}
                        </td>
                        <td>
                            ${li.contentTitle}
                        </td>
                        <td>
                            ${li.contentShortTitle}
                        </td>
                        <td>
                            ${li.contentAbstract}
                        </td>
                        %{--<td>--}%
                            %{--${li.content}--}%
                        %{--</td>--}%
                        <td>
                            浏览:${li.timesOfBrowsed}
                            <br/>
                            点赞:${li.timesOfPraised}
                            <br/>
                            转载:${li.timesOfReferenced}
                            <br/>
                            评论:${li.timesOfCommented}
                            <br/>
                            收藏:${li.timesOfCollected}
                        </td>
                        <td>
                            <button class="btn btn-warning" onclick="window.location.replace('/mikuSnsContent/edit?dyId=${li.dyId}')">编辑</button>
                            <button class="btn btn-danger" onclick="window.location.replace('/mikuSnsContent/delete?id=${li.cid}')">删除</button>
                            <button class="btn btn-success" onclick="window.open('http://test.unesmall.com/api/h/1.0/articleDetailPage.htm?cid=${li.cid}&dyid=${li.dyId}&goalType=1','_blank','width=600,height=1000,menubar=no,toolbar=no, status=no,scrollbars=yes')">详情</button>
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

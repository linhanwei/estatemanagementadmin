<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 25/04/16
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
        APP推送管理
        <small>运营工具</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>运营工具</a></li>
        <li class="active">APP推送管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">推送消息列表</g:link></li>
                    <li>
                        <g:link action="addHtml">添加推送消息</g:link>
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
                    <th style="width: 60px"><i class="fa "></i>推送ID</th>
                    <th style="width: 120px"><i class="fa "></i>推送标题</th>
                    <th style="width: 200px"><i class="fa "></i>推送内容</th>
                    <th style="width: 80px"><i class="fa "></i>安卓首次推送成功数量</th>
                    <th style="width: 80px"><i class="fa "></i>苹果首次推送成功数量</th>
                    <th style="width: 80px"><i class="fa "></i>安卓推送成功总数量</th>
                    <th style="width: 80px"><i class="fa "></i>苹果推送成功总数量</th>
                    %{--<th style="width: 100px"><i class="fa "></i>推送后返回消息ID</th>--}%
                    <th style="width: 110px"><i class="fa fa-calendar">修改时间</i></th>
                    <th style="width: 110px"><i class="fa fa-calendar">添加时间</i></th>
                    <th style="width: 130px"><i class="fa ">操作</i></th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${msgPushList}" var="msgPush">
                        <tr id="${msgPush?.id}" class="info">
                            <td>${msgPush?.id}</td>
                            <td>${msgPush?.msg_title}</td>
                            <td>${msgPush?.msg_content}</td>
                            <td>${msgPush?.andorid_succ_num}</td>
                            <td>${msgPush?.ios_succ_num}</td>
                            <td class="android_succ_total">${msgPush?.andorid_succ_total_num}</td>
                            <td class="ios_succ_total">${msgPush?.ios_succ_total_num}</td>
                            %{--<td>${msgPush?.jpush_msg_id}</td>--}%
                            <td>${msgPush?.last_updated}</td>
                            <td>${msgPush?.date_created}</td>

                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location.replace('/mikuJGhttp/editHtml?id=${msgPush?.id}')">
                                    编辑
                                </button>
                                <button type="button" class="btn btn-success btn-sm"
                                         id="send_msg" mid="${msgPush?.id}" >
                                     发送
                                </button>
                                <button type="button" class="btn btn-success btn-sm"
                                        mid="${msgPush?.id}" msg_id="${msgPush?.jpush_msg_id}" id="refresh_number" >
                                    刷新推送数量
                                </button>
                                %{--<button type="button" class="btn btn-danger btn-sm"--}%
                                        %{--onclick="deleteCoupon(${coupon?.id})">--}%
                                    %{--删除--}%
                                %{--</button>--}%
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
    $(function(){
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

        //发送消息
        $('#send_msg').click(function(){
            if (!confirm("您真的要发送么？")) {
                return;
            }

            var _this = $(this),
                id = _this.attr('mid');

            $.ajax({
                url: '/mikuJGhttp/singleSendMsg',
                data: {'id': id},
                type: "POST",
                dataType: "json",
                success: function (data) {
                    alert(data.msg);
                    if(data.result){
                        $('#refresh_number').attr('msg_id',data.result);
                    }
                },
                error: function (data) {
                    alert('发送失败');
                }
            });
        });

        //刷新推送成功数量
        $('#refresh_number').click(function(){
            var _this = $(this),
                _this_parent = _this.parents('tr'),
                msg_id = _this.attr('msg_id'),
                id = _this.attr('mid');

            $.ajax({
                url: '/mikuJGhttp/getSendMsgResult',
                data: {'msg_id': msg_id,'id':id},
                type: "POST",
                dataType: "json",
                success: function (data) {
                    alert(data.msg);
                    _this_parent.find('.android_succ_total').text(data.result.android_received);
                    _this_parent.find('.ios_succ_total').text(data.result.ios_received);


                },
                error: function (data) {
                    alert("操作失败");

                }
            });
        });

    });

</script>


</body>

</html>

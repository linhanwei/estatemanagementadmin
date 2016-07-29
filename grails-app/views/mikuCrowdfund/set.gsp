<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/23
  Time: 10:48
--%>
<%@ page import="org.joda.time.DateTime;com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>


    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
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
        支持项名称: ${title}
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>众筹管理</a></li>
        <li class="active">众筹配置:支持项列表</li>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="list">页面列表</g:link>
                    </li>
                    <li>
                        <g:link action="add">新增众筹</g:link>
                    </li>
                    <li class="active">
                        <a href="/mikuCrowdfund/set?id=${id}&title=${title}">支持项配置</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="row">
            <div class='col-xs-12'>
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="/mikuCrowdfund/set?id=${id}&title=${title}">支持项列表</a>
                        </li>
                        <li>
                            <a href="/mikuCrowdfund/addDetail?id=${id}&title=${title}">新增支持项</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="box-body table-responsive no-padding">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center text-justify">
                <tr>
                    <th>名称</th>
                    <th>编码</th>
                    <th>价格</th>
                    <th>支持数</th>
                    <th>限量数</th>
                    <th>权重</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>

                <g:if test="${total > 0}">
                    <g:each status="i" in="${list}" var="ml">
                        <tr id="${ml?.id}" class="info">
                            <td>
                                <a href="/mikuCrowdfund/editDetail?id=${ml?.id}">${ml?.title}</a>
                            </td>
                            <td>
                                ${ml?.code}
                            </td>
                            <td>
                                ${ml?.price/100f}
                            </td>
                            <td>
                                ${ml?.soldNum}
                            </td>
                           <td>
                               <input onchange="modifyParam('${ml?.id}',0)" type="text"
                                      value="${ml?.num}" name="${ml?.id}" class="no-border" id="num${ml?.id}"
                                      style="width:30px;background:transparent;">
                           </td>
                           <td>
                               <input onchange="modifyParam('${ml?.id}',1)" type="text"
                                      value="${ml?.weight}" name="${ml?.id}" class="no-border" id="qu${ml?.id}"
                                      style="width:30px;background:transparent;">
                            </td>
                            <td>
                                <g:if test="${ml?.approveStatus == 0 as byte}">
                                    隐藏
                                </g:if>
                                <g:elseif test="${ml?.approveStatus == 1 as byte}">
                                    显示
                                </g:elseif>
                                <g:elseif test="${ml?.approveStatus == -1 as byte}">
                                    删除
                                </g:elseif>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary btn-success"
                                        onclick="window.location.replace('doForDetail?id=${ml?.id}&status=1&cid=${id}&title=${title}')">显示</button>
                                <button type="button" class="btn btn-primary btn-info"
                                        onclick="window.location.replace('doForDetail?id=${ml?.id}&status=0&cid=${id}&title=${title}')" >隐藏</button>
                                <button type="button" class="btn btn-primary btn-sm"
                                        onclick="window.location.replace('doForDetail?id=${ml?.id}&status=-1&cid=${id}&title=${title}')">删除</button>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        </div>
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
    function modifyParam(id,flag)
    {
        var target="",name="";
        if(flag){
            target = $("#qu"+id).val().trim();
            name="weight";
        }
        else{
            target = $("#num"+id).val().trim();
            name="num";
        }
        if(!target)
        {
            alert("对应的权重不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(target);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/mikuCrowdfund/modifyParam',
                data: {'id': id, 'target': num,'name':name},
                type: "POST",
                dataType: "json",
                success: function (data) {
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的权重只能填数字类型...");
            return false;
        }
    }


</script>
</body>
</html>
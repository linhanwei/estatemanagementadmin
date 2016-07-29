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
    <!-- select2 -->
    <asset:stylesheet src="select2/select2.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>

    %{--<!-- iCheck -->--}%
    %{--<asset:stylesheet src="iCheck/square/blue.css"/>--}%
    %{--<!-- Bootstrap time Picker -->--}%
    %{--<asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>--}%
    %{--<!-- web uploader -->--}%
    %{--<asset:stylesheet src="third-party/webuploader/webuploader.css"/>--}%
    %{--<asset:stylesheet src="third-party/webuploader/style.css"/>--}%
    %{--<asset:stylesheet src="third-party/webuploader/style2.css"/>--}%


    <asset:stylesheet src="skins/skin-blue.css"/>
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
        众筹项目列表
        <small>众筹管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>众筹管理</a></li>
        <li class="active">众筹项目列表</li>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="list">页面列表</g:link>
                    </li>
                    <li>
                        <g:link action="add">新增众筹</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
            <g:form action="list" class="form-inline">
                <div class="box-header">
                <div class="form-group">
                    <label>众筹名称：</label>
                    <input  name="query" class="form-control"
                            style="width: 190px" value="${params.query}"
                            placeholder="众筹名称"/>
                </div>
                <div class="form-group">
                    <label>众筹状态：</label>
                    <g:select optionKey="key" optionValue="value" name="selectstatus"
                              class="form-control" from="${FalgMap}" value="${params.selectstatus}"
                              noSelection="['': '众筹状态']"/>
                </div>
                <div class="form-group">
                    <label>查询页码：</label>
                        <g:select optionKey="key" optionValue="value" name="max"
                                  class="form-control" from="${PageMap}" value="${params.max}"
                                  noSelection="['10': '请选择页码']"/>
                </div>
                    <button type="submit"
                            class="btn btn-primary"><i
                            class="fa fa-search">查询</i></button>
                </div>
            </g:form>


        <div class="box-body table-responsive no-padding">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center text-justify">
                <tr>
                    <th>名称</th>
                    <th style="position: relative">目标
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('targetAmount-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('targetAmount-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th style="position: relative">支持
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('totalFee-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('totalFee-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th style="position: relative">支持数
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('soldNum-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('soldNum-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    <th style="position: relative">开始时间
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('startTime-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('startTime-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    </th>

                    <th>结束时间</th>
                    <th>发货周期(天)</th>
                    <th>状态</th>
                    </th>
                    <th style="position: relative">支持%
                    </th>
                    <th style="position: relative">权重
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('weight-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('weight-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${list}" var="ml">
                        <tr id="${ml?.id}" class="info">
                            <td>
                                ${ml?.title}
                                <div style="padding-top: 10px;color: red">
                                    ${ml?.id}
                                </div>
                            </td>
                            <td>
                                ${ml?.targetAmount/100f}
                            </td>
                            <td>
                                ${ml?.totalFee}
                            </td>
                           <td>
                                ${ml?.soldNum}
                            </td>

                           <td>
                                ${ml?.startTime}
                            </td>
                            <td>
                                ${ml?.endTime}
                            </td>
                            <td>
                                ${ml?.plusDay}
                            </td>
                            <td>
                                %{--(-1=无效;0=正常;1=成功;2=失败)--}%
                                <g:if test="${ml?.status== 0 as byte}">
                                    正常
                                </g:if>
                                <g:elseif test="${ml?.status== 1 as byte}">
                                    成功
                                </g:elseif>
                                <g:elseif test="${ml?.status== 2 as byte}">
                                    失败
                                </g:elseif>
                            </td>
                            <td>
                                ${Math.round(ml?.totalFee/ml?.targetAmount*100f)}%
                            </td>
                            <td>
                                <input onchange="modiweight('${ml?.id}')" type="text"
                                       value="${ml?.weight}" name="${ml?.id}" class="no-border" id="qu${ml?.id}"
                                       style="width:30px;background:transparent;">
                            </td>
                            <td>
                                <g:if test="${ml?.approveStatus== 0 as byte}">
                                    下架
                                </g:if>
                                <g:elseif test="${ml?.approveStatus== 1 as byte}">
                                    上架
                                </g:elseif>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary btn-success"
                                        onclick="window.location.replace('edit?id=${ml?.id}')">编辑</button>
                                <button type="button" class="btn btn-primary btn-info"
                                        onclick="window.location.replace('set?id=${ml?.id}&title=${ml?.title}')">支持项</button>
                                <button type="button" class="btn btn-primary btn-error"
                                        onclick="window.location.replace('detele?id=${ml?.id}')">删除</button>
                                <g:if test="${ml?.approveStatus== 0 as byte}">
                                    <button type="button" class="btn btn-primary btn-info"
                                            onclick="window.location.replace('changeApprove?status=1&id=${ml?.id}')">上架</button>
                                </g:if>
                                <g:elseif test="${ml?.approveStatus== 1 as byte}">
                                    <button type="button" class="btn btn-primary btn-warning"
                                            onclick="window.location.replace('changeApprove?status=0&id=${ml?.id}')">下架</button>
                                </g:elseif>

                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->

    <div class="box-footer clearfix">
        <g:if test="${total > 0}">
            <div class="pagination pull-right">
                <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                            maxsteps="10" action="list" total="${total}"/>
            </div>
        </g:if>
        </div>
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
    function modiweight(id)
    {
        var newWeight = $("#qu"+id).val().trim();
        if(!newWeight)
        {
            alert("对应的权重不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(newWeight);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/mikuCrowdfund/updateOneweight',
                data: {'id': id, 'weight': newWeight},
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



    //进行各类的排序
    function paixu(content){
        var flag=content;
        var stateArr=content.split("-");
        var field=stateArr[0];
        var fieldstate=stateArr[1];
        var query=$("input[name=query]").val();
        var selectstatus=$("select[name=selectstatus]").val();
        var pagesize=$("select[name=max]").val();
        var str='/mikuCrowdfund/list?max='+pagesize+"&query="+query+"&selectstatus="+selectstatus+"&fieldName="+field+"&fieldstate="+fieldstate;
        window.location.replace(str);
    }




    function myajax(){
        //这里是获取的是你表单的那2个值
        var fnameValue=$("input[name=fname]").val();
        var lnameValue=$("input[name=lname]").val();
        //传参数给你的接口，用ajax来进行调用
        $.ajax({
            //你的接口名称
            url: 'http://项目名称//form_action.asp',
            //参数的名称-->注意是json方式来传 key:value【key就是你的ipnut标签的name值，value就是你的ipnut标签的value值】
            data: {'fname': fnameValue, 'lname': lnameValue},
            //请求接口有2种方式请求：GET 或者 POST【相当于form的method一样】
            type: "POST",
            //你传给你的接口的数据方式，显然上面的{'fname': fnameValue, 'lname': lnameValue}就是json方式
            dataType: "json",
            //ajax的好处是页面没有刷新，异步加载【就是不用刷新页面就能请求后台接口数据】
            //如果按照你的需求的话，则这里应该得到参数应该是php做好有图片的页面链接
            success: function (data) {
                debugger;
               //假设data=php做好有图片的页面链接url，直接跳转即可
                window.location.replace(data);
            },
            error: function (data) {
                //这里是后台接口返回的错误，一般不会出现，如果出现了也是后台接口的问题，data则为错误的信息
                //不操作也可以.
            }
        });
    }

</script>
</body>
</html>
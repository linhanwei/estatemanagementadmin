<%--
Created by IntelliJ IDEA.
User: spider
Date: 26/9/14
Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
    <!-- ztree -->
    <asset:stylesheet src="zTreeStyle.css"/>
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
    <head>
        <title></title>
    </head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1> 课程管理 <small>课程</small> </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>私人订制</a></li>
        <li class="active">课程管理</li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li ><g:link action="index">课程列表</g:link></li>
                    <li><g:link action="addCourseView">添加课程</g:link></li>
                    <li class="active"><g:link action="lessonList">课时列表</g:link></li>
                    <li><g:link action="addLessonView">添加课时</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="header-box form-inline" style="overflow: hidden;">
            <form action="lessonList" class="form-inline content-header">
                <div class="col-lg-4 form-group">
                    <label class="control-label">课时名称：</label>
                    <input name="lessonName" class="form-control" value="" type="text" placeholder="课时名称">
                </div>
                %{--<div class="col-lg-4 form-group">--}%
                %{--<label class="control-label">课程类型：</label>--}%
                %{--<g:select optionKey="key" optionValue="value" name="courseType"--}%
                %{--class="form-control" from="${courseTypeMap}" value="${params.courseType}"--}%
                %{--noSelection="['': '请选择']"/>--}%
                %{--</div>--}%

                <div class="col-lg-4 form-group">

                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>搜索</button>
                </div>

            </form>

            %{--<!-- 导入出 -->--}%
            %{--<div class="col-lg-12 form-group text-right" style="margin-top: 5px;">--}%
            %{--<button type="submit" class="btn btn-success"><i class="fa fa-download"></i>导出Excel</button>--}%
            %{--<button  class="btn btn-primary" id="inputExcel"><i class="fa fa-upload"></i>导入Excel</button>--}%
            %{--<g:link controller="mikuProvider" action="createOneModelExcel" target="_blank" params="[flag:'0']">下载模板</g:link>--}%
            %{--</div>--}%
        </div>

        <div class="table-responsive box-body">
            <table class="table table-hover table-bordered text-center">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>课时名称</th>
                    <th>课时简称</th>
                    %{--<th>课程类型</th>--}%
                    <th>课时时长(分)</th>
                    <th>课时步骤数</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <g:each status="i" in="${list}" var="li">
                    <tr>
                        <td>${i+1}</td>
                        <td>${li.lessonName}</td>
                        <td>${li.lessonShortName}</td>
                        %{--<td>--}%
                        %{--${courseTypeMap.get(li?.courseType)}--}%
                        %{--</td>--}%
                        <td>
                            ${li.lessonTime}
                        </td>
                        <td>
                            ${li.lessonStepsNum}
                        </td>
                        <td>

                            <button class="btn btn-primary" onclick="window.location.replace('/mikuPlanCourseManage/editLessonView?id=${li.id}')">编辑</button>
                            <button class="btn btn-danger d_btn" data_id="${li.id}" >删除</button>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
            %{--${params}--}%
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                                maxsteps="5" action="lessonList" total="${total}"/>
                </div>
            </g:if>
        </div>
    </div>
</section>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- ztree -->
<asset:javascript src="jquery.ztree.all.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>

<script>


    $(document).on('click','.d_btn',function(){
        var id=$(this).attr('data_id');
        var data={
            'id':id
        }
        if(confirm('确定删除此条记录?')){
            ajax_call(d_success,'/mikuTplCourseManage/delLesson',data,nf);
        }

    })

    //删除成功
    function d_success(data){
        alert(data.msg);
        if(data.status==1){
            window.location.reload();
        }
    }


    icheck();
    %{--icheck--}%
    function icheck(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    }

    //        ajax
    function ajax_call(success,url,data,error) {
        $.ajax({
            url: url,
            data: data,
            type: "POST",
            dataType: "json",
            success: function (data) {
                success(data);
            },
            error: function (data) {
                error(data)
            }
        });
    }

    //空方法
    function nf(){}
</script>
</body>
</html>
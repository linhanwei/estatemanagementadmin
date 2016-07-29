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
    <!-- bootstrap-multiselect -->
    <asset:stylesheet src="bootstrap-multiselect/bootstrap-multiselect.css"/>




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
        员工管理
        <small>系统管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>系统管理</a></li>
        <li class="active">员工管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a href="#employeeList" data-toggle="tab">员工列表</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">

            <h2>${community?.name}</h2>

        </div>

        <div class="box-body no-padding form-horizontal">
            <table class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th>站点归属</th>
                    <th>名字</th>
                    <th>手机号</th>
                    <th>是否有效</th>
                    <th>角色</th>
                    <th>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${employeeList}" var="employee">
                        <tr id="${employee?.id}" class="info">
                            <td>${EmployeeMap.get(employee?.id)?.name}</td>
                            <td>${employee?.name}</td>
                            <td>${employee?.mobile}</td>
                            <td>${employee?.status == 1 as byte ? '有效' : '无效'}</td>
                            <td>${(employee?.role)*.name}</td>
                            <td>
                                <button class="btn btn-warning btn-sm"
                                        onclick="editEmployeeRoles(${employee.id})">更新角色</button>
                                <button class="btn btn-danger btn-sm"
                                        onclick="deleteEmployee(${employee.id})">删除员工</button>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <g:if test="${total > 0}">
                    <div class="pagination pull-right">
                        <g:paginate next="下一页" prev="上一页" params="${params}"
                                    maxsteps="10" action="index" total="${total}"/>
                    </div>
                </g:if>
            </g:if>
        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">编辑角色</h4>
            </div>

            <g:form action="updateEmployeeRole" useToken="true">
                <div class="modal-body form-horizontal">
                    <input id="selectedEmployeeId" name="selectedEmployeeId" style="display: none;">

                    <div id="selectedRoles">
                        <g:render template="roles"/>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </g:form>
        </div>
    </div>
</div>


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
<!-- bootstrap-multiselect -->
<asset:javascript src="bootstrap-multiselect/bootstrap-multiselect.js"/>



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

    function editEmployeeRoles(id) {
        <g:remoteFunction params="{'id': id}" action="queryEmployeeRoles" asynchronous="false" update="selectedRoles" onSuccess="roleModalShow(id)"/>
    }

    function roleModalShow(id) {
        $('#selectedEmployeeId').val(id)
        $('#roleSelect').multiselect({
            buttonText: function (options, select) {
                if (options.length === 0) {
                    return '没有添加任何角色 ... ';
                }
                else {
                    var labels = [];
                    options.each(function () {
                        if ($(this).attr('label') !== undefined) {
                            labels.push($(this).attr('label'));
                        }
                        else {
                            labels.push($(this).html());
                        }
                    });
                    return labels.join(';');
                }
            }
        });


        $('#myModal').modal('show')
    }

    function deleteEmployee(id) {
        if (!confirm("您确定要删除该员工么？")) {
            return;
        }

        $.ajax({
            url: '/employee/deleteEmployee',
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

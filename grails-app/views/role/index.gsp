<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.apache.commons.lang3.StringUtils; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
        角色管理
        <small>系统功能</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>系统功能</a></li>
        <li class="active">角色管理</li>
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
            <div style="margin-top: 10px;"></div>

            <g:if test="${flash.message}">
                <p class="bg-danger">${flash.message}</p>
            </g:if>

        <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                新增角色
            </button>

        </div>

        <div class="box-body no-padding form-horizontal">
            <table class="table table-bordered">
                <tr>
                    <th>角色名字</th>
                    <th>角色权限</th>
                    <th>操作</th>
                </tr>
                <g:each status="i" in="${roleList}" var="role">
                    <tr id="${role?.id}">
                        <td>${role?.name}</td>
                        <td>${StringUtils.join(role.permissions, ';')}</td>
                        <td>
                            <button class="btn btn-success btn-sm"
                                    onclick="editRolePermissions(${role.id})">编辑权限</button>
                            <button class="btn btn-danger btn-sm" onclick="deleteRole(${role.id})">删除角色</button>
                        </td>
                    </tr>
                </g:each>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

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
                <h4 class="modal-title" id="myModalLabel">新增角色</h4>
            </div>

            <g:form action="createRole" useToken="true">
                <div class="modal-body form-horizontal">
                    <div class="form-group">
                        <label class="col-xs-2 control-label">角色</label>

                        <div class="col-xs-8">
                            <input class="form-control" name="role">
                        </div>
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

<!-- Modal -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel2">编辑权限</h4>
            </div>

            <g:form action="updateRolePermissions" useToken="true">
                <div class="modal-body form-horizontal">
                    <input id="selectedRoleId" name="selectedRoleId" style="display: none;">
                    <input id="selectedmyPermisions" name="selectedmyPermisions" style="display: none;">
                    <div id="selectedPermissions">
                        <g:render template="permissions"/>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="mysaveBtn">保存</button>
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
    function editRolePermissions(id) {
        <g:remoteFunction params="{'id': id}" action="queryRolePermissions" asynchronous="false" update="selectedPermissions" onSuccess="checkboxShow(id)"/>
    }
    function checkboxShow(id)
    {
        $('#selectedRoleId').val(id);
        $('#myModal2').modal('show');
        $("input[type='checkbox']").on('click', function() {
            var checkedFlg=$(this).attr('checkedFlg').trim();
            if(checkedFlg=="1")
            {
                $(this).attr('checkedFlg','0');
            }
            else
            {
                $(this).attr('checkedFlg','1');
            }
        });

    }






    function permissionModalShow(id) {
        $.ajax({
            url: '/role/testMyselect',
            data: {'id': id},
            type: "POST",
            success: function (data) {
                debugger;
                var obj=eval("("+data+")");
                $('#permissionSelect').multiselect({
                    //这个是按钮的文本内容值
                    buttonText: function (options, select) {
                        if (obj.length === 0) {
                            return '没有添加任何权限 ... ';
                        }
                        else {
                            return '对应权限';
                        }
                    }
                });
                $('#myModal2').modal('show');

                $('#selectedRoleId').val(id);
                var liobj=$("#selectedPermissions").find('.dropdown-menu').children();
                $.each(obj,function(index,item){
                    var tiltle=item.title.trim();
                    //进行遍历所有的标签进行赋值
                    $.each(liobj,function(i,item){
                        var lititle= $(item).find('.checkbox').text().trim();
                        if(tiltle==lititle)
                        {
                            debugger;
                            $(item).find('input[type=checkbox]').click();
                            $(item).attr("class","active");
                            return;
                        }
                    })
                });
            }
        });


//        debugger;
//        $('#selectedRoleId').val(id)
//        $('#permissionSelect').multiselect({
//            //这个是按钮的文本内容值
//            buttonText: function (options, select) {
//                debugger;
//                if (options.length === 0) {
//                    return '没有添加任何权限 ... ';
//                }
//                else {
//                    var labels = [];
//                    options.each(function () {
//                        if ($(this).attr('label') !== undefined) {
//                            labels.push($(this).attr('label'));
//                        }
//                        else {
//                            labels.push($(this).html());
//                        }
//                    });
//                    return labels.join(';');
//                }
//
//
//
//            }
//        });

//        var liobj=$("#selectedPermissions").find('.dropdown-menu').children();
//        $.each(liobj,function(i,item){console.log(item.find('label'))})
//        $(item).find('.checkbox').text().trim()


    }

    function deleteRole(id) {
        if (!confirm("您确定要删除这个角色么，角色删除后，关联用户可能无法操作？")) {
            return;
        }

        $.ajax({
            url: '/role/deleteRole',
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


    //函数的初始化
    $(function(){
        //进行保存的操作
        $('#mysaveBtn').click(function(){
            debugger;
            var arr=[];
            $('.mycheckbox').each(function(index,checkname){
                var checkedFlg =$(this).attr('checkedFlg').trim();
                if(checkedFlg=="1")
                {
                    arr.push($(this).attr("idflag"));
                }
            });
            $("#selectedmyPermisions").val(arr.join(','));
        });
    });
</script>

</body>

</html>

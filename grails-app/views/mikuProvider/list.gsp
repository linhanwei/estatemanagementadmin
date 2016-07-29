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
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- ztree -->
    <asset:stylesheet src="zTreeStyle.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>

    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>

    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <style>
    .tipeHide{display: none;color: red}

    </style>
    <!-- zTress-style -->
    <style type="text/css">
    .ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
    </style>

</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        添加供应商商品
        <small>供应商品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>供应商管理</a></li>
        <li class="active">添加供应商</li>
    </ol>
</section>

<!-- Main content -->
<!-- Main content -->
<!-- Content Header (Page header) -->
<section class="content-header">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="list">列表信息</g:link></li>
                    <li><g:link action="index">新增供应商</g:link></li>
                </ul>
            </div>
        </div>
    </div>
    %{--<div class="header-box" style="overflow: hidden;">--}%
    %{--<form action="" class="form-inline">--}%
    %{--<div class="col-sm-6 col-md-5 form-group">--}%
    %{--<label class="control-label" style="">货号/条码/商品名称/商品简码：</label>--}%
    %{--<input name="query" class="form-control" value="" placeholder="查询相应货号、条码、商品名称、商品简码">--}%
    %{--<button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 查询</button>--}%
    %{--</div>--}%
    %{--<div class="col-sm-6 col-md-4 form-group">--}%
    %{--<div class="col-xs-6">--}%
    %{--<input type="checkbox" />--}%
    %{--<lable>是否显示停销商品</lable>--}%
    %{--</div>--}%
    %{--<div class="col-xs-6">--}%
    %{--<input type="checkbox" />--}%
    %{--<lable>是否显示停销商品</lable>--}%
    %{--</div>--}%
    %{--<div class="col-xs-6">--}%
    %{--<input type="checkbox" />--}%
    %{--<lable>是否显示停销商品</lable>--}%
    %{--</div>--}%

    %{--</div>--}%
    %{--</form>--}%
    %{--</div>--}%

</section>
<!-- Main content -->
<section class="content" style="padding-top: 0;">
    <div class="row">

        <div class="col-xs-2" style="padding-right: 0;">
            <div id="trees-left" class="box box-primary">
                <div class="box-header">
                    <div class="box-tools"> </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body  no-padding" style="position: relative;">
                    <input id="selectedId" style="display: none;">
                    <input id="selectedName" style="display: none;">
                    <input id="selectedFeatures" style="display: none;">
                    <div id="jstree" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="20000007" aria-busy="false">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                <!-- 按钮触发模态框 -->
                    <button class="btn" style="position: absolute;top: 0;right: 0;background-color: #fb4e90;color: #fff;display: none;" id="click_btnh" data-toggle="modal"
                            data-target="#myModal">
                        新增类目
                    </button>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
        <!-- 右侧box -->
        <section class="content-header col-xs-10" style="margin-bottom: 10px;">
        <form action="list" class="form-inline">
            <div class="header-box" style="background-color: white;">
                <div class="col-md-4 form-group">
                    <label class="control-label">供应商名称：</label>
                    <input name="supplier" class="form-control" value="${params.supplier}" type="text">
                </div>
                <div class="col-md-4 form-group">
                    <label class="control-label">电话：</label>
                    <input name="phone" class="form-control" value="${params.phone}" type="tel">
                </div>



                <div class="col-md-4 form-group">
                    <label class="control-label" >查询页码：</label>
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '页码']"/>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>搜索</button>
                </div>
            </div>
        </form>
        </section>
        <div id="operation" class="col-xs-10">
        <div class="box box-primary " style="padding-top:10px;">
            <div class="table-responsive">
                <table class="table table-hover table-bordered text-center">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>供应商名称</th>
                        <th>简称</th>
                        <th>联系人</th>
                        <th>职务</th>
                        <th>电话</th>
                        <th>账期</th>
                        <th>地区</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                        <g:each status="i" in="${list}" var="li">
                            <tr>
                            <td>${i+1}</td>
                            <td>${li.name}</td>
                            <td>${li.sname}</td>
                            <td>${li.cperson}</td>
                            <td>${li.job}</td>
                            <td>${li.mobile}</td>
                            <td>${li.accounttime}</td>
                            <td>${li.address}</td>
                            <td>
                                <button class="btn btn-warning" onclick="window.location.replace('/mikuProvider/edit?id=${li.id}')">编辑</button>
                                <button class="btn btn-danger" onclick="window.location.replace('/mikuProvider/deleteProvider?id=${li.id}')">删除</button>
                                <button class="btn btn-info" onclick="window.location.replace('/mikuProvider/copy?id=${li.id}')">复制</button>
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
                                    maxsteps="5" action="list" total="${total}"/>
                    </div>
                </g:if>
            </div>
        </div>
            <!-- /.box -->
        </div>

    </div>
</section>

<!-- /.content -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    新增类目
                </h4>
            </div>
            <div class="modal-body">
                <input id="in-w" type="text" class="form-control" placeholder="">
                <input type="hidden" id="cate_pid" name="cate_pid" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">取消
                </button>
                <button id="s_click" type="button" class="btn btn-primary">
                    确定
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>



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


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<!-- zTress-javascript -->
<script type="text/javascript">
    <!--
    var setting = {
        view: {
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false
        },
        edit: {
            enable: true,
            editNameSelectAll: true,
            showRemoveBtn: showRemoveBtn,
            showRenameBtn: true
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeDrag: beforeDrag,
            beforeEditName: beforeEditName,
            beforeRemove: beforeRemove,
            beforeRename: beforeRename,
            onRemove: onRemove,
            onRename: onRename,
            onClick: zTreeOnClick,
            onDblClick: zTreeOnDblClick
        }
    };

    var zNodes;

    //树加载
    $.ajax({
        url: '/mikuSupplierClassify/list',
        type: "POST",
        dataType: "json",
        async:false,
        success: function (data) {
            zNodes=data;
            if(data.length<=0){
                $('#click_btnh').show();
            }
        },
        error: function (data) {
            //失败
        }
    });

    var log, className = "dark";
    function beforeDrag(treeId, treeNodes) {
        return false;
    }

    function beforeEditName(treeId, treeNode) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.selectNode(treeNode);
        return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
    }
    function beforeRemove(treeId, treeNode) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.selectNode(treeNode);
        // return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
        if(confirm("确认删除节点 -- " + treeNode.name + " 吗？")){
            //确定删除触发
            $.ajax({
                url: '/mikuSupplierClassify/del?id='+treeNode.id,
                type: "POST",
                dataType: "json",
                success: function (data) {
                    //成功
                    $.fn.zTree.init($("#treeDemo"), setting, data);
                },
                error: function (data) {
                    //失败
                    alert('删除失败！');
                }
            })
        }else{
            return false;
        }
    }
    function onRemove(e, treeId, treeNode) {
        showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
    }
    function beforeRename(treeId, treeNode, newName, isCancel) {
        className = (className === "dark" ? "":"dark");
        showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
        if (newName.length == 0) {
            alert("节点名称不能为空.");
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            setTimeout(function(){zTree.editName(treeNode)}, 10);
            return false;
        }else{
            $.ajax({
                url: '/mikuSupplierClassify/edit?id='+treeNode.id+'&name='+newName,
                type: "POST",
                dataType: "json",
                success: function (data) {
                    //成功
                    $.fn.zTree.init($("#treeDemo"), setting, data);
                },
                error: function (data) {
                    //失败
                    alert('编辑失败！');
                }
            });
        }
        return true;
    }
    function onRename(e, treeId, treeNode, isCancel) {
        showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
    }
    function showRemoveBtn(treeId, treeNode) {
//        return !treeNode.isFirstNode;
        if(treeNode.level == 0){
            return false;
        }else{
            return true;
        }
    }
    function showRenameBtn(treeId, treeNode) {
        return !treeNode.isLastNode;
    }
    function showLog(str) {
        if (!log) log = $("#log");
        log.append("<li class='"+className+"'>"+str+"</li>");
        if(log.children("li").length > 8) {
            log.get(0).removeChild(log.children("li")[0]);
        }
    }
    function getTime() {
        var now= new Date(),
                h=now.getHours(),
                m=now.getMinutes(),
                s=now.getSeconds(),
                ms=now.getMilliseconds();
        return (h+":"+m+":"+s+ " " +ms);
    }

    $('#s_click').bind('click',function(){
//        var newCount = 1;
        var _val=$('#in-w').val();//名字
        var treeNode_id=$('#cate_pid').val();;//父节点id
        $.ajax({
            url: '/mikuSupplierClassify/add?name='+_val+'&pId='+treeNode_id,
            type: "POST",
            dataType: "json",
            success: function (data) {
                //成功
                alert('添加成功！');
                $('#myModal').modal('hide');
                $.fn.zTree.init($("#treeDemo"), setting, data);
            },
            error: function (data) {
                //失败
                alert('添加失败！');
            }
        });
    });


    var newCount = 1;

    function addHoverDom(treeId, treeNode) {
        if(treeNode.level === 0 || treeNode.level === 1){//添加按钮的隐藏
            return false;
        }else{
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
//            var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
//                    + "' title='add node' onfocus='this.blur();'></span>";
//            sObj.after(addStr);
        }
    };

    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };
    function selectAll() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
    }
    //树枝单击
    function zTreeOnClick(event, treeId, treeNode) {
        var cate_id = treeNode.id;
        $('#cate_pid').val(cate_id);
        $('#click_btnh').show();
    };
    //树枝双击
    function zTreeOnDblClick(event, treeId, treeNode) {
        if(treeNode.isParent){
            window.location.replace('/mikuProvider/list?isparent=1&tid='+treeNode.id);
        }else{
            window.location.replace('/mikuProvider/list?isparent=0&tid='+treeNode.id);
        }
    };
    //初始化
    $(document).ready(function(){
        $('#trees-left').css({'min-height':$('#operation .box').height()+80,'max-height':$('#operation .box').height()+80,'overflow':'auto'});
//        $('#trees-left').css({'height':$(window).height()*0.76+22,'overflow':'auto'});
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        $("#selectAll").bind("click", selectAll);
    });
    //-->
</script>

</body>

</html>

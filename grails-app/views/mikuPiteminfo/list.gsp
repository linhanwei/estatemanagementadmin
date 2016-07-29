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

    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
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
                    <li><g:link action="index">新增供应商商品</g:link></li>
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
        <section class="content-header col-xs-10" style="margin-bottom: 10px;">
            <form action="list" class="form-inline">
                <div class="header-box" style="background-color: white;">
                    <div class="col-md-4 form-group">
                        <label class="control-label">商品名称：</label>
                        <input name="commodity" class="form-control" value="${params.commodity}" type="text">
                    </div>
                    <div class="col-md-4 form-group">
                        <label class="control-label">米酷码：</label>
                        <input name="miic" class="form-control" value="${params.miic}" type="text">
                    </div>
                    <div class="col-md-4 form-group">
                        <label class="control-label">商品编码：</label>
                        <input name="cic" class="form-control" value="${params.cic}" type="text">

                    </div>

                    <div class="col-md-4 form-group" style="margin-top: 5px;">
                        <label class="control-label" >查询页码：</label>
                        <g:select optionKey="key" optionValue="value" name="max"
                                  class="form-control" from="${PageMap}" value="${params.max}"
                                  noSelection="['10': '页码']"/>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>搜索</button>
                    </div>

                </div>
            </form>
        </section>
        <!-- 右侧box -->
        <div id="operation" class="col-xs-10">
            <div class="box box-primary " style="padding-top:10px;">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>商品名称</th>
                            <th>规格</th>
                            <th>是否出货商品</th>
                            <th>商品编码</th>
                            <th>邮费</th>
                            <th>地区</th>
                            <th>库存</th>
                            <th>进货价</th>
                            <th>销售价</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                            <g:each status="i" in="${list}" var="li">

                                <g:if test="${li.weight==1 as byte}">
                                    <tr class="danger">
                                </g:if>
                                <g:else>
                                    <tr>
                                </g:else>
                                   <td>${i+1}</td>
                                    <td>${li.title}</td>
                                    <td>${li.type}</td>
                                    <td>
                                        <g:if test="${li.weight==1 as byte}">
                                            是
                                        </g:if>
                                        <g:else>
                                            否
                                        </g:else>
                                    </td>
                                    <td>${li.code}</td>
                                    <td>${li.postFee/100f}</td>
                                    <td>${li.area}</td>
                                    <td>${li.rknum}</td>
                                    <td>${li.jhprice/100f}</td>
                                    <td>${li.xsprice/100f}</td>
                                    <td>
                                        <button class="btn btn-success" id="recall" data_id="${li.id}">撤销审核</button>
                                        <button class="btn btn-warning" onclick="window.location.replace('/mikuPiteminfo/edit?id=${li.id}')">编辑</button>
                                        <button class="btn btn-danger" onclick="window.location.replace('/mikuPiteminfo/delete?id=${li.id}')">删除</button>
                                        <button class="btn btn-info" onclick="window.location.replace('/mikuPiteminfo/copy?id=${li.id}')">复制</button>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <div class="box-footer clearfix">
                        <g:if test="${total > 0}">
                            <div class="pagination pull-right">
                                <g:paginate next="下一页" prev="上一页" params="${params}"
                                            maxsteps="10" action="list" total="${total}"/>
                            </div>
                        </g:if>
                    </div><!-- /.box-footer-->
                </div>
                </div>
            </div>
        %{--fd--}%
            <!-- /.box -->
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


    $(document).on('click','#recall',function(){//撤回审核商品
        var id=$(this).attr('data_id');
        var data={
            'id':id
        }
        if(confirm('确定撤回该商品？')){
            ajax_call1(recall_success,'/mikuPiteminfo/cancelCheck',data,nf);
        }
    })



    //商品撤回成功
    function recall_success(){
        alert('商品已撤回！');
        location.reload();
    }


    //ajax
    function ajax_call1(success,url,data,error) {
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
        url: '/mikuProvider/selectClassify',
        type: "POST",
        dataType: "json",
        async:false,
        success: function (data) {
            zNodes=data;
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
                url: '/mikuProvider/deleteClassify?id='+treeNode.id,
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
                url: '/mikuProvider/updateClassify?id='+treeNode.id+'&name='+newName,
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
        var _val=$('#in-w').val();
        var treeNode_id=3;//父节点id
        $.ajax({
            url: '/mikuProvider/addClassify?name='+_val+'&pId='+treeNode_id,
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
            var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                    + "' title='add node' onfocus='this.blur();'></span>";
            sObj.after(addStr);
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
        //do someting
//        alert(treeNode.id);
        if(treeNode.isParent){
            $('#click_btnh').show();
        }else{
            $('#click_btnh').hide();
        }
    };
    //树枝双击
    function zTreeOnDblClick(event, treeId, treeNode) {
        if(treeNode.isParent){
            window.location.replace('/mikuPiteminfo/list?isparent=1&tid='+treeNode.id);
        }else{
            window.location.replace('/mikuPiteminfo/list?isparent=0&tid='+treeNode.id);
        }
    };
    //初始化
    $(document).ready(function(){
        $('#trees-left').css({'min-height':$('#operation .box').height()+120,'max-height':$('#operation .box').height()+120,'overflow':'auto'});
//        $('#trees-left').css({'height':$(window).height()*0.76+22,'overflow':'auto'});
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        $("#selectAll").bind("click", selectAll);
    });
</script>

</body>

</html>

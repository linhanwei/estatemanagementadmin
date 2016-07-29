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
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- ztree -->
    <asset:stylesheet src="zTreeStyle.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>

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
    #addlist{display: none;}
    .zTreeDemoBackground {max-height: 400px;overflow-y: auto;}
    #category_txt{padding-top: 7px;}
    </style>

</head>

<body data_cateid="">

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        修改供应商信息
        <small>供应商管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>供应商管理</a></li>
        <li class="active">添加供应商</li>
    </ol>
</section>

<!-- Main content -->
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li id="list_change"><g:link action="list">列表信息</g:link></li>
                    <li class="active"><g:link action="index">新增供应商</g:link></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">
        <form action="add" name="item_form" id="item_form">
            <input type="text" name="id" value="${mikuProvider.id}" class="hide"/>
            <div class="box-header"> </div>
            <div class="box-body no-padding form-horizontal list-group">
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">供应商名称：</label>
                    <div class="col-xs-3">
                        <input type="text" name="name" class="form-control" placeholder="供应商名称" value="${mikuProvider.name}">
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">供应商简称：</label>
                    <div class="col-xs-3">
                        <input type="text" name="sname" class="form-control" placeholder="供应商简称" value="${mikuProvider.sname}">
                    </div>

                    <label class="col-xs-2 control-label">联系人：</label>

                    <div class="col-xs-3">
                        <input type="text" name="cperson" class="form-control" placeholder="联系人" value="${mikuProvider.cperson}">
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">职务：</label>
                    <div class="col-xs-3">
                        <input type="text" name="job" class="form-control" placeholder="职务" value="${mikuProvider.job}">
                    </div>
                    <label class="col-xs-2 control-label">地区：</label>
                    <div class="col-xs-3">
                        <input type="text" name="address" class="form-control" placeholder="地区" value="${mikuProvider.address}">
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">账期：</label>
                    <div class="col-xs-3">
                        <input type="text" name="accounttime" class="form-control" placeholder="账期" value="${mikuProvider.accounttime}">
                    </div>


                    <label class="col-xs-2 control-label">电话：</label>
                    <div class="col-xs-3">
                        <input type="text" name="mobile" class="form-control" placeholder="电话" value="${mikuProvider.mobile}">
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">类目：</label>
                    <div class="col-xs-8 form-group">
                        <div class="col-xs-1 form-group">
                            <button class="btn btn-primary" id="edit_super" data_cateid_supper="${mikuProvider.id}" data_clssfiyId="${mikuProvider.clssfiyId}">编辑</button>
                        </div>
                        <p id="category_txt" class="col-xs-9 form-group">${cateNameList}</p>
                        %{--<input id="category_txt" type="text" value="${cateNameList}" class="form-control" disabled/>--}%
                        <input id="category_id" type="hidden" value="${mikuProvider.clssfiyId}" name="clssfiyId"/>
                    </div>


                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">邮政编码：</label>
                    <div class="col-xs-3">
                        <input type="text" name="zipcode" class="form-control" placeholder="邮政编码" value="${mikuProvider.zipcode}">
                    </div>
                    <label class="col-xs-2 control-label">电子邮箱：</label>
                    <div class="col-xs-3">
                        <input type="text" name="email" class="form-control" placeholder="电子邮箱" value="${mikuProvider.email}">
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">备注：</label>
                    <div class="col-xs-8">
                        <textarea name="memo" class="form-control" rows="5" placeholder="备注">${mikuProvider.memo}</textarea>
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">评价：</label>
                    <div class="col-xs-8">
                        <textarea name="assess" class="form-control" rows="5" placeholder="评价">${mikuProvider.assess}</textarea>
                    </div>
                </div>
                <input name="recType" type="text" value="1" style="display: none;" id="recType"/>
            </div>
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" id="fbBtn">添加</button>
                    <button class="btn btn-default" type="reset">取消</button>
                </div>
            </div>
            <!-- /.box-footer-->
        </form>
    </div>
    <!-- /.box -->
</section>

<div class="modal fade bs-example-modal-lg" id="checked_super" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title">绑定供应商类目</h3>
            </div>
            <div class="modal-body">

                %{--box1--}%
                <div class="tree_box">
                    <div class="clearfix">
                        <h4 style="float: left;">供应商类目</h4>
                        <div style="float: left;">
                            <button type="button" class="btn btn-danger" id="addlist">新增类目</button>
                        </div>
                    </div>

                    <div class="tree_box_con">

                        %{--树--}%
                        <div class="zTreeDemoBackground">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>

                    </div>

                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="chang_relation">确定</button>
                    %{--<button type="button" class="btn btn-primary">Save changes</button>--}%
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 增加类目 -->
<div class="modal fade" id="add_category" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                &times;
                </button>
                <h4 class="modal-title">
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
                <button id="s_click" type="button" class="btn btn-primary identification">
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
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- ztree -->
<asset:javascript src="jquery.ztree.all.min.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>
    //*************************************************
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
    });
    $('.dropdown-toggle').dropdown();

    (function ($) {//jq获取指定url参数
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
    var recType=$.getUrlParam('recType');
    if(recType!=='1'){
        $('#recType').remove();
    }
    if(recType=='1'){
        $('#list_change a').attr('href','/mikuProvider/checkList');
    }



    $(document).on('click','#edit_super',function(e){//点击编辑供应商
        e.preventDefault();
        var clssfiyid=$(this).attr('data_clssfiyid');
        $('body').attr('data_clssfiyid',clssfiyid);
        $('#checked_super').modal('show');
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    }).on('click','#addlist',function(){//点击增加类目
        $('#add_category').modal('show');
    }).on('click','#s_click',function(){//确定增加类目
        var tId=$('body').attr('data_cateid');//父节点id
        var name=$('#in-w').val();
        $.ajax({
            url: '/mikuSupplierClassify/add?name='+name+'&pId='+tId,
            type: "POST",
            dataType: "json",
            success: function (data) {
                //成功
                alert('添加成功！');
                $('#add_category').modal('hide');
                $.fn.zTree.init($("#treeDemo"), setting, data);
            },
            error: function (data) {
                //失败
                alert('添加失败！');
            }
        });
    }).on('click','#chang_relation',function(){//类目确定按钮
        $('#checked_super').modal('hide');
        var cateId=$('body').attr('data_cateid');
        var data={
            'cateId':cateId
        }
        ajax_call1(complete_Category,'/mikuProvider/searchSupplyAllCate',data);
    })





//    遍历到对应的完整类目
    function complete_Category(data){
        var data=data.result;
        $('#category_txt').text('');
        $('#category_txt').text(data);

    }


    //    树1

    var setting = {
        view: {
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false,
            fontCss: setFontCss
        },
        edit: {
            enable: true,
            editNameSelectAll: true,
            showRemoveBtn: false,
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
            onClick: zTreeOnClick
        }
    };

    //        ajax
    function ajax_call1(success,url,data) {
        $.ajax({
            url: url,
            data: data,
            type: "POST",
            dataType: "json",
            success: function (data) {
                success(data);
            },
            error: function (data) {
            }
        });
    }



    var zNodes;
    //树加载
    treeajax('/mikuSupplierClassify/list');

    function treeajax(url) {
        $.ajax({
            url: url,
            type: "POST",
            dataType: "json",
            async: false,
            success: function (data) {
                zNodes = data;
                if(data.length<=0){//如果没有类目显示增加类目按钮
                    $('#addlist').show();
                }
            },
            error: function (data) {
                //失败
            }
        });
    }



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
        return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
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
                    alert('编辑成功！');
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
        return !treeNode.isFirstNode;
    }
//            function showRenameBtn(treeId, treeNode) {
//                return !treeNode.isLastNode;
//            }
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

    var newCount = 1;
    function addHoverDom(treeId, treeNode) {
        return false;
    };
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };
    function setFontCss(treeId, treeNode) {
        var clssfiyid=$('body').attr('data_clssfiyid');
        return treeNode.id == clssfiyid ? {color:"red"} : {};
    };

    //树枝单击
    function zTreeOnClick(event, treeId, treeNode) {
        $('#addlist').show();
        var tId=treeNode.id;
        $('body').attr('data_cateid',tId);
        $("#category_id").attr("value",tId);

    }
    //        树加载
    $(document).ready(function(){

        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });
</script>

</body>

</html>

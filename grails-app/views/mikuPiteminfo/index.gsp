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
    #addlist_goods{display: none;}
    #check_stock span,#check_price span,#check_mi span,#check_category span,#check_supplier span,#check_postfee span,#check_jhprice span,#check_xsprice span{color: red;display: none;}
    .zTreeDemoBackground {max-height: 400px;overflow-y: auto;}
    #tb_one_supplier tr{cursor: pointer;}
    #t_body_supplier{display: none;max-height: 267px;overflow-y: scroll;overflow-x: hidden;}
    .t_head{padding-right: 17px;display: none;}
    .t_head ul{padding: 0;margin: 0;}
    .t_head li{float: left;border: 1px solid #F5F5F5;list-style: none;border-right: none;text-align: center;
        height: 38px;line-height: 38px;font-weight: bold;word-wrap: break-word;}
    #addlist{display: none;}
    #category_txt1{padding-top: 7px;}
    #category_txt{padding-top: 7px;}
    /*浮动闭合*/
    .clearfix:after
    {
        content: ".";
        display: block;
        height: 0;
        clear: both;
        visibility: hidden;
    }
    *html .clearfix
    {
        height:1%;
    }
    *:first-child+html .clearfix { zoom: 1; }
    /*{
        height: 1%;
        zoom:1;
    }*/
    .clearfix
    {
        display:inline-block;
    }
    /*Hide from IE Mac*/
    .clearfix
    {
        display: block;
    }
    /*End hide from IE Mac*/

    /*float 万能闭合钥匙结束*/
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
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="list">列表信息</g:link></li>
                    <li class="active"><g:link action="index">新增供应商商品</g:link></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">
        <form action="addPitem" name="item_form" id="item_form">
            <div class="box-header"> </div>
            <div class="box-body no-padding form-horizontal list-group">
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">商品名称：</label>
                    <div class="col-xs-3">
                        <input type="text" name="title" class="form-control" placeholder="商品名称">
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">库存：</label>
                    <div class="col-xs-3" id="check_stock">
                        <input type="number" name="num" class="form-control" placeholder="库存">
                        <span>库存不能为空</span>
                    </div>

                    <label class="col-xs-2 control-label">是否可退货：</label>

                    <div class="col-xs-3">
                        <div class="input-group" style="width: 235px;margin-top: 7px;">
                            <g:checkBox name="isrefund" class="input-sm jstree-checkbox" />
                        </div>
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">价格：</label>
                    <div class="col-xs-3" id="check_price">
                        <input type="number" name="price" class="form-control" placeholder="价格">
                        <span>价格不能为空</span>
                    </div>
                    <label class="col-xs-2 control-label">邮费：</label>
                    <div class="col-xs-3" id="check_postfee">
                        <input type="number" name="postFee" class="form-control" placeholder="邮费">
                        <span>邮费不能为空</span>
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">供应商品编码：</label>
                    <div class="col-xs-3">
                        <input type="text" name="code" class="form-control" placeholder="供应商品编码">
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">进行品牌关联：</label>
                    <div class="col-xs-3">
                        <g:select optionKey="id" optionValue="name" name="brandId"
                                  class="form-control" from="${mikuBrandList}"
                                  noSelection="['': '请选择品牌']"/>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">米酷商品唯一编码：</label>
                    <div class="col-xs-3" id="check_mi">
                        <input type="text" name="picode" class="form-control" placeholder="商品对应的编码">
                        <span>米酷商品唯一编码不能为空</span>
                    </div>
                    <label class="col-xs-2 control-label">是否出货商品：</label>
                    <div class="col-xs-3" style="margin-top: 7px;">
                        <input type="checkbox" name="weight" class="form-control" value="0" id="check_shipment">
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">规格：</label>
                    <div class="col-xs-3">
                        <input type="text" name="type" class="form-control" placeholder="规格">
                    </div>
                    <label class="col-xs-2 control-label">地区：</label>
                    <div class="col-xs-3">
                        <input type="text" name="area" class="form-control" placeholder="地区">
                    </div>
                </div>

                %{--<div class="list-group-item form-group">--}%
                    %{--<label class="col-xs-2 control-label">商品类目:</label>--}%
                    %{--<div class="col-xs-3" id="check_category">--}%
                        %{--<g:select optionKey="id" optionValue="name" name="classfiId"--}%
                                  %{--class="form-control" from="${list}"--}%
                                  %{--noSelection="['': '商品类目']"/>--}%
                        %{--<span>商品类目不能为空</span>--}%
                    %{--</div>--}%
                    %{--<label class="col-xs-2 control-label">供应商:</label>--}%
                    %{--<div class="col-xs-3" id="check_supplier">--}%
                        %{--<select id="providerId" class="form-control" name="providerId">--}%
                            %{--<option value="">请选择供应商</option>--}%
                        %{--</select>--}%
                        %{--<span>供应商不能为空</span>--}%
                    %{--</div>--}%
                %{--</div>--}%
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">商品类目：</label>
                    <div class="col-xs-8 form-group">
                        <div class="col-xs-1 form-group">
                            <button class="btn btn-primary" id="edit_goods">编辑</button>
                        </div>
                        <p id="category_txt1" class="col-xs-9"></p>
                        %{--<input id="category_txt1" type="text" value="" class="form-control" disabled/>--}%
                        <input id="category_id1" type="hidden" value="" name="pclassifyId"/>
                    </div>

                    %{--<label class="col-xs-2 control-label">供应商:</label>--}%
                    %{--<div class="col-xs-3">--}%
                    %{--<g:select optionKey="id" optionValue="name" name="providerId"--}%
                    %{--class="form-control" from="${plist}" value="${item.providerId}"--}%
                    %{--noSelection="['': '供应商']"/>--}%
                    %{--</div>--}%
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">供应商：</label>
                    <div class="col-xs-8 form-group">
                        <div class="col-xs-1 form-group">
                            <button class="btn btn-primary" id="edit_super">编辑</button>
                        </div>
                        <p id="category_txt" class="col-xs-9"></p>
                        %{--<input id="category_txt" type="text" value="" class="form-control" disabled/>--}%
                        <input id="category_id" type="hidden" value="" name="providerId"/>
                    </div>

                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">进货价：</label>
                    <div class="col-xs-3" id="check_jhprice">
                        <input type="number" name="jhprice" class="form-control" placeholder="进货价">
                        <span>进货价不能为空</span>
                    </div>
                    <label class="col-xs-2 control-label">建议销售价：</label>
                    <div class="col-xs-3" id="check_xsprice">
                        <input type="number" name="xsprice" class="form-control" placeholder="建议销售价">
                        <span>建议销售价不能为空</span>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">备注：</label>
                    <div class="col-xs-8">
                        <textarea name="memo" class="form-control" rows="5" placeholder="备注"></textarea>
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">评价：</label>
                    <div class="col-xs-8">
                        <textarea name="assess" class="form-control" rows="5" placeholder="评价"></textarea>
                    </div>
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">物流说明：</label>
                    <div class="col-xs-8">
                        <textarea name="logisticDestrion" class="form-control" rows="5" placeholder="物流说明"></textarea>
                    </div>
                </div>

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

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" id="myModalLabel">商品关联</h3>
            </div>
            <div class="modal-body">

                %{--box2--}%
                <div class="tree_box" style="border-right: 0;">
                    <div class="clearfix">
                        <h4 style="float: left;">商品类目</h4>
                        <div style="float: left;">
                            <button type="button" class="btn btn-danger" id="addlist_goods">新增类目</button>
                        </div>
                    </div>
                    <div class="tree_box_con">

                        %{--树--}%
                        <div class="zTreeDemoBackground">
                            <ul id="treeDemo2" class="ztree"></ul>
                        </div>


                        %{--内容文本--}%
                        %{--<div class="box-body" id="showmsg">--}%

                        %{--<p>已选供应商：<span id="providername"></span><button type="button" class="btn btn-danger btn-sm" id="clear_shoper">清空</button></p>--}%
                        %{--<p>已选商品类目：<span id="catename"></span><button type="button" class="btn btn-danger btn-sm" id="clear_goodslist">清空</button></p>--}%
                        %{--</div>--}%
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="chang_relation2">确定</button>
                    %{--<button type="button" class="btn btn-primary">Save changes</button>--}%
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 增加类目 -->
<div class="modal fade" id="add_category" tabindex="-1" role="dialog" aria-hidden="true" style="z-index: 1051;">
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

<div class="modal fade bs-example-modal-lg" id="checked_super" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title">绑定供应商</h3>
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

                        %{--供应商列表--}%
                        <div class="box-body" style="padding-left: 0;padding-right: 0;">
                            <div class="t_head">
                                <ul class="clearfix">
                                    %{--<li>序号</li>--}%
                                    <li>供应商名称</li>
                                    <li>简称</li>
                                    %{--<li>联系人</li>--}%
                                    %{--<li>职务</li>--}%
                                    <li style="border-right: 1px solid #F5F5F5;">电话</li>
                                    %{--<li>地区</li>--}%
                                </ul>
                            </div>
                            <div class="t_body" id="t_body_supplier">
                                <table class="table table-hover table-bordered text-center" style="margin-bottom: 0;" id="tb_one_supplier">
                                    %{--<tbody id="tb_one_supplier">--}%
                                    %{--查询数据--}%
                                    %{--</tbody>--}%
                                </table>
                            </div>
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





<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- ztree -->
<asset:stylesheet src="zTreeStyle.css"/>
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

    $(document).on('click','#fbBtn',function(){
        var check_stock=$('#check_stock input').val();
        var check_price=$('#check_price input').val();
        var check_postfee=$('#check_postfee input').val();
        var check_jhprice=$('#check_jhprice input').val();
        var check_mi=$('#check_mi input').val();
        var check_xsprice=$('#check_xsprice input').val();
        var check_category=$('#check_category select').val();
        var check_supplier=$('#check_supplier select').val();
        if(check_stock==''){
            $('#check_stock span').css('display','block');
        }else{
            $('#check_stock span').css('display','none');
        }
        if(check_price==''){
            $('#check_price span').css('display','block');
        }else{
            $('#check_price span').css('display','none');
        }
        if(check_postfee==''){
            $('#check_postfee span').css('display','block');
        }else{
            $('#check_postfee span').css('display','none');
        }
        if(check_jhprice==''){
            $('#check_jhprice span').css('display','block');
        }else{
            $('#check_jhprice span').css('display','none');
        }
        if(check_xsprice==''){
            $('#check_xsprice span').css('display','block');
        }else{
            $('#check_xsprice span').css('display','none');
        }
        if(check_mi==''){
            $('#check_mi span').css('display','block');
        }else{
            $('#check_mi span').css('display','none');
        }
        if(check_category==''){
            $('#check_category span').css('display','block');
        }else{
            $('#check_category span').css('display','none');
        }
        if(check_supplier==''){
            $('#check_supplier span').css('display','block');
        }else{
            $('#check_supplier span').css('display','none');
        }
        if(check_stock=='' || check_price=='' || check_mi=='' || check_category=='' || check_supplier==''){
            return false;
        }
    }).on('click','#edit_goods',function(e){
        e.preventDefault();
        $('#myModal').modal('show');
        $('.identification').attr('id','s_click_goods');

    }).on('click','#addlist_goods',function(){
        $('#add_category').modal('show');
    }).on('click','#edit_super',function(e){//点击编辑供应商
        e.preventDefault();
        $('#checked_super').modal('show');
        $('.identification').attr('id','s_click');
    }).on('click','#s_click_goods',function(){
        var _val=$('#in-w').val();
        var treeNode_id=3;//父节点id
        $.ajax({
            url: '/mikuProvider/addClassify?name='+_val+'&pId='+treeNode_id,
            type: "POST",
            dataType: "json",
            success: function (data) {
                //成功
                alert('添加成功！');
                $('#add_category').modal('hide');
                $.fn.zTree.init($("#treeDemo2"), setting2, data);
            },
            error: function (data) {
                //失败
                alert('添加失败！');
            }
        });
    }).on('click','#tb_one_supplier tr',function(){
        $(this).addClass('success').siblings().removeClass('success');
        var data_providerid=$(this).attr('data_providerid');
        $('#category_id').attr('value',data_providerid);
        var name=$(this).attr('data_name');
        $('#category_txt').text(name);
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
    }).on('click','#chang_relation2',function(){
        var cateId=$('body').attr('data_goods');
        var data={
            'cateId':cateId
        }
        ajax_call1(complete_Category2,'/mikuPiteminfo/searchGoodsAllCate',data);
    }).on('click','#chang_relation',function(){//类目确定按钮
        $('#checked_super').modal('hide');
    }).on('ifUnchecked','#check_shipment',function(){
        $('#check_shipment').attr('value',0);
    }).on('ifChecked','#check_shipment',function(){
        $('#check_shipment').attr('value',1);
    })






    //    遍历到对应的商品完整类目
    function complete_Category2(data){
        var data=data.result;
        console.log(data);
        $('#category_txt1').text(data);
        $('#myModal').modal('hide');

    }

    //供应商查询结果
    function supplier_query_results(data){
        var tp=supplier_query_results_Html(data);
        $('#tb_one_supplier').empty();
        if(tp==''){
            $('.t_head').hide();
            $('#t_body_supplier').hide();
        }else{
            $('.t_head').show();
            $('#t_body_supplier').show();
        }
        $('#tb_one_supplier').append(tp);
        setWidth('.t_head li','#tb_one_supplier tr:first td',17);
    }

    function supplier_query_results_Html(obj){
        var tp='';
        var obj=obj.result;
        if(obj){
            var html='<tbody>';

            for(var j=0;j<obj.length;j++){
                html+='<tr data_providerId="'+obj[j].id+'" data_name="'+obj[j].name+'">';
//                        html+='<td style="min-width: 30px;">'+j+'</td>';
                html+='<td style="width: 397px;">'+obj[j].name+'</td>';
                html+='<td style="width: 152px;">'+obj[j].sname+'</td>';
//                        html+='<td>'+obj[j].cperson+'</td>';
//                        html+='<td>'+obj[j].job+'</td>';
                html+='<td style="width: 303px;">'+obj[j].mobile+'</td>';
//                        html+='<td style="min-width: 30px;">'+obj[j].address+'</td>';
                html+='</tr>';

            }
            html+='</tbody>';
            tp+=html;
        }
        return tp;

    }



    //        设置table头部宽
    function setWidth(target_selector,original_selector,num){
        var Obj=$(target_selector);
        var Obj1=$(original_selector);
        for(var i= 0;i<Obj1.length;i++){
            Obj.eq(i).width(Obj1.eq(i).width()+num);
        }
    }




    //    树1(供应商的)

    var setting = {
        view: {
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false
//            fontCss: setFontCss
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
    //    function setFontCss(treeId, treeNode) {
    //        var id=$('#edit_super').attr('data_cateid_supper');
    //        return treeNode.id == id ? {color:"red"} : {};
    //    };

    //树枝单击
    function zTreeOnClick(event, treeId, treeNode) {
        $('#addlist').show();
        var tId=treeNode.id;
        $('body').attr('data_cateid',tId);
//        $("#category_id").attr("value",tId);

        var data={
            'cateId':tId,
            'ischeck':1
        }
        ajax_call1(supplier_query_results,'/mikuProvider/search',data);



    }


    //树2
    var setting2 = {
        view: {
            addHoverDom: false,
            removeHoverDom: removeHoverDom2,
            selectedMulti: false
//                fontCss: setFontCss
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
            beforeDrag: beforeDrag2,
            beforeEditName: beforeEditName2,
            beforeRemove: beforeRemove2,
            beforeRename: beforeRename2,
            onRemove: onRemove2,
            onRename: onRename2,
            onClick: zTreeOnClick2
        }
    };

    var zNodes2;
    //树加载
    treeajax2('/mikuProvider/selectClassify');

    function treeajax2(url) {
        $.ajax({
            url: url,
            type: "POST",
            dataType: "json",
            async: false,
            success: function (data) {
                zNodes2 = data;
            },
            error: function (data) {
                //失败
            }
        });
    }


    var log, className = "dark";
    function beforeDrag2(treeId, treeNodes) {
        return false;
    }
    function beforeEditName2(treeId, treeNode) {
        className = (className === "dark" ? "":"dark");
        showLog2("[ "+getTime2()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        zTree.selectNode(treeNode);
        return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
    }
    function beforeRemove2(treeId, treeNode) {
        className = (className === "dark" ? "":"dark");
        showLog2("[ "+getTime2()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        zTree.selectNode(treeNode);
        return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
    }
    function onRemove2(e, treeId, treeNode) {
        showLog2("[ "+getTime2()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
    }
    function beforeRename2(treeId, treeNode, newName, isCancel) {
        className = (className === "dark" ? "":"dark");
        showLog2((isCancel ? "<span style='color:red'>":"") + "[ "+getTime2()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
        if (newName.length == 0) {
            alert("节点名称不能为空.");
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            setTimeout(function(){zTree.editName(treeNode)}, 10);
            return false;
        }
        return true;
    }
    function onRename2(e, treeId, treeNode, isCancel) {
        showLog2((isCancel ? "<span style='color:red'>":"") + "[ "+getTime2()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
    }
    function showRemoveBtn2(treeId, treeNode) {
        return !treeNode.isFirstNode;
    }
    function showRenameBtn2(treeId, treeNode) {
        return !treeNode.isLastNode;
    }
    function showLog2(str) {
        if (!log) log = $("#log");
        log.append("<li class='"+className+"'>"+str+"</li>");
        if(log.children("li").length > 8) {
            log.get(0).removeChild(log.children("li")[0]);
        }
    }
    function getTime2() {
        var now= new Date(),
                h=now.getHours(),
                m=now.getMinutes(),
                s=now.getSeconds(),
                ms=now.getMilliseconds();
        return (h+":"+m+":"+s+ " " +ms);
    }

    var newCount = 1;
    function addHoverDom2(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                + "' title='add node' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"new node" + (newCount++)});
            return false;
        });
    };
    function removeHoverDom2(treeId, treeNode) {
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };
    //        function setFontCss(treeId, treeNode) {
    //            var providerid=$('body').attr('data_providerid');
    //            return treeNode.id == providerid ? {color:"red"} : {};
    //        };
    function zTreeOnClick2(event, treeId, treeNode) {
        var data_goods=treeNode.id;
        $('body').attr('data_goods',data_goods);
        $('#category_id1').val(data_goods);
        if(treeNode.isParent){
            $('#addlist_goods').show();
        }else{
            $('#addlist_goods').hide();
        }
    };



    //        树加载
    $(document).ready(function(){

        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        $.fn.zTree.init($("#treeDemo2"), setting2, zNodes2);
    });


    $('#classfiId').change(function () {
        $('#providerId').find('option').remove();
        $("#classfiId option:selected").each(function () {
            var id = $(this).val();
            if(id){
                $.ajax({
                    url: '<g:createLink controller="mikuPiteminfo" action="queryProviderBytId"/>',
                    data: {'id': id},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        debugger;
                        $.each(data, function (index, m) {
                            $('#providerId').append('<option value="' + m.id + '">' + m.name + '</option>');
                        })
                    }, error: function (data) {
                    }
                });
            }
        });
    });


</script>

</body>

</html>

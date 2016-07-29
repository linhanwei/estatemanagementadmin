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
    <html>
    <head>
        <title>待审核供应商管理</title>
        <style type="text/css">
        .ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
        .tree_box{width: 50%;float: left;border-top: 0;border-radius: 0;box-shadow:0 0 0;border-right: 2px solid #d5d5d5;min-height: 650px;}
        #frist_table tr{cursor: pointer;}
        .frist_body{max-height: 300px;overflow-y: scroll;display: none;min-width: 874px;}
        .zTreeDemoBackground{max-height: 400px;overflow-y: auto;}
        #showmsg{border: 1px solid #eee;margin-top: 30px;}
        #t_body_supplier{max-height: 267px;overflow-y: scroll;overflow-x: hidden;}
        #tb_one_supplier tr{cursor: pointer;}
        #t_body_supplier{display: none;}
        #addlist{display: none;}
        #addlist_goods{display: none;}
        .frist_thead{padding-right: 17px;display: none;min-width: 874px;}
        .frist_thead ul{padding: 0;margin: 0;}
        .frist_thead li{float: left;border: 1px solid #F5F5F5;list-style: none;border-right: none;text-align: center;
            height: 38px;line-height: 38px;font-weight: bold;word-wrap: break-word;}
        .t_head{padding-right: 17px;display: none;}
        .t_head ul{padding: 0;margin: 0;}
        .t_head li{float: left;border: 1px solid #F5F5F5;list-style: none;border-right: none;text-align: center;
            height: 38px;line-height: 38px;font-weight: bold;word-wrap: break-word;}
        #clear_shoper{margin-left: 10px;}
        #clear_goodslist{margin-left: 10px;}
        #providername{color: red;}
        #catename{color: red;}
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
    <body data_id="" data_catename="" data_providername="" data_providerId="" data_cateId="" data_providerId2="" data_cateid1="" data_pclassifyId="">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1> 待审核商品管理 <small></small> </h1>
        <ol class="breadcrumb">
            <li><a href="http://120.24.102.187:8090/mikuProvider/checkList"><i class="fa fa-dashboard"></i>进销存出入库</a></li>
            <li class="active">待审核商品管理</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="myTab">
                    </ul>
                </div>
            </div>
        </div>
        <!-- Default box -->
        <div class="box">
            <section class="content-header content-header1">
                <div>
                    <div class="header-box form-inline" style="overflow: hidden;">
                        <form action="checkList" class="form-inline">
                            <div class="col-lg-4 form-group">
                                <label class="control-label">商品名称：</label>
                                <input name="title" class="form-control" value="${params.title}" type="text">
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label">商品编码：</label>
                                <input name="code" class="form-control" value="${params.code}" type="text">
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label">未选状态：</label>
                                <g:select optionKey="key" optionValue="value" name="status"
                                          class="form-control" from="${noCheckStatus}" value="${params.status}"
                                          noSelection="['0': '请选择']"/>

                                <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>搜索</button>
                            </div>
                        </form>

                        <!-- 导入出 -->
                        <div class="col-lg-12 form-group text-right" style="margin-top: 5px;">
                            %{--<button type="submit" class="btn btn-success"><i class="fa fa-download"></i>导出Excel</button>--}%
                        <button  class="btn btn-primary" id="inputExcel"><i class="fa fa-upload"></i>导入Excel</button>
                            <g:link controller="mikuProvider" action="createOneModelExcel" target="_blank" params="[flag:'0']">下载模板</g:link>
                            <g:link controller="mikuPiteminfo" action="synchroItems">同步米酷数据使用</g:link>
                        </div>
                    </div>

                    <!-- table1 body -->
                    <div class="table-responsive box-body">
                        <table class="table table-hover table-bordered text-center">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>商品名称</th>
                                <th>关键字</th>
                                <th>未选状态</th>
                                <th>规格</th>
                                <th>是否出货商品</th>
                                <th>商品编码</th>
                                <th>邮费</th>
                                <th>账期</th>
                                <th>地区</th>
                                <th>库存</th>
                                <th>进货价</th>
                                <th>销售价</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="frist_table">
                            <g:each status="i" in="${list}" var="li">
                                <g:if test="${li.weight==1}">
                                    <tr class="danger" data_words="${li.keyword}" data_ischeck="${li.isCheck}">
                                </g:if>
                                <g:else>
                                    <tr data_words="${li.keyword}" data_ischeck="${li.isCheck}">
                                </g:else>
                                    <td>${i+1}</td>
                                    <td>${li.title}</td>
                                    <td>${li.keyword}</td>
                                    <td style="color: red;" data_1="${li.pclassifyId}">
                                        <g:if test="${li.pclassifyId==0}">
                                            <p>商品类目</p>
                                        </g:if>
                                        <g:if test="${li.pitemCode==0}">
                                            <p>米酷码</p>
                                        </g:if>
                                        <g:if test="${li.providerId==0}">
                                            <p>供应商</p>
                                        </g:if>
                                    </td>
                                    <td>${li.type}</td>
                                    <td>
                                        <g:if test="${li.weight==1}">
                                            是
                                        </g:if>
                                        <g:else>
                                            否
                                        </g:else>
                                    </td>
                                    <td>${li.code}</td>
                                    <td>${li.postFee/100f}</td>
                                    <td>${li.area}</td>
                                    <td>${li.area}</td>
                                    <td>${li.rknum}</td>
                                    <td>${li.jhprice/100f}</td>
                                    <td>${li.xsprice/100f}</td>
                                    <td>
                                        <button type="submit" class="btn btn-primary relationbtn" data-toggle="modal" data-target="#myModal" data_id="${li.id}" data_providerId="${li.providerId}">关联</button>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    <div class="box-footer clearfix">
                        <g:if test="${total > 0}">
                            <div class="pagination pull-right">
                                <g:paginate next="下一页" prev="上一页" params="${params}"
                                            maxsteps="10" action="checkList" total="${total}"/>
                            </div>
                        </g:if>
                    </div><!-- /.box-footer-->
                    </div>
                </div>
                <!-- table2 body -->
                <div class="box">
                    <div class="box-header form-inline">
                        <div class="col-lg-6">
                            <label class="control-label">搜索：</label>
                            <input type="text" class="form-control" name="query" id="query_value">
                            <button type="submit" class="btn btn-primary" id="query"><i class="fa fa-search"></i>搜索</button>
                        </div>
                        <div class="col-lg-6 text-right">
                            <button type="submit" class="btn btn-primary" id="adopt" data_id="">确定</button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="frist_thead">
                            <ul class="clearfix">
                                <li>序号</li>
                                <li>商品名称</li>
                                <li>关键字</li>
                                <li>规格</li>
                                <li>权重</li>
                                <li>商品编码</li>
                                <li>邮费</li>
                                <li>账期</li>
                                <li>地区</li>
                                <li>库存</li>
                                <li>进货价	</li>
                                <li>销售价</li>
                                <li style="border-right: 1px solid #F5F5F5;">选择</li>
                            </ul>

                        </div>
                        <div class="frist_body">
                            <table class="table table-hover table-bordered text-center table-fixed-header" id="result_query">
                                %{--<tbody id="result_query">--}%
                                %{--查询结果区--}%
                                %{--</tbody>--}%
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </section>
        <!-- /.box -->
        <!-- Modal -->
        <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-maroon-gradient">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel">商品关联供应商、商品类目</h3>
                    </div>
                    <div class="modal-body">

                        %{--box1--}%
                        <div class="box tree_box">
                            <div class="clearfix">
                                <h4 style="width:50%;float: left;">供应商类目</h4>
                                <div style="width:50%;float: left;">
                                    <button type="button" class="btn btn-danger" id="addlist">新增类目</button>
                                </div>
                            </div>

                            <div class="tree_box_con">

                                %{--树--}%
                                <div class="zTreeDemoBackground">
                                    <ul id="treeDemo" class="ztree"></ul>
                                </div>

                                %{--表--}%
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

                        %{--box2--}%
                        <div class="box tree_box" style="border-right: 0;">
                             <div class="clearfix">
                                 <h4 style="width: 50%;float: left;">商品类目</h4>
                                 <div style="width: 50%;float: left;">
                                     <button type="button" class="btn btn-danger" id="addlist_goods">新增类目</button>
                                 </div>
                             </div>
                             <div class="tree_box_con">

                                 %{--树--}%
                                 <div class="zTreeDemoBackground">
                                     <ul id="treeDemo2" class="ztree"></ul>
                                 </div>

                                 %{--内容文本--}%
                                 <div class="box-body" id="showmsg">

                                     <p>已选供应商：<span id="providername"></span><button type="button" class="btn btn-danger btn-sm" id="clear_shoper">清空</button></p>
                                     <p>已选商品类目：<span id="catename"></span><button type="button" class="btn btn-danger btn-sm" id="clear_goodslist">清空</button></p>
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

        <!-- 增加商品类目 -->
        <div class="modal fade" id="addlist_goods_alert" tabindex="-1" role="dialog" aria-hidden="true" style="z-index: 1051;">
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
                        <input id="in-w_goods" type="text" class="form-control" placeholder="">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">取消
                        </button>
                        <button id="s_click_goods" type="button" class="btn btn-primary">
                            确定
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

        %{--alert层--}%
        %{--<div class="modal fade" id="operating">--}%
            %{--<div class="modal-dialog">--}%
                %{--<div class="modal-content">--}%
                    %{--<div class="modal-header">--}%
                        %{--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--}%
                        %{--<h4 class="modal-title">--}%
                            %{--显示标题--}%
                        %{--</h4>--}%
                    %{--</div>--}%
                    %{--<div class="modal-body">--}%
                        %{--<p>--}%
                            %{--显示信息--}%
                        %{--</p>--}%
                    %{--</div>--}%
                    %{--<div class="modal-footer">--}%
                        %{--<button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%




    %{--导入功能--}%
        <g:uploadForm action="inputExcelData" enctype="multipart/form-data" style="display:none" controller="mikuProvider">
            <input type="text" name="type" value="1"/>
            <input type="file" name="myFile" id="myFile" accept=".xls"/>
            <input type="submit" style="display: none;" id="inputPortExcelByModify">
        </g:uploadForm>



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


        //点击批量导入的按钮
        $('#inputExcel').on("click",function(){
            $('#myFile').click();
        });

        $('#myFile').on('change',function(){
            debugger;
            //获取其文件类型
            var fileName=$("#myFile").val();
            if(fileName.length>1 && fileName)
            {
                var  index=fileName.lastIndexOf(".");
                var type=fileName.substring(index+1);
                if(type!="xls")
                {
                    alert("请上传对应Excel类型的文件");
                    return;
                }
                else{
                    $('#inputPortExcelByModify').click();
                }
            }
        });

            $(function(){
                icheck();
            })

        %{--icheck--}%
        function icheck(){
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });
        }

        $(document).on('click','#frist_table tr',function(){//点击第一区table
            $(this).addClass('success').siblings().removeClass('success');
            var value=$(this).attr('data_words');
            var ischeck=$(this).attr('data_ischeck');
            var data={
                'words':value,
                'ischeck':ischeck
            }
            ajax_call(f_goods_success,'/mikuPiteminfo/search',data);


        }).on('click','#adopt',function(){//审核通过
            var id=$('#adopt').attr('data_id');
            $('#operating').remove();
            var data={
                'id':id,
                'eid':id

            }
            ajax_call(codeSuccess,'/mikuPiteminfo/checkGoods',data);

        }).on('ifChecked','#result_query input',function(){
            var id=$(this).attr('data_id');
            $('#adopt').attr('data_id',id);
        }).on('click','.relationbtn',function(event){//关联
            event.stopPropagation();
            $('#tb_one_supplier').empty();
            $('#t_body_supplier').hide();
            $('.t_head').hide();
            var id=$(this).attr('data_id');//类目id
            var providerId=$(this).attr('data_providerId');//绑定对应的供应商ID
            $('body').attr('data_providerId',providerId);
            $('body').attr('data_id',id);

            var data={
                'id':id
            }

            ajax_call(one_id_success,'/mikuPiteminfo/search',data);


//                alert($('body').attr('data_providercateid'))

        }).on('click','#tb_one_supplier tr',function(){//设置providerId
            var providerId2=$(this).attr('data_providerId');
            $('body').attr('data_providerId2',providerId2);
            var name=$(this).attr('data_name');
            $('#providername').text(name);
            $(this).addClass('success').siblings().removeClass('success');

        }).on('click','#chang_relation',function(){//关联供应商、商品类目
            var id=$('body').attr('data_id');//商品id
            var providerId=$('body').attr('data_providerid');//原始供应商id
            var providerId2=$('body').attr('data_providerid2');//新供应商id
            var cateId=$('body').attr('data_cateId');

            var catename=$('#catename').text();
//            if(catename==''){
//                alert('请选择商品类别！');
//                return false;
//            }
//            if(providerId2==undefined && providerId==''){
//                alert('未选供应商');
//                return false;
//            }
            if(providerId){
                var data={
                    'id':id,
                    'providerId':providerId
                }
            }
            if(providerId2){
                var data={
                    'id':id,
                    'providerId':providerId2
                }
            }
            if(cateId){
                if(providerId){
                    var data={
                        'id':id,
                        'providerId':providerId,
                        'cateId':cateId
                    }
                }
                if(providerId2){
                    var data={
                        'id':id,
                        'providerId':providerId2,
                        'cateId':cateId
                    }
                }
            }
            ajax_call(bingSupplier,'/mikuPiteminfo/bingSupplier',data)

        }).on('click','#query',function(){

            var value=$('#query_value').val();
            var data={
                'words':value,
                'ischeck':1
            }
            ajax_call(query_goods,'/mikuPiteminfo/search',data);
        }).on('click','#addlist',function(){//弹新增类目
            $('#in-w').val('');
            $('#add_category').modal('show');
            $('.identification').attr('id','s_click');
        }).on('click','#s_click',function(){//点确定新增类目
            var tId=$('body').attr('data_cateid1');//父节点id
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

        }).on('click','#addlist_goods',function(){//弹出类目增加

            $('#add_category').modal('show');
            $('.identification').attr('id','s_goods');
            $('#in-w').val('');
        }).on('click','#s_goods',function(){//增加新商品类目
            var tId=$('body').attr('data_cateid');//父节点id
            var name=$('#in-w').val();
            $.ajax({
                url: '/mikuProvider/addClassify?name='+name+'&pId='+tId,
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
        }).on('click','#clear_shoper',function(){//清空供应商
            $('body').attr('data_providerid2','0');
            $('#providername').text('');
        }).on('click','#clear_goodslist',function(){//清空商品类目
            $('body').attr('data_cateid','0');
            $('#catename').text('');
        })


        //        ajax
        function ajax_call(success,url,data) {
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



//            search根据id
            function one_id_success(data){
                var data=data.result;
                var cateName=data.cateName;//商品类目名
                var providerName=data.providerName;//供应商名
                var providerCateId=data.providerCateId;//供应商类目id
                var pclassifyId=data.pclassifyId;
                $('body').attr('data_catename',cateName);
                $('body').attr('data_providername',providerName);
                $('body').attr('data_providerCateId',providerCateId);
                $('body').attr('data_pclassifyId',pclassifyId);

                $('#providername').text(providerName);
                $('#catename').text(cateName);

//                treeajax('/mikuSupplierClassify/list');
//                treeajax2('/mikuProvider/selectClassify');
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                $.fn.zTree.init($("#treeDemo2"), setting2, zNodes2);
            }

            //            搜索商品
            function query_goods(data){
                var tp=f_goods_tp(data);
                $('#result_query').empty();
                $('.frist_thead').show();
                $('.frist_body').show();
                $('#result_query').append(tp);

                icheck();
                setWidth('.frist_thead li','#result_query tr:first td',17);
            }

//        查询成功
            function f_goods_success(data){
                var tp=f_goods_tp(data);
                $('#result_query').empty();
                $('.frist_thead').show();
                $('.frist_body').show();
                $('#result_query').append(tp);
                icheck();
                setWidth('.frist_thead li','#result_query tr:first td',17);

            }


        //当浏览器窗口大小改变时
        window.onresize=function(){
            setWidth('.frist_thead li','#result_query tr:first td',17);
            setWidth('.t_head li','#tb_one_supplier tr:first td',17);
        }

        //        设置table头部宽
        function setWidth(target_selector,original_selector,num){
            var Obj=$(target_selector);
            var Obj1=$(original_selector);
            for(var i= 0;i<Obj1.length;i++){
                Obj.eq(i).width(Obj1.eq(i).width()+num);
            }
        }

//        空方法
        function nf(){

        }
//            绑定供应商
        function bingSupplier(data){
            alert('绑定成功！');
            $('#myModal').modal('hide');//绑定成功隐藏
            location.reload();
        }

//        打码确定
        function codeSuccess(data){
            alert(data.msg);
            location.reload();
        }

//            frist商品列表模板
        function f_goods_tp(obj){
            var tp='';
            var obj=obj.result;
            var html='<tbody>';
            for(var i= 0;i<obj.length;i++){
                html+='<tr>';
                html+='<td width="5%">'+i+'</td>';
                html+='<td width="10%">'+obj[i].title+'</td>';
                html+='<td width="10%">'+obj[i].keyword+'</td>';
                html+='<td width="5%">'+obj[i].type+'</td>';
                html+='<td width="10%">'+obj[i].weight+'</td>';
                html+='<td width="10%">'+obj[i].code+'</td>';
                html+='<td width="5%">'+obj[i].postFee/100+'</td>';
                html+='<td width="10%">'+obj[i].area+'</td>';
                html+='<td width="10%">'+obj[i].area+'</td>';
                html+='<td width="10%">'+obj[i].rknum+'</td>';
                html+='<td width="5%">'+obj[i].jhprice/100+'</td>';
                html+='<td width="5%">'+obj[i].xsprice/100+'</td>';
                html+='<td width="5%"><input name="checkone" type="radio" data_id="'+obj[i].id+'"></td>';
                html+='</tr>';

            }
            html+='</tbody>';
            tp+=html;

            return tp;

        }

//          alert层
                function alertHtml(title,body){
                    var html='<div class="modal fade" id="operating">';
                    html+='<div class="modal-dialog">';
                    html+='<div class="modal-content">';
                    html+='<div class="modal-header">';
                    html+='<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
                    html+='<h4 class="modal-title">'+title+'</h4>';
                    html+='</div>';
                    html+='<div class="modal-body">';
                    html+='<p>'+body+'</p>';
                    html+='</div>';
                    html+='<div class="modal-footer">';
                    html+='<button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>';
                    html+='</div>';
                    html+='</div>';
                    html+='</div>';

                    return html;
                }




        //    供应商类目

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
//        function showRenameBtn(treeId, treeNode) {
//            return !treeNode.isLastNode;
//        }
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
            var data_providercateid=$('body').attr('data_providercateid');
            return treeNode.id == data_providercateid ? {color:"red"} : {};
        };

        //树枝单击
        function zTreeOnClick(event, treeId, treeNode) {
            $('#addlist').show();
            var tid=treeNode.id;
            $('body').attr('data_cateid1',tid);
            var data={
                'cateId':tid,
                'ischeck':1
            }
            ajax_call1(one_tree_db,'/mikuProvider/search',data);


            }

            function one_tree_db(data){
                var tp=one_tree_dbHtml(data);
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

            function one_tree_dbHtml(obj){
                var tp='';
                var obj=obj.result;
                var supplier_id=$('body').attr('data_providerid');
                if(obj){
                    var html='<tbody>';
                    for(var j=0;j<obj.length;j++){
                        if(supplier_id==obj[j].id){
                            html+='<tr class="warning" data_providerId="'+obj[j].id+'" data_name="'+obj[j].name+'">';
                        }else{
                            html+='<tr data_providerId="'+obj[j].id+'" data_name="'+obj[j].name+'">';
                        }

//                        html+='<td style="min-width: 30px;">'+j+'</td>';
                        html+='<td style="width: 181px;">'+obj[j].name+'</td>';
                        html+='<td style="width: 71px;">'+obj[j].sname+'</td>';
//                        html+='<td>'+obj[j].cperson+'</td>';
//                        html+='<td>'+obj[j].job+'</td>';
                        html+='<td style="width: 144px;">'+obj[j].mobile+'</td>';
//                        html+='<td style="min-width: 30px;">'+obj[j].address+'</td>';
                        html+='</tr>';

                    }
                    html+='</tbody>';
                    tp+=html;
                }
                return tp;

            }


        //商品类目
        var setting2 = {
            view: {
                addHoverDom: false,
                removeHoverDom: removeHoverDom2,
                selectedMulti: false,
                fontCss: setFontCss2
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
        function setFontCss2(treeId, treeNode) {
            var pclassifyId=$('body').attr('data_pclassifyId');
            return treeNode.id == pclassifyId ? {color:"red"} : {};
        };
        function zTreeOnClick2(event, treeId, treeNode) {
            var cateId=treeNode.id;
            var name=treeNode.name;
            $('#catename').text(name);//设置商品类目名
            $('body').attr('data_cateId',cateId);

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

    </script>
    </body>
    </html>
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
        <h1> 米酷商品列表 <small>未审核商品</small> </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>米酷商品列表</a></li>
            <li class="active">未审核商品</li>
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
                                    <button type="submit" class="btn btn-primary" onclick="window.location.replace('/mikuCustomizedMultimediaManage/editView?id=${li.id}')">发布</button>
                                    <button type="submit" class="btn btn-warning">删除</button>
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

            </section>
        </div>
    </section>
    <!-- /.box -->



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





        //        空方法
        function nf(){

        }


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



    </script>
    </body>
    </html>
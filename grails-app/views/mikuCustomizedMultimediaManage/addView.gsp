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

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>

    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <style>
    .lineDiv
    {
        position: relative;
        border-bottom: 1px solid #eee;
        height: 30px;
        margin: 10px 0;
    }

    .title
    {
        position: absolute;
        width: 200px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        left: 50%;
        top: -3px;
        /*background-color: #fff;*/
        margin-left: -100px;
        font-size: large;
        font-weight: 200;
    }

    .tipeHide{display: none;color: red}

    /*搜索*/
    ::-webkit-scrollbar-track {
        background-color: rgba(0, 0, 0, 0);
    }

    ::-webkit-scrollbar {
        width: 0px;
        background-color: rgba(0, 0, 0, 0);
    }

    ::-webkit-scrollbar-thumb {
        background-color: rgba(0, 0, 0, 0);
    }

    .row{position: relative;}
    .searchBox{border:1px solid #e5e5e5;padding:5px;position:absolute;
        top:34px;
        width:92.5%;z-index: 9;background-color: #fff;
    }
    .searchBox dl{max-height:100px;overflow-y: auto;margin-bottom: 0}
    .searchBox dd{padding:2px 3px;font-size: 14px;}
    .searchBox .close{position:absolute;top:5px;right:5px}
    .searchBox dd:hover{background-color: #1094fa;
        color: #fff;}


    .inputClose{ position: absolute; right: 22px;top: 6px;font-size: 18px;cursor: pointer;}
    </style>

</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        私人订制
        <small>视频管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>多媒体管理</a></li>
        <li class="active">增加多媒体</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">多媒体列表</g:link></li>
                    <li class="active"><g:link action="addView">增加多媒体</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="item_form" useToken="true" action="add">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">资源名称：</label>
                    <div class="col-xs-3">
                        <input type="text" id="resName" name="resName" class="form-control"
                               placeholder="资源名称" >
                    </div>

                    <label class="col-xs-2 control-label">资源名缩写：</label>

                    <div class="col-xs-3">
                        <input type="text" id="resShortName" name="resShortName" class="form-control"
                               placeholder="资源名缩写" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">订制类型：</label>

                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="mineType"
                                  class="form-control" from="${mineTypeMap}" value=""
                                  noSelection="['': '请选择']"/>
                    </div>

                    <label class="col-xs-2 control-label">资源类型：</label>
                    <div class="col-xs-3">
                        %{--<select name="" class="form-control" id="resType">--}%
                            %{--<option value="">请选择</option>--}%
                            %{--<option value="1">视频</option>--}%
                            %{--<option value="2">音频</option>--}%
                            %{--<option value="3">图片</option>--}%
                        %{--</select>--}%
                        <g:select optionKey="key" optionValue="value" name="resType"
                                  class="form-control" from="${resTypeMap}" value=""
                                  noSelection="['': '请选择']"/>
                    </div>

                </div>

                <div class="list-group-item form-group" id="type_show_in" style="display:none;">

                    <label class="col-xs-2 control-label" id="type_txt"></label>

                    <div class="col-sm-8" id="pic_show">
                        %{--<!--dom结构部分-->--}%
                        <div id="uploader" class="queueList">

                            <!--用来存放item-->

                            <ul id="fileList" class="filelist">

                            </ul>

                            <div id="filePicker">选择图片</div>
                        </div>
                    </div>

                    <div class="col-xs-6" id="mul_show" style="display:none;">
                        <input type="url" id="resUrl" name="resUrl" class="form-control"
                               placeholder="url" >
                    </div>

                </div>


                <div class="list-group-item form-group mul_show" style="display: none;">
                    <label class="col-xs-2 control-label">资源时长(分)：</label>
                    <div class="col-xs-3">
                        <input type="number" id="resTime" name="resTime" class="form-control"
                               placeholder="资源时长" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">资源使用提示：</label>

                    <div class="col-xs-3">
                        <textarea rows="3" name="resUseRemind" id="resUseRemind" class="form-control" placeholder="资源使用提示"></textarea>
                    </div>
                </div>

            </div>

            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit" id="fbBtn">确定</button>
                </div>
            </div><!-- /.box-footer-->
        </g:form>

    </div><!-- /.box -->
</section><!-- /.content -->


%{--<!-- Modal -->--}%
%{--<div class="modal fade bs-example-modal-lg" id="myShow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--}%
    %{--<div class="modal-dialog modal-lg" role="document">--}%
        %{--<div class="modal-content">--}%
            %{--<div class="modal-header bg-maroon-gradient">--}%
                %{--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--}%
                %{--<h3 class="modal-title"></h3>--}%
            %{--</div>--}%
            %{--<div class="modal-body">--}%
                %{--<div class="select_con">--}%

                %{--</div>--}%
            %{--</div>--}%
            %{--<div class="modal-footer">--}%
                %{--<button type="button" class="btn btn-primary determine" id="">确定</button>--}%
                %{--<button type="button" class="btn btn-primary">Save changes</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%



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
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>


    $('#resType').change(function(){
        var value=$(this).find("option:selected").attr('value');
        $('#type_show_in').hide();
        $('#pic_show').hide();
        $('#mul_show').hide();
        $('.mul_show').hide();

        $('#resUrl').val("");
//        $('#resName').val("");
//        $('#resShortName').val("");
        $('#resTime').val("");
        $('#resUseRemind').val("");

        if(value){
            $('#type_show_in').show();
            if(value==1){
                $('#mul_show').show();
                $('.mul_show').show();
                $('#resUrl').val('http://mikumine.b0.upaiyun.com/multimedia/');
                $('#type_txt').text('视频地址：');
            }else if(value==2){
                $('#mul_show').show();
                $('.mul_show').show();
                $('#resUrl').val('http://mikumine.b0.upaiyun.com/multimedia/');
                $('#type_txt').text('音频地址：');
            }else if(value==3){
                $('#pic_show').show();
                $('#type_txt').text('上传图片：');
            }

        }
    })




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








    //*************************************************

    function checkbox(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '10%' // optional
        });
    }


    $('.dropdown-toggle').dropdown()



</script>

</body>

</html>

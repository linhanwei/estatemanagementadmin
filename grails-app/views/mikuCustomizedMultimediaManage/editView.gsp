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
        <li class="active">编辑多媒体</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">多媒体列表</g:link></li>
                    <li class="active"><g:link action="addView">编辑多媒体</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="item_form" useToken="true" action="add">
            <div class="box-header">
            </div>
            <input type="hidden" value="${info.id}" id="id" name="id" class="form-control">
            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">资源名称：</label>
                    <div class="col-xs-3">
                        <input type="text" value="${info.resName}" id="resName" name="resName" class="form-control"
                               placeholder="资源名称" >
                    </div>

                    <label class="col-xs-2 control-label">资源名缩写：</label>

                    <div class="col-xs-3">
                        <input type="text" value="${info.resShortName}" id="resShortName" name="resShortName" class="form-control"
                               placeholder="资源名缩写" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">订制类型：</label>

                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="mineType"
                                  class="form-control" from="${mineTypeMap}" value="${info.mineType}"
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
                        class="form-control" from="${resTypeMap}" value="${info.resType}"
                        noSelection="['': '请选择']"/>
                    </div>

                </div>

                <div class="list-group-item form-group" id="type_show_in" style="display:none;">

                        <label class="col-xs-2 control-label" id="type_txt"></label>
                    %{--<g:if test="${picList}">--}%
                    <div class="col-sm-8" id="pic_show" style="display:none;">
                        <!--dom结构部分-->

                        <div id="uploader" class="queueList">
                            <!--用来存放item-->
                            <ul id="fileList" class="filelist">

                                    <g:each status="i" in="${picList}" var="picUrl">
                                        <li id="WU_FILE_11${i}" class="state-complete">
                                            <p class="title"></p>

                                            <p class="imgWrap">
                                                <img src="${picUrl}">
                                                <input name="item-pic" value="${picUrl}" style="display: none">
                                            </p>

                                            <div class="file-panel">
                                                <span class="cancel">删除</span>
                                                <span class="rotateLeft">向左移动</span>
                                                <span class="rotateRight">向右移动</span>
                                            </div>
                                            <span class="success"/>
                                        </li>
                                    </g:each>

                            </ul>

                            <div id="filePicker">选择图片</div>
                        </div>

                        </div>
                    %{--</g:if>--}%
                    %{--<g:else>--}%
                        <div class="col-xs-3" id="mul_show" style="display:none;">
                            <input type="url" value="${info.resUrl}" id="resUrl" name="resUrl" class="form-control"
                                   placeholder="url" >
                        </div>
                    %{--</g:else>--}%



                </div>


                <div class="list-group-item form-group mul_show" style="display:none;">
                    <label class="col-xs-2 control-label">资源时长：</label>
                    <div class="col-xs-3">
                        <input type="text" id="resTime" name="resTime" value="${info.resTime}" class="form-control"
                               placeholder="资源时长" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">资源使用提示：</label>

                    <div class="col-xs-3">
                        <textarea rows="3" name="resUseRemind" id="resUseRemind" class="form-control" placeholder="资源使用提示">${info.resUseRemind}</textarea>
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
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>
<asset:javascript src="pages/item/publish-url-pic.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>

    $(document).ready(function(){
        var ifshow=$('#resType').find("option:selected").attr('value');
        if(ifshow){
            $('#type_show_in').show();
            if(ifshow==1){
                $('#mul_show').show();
                $('.mul_show').show();
                $('#type_txt').text('视频地址：');
            }else if(ifshow==2){
                $('#mul_show').show();
                $('.mul_show').show();
                $('#type_txt').text('音频地址：');
            }else if(ifshow==3){
                $('#pic_show').show();
                $('#type_txt').text('上传图片：');
            }

        }
    })

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
//        $('#resUseRemind').val("");

        if(value){
            $('#type_show_in').show();
            if(value==1){
                $('#mul_show').show();
                $('.mul_show').show();
                $('#type_txt').text('视频地址：');
            }else if(value==2){
                $('#mul_show').show();
                $('.mul_show').show();
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

    //图片管理开始
    $('.dropdown-toggle').dropdown()

    $("[id^='WU_FILE_']").each(function () {

        var id = this.id
        var $btn = $(this).find('.file-panel')

        $(this).on('mouseenter', function () {
            $btn.stop().animate({height: 30});
        });

        $(this).on('mouseleave', function () {
            $btn.stop().animate({height: 0});
        });

        $btn.on('click', 'span', function () {

            var index = $(this).index(),
                    deg;

            switch (index) {
                case 0:
                    $('#' + id).remove()
                    return;
                case 1:
                    console.log(id)
                    moveDown($('#' + id))
                    break;
                case 2:
                    moveUp($('#' + id))
                    break;

            }

        });

        function moveUp($item) {
            $before = $item.prev();
            $item.insertBefore($before);
        }

        function moveDown($item) {
            $after = $item.next();
            $item.insertAfter($after);
        }
    });
    //图片管理结束


</script>

</body>

</html>

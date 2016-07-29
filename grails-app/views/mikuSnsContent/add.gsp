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
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>



    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style>
        .dn{
            display: none;
        }
    .f_r{
        color: red;
    }
    </style>
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        发现:添加文章
        <small>添加文章</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>发现管理</a></li>
        <li class="active">添加文章</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li >
                        <g:link action="list">发现文章列表</g:link></li>
                    <li class="active">
                        <g:link action="add">添加发现文章</g:link></li>

                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="addTagForm" useToken="true" action="publish">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group clearfix">
                <div class='col-xs-12'>
                    <div class="row">

                        <input type="text" class="hide" value="1" name="userInfoflag" placeholder="用户判断标示"/>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>添加文章方式:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="radio" checked="checked" id="systemtype" name="addtype" class="form-control">系统方式发布
                                <input type="radio" id="addtype" name="addtype" class="form-control"/>增加用户发布
                            </div>
                        </div>

                        <div class="list-group-item form-group" id="userid">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>用户:</label>

                            <div class="col-xs-12 col-sm-3 userid_box">
                                %{--<input type="text" name="userId" class="form-control"--}%
                                       %{--placeholder="用户id">--}%
                                <g:select optionKey="id" optionValue="nickname" name="userId"
                                          class="form-control" from="${list}" value="${list.nickname}" noSelection="['': '请选择']"/>
                                %{--<select name="userId" class="form-control" id="userId">--}%
                                %{--<option value="">dddd</option>--}%
                                %{--<option value="">dddd</option>--}%
                            %{--</select>--}%
                            </div>
                            <span class="f_r" id="user_check" style="display:none;">空户不能为空！</span>
                        </div>

                        <div class="list-group-item form-group dn" id="username">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>用户名称:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="userName" class="form-control"
                                       placeholder="系统用户名称">
                            </div>
                            <span class="f_r" id="userName_check" style="display:none;">空户不能为空！</span>
                        </div>

                        <div class="list-group-item form-group dn" id="userportrait">
                        <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>用户的头像:</label>
                            <div class="col-xs-12 col-sm-8">
                            <!--dom结构部分-->
                                <div id="uploader3" class="queueList">
                                <!--用来存放item-->
                                    <ul id="fileList3" class="filelist">
                                    </ul>
                                    <div id="filePicker3">用户的头像</div>
                                    <span style="display:none;color:red" id="PosterImgTip">请上传对应用户的头像</span>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>文章标题:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="contentTitle" class="form-control"
                                       placeholder="文章标题">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>文章标题简称:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="contentShortTitle" class="form-control"
                                       placeholder="文章标题简称">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>内容摘要:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="contentAbstract" class="form-control"
                                       placeholder="内容摘要">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>封面图:</label>
                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader" class="queueList">
                                    <!--用来存放item-->
                                    <ul id="fileList" class="filelist">

                                    </ul>
                                    <div id="filePicker">封面图</div>
                                </div>
                                <span class="f_r" id="uploader_check" style="display:none;">至少上传一张封面图！</span>
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>缩略图:</label>
                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader2" class="queueList">
                                    <!--用来存放item-->
                                    <ul id="fileList2" class="filelist">
                                    </ul>
                                    <div id="filePicker2">缩略图</div>
                                </div>
                                <span class="f_r" id="uploader_check2" style="display:none;">至少上传一张缩略图！</span>
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-font"></i>文字内容:</label>
                            <div class="col-xs-12 col-sm-8">
                                <textarea name="content" id="content_textarea" style="display: none;"></textarea>
                                <script id="editor" type="text/plain" style="width:100%;height:500px;"></script>
                            </div>
                        </div>

                        %{--<div class="list-group-item form-group">--}%
                            %{--<label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>内容图片:</label>--}%
                            %{--<div class="col-xs-12 col-sm-8">--}%
                                %{--<!--dom结构部分-->--}%
                                %{--<div id="uploader4" class="queueList">--}%
                                    %{--<!--用来存放item-->--}%
                                    %{--<ul id="fileList4" class="filelist">--}%
                                    %{--</ul>--}%
                                    %{--<div id="filePicker4">内容图片</div>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                        <input type="text" class="hide" value="2" name="referencedGoalType" placeholder="被引用资源类型对象类型:1、客服/私人管家2、文章3、课程4、私人定制线下店"/>
                        <input type="text" class="hide" value="0" name="specialFlag" placeholder="用于处理特殊文章：0、正常文章1、负面文章（作者可见，其它用户不可见） 2、待定"/>



                    </div>
                </div>
            </div><!-- /.box-body -->
            <div class="box-footer clearfix">
                <div class="col-sm-offset-3">
                    <button id="fbtn_up" type="submit" style="display: none;"></button>
                    <button id="fbtn" type="button" class="btn btn-primary">确定</button>
                    <button class="btn btn-default" type="reset">取消</button>
                </div>
            </div><!-- /.box-footer-->
        </g:form>
    </div><!-- /.box -->
</section><!-- /.content -->


<div class="userid_html dn">
    <g:select optionKey="id" optionValue="nickname" name="userId"
              class="form-control" from="${list}" value="${list.nickname}" noSelection="['': '请选择']"/>
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
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>
<asset:javascript src="pages/item/publish-url-pic.js"/>
<asset:javascript src="pages/item/add-sns-pic.js"/>

%{--ueditor--}%
<asset:javascript src="UEditor/ueditor.config.js"/>
<asset:javascript src="UEditor/ueditor.all.js"/>
<asset:javascript src="UEditor/zh-cn.js"/>

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

    $('#userId').removeAttr("multiple");

    $("#decrease").click(function () {
        var now = $("#num").val();
        now = now * 1 - 1
        if (now > 0) {
            $("#num").val(now);
        }
    });
    $("#insert").click(function () {
        var now = $("#num").val();
        now = now * 1 + 1
        if (now > 0) {
            $("#num").val(now);
        }
    });

    $('.dropdown-toggle').dropdown()

    $(document).on('click','#fbtn',function(){

        getLocalData();

        var user_check=$('#userId').val();
        var uploader_check=$('#uploader #fileList').find('li');
        var uploader_check2=$('#uploader2 #fileList2').find('li');
        var userName=$('#username input').val();

        if($('#systemtype').is(':checked')){
            if(!user_check){
                $('#user_check').show();
                return;
            }else{
                $('#user_check').hide();
            }
        }else if($('#addtype').is(':checked')){
            if(!userName){
                $('#userName_check').show();
                return;
            }else{
                $('#userName_check').hide();
            }

        }

        if(uploader_check.length==0){
            $('#uploader_check').show();
            return;
        }else{
            $('#uploader_check').hide();
        }
        if(uploader_check2.length==0){
            $('#uploader_check2').show();
            return;
        }else{
            $('#uploader_check2').hide();
        }


        $('#fbtn_up').click();

        //海报图片
        var deilPic=$("input[name=detail-pic]");
//        if(deilPic.length==0)
//        {
//            alert("至少需要上传一张海报图.");
//            $("#ComImgTip").css('display','block');
//            $("#ComImgTip").css('margin-top','10px');
//            return false;
//        }else{
//            $("#ComImgTip").css('display','none');
//        }
//        //详情图的限制
//        var urlPic=$("input[name=url-pic]");
//        if(urlPic.length==0)
//        {
//            alert("至少需要上传一张海报中呈现的产品图.");
//            $("#PosterImgTip").css('display','block');
//            $("#PosterImgTip").css('margin-top','10px');
//            return false;
//        }else{
//            $("#PosterImgTip").css('display','none');
//        }
    }).on('ifChecked','#switchtype input[value=1]',function(){
        $('#con_url').attr('type','url');
    }).on('ifChecked','#systemtype',function(){
        $('.userid_box').append($('.userid_html').html());
        $('#userId').removeAttr("multiple");
        $('#userid').show();
        $('#username').hide();
        $('#userportrait').hide();
    }).on('ifChecked','#addtype',function(){
        $('#userid').hide();
        $('.userid_box').empty();
        $('#username').show();
        $('#userportrait').show();
    })

    //UEditor获取草稿箱的内容

    function getLocalData () {
        $('#content_textarea').text(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }


    $('#fbtn_up').click(function(){

    });



</script>

<script>
    var ue = UE.getEditor('editor',{
        //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
        toolbars:[
            ['fullscreen', 'source', '|', 'undo', 'redo', '|',
                'bold', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                'customstyle', 'paragraph', 'fontsize', '|',
                'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
                'link', 'unlink','|',
                'simpleupload', 'insertimage', 'emotion', 'insertvideo']
        ],
        elementPathEnabled:false
    });

</script>

</body>

</html>

<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.apache.commons.lang.StringUtils; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        发现:编辑文章
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

   %{-- mikuSnsContent:mikuSnsContent,
    mikuMyDynamic:mikuMyDynamic--}%

    <!-- Default box -->
    <div class="box">
        <g:form name="addTagForm" useToken="true" action="publish">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group clearfix">
                <div class='col-xs-12'>
                    <div class="row">

                        <input type="text" class="hide" value="1" name="userInfoflag" placeholder="用户判断标示"/>
                        <input type="text" class="hide" value="${mikuMyDynamic.id}" name="dyId" placeholder="文章活动表的Id"/>
                        <input type="text" class="hide" value="${mikuSnsContent.id}" name="sId" placeholder="文章内容表的Id"/>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>用户id:</label>

                            <div class="col-xs-12 col-sm-3">
                                %{--<input type="text" name="userId" class="form-control"--}%
                                       %{--placeholder="用户id"  value="${mikuMyDynamic.userId}">--}%

                                <g:select optionKey="id" optionValue="nickname" name="userId"
                                          class="form-control" from="${list}" value="${mikuSnsContent.userId}" noSelection="['': '请选择']"/>
                            </div>
                        </div>

                        %{--<div class="list-group-item form-group">--}%
                            %{--<label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>系统用户名称:</label>--}%

                            %{--<div class="col-xs-12 col-sm-3">--}%
                                %{--<input type="text" name="userName" class="form-control"--}%
                                       %{--placeholder="系统用户名称">--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        %{--<div class="list-group-item form-group">--}%
                            %{--<label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>用户的头像:</label>--}%
                            %{--<div class="col-xs-12 col-sm-8">--}%
                                %{--<!--dom结构部分-->--}%
                                %{--<div id="uploader3" class="queueList">--}%
                                    %{--<!--用来存放item-->--}%
                                    %{--<ul id="fileList3" class="filelist">--}%
                                    %{--</ul>--}%
                                    %{--<div id="filePicker3">用户的头像</div>--}%
                                    %{--<span style="display:none;color:red" id="PosterImgTip">请上传对应用户的头像</span>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>文章标题:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="contentTitle" class="form-control"
                                       placeholder="文章标题" value="${mikuSnsContent.contentTitle}">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>文章标题简称:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="contentShortTitle" class="form-control"
                                       placeholder="文章标题简称" value="${mikuSnsContent.contentShortTitle}">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>内容摘要:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="contentAbstract" class="form-control"
                                       placeholder="内容摘要" value="${mikuSnsContent.contentAbstract}">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>封面图:</label>
                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader" class="queueList">
                                    <!--用来存放item-->

                                    <ul id="fileList" class="filelist">
                                        <g:each status="i" in="${org.apache.commons.lang.StringUtils.split(mikuSnsContent.contentSurfacePicUrl, ';')}" var="picUrl">
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


                                    <div id="filePicker">封面图</div>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>缩略图:</label>
                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader2" class="queueList">
                                    <!--用来存放item-->
                                    <ul id="fileList2" class="filelist">
                                        <g:each status="i" in="${org.apache.commons.lang.StringUtils.split(mikuSnsContent.contenThumbPicUrl, ';')}" var="picUrl">
                                            <li id="WU_FILE_11${i}" class="state-complete">
                                                <p class="title"></p>

                                                <p class="imgWrap">
                                                    <img src="${picUrl}">
                                                    <input name="detail-pic" value="${picUrl}" style="display: none">
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
                                    <div id="filePicker2">缩略图</div>
                                </div>
                                <span style="display:none;color:red" id="ComImgTip">至少上传一张海报图片</span>
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-font"></i>文字内容:</label>
                            <div class="col-xs-12 col-sm-8">
                                <textarea name="content" id="content_textarea" style="display: none;">${mikuSnsContent.content}</textarea>
                                %{--<textarea name="content" id="content_textarea" >${mikuSnsContent.content}</textarea>--}%
                                <script id="editor" type="text/plain" style="width:100%;height:500px;"></script>

                                %{--<script type="text/plain" id="myEditor1" name="myEditor1">{$article.content}</script>--}%

                                %{--改成：--}%

                                %{--<textarea id="myEditor1" name="myEditor1">{$article.content}</textarea>--}%

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

                        %{--<div class="list-group-item form-group">--}%
                            %{--<label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>内容图片:</label>--}%
                            %{--<div class="col-xs-12 col-sm-8">--}%
                                %{--<!--dom结构部分-->--}%
                                %{--<div id="uploader4" class="queueList">--}%
                                    %{--<!--用来存放item-->--}%
                                    %{--<ul id="fileList4" class="filelist">--}%
                                        %{--<g:each status="i" in="${org.apache.commons.lang.StringUtils.split(mikuSnsContent.picUrls, ';')}" var="picUrl">--}%
                                            %{--<li id="WU_FILE_11${i}" class="state-complete">--}%
                                                %{--<p class="title"></p>--}%

                                                %{--<p class="imgWrap">--}%
                                                    %{--<img src="${picUrl}">--}%
                                                    %{--<input name="sns-pic" value="${picUrl}" style="display: none">--}%
                                                %{--</p>--}%

                                                %{--<div class="file-panel">--}%
                                                    %{--<span class="cancel">删除</span>--}%
                                                    %{--<span class="rotateLeft">向左移动</span>--}%
                                                    %{--<span class="rotateRight">向右移动</span>--}%
                                                %{--</div>--}%
                                                %{--<span class="success"/>--}%
                                            %{--</li>--}%
                                        %{--</g:each>--}%
                                    %{--</ul>--}%
                                    %{--<div id="filePicker4">内容图片</div>--}%
                                %{--</div>--}%
                                %{--<span style="display:none;color:red" id="ComImgTip">至少上传一张内容图片</span>--}%
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


        $('#fbtn_up').click();

        function getLocalData () {
            $('#content_textarea').val(UE.getEditor('editor').execCommand( "getlocaldata" ));
        }
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
    })


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

    $(function(){
        var content =$('#content_textarea').val();
        //判断ueditor 编辑器是否创建成功
        ue.addListener("ready", function () {
            // editor准备好之后才可以使用
            ue.setContent(content);

        });
    });


</script>

</body>

</html>

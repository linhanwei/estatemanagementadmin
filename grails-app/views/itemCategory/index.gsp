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
    <!-- jstree -->
    <asset:stylesheet src="jstree/themes/default/jstree-style.css"/>
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
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        类目
        <small>管理</small>
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-6'>
            <div class="box box-primary">
                <div class="box-header">
                    <div class="box-tools">
                    </div>
                </div><!-- /.box-header -->
                <div class="box-body  no-padding">
                    <input id="selectedId" style="display: none;"/>
                    <input id="selectedName" style="display: none;"/>
                    <input id="selectedFeatures" style="display: none;"/>
                    <div id="jstree">
                    </div>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div>

        <div id="operation" class='col-xs-6'>
            <div class="box box-primary">
                <div class="box-header">

                    <button type="button" id="createNode" class="btn btn-primary" data-toggle="modal"
                            onclick="bindSelected()"
                            data-target="#myModal">
                        新增父类目
                    </button>

                </div><!-- /.box-header -->
                <div id="nodeDetail">
                </div>
            </div><!-- /.box -->
        </div>
    </div>
</section><!-- /.content -->


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">新增类目</h4>
            </div>

            <div class="modal-body">
                <g:render template="create"/>
            </div>
        </div>
    </div>
</div>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- jstree -->
<asset:javascript src="jstree/jstree.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script type="text/javascript">

    function bindSelected() {
        $('#pId').val($('#selectedId').val())
        $('#pName').val($('#selectedName').val())
        $('#pFeatures').val($('#selectedFeatures').val());
        bindPicCreate()
    }

    function bindPicEdit() {
        /**
         * Created by saarixx on 12/11/14.
         */
        (function ($) {
            // 当domReady的时候开始初始化
            $(function () {
                // 初始化Web Uploader
                var uploader = WebUploader.create({

                    // 选完文件后，是否自动上传。
                    auto: true,

                    // swf文件路径
                    swf: "assets/ueditor-1.4.3/third-party/webuploader/Uploader.swf",

                    // 文件接收服务端。
                    server: '/itemPublish/handle?action=uploadImage',

                    // 选择文件的按钮。可选。
                    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                    pick: '#filePicker2',

                    // 只允许选择图片文件。
                    accept: {
                        title: 'Images',
                        extensions: 'gif,jpg,jpeg,bmp,png',
                        mimeTypes: 'image/*'
                    }
                });

                var $ = jQuery,
                        $list = $('#fileList2'),
                // 优化retina, 在retina下这个值是2
                        ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                        thumbnailWidth = 100 * ratio,
                        thumbnailHeight = 100 * ratio,

                // Web Uploader实例
                        uploader;

                // 当有文件添加进来的时候
                uploader.on('fileQueued', function (file) {
                    addFile(file)
                });


                // 文件上传成功，给item添加成功class, 用样式标记上传成功。
                uploader.on('uploadSuccess', function (file) {
                    $('#' + file.id).addClass('state-complete');
                    $('#' + file.id).append('<span class="success"></span>');
                });

                uploader.on('uploadAccept', function (file, response) {
                    console.log($('#' + file.file.id).find('p.imgWrap'))
                    $('#' + file.file.id).find('p.imgWrap').html('<img src="' + response.url + '"><input name="detail-pic" value="' + response.url + '" style="display: none">');
                });

                // 文件上传失败，显示上传出错。
                uploader.on('uploadError', function (file) {
                    var $li = $('#' + file.id),
                            $error = $li.find('div.error');

                    // 避免重复创建
                    if (!$error.length) {
                        $error = $('<div class="error"></div>').appendTo($li);
                    }

                    $error.text('上传失败');
                });

                // 完成上传完了，成功或者失败，先删除进度条。
                uploader.on('uploadComplete', function (file) {
                    $('#' + file.id).find('.progress').remove();
                });

                // 当有文件添加进来时执行，负责view的创建
                function addFile(file) {
                    var $li = $('<li id="' + file.id + '">' +
                                    '<p class="title">' + file.name + '</p>' +
                                    '<p class="imgWrap"></p>' +
                                    '</li>'),

                            $btns = $('<div class="file-panel">' +
                                    '<span class="cancel">删除</span>' +
                                    '<span class="rotateLeft">向左移动</span>' +
                                    '<span class="rotateRight">向右移动</span>' +
                                    '</div>').appendTo($li),

                            $wrap = $li.find('p.imgWrap'),
                            $info = $('<p class="error"></p>')


                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        var img;
                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }
                        img = $('<img src="' + src + '">');
                        $wrap.empty().append(img);
                    }, thumbnailWidth, thumbnailHeight);

                    $li.on('mouseenter', function () {
                        $btns.stop().animate({height: 30});
                    });

                    $li.on('mouseleave', function () {
                        $btns.stop().animate({height: 0});
                    });

                    $btns.on('click', 'span', function () {

                        var index = $(this).index(),
                                deg;

                        switch (index) {
                            case 0:
                                removeFile(file);
                                return;
                            case 1:
                                moveDown($('#' + file.id))
                                break;
                            case 2:
                                moveUp($('#' + file.id))
                                break;

                        }

                    });

                    // $list为容器jQuery实例
                    $list.append($li);
                }

                // 负责view的销毁
                function removeFile(file) {
                    var $li = $('#' + file.id);
                    $li.off().find('.file-panel').off().end().remove();
                }


                function moveUp($item) {
                    $before = $item.prev();
                    $item.insertBefore($before);
                }

                function moveDown($item) {
                    $after = $item.next();
                    $item.insertAfter($after);
                }

            });

        })(jQuery);

        //debugger;
        //进行2级目录限制
        var lmcjNum=$("#lmcjNum").val();
        debugger;
        if(lmcjNum && parseInt(lmcjNum)>2)
        {
            $("#createNode").hide();
        }
        else{
            $("#createNode").show();
        }

    }

    function bindPicCreate() {
        /**
         * Created by saarixx on 12/11/14.
         */
        (function ($) {
            // 当domReady的时候开始初始化
            $(function () {
                // 初始化Web Uploader
                var uploader = WebUploader.create({

                    // 选完文件后，是否自动上传。
                    auto: true,

                    // swf文件路径
                    swf: "assets/ueditor-1.4.3/third-party/webuploader/Uploader.swf",

                    // 文件接收服务端。
                    server: '/itemPublish/handle?action=uploadImage',

                    // 选择文件的按钮。可选。
                    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                    pick: '#filePicker',

                    // 只允许选择图片文件。
                    accept: {
                        title: 'Images',
                        extensions: 'gif,jpg,jpeg,bmp,png',
                        mimeTypes: 'image/*'
                    }
                });

                var $ = jQuery,
                        $list = $('#fileList'),
                // 优化retina, 在retina下这个值是2
                        ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                        thumbnailWidth = 100 * ratio,
                        thumbnailHeight = 100 * ratio,

                // Web Uploader实例
                        uploader;

                // 当有文件添加进来的时候
                uploader.on('fileQueued', function (file) {
                    addFile(file)
                });


                // 文件上传成功，给item添加成功class, 用样式标记上传成功。
                uploader.on('uploadSuccess', function (file) {
                    $('#' + file.id).addClass('state-complete');
                    $('#' + file.id).append('<span class="success"></span>');
                });

                uploader.on('uploadAccept', function (file, response) {
                    $('#' + file.file.id).find('p.imgWrap').html('<img src="' + response.url + '"><input name="item-pic" value="' + response.url + '" style="display: none">');
                });

                // 文件上传失败，显示上传出错。
                uploader.on('uploadError', function (file) {
                    var $li = $('#' + file.id),
                            $error = $li.find('div.error');

                    // 避免重复创建
                    if (!$error.length) {
                        $error = $('<div class="error"></div>').appendTo($li);
                    }

                    $error.text('上传失败');
                });

                // 完成上传完了，成功或者失败，先删除进度条。
                uploader.on('uploadComplete', function (file) {
                    $('#' + file.id).find('.progress').remove();
                });

                // 当有文件添加进来时执行，负责view的创建
                function addFile(file) {
                    var $li = $('<li id="' + file.id + '">' +
                                    '<p class="title">' + file.name + '</p>' +
                                    '<p class="imgWrap"></p>' +
                                    '</li>'),

                            $btns = $('<div class="file-panel">' +
                                    '<span class="cancel">删除</span>' +
                                    '<span class="rotateLeft">向左移动</span>' +
                                    '<span class="rotateRight">向右移动</span>' +
                                    '</div>').appendTo($li),

                            $wrap = $li.find('p.imgWrap'),
                            $info = $('<p class="error"></p>')


                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        var img;
                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }
                        img = $('<img src="' + src + '">');
                        $wrap.empty().append(img);
                    }, thumbnailWidth, thumbnailHeight);

                    $li.on('mouseenter', function () {
                        $btns.stop().animate({height: 30});
                    });

                    $li.on('mouseleave', function () {
                        $btns.stop().animate({height: 0});
                    });

                    $btns.on('click', 'span', function () {

                        var index = $(this).index(),
                                deg;

                        switch (index) {
                            case 0:
                                removeFile(file);
                                return;
                            case 1:
                                moveDown($('#' + file.id))
                                break;
                            case 2:
                                moveUp($('#' + file.id))
                                break;

                        }

                    });

                    // $list为容器jQuery实例
                    $list.append($li);
                }

                // 负责view的销毁
                function removeFile(file) {
                    var $li = $('#' + file.id);
                    $li.off().find('.file-panel').off().end().remove();
                }


                function moveUp($item) {
                    $before = $item.prev();
                    $item.insertBefore($before);
                }

                function moveDown($item) {
                    $after = $item.next();
                    $item.insertAfter($after);
                }

            });

        })(jQuery);
    }

    function deleteCategory(id) {
        if (!confirm("您确定要删除这个类目么")) {
            return;
        }
        $.ajax({
            url: '/itemCategory/deleteCategory',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location.replace("/itemCategory/index")
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    $(function () {

        $('#jstree').jstree({
            'core': {
                'data': {
                    "url": "/itemCategory/tree/",
                    "dataType": "json" // needed only if you do not supply JSON headers
                }
            },
            'plugins': ["wholerow"]
        });

        $('#jstree').on("changed.jstree", function (e, data) {
            var features=data.node.original.features;
            $('#selectedId').val(data.selected)
            $('#selectedName').val(data.instance.get_selected(true)[0].text)
            $('#selectedFeatures').val(features?features:"")
            $('#createNode').text('新增子类目')
            var id = data.selected
            <g:remoteFunction action="selectedNodeDetail" params="'id='+id" asynchronous="true" update="nodeDetail" onSuccess="bindPicEdit()"/>
        });

        $(document).mouseup(function (e) {
            var container = $("#jstree");
            var operation = $("#operation");
            var modal = $("#myModal")


            if (!container.is(e.target) && container.has(e.target).length === 0 && !operation.is(e.target) && operation.has(e.target).length === 0
                    && !modal.is(e.target) && modal.has(e.target).length === 0) {
                //debugger; 离开树的点击的事件
                $("#createNode").show();

                $('#selectedId').val('')
                $('#selectedName').val('')
                $('#createNode').text('新增父类目')
                $('#nodeDetail').empty()
                $('#pName').val('')
                $('#pId').val('')
                $('#selectedFeatures').val('')
                var instance = $('#jstree').jstree(true);
                instance.deselect_all();


            }
        });
    });


    //进行对表单的提交
    $("#createBtn").click(function(){
        var nameFlag=$('#pName').val();
        var features=$('#pFeatures').val();
        //一级类目是没值，二级类目有值
        if(!nameFlag){
            if(features.length==0){
                alert("一级类目属性为必填项");
                return false;
            }
        }
    });


    //隐藏的操作
    function hideCategory(id){
        if (!confirm("您确定要隐藏这个类目么")) {
            return;
        }
        $.ajax({
            url: '/itemCategory/hideCategory',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location.replace("/itemCategory/index")
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    //隐藏的操作
    function showCategory(id){
        if (!confirm("您确定要显示这个类目么")) {
            return;
        }
        $.ajax({
            url: '/itemCategory/showCategory',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location.replace("/itemCategory/index")
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });

    }


</script>

</body>

</html>

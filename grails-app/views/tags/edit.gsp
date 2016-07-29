<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.apache.commons.lang3.StringUtils; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>




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
        编辑标签
        <small>标签管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>标签管理</a></li>
        <li class="active">新增标签</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">标签列表</g:link></li>
                    <li class="active">
                        <g:link action="addTagsHtml">新增标签</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="addTagForm" useToken="true" action="addTagAagin">
            <div class="box-header">
            </div>
            <input type="text" name="tid" value="${tags.id}" class=" hide"/>
            <div class="box-body no-padding form-horizontal list-group clearfix">
                <div class='col-xs-12'>
                    <div class="row">

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>标题</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="name" class="form-control" value="${tags.name}"
                                       placeholder="标题">
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-tag"></i>类型:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input name="bit" type="text" class="form-control" placeholder="类型值bit" value="${tags.bit}">
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>标签图:</label>

                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader" class="queueList">

                                    <!--用来存放item-->

                                    <ul id="fileList" class="filelist">
                                            <g:each status="i" in="${org.apache.commons.lang3.StringUtils.split(tags.pic, ';')}" var="picUrl">
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
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-laptop"></i>标签类别:</label>

                            <div class="col-xs-12 col-sm-8">
                                <div class="input-group">
                                    <g:if test="${typeMap != null}">
                                        <g:each in="${typeMap}" var="type" status="i">
                                            <g:if test="${type.key==tags.type}">
                                                <input type="radio" name="type" value="${type.key}" checked>${type.value}
                                            </g:if>
                                            <g:else>
                                                <input type="radio" name="type" value="${type.key}">${type.value}
                                            </g:else>
                                        </g:each>
                                    </g:if>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-sort-numeric-asc"></i>权重:</label>

                            <div class="col-xs-12 col-sm-8">
                                <div class="input-group">
                                    <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                                    <input type="text" placeholder="数量"  id="num" name="weight"
                                           readonly style="width: 30px;text-align: center;" value="${tags.weight}">
                                    <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div><!-- /.box-body -->
            <div class="box-footer clearfix">
                <div class="col-sm-offset-3">
                    <button type="submit" class="btn btn-primary" type="submit">发布</button>
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


</script>

</body>

</html>

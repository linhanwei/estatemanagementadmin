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
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        添加
        <small>添加软文</small>
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
                    <li >
                        <g:link action="list">软文列表</g:link></li>
                    <li class="active">
                        <g:link action="add">添加软文</g:link></li>

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

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>红色标题:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="mtitle" class="form-control"
                                       placeholder="红色标题">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-bookmark"></i>标题:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="ltitle" class="form-control"
                                       placeholder="标题">
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-mail-reply"></i>跳转类型:</label>

                            <div class="col-xs-12 col-sm-3">
                                <div class="input-group" id="switchtype">
                                    <g:if test="${redirectTypeMap != null}">
                                        <g:each in="${redirectTypeMap}" var="tag" status="i">
                                            <input type="radio" name="redirectType" value="${tag.key}">${tag.value}
                                        </g:each>
                                    </g:if>
                                </div>
                            </div>
                        </div>


                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-hand-o-right"></i>内容链接:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input id="con_url" name="contenturl" type="text" class="form-control" placeholder="内容链接">
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-tag"></i>类型:</label>

                            <div class="col-xs-12 col-sm-3">
                                <g:select optionKey="key" optionValue="value" name="type"
                                          class="form-control" from="${typeMap}"
                                          noSelection="['': '软文类型']"/>
                                %{--<select name="type" class="form-control" id="">--}%
                                    %{--<option value="软文类型">软文类型</option>--}%
                                    %{--<option value="单品">单品</option>--}%
                                    %{--<option value="拼团">拼团</option>--}%
                                    %{--<option value="满减">满减</option>--}%
                                %{--</select>--}%
                            </div>
                        </div>
                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-font"></i>文字内容:</label>
                            <div class="col-xs-12 col-sm-3">
                                <textarea name="content" class="form-control" rows="5" placeholder="文字内容"></textarea>
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>内容图片:</label>
                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader" class="queueList">

                                    <!--用来存放item-->

                                    <ul id="fileList" class="filelist">

                                    </ul>

                                    <div id="filePicker">选择内容图片</div>
                                </div>


                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-jpy"></i>推广费:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input name="fee" type="number" class="form-control" placeholder="推广费">
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-jpy"></i>是否有效:</label>

                            <div class="col-xs-12 col-sm-3">

                                <input type="radio" name="isstatus" value="1"/>
                                有效
                                <input type="radio" name="isstatus" value=""/>
                                无效
                            </div>
                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>海报图片:</label>
                            <div class="col-xs-12 col-sm-8">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader2" class="queueList">

                                    <!--用来存放item-->

                                    <ul id="fileList2" class="filelist">

                                    </ul>

                                    <div id="filePicker2">选择海报图片</div>

                                </div>
                                <span style="display:none;color:red" id="ComImgTip">至少上传一张海报图片</span>
                            </div>

                        </div>

                        <div class="list-group-item form-group">
                            <label class="col-sm-3 control-label"><i class="fa fa-picture-o"></i>海报中呈现的产品图片:</label>
                            <div class="col-xs-12 col-sm-8">
                                <!--dom结构部分-->
                                <div id="uploader3" class="queueList">

                                    <!--用来存放item-->

                                    <ul id="fileList3" class="filelist">

                                    </ul>

                                    <div id="filePicker3">海报中呈现的产品图片</div>
                                <span style="display:none;color:red" id="PosterImgTip">至少上传一张海报中呈现的产品图片</span>
                                </div>


                            </div>
                        </div>

                    </div>
                </div>
            </div><!-- /.box-body -->
            <div class="box-footer clearfix">
                <div class="col-sm-offset-3">
                    <button id="fbtn" type="submit" class="btn btn-primary" type="submit">确定</button>
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

    $(document).on('click','#fbtn',function(){
        //海报图片
        var deilPic=$("input[name=detail-pic]");
        if(deilPic.length==0)
        {
            alert("至少需要上传一张海报图.");
            $("#ComImgTip").css('display','block');
            $("#ComImgTip").css('margin-top','10px');
            return false;
        }else{
            $("#ComImgTip").css('display','none');
        }
        //详情图的限制
        var urlPic=$("input[name=url-pic]");
        if(urlPic.length==0)
        {
            alert("至少需要上传一张海报中呈现的产品图.");
            $("#PosterImgTip").css('display','block');
            $("#PosterImgTip").css('margin-top','10px');
            return false;
        }else{
            $("#PosterImgTip").css('display','none');
        }
    }).on('ifChecked','#switchtype input[value=1]',function(){
        $('#con_url').attr('type','url');
    })

</script>

</body>

</html>

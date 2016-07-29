<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime;org.apache.commons.lang3.StringUtils; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
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

    <style>
    .lineDiv
    {
        position: relative;
        border-bottom: 1px solid #eee;
        height: 10px;
        margin: 20px 0;
    }

    .title
    {
        position: absolute;
        width: 200px;
        height: 30px;
        text-align: center;
        left: 50%;
        top: -3px;
        background-color: #fff;
        margin-left: -100px;
        font-size: large;
        font-weight: 200;
    }

    </style>


    <style type="text/css" >
    .tipeHide{display: none;color: red}

    </style>

</head>

<body>

<section class="content-header">
    <h1>
        编辑众筹
        <small>众筹</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>众筹</a></li>
        <li class="active">编辑众筹</li>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="list">页面列表</g:link>
                    </li>
                    <li>
                        <g:link action="add">新增众筹</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="item_form" useToken="true" action="addOneData">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group">

                <div class="form-group" style="display: none">
                    <input name="id" value="${item.id}">
                </div>
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>众筹主图<span style="color: red">*</span>:</label>

                    <div class="col-sm-8">
                        %{--<!--dom结构部分-->--}%
                        <div id="uploader" class="queueList">
                            <!--用来存放item-->
                            <ul id="fileList" class="filelist">
                                <g:each status="i" in="${StringUtils.split(item.picUrls, ';')}" var="picUrl">
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
                        <span style="display:none;color:red" id="MainImgTip">至少上传一张选择众筹主图</span>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>众筹名称<span style="color: red">*</span></label>

                    <div class="col-xs-8">
                        <input type="text" name="title" class="form-control"
                               placeholder="众筹名称" value="${item.title}">
                        <span class="tipeHide" id="titleTip">请写入对应的众筹名称</span>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">众筹描述</label>

                    <div class="col-xs-8">
                        <textarea name="description" class="form-control" rows="5">${item?.description}</textarea>
                    </div>
                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">视频链接</label>

                    <div class="col-xs-8">
                        <input type="text" name="video" class="form-control"
                               placeholder="视频链接" value="${item?.video}">
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-sm-2 control-label">图文详情</label>

                    <div class="col-sm-8">
                        <div id="uploader2" class="queueList">
                            <!--用来存放item-->
                            <ul id="fileList2" class="filelist">
                                <g:each status="i" in="${StringUtils.split(item.detail, ';')}" var="picUrl">
                                    <li id="WU_FILE_99${i}" class="state-complete">
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

                            <div id="filePicker2">选择图片</div>
                        </div>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-money"></i>目标金额<span style="color: red">*</span>:</label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rmb"></i></span>
                            <input type="text" name="referencePrice" class="form-control" value="${item.targetAmount/100f}">
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="referencePriceTip">请写入对应目标金额</span>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">开始时间:</label>

                    <div class="col-xs-3">
                        <input name="start_time"
                               class="input-sm form_datetime  form-control" value="${item.startTime?new DateTime(item.startTime).toString("yyyy-MM-dd HH:mm"):""}"/>
                    </div>


                    <label class="col-sm-2 control-label">结束时间:</label>
                    <div class="col-xs-3">
                        <input name="end_time"
                               class="input-sm form_datetime  form-control" value="${item.endTime?new DateTime(item.endTime).toString("yyyy-MM-dd HH:mm"):""}"/>

                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>发货周期<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <input type="text" name="days" class="form-control" placeholder="发货周期" value="${item.plusDay}">
                        <span class="tipeHide" id="daysTip">请写入对应发货周期</span>
                    </div>


                    <label class="col-sm-2 control-label"><i class="fa fa-sort-numeric-asc">权重:</i></label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                            &nbsp;
                            <input type="text" placeholder="数量" value="9" id="num" name="weight" value="${item.weight}"
                                   readonly style="width: 30px">
                            <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit"  id="fbBtn">发布</button>
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
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>


<asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>

<script>
    var ids=[];
    //*************************************************
    $(function(){
        $(".form_datetime")
                .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
                .on('changeDate', function (ev) {
                    var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                    $('#acceptTime').val(value)
                });
    });


    //进行提交
    $("#fbBtn").on('click',function(){

        debugger;
        //主图的限制
        var itemmainpic=$("input[name=item-pic]");
        if(itemmainpic && itemmainpic.length>10)
        {
            alert("主图只能上传10张");
            return false;
        }
        if(itemmainpic.length==0)
        {
            alert("至少需要上传一张主图.");
            $("#MainImgTip").show();
            return false;
        }
        //详情图的限制
        var deilPic=$("input[name=detail-pic]");
        if(deilPic && deilPic.length>60)
        {
            alert("详情图只能上传60张");
            return false;
        }

        //进行对各项限制
        var tipflag=showAllTips();
        if(!tipflag){
            alert("请填入对应的必填字段...");
            return false;
        }
    });

    //*************************************************


    //进行对各项限制
    function showAllTips()
    {
        //全部都隐藏
        $(".tipeHide").hide();
        //主图的提示隐藏
        $("#MainImgTip").hide();
        var inputarr=["title","referencePrice","days"];
        var inputnumarr=[];
        //进行校验 input
        for(var i=0;i<inputarr.length;i++){
            var content=$("input[name="+inputarr[i]+"]").val();
            if(!content){
                inputnumarr.push(i);
            }
        }
        //遍历进行处理对应的dom[input]
        for(var j=0;j<inputnumarr.length;j++){
            $("#"+inputarr[inputnumarr[j]]+"Tip").show();
        }
        if(inputnumarr.length>0){
            return false;
        }else{
            return true;
        }
    }










    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
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

    var first = true

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




</script>

</body>

</html>

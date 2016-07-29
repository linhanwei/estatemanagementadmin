<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    %{--<asset:stylesheet src="bootstrap.min.css"/>--}%
    %{--<!-- font Awesome -->--}%
    %{--<asset:stylesheet src="font-awesome.min.css"/>--}%
    %{--<!-- Theme style -->--}%
    %{--<asset:stylesheet src="AdminLTE.css"/>--}%
    %{--<asset:stylesheet src="skins/skin-blue.css"/>--}%
    %{--<!-- pagination -->--}%
    %{--<asset:stylesheet src="jquery.pagination_2/pagination.css"/>--}%
    %{--<!-- sticky -->--}%
    %{--<asset:stylesheet src="sticky/sticky.css"/>--}%
    %{--<!-- iCheck -->--}%
    %{--<asset:stylesheet src="iCheck/square/blue.css"/>--}%
    %{--<!-- Bootstrap time Picker -->--}%
    %{--<asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>--}%

    %{--<asset:stylesheet src="third-party/webuploader/style2.css"/>--}%
    %{--<asset:stylesheet src="third-party/webuploader/webuploader.css"/>--}%
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
        新增优惠劵
        <small>运营工具</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>运营工具</a></li>
        <li class="active">新增优惠劵</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">优惠劵列表</g:link></li>
                    <li class="active">
                        <g:link action="addCouponHtml">新增优惠</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="coupon_add_form" useToken="true" action="addCoupons">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal">

                <div class='col-xs-12'>
                    <div class="row">
                        <div style="margin: 10px 0 20px;">

                        </div>

                        <div class="form-group" >
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-tasks"></i>优惠劵名称<span style="color: red">*</span>:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input name="name"
                                       class="input-sm form-control" placeholder="优惠劵名称"/>
                            </div>
                            <span style="color: red;line-height: 30px;display:none" id="nameTip">优惠劵名称不能为空.</span>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-gavel"></i>类型<span style="color: red">*</span>:</label>

                            <div class="col-xs-12 col-sm-5">
                                <div class="input-group">
                                %{--<input type="radio" name="type" value="2001">满减--}%
                                %{--<input type="radio" name="type" value="2002">新人--}%
                                %{--<input type="radio" name="type" value="2003">邀请--}%
                                %{--<input type="radio" name="type" value="2004">注册--}%
                                    <g:if test="${typeMap != null}">
                                        <g:each in="${typeMap}" var="tag" status="i">
                                            <span class="onecontentdiv s${tag.key}">
                                                <g:if test="${i==0}">
                                                    <input type="radio" name="type" value="${tag.key}" checked>${tag.value}
                                                </g:if>
                                                <g:else>
                                                    <input type="radio" name="type" value="${tag.key}">${tag.value}
                                                </g:else>
                                            </span>
                                        </g:each>
                                    </g:if>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3  control-label"><i class="fa fa-dollar"></i>面值<span style="color: red">*</span>:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input name="value"
                                       class="input-sm form-control" placeholder="面值"/>
                            </div>
                            <span style="color: red;line-height: 30px;display:none" id="valueTip">面值不能为空.</span>
                        </div>

                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label"><i class="fa fa-calculator"></i>获得概率<span style="color: red">*</span>:</label>--}%

                            %{--<div class="col-xs-3">--}%
                                %{--<input name="probability"--}%
                                       %{--class="input-sm form-control" placeholder="%"/>--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-dollar"></i>最低使用门槛<span style="color: red">*</span>:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input name="minValue"
                                       class="input-sm form-control" placeholder="最低使用门槛(单位:元)"/>
                            </div>
                            <span style="color: red;line-height: 30px;display:none" id="minValueTip">最低使用门槛不能为空.</span>
                        </div>

                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label"><i class="fa fa-bookmark">属性:</i></label>--}%

                            %{--<div class="col-xs-3">--}%
                                %{--<input type="text" name="attributes" class="input-sm  form-control"--}%
                                       %{--placeholder="属性">--}%
                            %{--</div>--}%
                        %{--</div>--}%


                        <div class="form-group">
                        <label class="col-xs-4 col-sm-3 control-label">有效天数<span style="color: red">*</span>:</label>

                        <div class="col-xs-12 col-sm-3">
                        <input name="validity"
                        class="input-sm form-control" placeholder="单位:天"/>
                        </div>
                        <span style="color: red;line-height: 30px;display:none" id="validityTip">有效天数不能为空.</span>
                        </div>



                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label"><i class="fa fa-home">专属店铺</i></label>--}%

                            %{--<div class="col-xs-3">--}%
                                %{--<g:select optionKey="id" optionValue="title" name="shopId"--}%
                                          %{--class="form-control" from="${shops}" noSelection="['': '通用']"/>--}%
                            %{--</div>--}%
                        %{--</div>--}%


                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>起始时间</label>--}%

                            %{--<div class="col-xs-3">--}%
                                %{--<input name="startTime"--}%
                                       %{--class="input-sm form_datetime  form-control" />--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        %{--<div class="form-group">--}%
                            %{--<label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>结束时间</label>--}%

                            %{--<div class="col-xs-3">--}%
                                %{--<input name="endTime"--}%
                                       %{--class="input-sm form_datetime  form-control"/>--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-tag"></i>发放数量<span style="color: red">*</span>:</label>

                            <div class="col-xs-12 col-sm-3">
                                <input type="text" name="giveNum" class="input-sm  form-control"
                                       placeholder="限制数量，默认无限制">
                            </div>
                            <span style="color: red;line-height: 30px;display:none" id="giveNumTip">发放数量不能为空.</span>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-picture-o"></i>优惠券图片:</label>

                            <div class="col-xs-12 col-sm-3" style="  padding-right: 5px;">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader" class="queueList">
                                    <ul id="fileList" class="filelist">

                                    </ul>

                                    <div id="filePicker">选择图片</div>
                                </div>

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-picture-o"></i>过期优惠券图片:</label>

                            <div class="col-xs-12 col-sm-3" style="  padding-right: 5px;">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader2" class="queueList">
                                    <ul id="fileList2" class="filelist">

                                    </ul>

                                    <div id="filePicker2">选择图片</div>
                                </div>

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-4 col-sm-3 control-label"><i class="fa fa-tag"></i>相关描述</label>

                            <div class="col-xs-12 col-sm-6">
                                <textarea name="description" class="form-control" rows="5"></textarea>
                            </div>
                        </div>


                    </div>
                </div>
            </div>

            <div class="box-footer clearfix">
                <div class="col-sm-offset-3">
                    <button type="submit" class="btn btn-primary" type="submit" id="subMitCoupon">发放</button>
                    <button class="btn btn-default" type="reset">取消</button>
                </div>
            </div><!-- /.box-footer-->
        </g:form>

    </div><!-- /.box -->

</section><!-- /.content -->




%{--<!-- Jquery -->--}%
%{--<asset:javascript src="jquery-2.1.3.js"/>--}%
%{--<!-- jQuery UI 1.10.3 -->--}%
%{--<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>--}%
%{--<!-- Bootstrap -->--}%
%{--<asset:javascript src="bootstrap.js"/>--}%
%{--<!-- AdminLTE App -->--}%
%{--<asset:javascript src="app.js"/>--}%
%{--<!-- sticky -->--}%
%{--<asset:javascript src="sticky/sticky.js"/>--}%
%{--<!-- iCheck -->--}%
%{--<asset:javascript src="iCheck/icheck.min.js"/>--}%
%{--<!-- bootstrap time picker -->--}%
%{--<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>--}%
%{--<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>--}%
%{--<asset:javascript src="pages/item/publish-item-pic.js"/>--}%
%{--<asset:javascript src="pages/item/publish-detail-pic.js"/>--}%

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


    $('#subMitCoupon').click(function(){
        debugger;
        var size=$("input[name=item-pic]").length;
        if(!size){
            alert("请上传一张优惠劵的图片");
            return false;
        }

        //进行必填字段的校验
        var flag= 0,
            textObj=$(":text");
        $.each(textObj,function(index,content){
            var tcontent=$(content);
            var name=tcontent.attr('name');
            if(name!="item-pic" && name!="detail-pic"){
                if(!tcontent.val()){
                    flag++;
                    $("#"+name+"Tip").show();
                }else{
                    $("#"+name+"Tip").hide();
                }
                //数字的校验
                if(name!="name" && tcontent.val() && isNaN(tcontent.val())){
                    flag++;
                    $("#"+name+"Tip").html("填入对应数字类型.")
                            .show();
                }
            }
        });
        if(flag){
            return false;
        }
    });


</script>

</body>

</html>

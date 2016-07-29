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
        新增站点
        <small>站点管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>站点管理</a></li>
        <li class="active">新增站点</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">站点列表</g:link></li>
                    <li class="active"><g:link action="newCommunity">新增站点</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body no-padding form-horizontal clearfix">
            <div class="container">
                <g:form class="form-horizontal" useToken="true" action="createCommunity">
                    <div class="form-group">
                        <div class="col-xs-12">
                            <input type="text" name="communityId" class="form-control" value="${community?.id}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">名字<span class="f_req">*</span></label>

                        <div class="col-sm-5">
                            <input type="text" name="name" class="form-control" value="${community?.name}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">地区<span class="f_req">*</span></label>

                        <input id="provinceName" name="provinceName" style="display: none" value="${community?.province}">
                        <input id="cityName" name="cityName" style="display: none" value="${community?.city}">
                        <input id="areaName" name="areaName" style="display: none" value="${community?.district}">

                        <div class="col-sm-5">
                            <select id="province" name="province" class="col-sm-4">
                                <option value="${community?.provinceId?:-1}">${community?.province}</option>
                            </select>
                            <select id="city" name="city" class="col-sm-4">
                                <option value="${community?.cityId?:-1}">${community?.city}</option>
                            </select>
                            <select id="area" name="area" class="col-sm-4">
                                <option value="${community?.districtId?:-1}">${community?.district}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">联系电话</label>

                        <div class="col-sm-5">
                            <input type="text" name="phone" class="form-control" value="${community?.phone}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">自提地址<span class="f_req">*</span></label>

                        <div class="col-sm-5">
                            <input type="text" name="location" class="form-control" value="${community?.location}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label"><a
                                href="http://lbs.amap.com/console/show/picker" target="_blank">自提坐标</a><span
                                class="f_req">*</span></label>

                        <div class="col-sm-5">
                            <input type="text" name="lbs" class="form-control" value="${community?.lbs}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">营业时间<span class="f_req">*</span></label>

                        <div class="col-sm-5">
                            <input type="text" name="openingHours" class="form-control" value="${community?.openingHours}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">描述信息</label>

                        <div class="col-sm-5">
                            <textarea rows="10" name="description" class="form-control">${community?.description}</textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label"><a href="${createLink(controller: 'amap')}"
                                                                 target="_blank">配送范围</a><span
                                class="f_req">*</span></label>

                        <div class="col-sm-8">

                            <textarea rows="10" name="deliveryArea" class="form-control">${community?.deliveryArea}</textarea>
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-sm-offset-1">
                            <button class="btn btn-primary" type="submit">提交</button>
                        </div>
                    </div>

                </g:form>
            </div>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

        </div><!-- /.box-footer-->
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
<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script language="javascript"
        src="http://webapi.amap.com/maps?v=1.3&key=${grailsApplication.config.amap.js_key}"></script>



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
    $(function () {

        for (var name in tdist) {
            var tvalue = tdist[name];

            if (tvalue[1] == "1") {
                $('#province').append('<option value="' + name + '">' + tvalue[0] + '</option>');
            }
        }
    })

    $('#province').change(function () {
        var str = "";
        $("#province option:selected").each(function () {
            $('#city').find('option').remove();
            $('#city').append('<option value="-1">请选择市...</option>');
            $('#area').find('option').remove();
            $('#area').append('<option value="-1">请选择区/县...</option>');

            if ($(this).val() != "-1") {
                for (var name in tdist) {
                    var tvalue = tdist[name];
                    if (tvalue[1] == $(this).val()) {
                        $('#city').append('<option value="' + name + '">' + tvalue[0] + '</option>');
                    }
                }
            }
            $('#provinceName').val(($("#province option:selected").text()))
        });
    }).trigger('change');

    $('#city').change(function () {
        var str = "";
        $("#city option:selected").each(function () {
            $('#area').find('option').remove();
            $('#area').append('<option value="-1">请选择区/县...</option>');
            if ($(this).val() != "-1") {
                for (var name in tdist) {
                    var tvalue = tdist[name];
                    if (tvalue[1] == $(this).val()) {
                        $('#area').append('<option value="' + name + '">' + tvalue[0] + '</option>');
                    }
                }
            }
        });

        $('#cityName').val(($("#city option:selected").text()))

    }).trigger('change');

    $('#area').click(function () {
        $('#area').change(function () {
            $('#areaName').val(($("#area option:selected").text()))
        });
    });
</script>


</body>

</html>

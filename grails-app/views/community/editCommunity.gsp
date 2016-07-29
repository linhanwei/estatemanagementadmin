<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 26/9/14
  Time: 15:16
--%>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <title>配送点管理</title>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- Ionicons -->
    <asset:stylesheet src="ionicons.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- validation -->
    <asset:stylesheet src="bootstrapValidator/bootstrapValidator.css"/>

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
    <h1>配送点<small>管理</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">配送点列表</g:link></li>
                    <li><g:link action="newCommunity">新增配送点</g:link></li>
                    <li class="active"><g:link action="editCommunity">编辑配送点</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="container">
                            <g:form class="form-horizontal" useToken="true" action="createCommunity">
                                <div class="form-group">
                                    <label class="col-sm-1 control-label">名字<span class="f_req">*</span></label>

                                    <div class="col-sm-5">
                                        <input name="communityId" style="display: none" value="${community?.id}">

                                        <input type="text" name="name" class="form-control" value="${community.name}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label">地区<span class="f_req">*</span></label>

                                    <input id="provinceName" name="provinceName" style="display: none"
                                           value="${community?.province}">
                                    <input id="cityName" name="cityName" style="display: none"
                                           value="${community?.city}">
                                    <input id="areaName" name="areaName" style="display: none"
                                           value="${community?.district}">

                                    <div class="col-sm-5">
                                        <select id="province" name="province" class="col-sm-4">
                                            <option value="${community?.provinceId}">${community?.province}</option>
                                        </select>
                                        <select id="city" name="city" class="col-sm-4">
                                            <option value="${community?.cityId}">${community?.city}</option>
                                        </select>
                                        <select id="area" name="area" class="col-sm-4">
                                            <option value="${community?.districtId}">${community?.district}</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label">联系电话<span class="f_req">*</span></label>

                                    <div class="col-sm-5">
                                        <input type="text" name="phone" class="form-control"
                                               value="${community.phone}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label">自提地址<span class="f_req">*</span></label>

                                    <div class="col-sm-5">
                                        <input type="text" name="location" class="form-control"
                                               value="${community.location}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label"><a
                                            href="http://lbs.amap.com/console/show/picker" target="_blank">自提坐标</a><span
                                            class="f_req">*</span></label>

                                    <div class="col-sm-5">
                                        <input type="text" name="lbs" class="form-control"
                                               value="${community.lbs}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label">营业时间<span class="f_req">*</span></label>

                                    <div class="col-sm-5">
                                        <input type="text" name="openingHours" class="form-control"
                                               value="${community.openingHours}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label">描述信息</label>

                                    <div class="col-sm-5">
                                        <textarea rows="10" name="description"
                                                  class="form-control">${community.description}</textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label"><a href="${createLink(controller: 'amap')}"
                                                                             target="_blank">配送范围</a><span
                                            class="f_req">*</span></label>

                                    <div class="col-sm-5">
                                        <textarea rows="10" name="deliveryArea"
                                                  class="form-control">${community.deliveryArea}</textarea>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <div class="col-sm-offset-1">
                                        <button class="btn btn-lg btn-primary" type="submit">提交</button>
                                    </div>
                                </div>

                            </g:form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section><!-- /.content -->

<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jquery-ui-1.10.3.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="AdminLTE/app.js"/>

<!-- bootstrap time picker -->
<asset:javascript src="plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="plugins/bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<asset:javascript src="plugins/bootstrapValidator/bootstrapValidator.min.js"/>
<asset:javascript src="plugins/bootstrapValidator/language/zh_CN.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<!-- notify -->
<asset:javascript src="bootstrap-growl.min.js"/>

<script type="text/javascript">
    $(function () {
        for (var name in tdist) {
            var tvalue = tdist[name];
            if (tvalue[1] == "1") {
                $('#province').append('<option value="' + name + '">' + tvalue[0] + '</option>');
            }
        }
    })


    $('#province').click(function () {
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
        })
    });

    $('#city').click(function () {
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
        });
    });


    $('#area').click(function () {
        $('#area').change(function () {
            $('#areaName').val(($("#area option:selected").text()))
        });
    });

</script>
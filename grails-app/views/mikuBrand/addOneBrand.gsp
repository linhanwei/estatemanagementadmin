<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2015/11/11
  Time: 15:57
--%>


<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
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
    <asset:stylesheet src="skins/skin-blue.css"/>


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
        新增品牌
        <small>品牌管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>品牌管理</a></li>
        <li class="active">新增品牌</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">品牌列表</g:link></li>
                    <li class="active">
                        <g:link action="addOneBrand">新增品牌</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="addTagForm" useToken="true" action="doAddBrand">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal">
                <div class='col-xs-12'>
                    <div class="row">
                        <div style="margin: 10px 0 20px;">

                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>品牌名称</label>

                            <div class="col-xs-2" style="  padding-right: 5px;">
                                <input type="text" name="name" class="form-control" value=""
                                       placeholder="品牌名称" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>品牌全称</label>

                            <div class="col-xs-2" style="  padding-right: 5px;">
                                <input type="text" name="fullname" class="form-control" value=""
                                       placeholder="品牌全称" >
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>所属公司</label>

                            <div class="col-xs-4" style="  padding-right: 5px;">
                                <input type="text" name="company" class="form-control" value=""
                                       placeholder="所属公司" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>品牌描述</label>

                            <div class="col-xs-4" style="  padding-right: 5px;">
                                %{--<input type="text" name="memo" class="form-control" value=""--}%
                                       %{--placeholder="品牌描述" >--}%
                                <textarea name="memo" class="form-control" rows="5" placeholder="品牌描述"></textarea>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>品牌图片</label>

                            <div class="col-xs-2" style="  padding-right: 5px;">
                                %{--<!--dom结构部分-->--}%
                                <div id="uploader" class="queueList">
                                    <ul id="fileList" class="filelist">

                                    </ul>

                                    <div id="filePicker">选择图片</div>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div><!-- /.box-body -->
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit" id="okbtn">添加</button>
                    <button class="btn btn-default" id="resetBtn">取消</button>
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

    $("#okbtn").click(function(){
        //主图的限制
        var itemmainpic=$("input[name=item-pic]");
        if(itemmainpic && itemmainpic.length>1)
        {
            alert("只能上传1张图片.");
            return false;
        }

    });

    //取消全部内容
    $("#resetBtn").click(function(){
        var iputObj=$("input[type=text]");
        $.each(iputObj,function(index,content){
            $(content).val("");
        });
        $("textarea").val("")
        return false;
    });

    //进行约束百分比例
    $("#profitpercentflg").on('change',function(){
        var newnumStr=$("#profitpercentflg").val().trim();
        if(!newnumStr)
        {
            $("#mytipflg").html("0");
            $("#mytipcontent").html("不能为空.").css("color","red");
            return;
        }

        if(parseFloat(newnumStr)<=0)
        {
            $("#mytipflg").html("0");
            $("#mytipcontent").html("请填合理的数字").css("color","red");
            return;
        }

        $.ajax({
            url:'<g:createLink controller="profitManager" action="getAllPercent" />',
            data:{'profitpercent':$(this).val().trim()},
            type: "POST",
            dataType: "json",
            success: function (data) {
                var mycout=parseFloat( $("#profitpercentflg").val().trim());
                var sumcout=parseFloat(data);
                var allcout=mycout+sumcout;
                if(allcout>100)
                {
                    var remian=100-sumcout;
                    $("#mytipflg").html("0");
                    $("#mytipcontent").html("总比例已超过100，剩下"+remian+"%可选").css("color","red");
                }
                else
                {
                    $("#mytipflg").html("1");
                    $("#mytipcontent").html("&nbsp;&nbsp;&nbsp;&nbsp;ok").css("color","green");
                }

            }, error: function (data) { // handle server errors
            }
        });

    });

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

</script>

</body>

</html>
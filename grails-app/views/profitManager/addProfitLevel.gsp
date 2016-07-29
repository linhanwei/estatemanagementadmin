<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2015/11/3
  Time: 21:30
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
        新增分润等级
        <small>分润管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>分润等级列表</a></li>
        <li class="active">新增分润等级</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">分润等级列表</g:link></li>
                    <li class="active">
                        <g:link action="addProfitLevel">新增分润等级</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="addTagForm" useToken="true" action="addProfitLevel">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal">
                <div class='col-xs-12'>
                    <div class="row">
                        <div style="margin: 10px 0 20px;">

                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>等级id</label>

                            <div class="col-xs-2" style="  padding-right: 5px;">
                                <input type="text" name="profitid" class="form-control" value=""
                                       placeholder="等级id" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>等级名称</label>

                            <div class="col-xs-2" style="  padding-right: 5px;">
                                <input type="text" name="profitname" class="form-control" value=""
                                       placeholder="等级名称" id="profitname">
                            </div>
                        </div>

                        <div class="form-group" style="line-height: 34px; ">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>分润比例</label>
                            <div class="col-xs-2" style="  padding-right: 5px;">
                                <input type="text" name="profitpercent" class="form-control" value="" id="profitpercentflg"
                                       placeholder="分润比例" style="display: inline-block">
                            </div>
                            <p >%</p>
                            <p id="mytipcontent"></p>
                            <p id="mytipflg" class="hide"></p>
                        </div>


                        <div class="form-grou hide">
                            <label class="col-sm-2 control-label"><i class="fa fa-sort-numeric-asc">权重:</i></label>

                            <div class="col-sm-8">
                                <div class="input-group">
                                    <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>&nbsp;&nbsp;
                                    <input type="text" placeholder="数量" value="1" id="num" name="weight"
                                           readonly style="width: 30px">
                                    <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>等级说明</label>

                            <div class="col-xs-2" style="  padding-right: 5px;">
                                <input type="text" name="profitInfo" class="form-control" value=""
                                       placeholder="分润等级说明" id="profitInfo">
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /.box-body -->
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit" id="okbtn">发布</button>
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
        var flag=$("#mytipflg").html().trim();
        if(!flag)
        {
            alert("请填入对应等级的数据");
            return false;
        }

    });

    //取消全部内容
   $("#resetBtn").click(function(){
       $("#profitname").val("");
       $("#profitInfo").val("");
       $("#profitpercentflg").val("");
       $("#num").val("1");
       $("#mytipcontent").html("");
       $("#mytipflg").html("");
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

    %{--$.ajax({--}%
        %{--url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" />', // remote datasource--}%
        %{--data: {'id': id},--}%
        %{--type: "POST",--}%
        %{--dataType: "json",--}%
        %{--success: function (data) {--}%
            %{--$.each(data, function (index, m) {--}%
                %{--$('#category').append('<option value="' + m.id + '">' + m.name + '</option>');--}%
            %{--})--}%

        %{--}, error: function (data) { // handle server errors--}%
        %{--}--}%
    %{--});--}%


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
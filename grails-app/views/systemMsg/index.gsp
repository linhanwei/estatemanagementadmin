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
        商品同步
        <small>控制开关</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>控制开关</a></li>
        <li class="active">商品同步</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="row">
                <button class="btn btn-primary" onclick="itemSync()">商品搜索同步</button>
            </div>

            <hr/>

            <div class="row">
                <button class="btn btn-primary" onclick="window.location.replace('/systemMsg/insertAllDataTologics');">物流地址信息更新</button>
            </div>

            <hr/>

            <div class="row">
                <button class="btn btn-primary" onclick="window.location.replace('/shopItemManager/downloadExcel?type=1');">导出所有商品</button>
                <button type="button" class="btn btn-info" id="inputPortExcelByModifycory">批量修改</button>
            </div>

            <div class="row">
                <button class="btn btn-primary" onclick="window.location.replace('/systemMsg/inseronedata?name=赖豪达&pId=1');">编码的测试</button>
            </div>


            <div class="row"  style="display: none">
                <button class="btn btn-primary" onclick="itemChange()">商品列表字段features的修改</button>
            </div>

            <div class="row" style="display: none">
                <button class="btn btn-primary" onclick="MoneyChange()">分润金额修改为整型</button>
            </div>
        </div>
    </div>
</section><!-- /.content -->


%{--导入功能--}%
<g:uploadForm action="midifyCategroy" enctype="multipart/form-data" style="display:none" controller="trade">
    <input type="file" name="myFile" id="myFile" accept=".xls"/>
    <input type="submit" style="display: none;" id="inputPortExcelByModify">
</g:uploadForm>

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
<script>



    //点击批量导入的按钮
    $('#inputPortExcelByModifycory').on("click",function(){
        $('#myFile').click();
    });
    $('#myFile').on('change',function(){
        //获取其文件类型
        var fileName=$("#myFile").val();
        if(fileName.length>1 && fileName)
        {
            var  index=fileName.lastIndexOf(".");
            var type=fileName.substring(index+1);
            if(type!="xls")
            {
                alert("请上传对应Excel类型的文件");
                return;
            }
            else{
                $('#inputPortExcelByModify').click();
            }
        }
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
    function itemSync() {
        $.ajax({
            url: "${createLink(action: 'syncSearchItem')}",
            type: "POST",
            dataType: "json",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    function itemChange()
    {
        $.ajax({
            url: "/itemPublish/changeEveryItemFeatures",
            type: "POST",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    function MoneyChange()
    {
        $.ajax({
            url: "/mikuSalesRecord/moneyChange",
            type: "POST",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

</script>


</body>

</html>

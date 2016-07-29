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
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
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

    <style>
    .lineDiv
    {
        position: relative;
        border-bottom: 1px solid #eee;
        height: 30px;
        margin: 10px 0;
    }

    .title
    {
        position: absolute;
        width: 200px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        left: 50%;
        top: -3px;
        /*background-color: #fff;*/
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

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        新增众筹
        <small>众筹</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>众筹</a></li>
        <li class="active">新增众筹</li>
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
                    <li  class="active">
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

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>众筹主图</label>

                    <div class="col-sm-8">
                        %{--<!--dom结构部分-->--}%
                        <div id="uploader" class="queueList">

                            <!--用来存放item-->

                            <ul id="fileList" class="filelist">

                            </ul>

                            <div id="filePicker">选择图片</div>
                        </div>
                        <span style="display:none;color:red" id="MainImgTip">至少上传一张选择众筹主图</span>
                    </div>

                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>众筹商品名称<span style="color: red">*</span></label>

                    <div class="col-xs-8">
                        <input type="text" name="title" class="form-control"
                               placeholder="众筹商品名称" >
                        <span class="tipeHide" id="titleTip">请写入对应的众筹商品名称</span>
                    </div>
                </div>


                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">众筹描述</label>

                    <div class="col-xs-8">
                        <textarea name="description" class="form-control" rows="5"></textarea>
                    </div>
                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">视频链接</label>

                    <div class="col-xs-8">
                        <input type="text" name="video" class="form-control"
                               placeholder="视频链接" value="http://baidu.com">
                        %{--placeholder="视频链接">--}%
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-sm-2 control-label">图文详情</label>

                    <div class="col-sm-8">
                        <div id="uploader2" class="queueList">
                            <!--用来存放item-->
                            <ul id="fileList2" class="filelist">
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
                            <input type="text" name="referencePrice" class="form-control" >
                            <span class="input-group-addon">元</span>
                        </div>
                        <span class="tipeHide" id="referencePriceTip">请写入对应目标金额</span>
                    </div>
                </div>



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">开始时间:</label>

                    <div class="col-xs-3">
                        <input name="start_time"
                               class="input-sm form_datetime  form-control" />
                    </div>


                    <label class="col-sm-2 control-label">结束时间:</label>
                    <div class="col-xs-3">
                        <input name="end_time"
                               class="input-sm form_datetime  form-control" />

                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>发货周期<span style="color: red">*</span>:</label>

                    <div class="col-xs-3">
                        <input type="text" name="days" class="form-control" placeholder="发货周期">
                        <span class="tipeHide" id="daysTip">请写入对应发货周期</span>
                    </div>


                    <label class="col-sm-2 control-label"><i class="fa fa-sort-numeric-asc">权重:</i></label>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                            &nbsp;
                            <input type="text" placeholder="数量" value="9" id="num" name="weight"
                                   readonly style="width: 30px">
                            <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                        </div>
                    </div>
                </div>


            </div>

            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit" id="fbBtn">发布</button>
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

<asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>

    $(function(){
        $(".form_datetime")
                .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
                .on('changeDate', function (ev) {
                    var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                    $('#acceptTime').val(value)
                });
        $("input[name=start_time]").val(CurentTime(0));
        $("input[name=end_time]").val(getNextDayByMethod(CurentTime(0))+" "+CurentTime(0).split(" ")[1]);
    });

    //*************************************************
    var ids=[];

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

    //进行对各项限制
    function showAllTips()
    {
        //全部都隐藏
        $(".tipeHide").hide();
        //主图的提示隐藏
        $("#MainImgTip").hide();
        //var arr=["title","code","purchasingPrice","referencePrice","price","itemProfitFee","num"];
        var inputarr=["title","referencePrice","days"];
        //[select]
//        var selectarr=["level1Category","category","brandId"];
        var inputnumarr=[];
//        var selectnumarr=[];
        //进行校验 input
        for(var i=0;i<inputarr.length;i++){
            var content=$("input[name="+inputarr[i]+"]").val();
            if(!content){
                inputnumarr.push(i);
            }
        }
        //进行校验 select
//        for(var i=0;i<selectarr.length;i++){
//            var content=$("select[name="+selectarr[i]+"]").val();
//            if(content=="-1" || !content){
//                selectnumarr.push(i);
//            }
//        }
        //遍历进行处理对应的dom[input]
        for(var j=0;j<inputnumarr.length;j++){
            $("#"+inputarr[inputnumarr[j]]+"Tip").show();
        }

        //遍历进行处理对应的dom[select]
//        for(var j=0;j<selectnumarr.length;j++){
//            $("#"+selectarr[selectnumarr[j]]+"Tip").show();
//        }
        if(inputnumarr.length>0){
            return false;
        }else{
            return true;
        }
    }




    //*************************************************

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
    });

    $("#purchaseTitle").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: '<g:createLink controller="purchasesManger" action="searchByTitle"/>', // remote datasource
                data: request,
                type: 'POST',
                success: function (data) {
                    response(data); // set the response
                }, error: function (data) { // handle server errors
                    console.log(data)
                }
            });
        },
        messages: {
            noResults: '',
            results: function () {
            }
        },
        minLength: 1, // triggered only after minimum 2 characters have been entered.
        select: function (event, ui) { // event handler when user selects a company from the list.
            console.log($('#purchaseId').val())
            console.log(ui.item.id)
            $('#purchaseId').val(ui.item.id); // update the hidden field.
            getprice(ui.item.id)
            console.log($('#purchaseId').val())
        }
    }).addClass("form-control").removeClass("ui-autocomplete-input");

    function getprice(id) {

        $.ajax({
            url: '<g:createLink controller="purchasesManger" action="getTitleById"/>', // remote datasource
            data: {'id': id},
            type: 'POST',
            success: function (data) {
                $('#purchasingPrice').val(data);
            }, error: function (data) { // handle server errors
                $('#purchasingPrice').val(data);
            }
        });
    }

    $('.dropdown-toggle').dropdown()

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


    //对类目属性进行json处理
    function dobeJson(){
       var descriptionName = $("input[name=descriptionName]");
       var descriptionValue = $("input[name=descriptionValue]");
       var obj={};
       for(var i=0;i<descriptionName.length;i++){
           var name=$(descriptionName[i]).val();
           var value=$(descriptionValue[i]).val();
           obj[name]=value;
       }
        var aToStr = JSON.stringify(obj);
       return aToStr;
    }



    function CurentTime(many)
    {
        var now = new Date();

        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate()+many;            //日

        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分

        var clock = year + "-";

        if(month < 10)
            clock += "0";

        clock += month + "-";

        if(day < 10)
            clock += "0";

        clock += day + " ";

        if(hh < 10)
            clock += "0";

        clock += hh + ":";
        if (mm < 10) clock += '0';
        clock += mm;
        return(clock);
    }


    //获取一天的方法
    function getNextDayByMethod(mdate){
        //获取当前值的下一天
        //获取当前的数组
        var marray = [];
        //把日期进行切割  格式为：yyyy-mm-dd
        //新的日期
        var nyear=0,nmonth=0,nday=0;
        marray = mdate.split("-");
        var year=parseInt(marray[0]);
        var month=parseInt(marray[1]);
        var day=parseInt(marray[2]);
        //判断是否月尾   ==月的尾部  年的尾部
        if(month==12 && day==31){
            nyear=year+1;
            nmonth=1;
            nday=1;
        }
        //看一下是否是月尾
        else if(day==getMonthDaysbyMoth(year,month) && month!=12){
            nyear=year;;
            nmonth=month+1;
            nday=1;
        }else{
            nyear=year;
            nmonth=month;
            nday=day+1;
        }
        nmonth=(nmonth<10?"0"+nmonth:nmonth);
        nday=(nday<10?"0"+nday:nday);
        return nyear+"-"+nmonth+"-"+nday;
    }


    function getMonthDaysbyMoth(year,month){
        //2月的判断的天数
        if (month == 2) {
            if (year % 4 == 0) {
                if (year % 100 != 0) {
                    return 29;
                }
                else {
                    if (year % 400 == 0) {
                        return 29;
                    }
                    else {
                        return 28;
                    }
                }
            }
            else {
                return 28;
            }
        }
        //如果是其他月份的判断
        if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12){
            return 31;
        }else{
            return 30;
        }
    }



</script>

</body>

</html>

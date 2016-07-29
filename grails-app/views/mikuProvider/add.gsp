<%--
Created by IntelliJ IDEA.
User: spider
Date: 26/9/14
Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
    .tipeHide{display: none;color: red}

    </style>

</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        添加供应商
        <small>供应商管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>供应商管理</a></li>
        <li class="active">添加供应商</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">

                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="item_form" useToken="true" action="publish">
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group">



                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>供应商编号<span style="color: red">*</span></label>

                    <div class="col-xs-8">
                        <input type="text" name="code" class="form-control"
        placeholder="供应商编号" value="">
            placeholder="标题" >
            <span class="tipeHide" id="codeTip">请写入对应的供应商编号</span>
            </div>
        </div>

            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label">供应商名称</label>

                <div class="col-xs-8">
                    <input type="text" name="name" class="form-control"
                           placeholder="供应商名称" >
                </div>
            </div>


            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>供应商简称<span style="color: red">*</span>:</label>

                <div class="col-xs-3">
                    <input type="text" name="sname" class="form-control" placeholder="供应商简称">
                    <span class="tipeHide" id="snameTip">请写入对应供应商简称</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>联系人<span style="color: red">*</span>:</label>

                <div class="col-xs-3">
                    <input type="text" name="cperson" class="form-control" placeholder="联系人">
                    <span class="tipeHide" id="cpersonTip">请写入对应联系人</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>职务<span style="color: red">*</span>:</label>

                <div class="col-xs-3">
                    <input type="text" name="job" class="form-control" placeholder="职务">
                    <span class="tipeHide" id="jobTip">请写入对应职务</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>地址<span style="color: red">*</span>:</label>

                <div class="col-xs-3">
                    <input type="text" name="address" class="form-control" placeholder="地址">
                    <span class="tipeHide" id="addressTip">请写入对应地址</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>电话<span style="color: red">*</span>:</label>

                <div class="col-xs-3">
                    <input type="tel" name="mobile" class="form-control" placeholder="电话">
                    <span class="tipeHide" id="mobileTip">请写入对应电话</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>邮政编码
                    <span style="color: red">*</span>:</label>
                <div class="col-xs-3">
                    <input type="text" name="zipcode" class="form-control" placeholder="邮政编码">
                    <span class="tipeHide" id="zipcodeTip">请写入对应邮政编码</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i>电子邮箱
                    <span style="color: red">*</span>:</label>
                <div class="col-xs-3">
                    <input type="email" name="email" class="form-control" placeholder="电子邮箱">
                    <span class="tipeHide" id="emailTip">请写入对应电子邮箱</span>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i> 备注

                    <div class="col-xs-3">
                        <input type="text" name="memo" class="form-control" placeholder=" 备注">
                    </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i> 账期

                    <div class="col-xs-3">
                        <input type="text" name="accounttime" class="form-control" placeholder=" 账期">
                    </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i> 评价

                    <div class="col-xs-3">
                        <input type="text" name="assess" class="form-control" placeholder=" 评价">
                    </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i> 状态

                    <div class="col-xs-3">
                        <g:checkBox name="status" class="input-sm jstree-checkbox"/>
                    </div>

            </div>
            <div class="list-group-item form-group datetimeDiv" >
                <label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>创建时间</i>
                </label>

                <div class="col-xs-3">
                    <g:if test="${banner.onlineStartTime}">
                        <input type="text"  value="${new org.joda.time.DateTime(banner.onlineStartTime).toString("yyyy-MM-dd HH:mm")}"
                               name="dateCreated"
                               class="form-control form_datetime"
                               readonly/>
                    </g:if>
                    <g:else>
                        <input type="text"
                               name="dateCreated"
                               class="form-control form_datetime"
                               readonly/>
                    </g:else>

                </div>

                <label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>修改时间</i>
                </label>

                <div class="col-xs-3">

                    <g:if test="${banner.onlineEndTime}">
                        <input type="text"  value="${new DateTime(banner.onlineEndTime).toString("yyyy-MM-dd HH:mm")}"
                               name="lastUpdated"
                               class="form-control form_datetime"
                               readonly/>
                    </g:if>
                    <g:else>
                        <input type="text"
                               name="lastUpdated"
                               class="form-control form_datetime"
                               readonly/>
                    </g:else>
                </div>

            </div>
            <div class="list-group-item form-group">
                <label class="col-xs-2 control-label"><i class="fa fa-map-marker"></i> 修改人ID

                    <div class="col-xs-3">
                        <input type="text" name="changeId" class="form-control" placeholder=" 修改人ID">
                    </div>

            </div>
            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="submit" class="btn btn-primary" type="submit" id="fbBtn">添加</button>
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

<script>

    //*************************************************

    //进行提交
    $("#fbBtn").on('click',function(){



        debugger;
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


        //[input]
        //var arr=["title","code","purchasingPrice","referencePrice","price","itemProfitFee","num"];

        var inputarr=["code", "sname", "cperson", "job", "address", "mobile", "zipcode", "email"];
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

        //遍历进行处理对应的dom[select]
        for(var j=0;j<selectnumarr.length;j++){
            $("#"+selectarr[selectnumarr[j]]+"Tip").show();
        }


        if(inputnumarr.length>0 || selectnumarr.length>0){
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

    $('.dropdown-toggle').dropdown()



</script>

</body>

</html>

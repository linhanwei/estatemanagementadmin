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
        Banner管理
        <small>运营工具</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>运营工具</a></li>
        <li class="active">Banner管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">Banner列表</g:link></li>
                    <li><g:link action="addBannerHtml">新增Banner</g:link></li>
                    %{--<li><g:link action="list">满减活动</g:link></li>--}%
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form class="form-inline" action="index">
                <div class="form-group">
                    <label class="control-label">模块类型：</label>

                    <g:select optionKey="key" optionValue="value" name="queryMoudleType"
                              value="${params.queryMoudleType}" id="level1Category"
                              class="form-control" from="${MoudleMap.entrySet()}"
                              noSelection="['': '模块类型']"/>
                </div>


                <div class="form-group">
                    <label class="control-label">banner类型：</label>

                    <g:select optionKey="key" optionValue="value" name="queryType"
                              value="${params.queryType}" id="level2Category"
                              class="form-control" from="${typeMap.entrySet()}"
                              noSelection="['': 'banner类型']"/>
                </div>

                <div class="form-group">
                    <label class="control-label">一级类目：</label>

                    <g:select optionKey="key" optionValue="value" name="categoryType"
                              value="${params.categoryType}"
                              class="form-control" from="${map.entrySet()}"
                              noSelection="['': '一级类目']"/>
                </div>


                <div class="form-group">
                    <label class="control-label" >查询页码：</label>
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '页码']"/>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>查询
                    </button>
                </div>

            </g:form>
        </div>

        <div class="box-body">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>标题</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>图片</th>
                    <th style="width: 130px"><i class="fa fa-tag"></i>类型</th>
                    <th style="width: 80px"><i class="fa fa-mail-reply"></i>跳转类型:</th>
                    <th style="width: 200px"><i class="fa fa-chain"></i>跳转URL/ID</th>
                    <th style="width: 60px"><i class="fa  fa-sort-numeric-asc"></i>权重</th>
                    <th style="width: 60px">显示文字</th>
                    <th style="width: 100px">开始时间</th>
                    <th style="width: 100px">结束时间</th>
                    <th style="width: 100px">一级类目</th>
                    <th style="width: 150px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${bannerList}" var="banner">
                        <g:if test="${banner?.showStatus == 1}">
                            <tr id="${banner?.id}" class="info">
                                <td>
                                    ${banner?.id}
                                    <div style="padding-top: 10px">
                                        ${banner?.title}
                                    </div>
                                </td>
                                <td>
                                    <g:if test="${typeMap.get(banner?.type)=="顶部活动位"}">
                                        <img src="${banner?.picUrl}" style="width: 127px;height: 40px">
                                    </g:if>
                                    <g:if test="${typeMap.get(banner?.type)=="类目入口"}">
                                        <img src="${banner?.picUrl}" style="width: 40px;height: 40px">
                                    </g:if>
                                    <g:if test="${typeMap.get(banner?.type)=="品牌入口"}">
                                        <img src="${banner?.picUrl}" style="width: 40px;height: 40px">
                                    </g:if>
                                    <g:if test="${typeMap.get(banner?.type)=="活动专区"}">
                                        <img src="${banner?.picUrl}" style="width: 93px;height: 40px">
                                    </g:if>
                                    <g:if test="${typeMap.get(banner?.type)=="秒杀专区"}">
                                        <img src="${banner?.picUrl}" style="width: 93px;height: 40px">
                                    </g:if>
                                    <g:else>
                                        <img src="${banner?.picUrl}" style="width: 93px;height: 40px">
                                    </g:else>
                                </td>

                                <td>
                                    ${typeMap.get(banner?.type)}
                                </td>
                                <td>
                                    ${redirectTypeMap.get(banner?.redirectType)}
                                </td>
                                <td>${banner?.target}</td>
                                <td><input onchange="modifyweight('${banner?.id}')" type="text"
                                           value="${banner?.weight}" name="${banner?.id}" class="no-border"
                                           style="width:30px;background:transparent;"></td>
                                <td>
                                    ${banner?.showText==1?"是":"否"}
                                </td>
                                <td>
                                    ${banner?.onlineStartTime?new DateTime(banner?.onlineStartTime).toString("yyyy-MM-dd HH:mm"):""}
                                </td>
                                <td>
                                    ${banner?.onlineEndTime?new DateTime(banner?.onlineEndTime).toString("yyyy-MM-dd HH:mm"):""}
                                </td>
                                <td>
                                    ${map.get(banner?.categoryId)}
                                </td>
                                <td>
                                    <g:if test="${banner?.showStatus == 1}">
                                        <button type="button" class="btn btn-info btn-sm"
                                                onclick="hideBanner(${banner?.id})">
                                            隐藏
                                        </button>
                                    </g:if>
                                    <g:if test="${banner?.showStatus == 0}">
                                        <button type="button" class="btn btn-primary btn-sm"
                                                onclick="showBanner(${banner?.id})">
                                            显示
                                        </button>
                                    </g:if>
                                    <button type="button" class="btn btn-warning btn-sm"
                                            onclick="window.location.replace('/banner/edit?id=${banner?.id}')">
                                        更改
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="deleteBanner(${banner?.id})">
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </g:if>
                        <g:if test="${banner.showStatus == 0}">
                            <tr id="${banner?.id}">
                                <td>${banner?.id}
                                    <div style="padding-top: 10px">
                                        ${banner?.title}
                                    </div>
                                </td>
                                <td><img src="${banner?.picUrl}" style="width: 128px;height: 42px">
                                </td>
                                <td>
                                    ${typeMap.get(banner?.type)}
                                </td>
                                <td>
                                    ${redirectTypeMap.get(banner?.redirectType)}
                                </td>
                                <td>${banner?.target}</td>

                                <td><input onchange="modifyweight('${banner?.id}')" type="text"
                                           value="${banner?.weight}" name="${banner?.id}" class="no-border"
                                           style="width:30px;background:transparent;"></td>
                                <td>
                                    ${banner?.showText==1?"是":"否"}
                                </td>
                                <td>
                                    ${banner?.onlineStartTime?new DateTime(banner?.onlineStartTime).toString("yyyy-MM-dd HH:mm"):""}
                                </td>
                                <td>
                                    ${banner?.onlineEndTime?new DateTime(banner?.onlineEndTime).toString("yyyy-MM-dd HH:mm"):""}
                                </td>
                                <td>
                                    ${map.get(banner?.categoryId)}
                                </td>
                                <td>
                                    <g:if test="${banner?.showStatus == 1}">
                                        <button type="button" class="btn btn-info btn-sm"
                                                onclick="hideBanner(${banner?.id})">
                                            隐藏
                                        </button>
                                    </g:if>
                                    <g:if test="${banner?.showStatus == 0}">
                                        <button type="button" class="btn btn-primary btn-sm"
                                                onclick="showBanner(${banner?.id})">
                                            显示
                                        </button>
                                    </g:if>

                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="deleteBanner(${banner?.id})">
                                        删除
                                    </button>

                                    <button type="button" class="btn btn-success btn-sm"
                                            onclick="window.location.replace('/banner/edit?id=${banner?.id}')">
                                        更改
                                    </button>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                                maxsteps="10" action="index" total="${total}"/>
                </div>
            </g:if>
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

    function modifyweight(id) {
        $("input").each(function change() {
            if (id == this.name) {
                var newWeight = this.value
                $.ajax({
                    url: '/banner/modifyweight',
                    data: {'id': id, 'newWeight': newWeight},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        $.sticky("修改成功", {autoclose: 2000, position: "top-center", type: "st-success"});
                        window.location.reload()
                    },
                    error: function (data) {
                        $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                    }
                });
            }
        });
    }

    function deleteBanner(id) {

        if (!confirm("您真的要删除这个Banner么？")) {
            return;
        }

        $.ajax({
            url: '/banner/deleteBanner',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#" + id).remove()
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    function showBanner(id) {

        if (!confirm("您真的要展示这个Banner么？")) {
            return;
        }

        $.ajax({
            url: '/banner/showBanner',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                window.location.reload()
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    function hideBanner(id) {

        if (!confirm("您真的要隐藏这个Banner么？")) {
            return;
        }

        $.ajax({
            url: '/banner/hideBanner',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                window.location.reload()

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    $("#level1Category").change(function(){
        var oneLevel=$(this).val().trim(),
                twoLevelObj=$('#level2Category');
        var tOptions=twoLevelObj.find('option');
        $.each(tOptions,function(index,obj){
            var value=$(obj).val();
            //首页
            if(oneLevel=="0")
            {
                if(value=="420")
                {
                    $(obj).hide();
                }
                else{
                    $(obj).show();
                }
            }
            //分类内
            else if(oneLevel=="1")
            {
                if(value=="419" || value=="420")
                {
                    $(obj).hide();
                }
                else
                {
                    $(obj).show();
                }
            }
            else if(oneLevel=="2")
            {
                if(value)
                {
                    $(obj).show();
                }
            }
            else if(oneLevel=="3" || oneLevel=="4" || oneLevel=="5")
            {
                if(value=="418")
                {
                    $(obj).show();
                }
                else
                {
                    $(obj).hide();
                }
            }
            //满减活动专区
            else if(oneLevel=="6"){
                if(value=="418" || value=="425")
                {
                    $(obj).show();
                }
                else
                {
                    $(obj).hide();
                }
            }
            else{
                if(value)
                {
                    $(obj).hide();
                }
            }
        });
        twoLevelObj.val("");
    });

    //    $("#level2Category").click(function(){
    //        debugger;
    //        var oneLevelObj = $("#level1Category");
    //        var tOptions=$(this).find('option');
    //        if(!oneLevelObj.val())
    //        {
    //            $.each(tOptions,function(index,obj){
    //                if($(obj).val())
    //                {
    //                    $(obj).hide();
    //                }
    //            })
    //        }
    //
    //    });

    $(function(){
        var oneLevelObj = $("#level1Category");
        var tOptions=$("#level2Category").find('option');
        var content=oneLevelObj.val().trim();
        if(!content)
        {
            $.each(tOptions,function(index,obj){
                if($(obj).val())
                {
                    $(obj).hide();
                }
            })
        }
        else
        {
            if(content=="0")
            {
                $.each(tOptions,function(index,obj){
                    if($(obj).val()=="420")
                    {
                        $(obj).hide();
                    }
                })
            }
            else if(content=="1")
            {
                $.each(tOptions,function(index,obj){
                    if($(obj).val()=="419")
                    {
                        $(obj).hide();
                    }
                })
            }
        }
    });



    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var queryMoudleType=$("#level1Category").val();
        var queryType=$("#level2Category").val();
        var categoryType=$("#categoryType").val();
        var str='/banner/index?max='+size+"&queryMoudleType="+queryMoudleType+"&queryType="+queryType;
        window.location.replace(str);
    });

</script>

</body>

</html>

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
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        活动列表信息
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="list">满减活动</g:link></li>
                    <li><g:link action="addBannerHtml">新增活动</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">

            <g:form class="form-inline" action="list">
                <div class="form-group">
                    <label class="control-label">活动名称：</label>
                    <input name="query" class="form-control" value="${params.query}">
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
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>活动名称</th>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>活动图片</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>开始时间</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>结束时间</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>满减参数</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${goodsList}" var="goods">
                        <tr>
                            <td>${goods.name}
                                <div style="padding-top: 10px">
                                    ${goods?.id}
                                </div>
                            </td>
                            <td>
                                <img src="${goods?.picUrls}" style="width: 90px;height: 47px">
                            </td>
                            <td>
                                ${goods?.startTime?new org.joda.time.DateTime(goods?.startTime).toString("yyyy-MM-dd HH:mm"):""}
                            </td>
                            <td>
                                ${goods?.endTime?new org.joda.time.DateTime(goods?.endTime).toString("yyyy-MM-dd HH:mm"):""}
                            </td>
                            <td class="Datacontent" id="${goods.id}">

                            </td>
                            <td>
                                <g:if test="${goods?.status == 0 as byte}">
                                    <button type="button" class="btn btn-primary btn-sm"
                                            onclick="window.location.replace('/mikuActiveTopic/changeOneActicestatus?flag=1&id=${goods.id}')">
                                        有效
                                    </button>
                                </g:if>
                                <g:if test="${goods?.status == 1 as byte}">
                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="window.location.replace('/mikuActiveTopic/changeOneActicestatus?flag=0&id=${goods.id}')">
                                        无效
                                    </button>
                                </g:if>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="lookItemDetail('${goods.id}');
                                        return false;"
                                        data-toggle="modal"
                                        data-target="#itemDetailModel">
                                    详情
                                </button>
                                <button type="button" class="btn btn-success btn-info" onclick="window.location.replace('/mikuActiveTopic/edit?id=${goods.id}')">
                                    修改
                                </button>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="list" total="${total}"/>
                </div>
            </g:if>
        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->

<div class="modal fade bs-example-modal-lg" id="itemDetailModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="itemId"></h2>
            </div>

            <div class="modal-body">
                <div id="itemDetail">
                    <g:render template="onedetail"/>
                </div>
            </div>
        </div>
    </div>
</div>


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
<g:if test="${total > 0}">
    <g:each status="i" in="${goodsList}" var="goods">
<g:if test="${goods.parameter}" >
var data=${goods.parameter};
var str="";
if(data){
    $.each(data,function(i,c){
        str+="满"+ parseFloat(c.min/100)+"元";
        str+="可减"+ parseFloat(c.value/100)+"元";
        str+="<br>";
    });
    $("#"+${goods.id}).html(str);
}
</g:if>

</g:each>
</g:if>



function lookItemDetail(id) {
    $("#itemId").text('满减活动的ID号:' + id)
    <g:remoteFunction update="itemDetail" action="lookItemDetail" options="'[asynchronous: false]'"  params="'id='+id"/>
}

</script>


</body>

</html>

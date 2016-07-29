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
        未审核的商品管理
        <small>审核商品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>未审核的商品管理</a></li>
        <li class="active">审核商品管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="index">未审核的商品管理</g:link></li>
                    <li><g:link action="addBannerHtml">修改商品管理</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form class="form-inline" action="index">
                <div class="form-group">
                    <label class="control-label" >商品名称：</label>
                    <input type="text"   class="form-control" placeholder="商品名称"/>
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
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>价格</th>
                    <th style="width: 130px"><i class="fa fa-tag"></i>邮费</th>
                    %{--<th style="width: 80px"><i class="fa fa-mail-reply"></i>品牌</th>--}%
                    <th style="width: 200px"><i class="fa fa-chain"></i>库存</th>
                    <th style="width: 100px">更新时间</th>
                    <th style="width: 150px"><i class="fa fa-hand-o-down"></i>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${list}" var="model">
                        <tr>
                        <td>${model.title}</td>
                        <td>${model.price/100f}</td>
                        <td>${model.postFee}</td>
                        <td>${model.num}</td>
                        <td>
                            ${model?.lastUpdated?new DateTime(model?.lastUpdated).toString("yyyy-MM-dd HH:mm"):""}
                        </td>
                        <td>
                            <button onclick="window.location.replace('/mikuItemContactPitems/doItemIndex?id=${model.id}')">审核</button>
                        </td>
                        </tr>
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



</script>

</body>

</html>

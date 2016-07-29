<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 8/9/14
  Time: 18:17
--%>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <title>商品管理</title>
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
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header"></section>
<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><g:link action="onSale">上架商品</g:link></li>
                    <li><g:link action="inStock">仓库商品</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box ">
                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-condensed" id="table">
                                        <tr>
                                            <th>类目</th>
                                            <th>产地</th>
                                            <th width="40%">名称</th>
                                            <th>重量</th>
                                            <th>采购价</th>
                                            <th>参考价</th>
                                            <th>更新时间</th>
                                            <th>操作</th>
                                        </tr>
                                        <g:if test="${total > 0}">
                                            <g:each status="i" in="${itemLists}" var="item">
                                                <tr id="${item.id}">
                                                    <td>${categoryMap.get(item.categoryId)}123123</td>
                                                    <td>${item.address}</td>
                                                    <td>${item.title}</td>
                                                    <td>${item.itemWeight}</td>

                                                    <td>${item.lastUpdated}</td>
                                                    <td>

                                                        <button type="button" class="btn btn-primary btn-sm"
                                                                onclick="makeInStock(${item.id})">下架</button>
                                                    <td>
                                                </tr>
                                            </g:each>
                                        </g:if>
                                    </table>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div><!-- /.box -->
                        <div class="box-footer clearfix">
                            <g:if test="${total > 0}">
                                <div class="pagination pull-right">
                                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                                maxsteps="10" action="queryItemOnSale" total="${total}"/>
                                </div>
                            </g:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->





<!-- Jquery -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="AdminLTE/app.js"/>
<!-- sticky -->
<asset:javascript src="plugins/sticky/sticky.js"/>

<script>


    function makeInStock(id) {

        if (!confirm("您真的要下架这个商品么？")) {
            return;
        }

        $.ajax({
            url: '/item/makeInStock',
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
</script>
</body>
</html>
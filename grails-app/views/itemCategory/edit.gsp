<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 8/11/14
  Time: 16:06
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
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- validation -->
    <asset:stylesheet src="bootstrapValidator/bootstrapValidator.css"/>
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
<section class="content-header">
    <h1>类目<small>管理</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <g:each in="${level1Categories}" var="level1">
                        <li><a href="../itemCategory/index?categoryId=${level1.id}">${level1.name}</a></li>
                    </g:each>
                    <li class="active"><g:link action="edit">类目编辑</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                <div class="box-tools">

                                </div>
                            </div><!-- /.box-header -->

                            <g:form class="form-horizontal" useToken="true" action="createOrUpdateCategory">
                                <div class="box-body table-responsive no-padding">

                                    <div style="display: none">
                                        <input name="id" value="${category.id}"/>
                                    </div>

                                    <div style="display: none">
                                        <input name="parentId" value="${category.parentId}"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">类目名称：</label>

                                        <div class="col-sm-6">
                                            <input name="name" class="form-control" value="${category.name}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">类目描述：</label>

                                        <div class="col-sm-6">
                                            <input name="memo" class="form-control" value="${category.memo}">
                                        </div>
                                    </div> <!-- /.box-body -->

                                    <div class="form-group">
                                        <div class="col-sm-offset-2">
                                            <button type="submit" class="btn btn-primary">提交</button>
                                            <button type="button" class="btn btn-warning"
                                                    onclick="window.location.replace('/itemCategory/national');">取消</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="box-footer clearfix">

                                </div>
                            </g:form>
                        </div><!-- /.box -->
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
<!-- InputMask -->
<asset:javascript src="plugins/input-mask/jquery.inputmask.js"/>
<asset:javascript src="plugins/input-mask/jquery.inputmask.date.extensions.js"/>
<asset:javascript src="plugins/input-mask/jquery.inputmask.extensions.js"/>
<!-- sticky -->
<asset:javascript src="plugins/sticky/sticky.js"/>

<!-- notify -->
<asset:javascript src="bootstrap-growl.min.js"/>
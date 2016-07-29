<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 14/11/10
  Time: 下午1:20
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">

    <title>订单管理</title>
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
    <!-- validation -->
    <asset:stylesheet src="bootstrapValidator/bootstrapValidator.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>

    <style type="text/css">
    body {
        font-size: 13px;
    }

    .addrTextArea {
        width: 100%;
        height: 60px;
        overflow-x: visible;
        overflow-y: visible;
        background: transparent;
        border-style: none
    }
    </style>


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
                    <li><g:link action="">便捷操作</g:link></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active">
                        <div class="box box-primary">
                            <div class="box-header">
                                <g:form action="finishTradeQuick" class="form-inline">
                                    <div class="input-group no-padding">
                                        <div class="input-group-addon">
                                            <i class="fa fa-mobile-phone"></i>手机号码:
                                        </div>
                                        <input id="query" name="query" class="input-sm"
                                               data-inputmask='"mask": "999-9999-9999"'
                                               data-mask="true"
                                               value="${params.query}"
                                               style="width: 120px"
                                               placeholder="用户号码:"/>
                                    </div>

                                    <button type="button" onclick="finishTradeQuick()"
                                            class="btn btn-primary"><i
                                            class="fa fa-search">查询</i></button>

                                </g:form>
                            </div>

                            <div class="box-body table-responsive no-padding"></div><!-- /.box-body -->
                            <div class="box-footer clearfix"></div>
                        </div><!-- /.box -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</section><!-- /.content -->


<div class="modal fade bs-example-modal-lg" id="tradeDetailModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="tradeId">订单号：</h2>
            </div>

            <div class="modal-body">
                <div id="tradeDetail">
                    <g:render template="tradeDetail"/>
                </div>
            </div>

        </div>
    </div>
</div>


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
<!-- bootstrap time picker -->
<asset:javascript src="plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="plugins/bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<!-- s
ticky -->
<asset:javascript src="plugins/sticky/sticky.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<!-- notify -->
<asset:javascript src="bootstrap-growl.min.js"/>


<script type="text/javascript">

    function finishTradeQuick() {
        var mobile = $('#query').val()
        $.ajax({
            url: "<g:createLink action="finishTradeQuick"></g:createLink>",
            data: {'mobile': mobile},
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert(JSON.stringify(data))
            },
            error: function (data) {
                alert(JSON.stringify(data))
            }
        });
    }

    $("#query").inputmask();

</script>
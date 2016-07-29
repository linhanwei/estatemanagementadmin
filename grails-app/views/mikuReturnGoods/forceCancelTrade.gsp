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
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>

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
        订单的强制的退款
        <small>退货管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>退货管理</a></li>
        <li class="active">订单的强制的退款</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="hqindex" controller="mikuReturnGoods">(发货前)申请退货订单</g:link></li>
                    <li><g:link action="thwctradeinfo" controller="mikuReturnGoods">(发货前)完成退货订单</g:link></li>
                    <li ><g:link action="index" controller="mikuReturnGoods">申请退货货物</g:link></li>
                    <li><g:link action="jhinfo" controller="mikuReturnGoods">用户寄货中</g:link></li>
                    <li ><g:link action="qrshinfo" controller="mikuReturnGoods">确认收货</g:link></li>
                    <li><g:link action="inginfo" controller="mikuReturnGoods">退货后订单</g:link></li>
                    <li ><g:link action="allinfo" controller="mikuReturnGoods">全部退货订单</g:link></li>
                    <li ><g:link action="personaldefine" controller="mikuReturnGoods">个人自定义退款</g:link></li>
                    <li><g:link action="personalOrderdefine" controller="mikuReturnGoods">分拆号退款</g:link></li>
                    <li class="active"><g:link action="forceCancelTrade" controller="mikuReturnGoods">订单的强制的退款</g:link></li>

                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
            <div class="box-header">
                <g:form action="forceCancelTrade" class="form-inline">
                    <table style="width:100%">
                        <tr>
                            <td>

                                <div class="form-group">
                                    <label>订单号：</label>
                                    <input  name="tradeId" class="form-control"
                                            style="width: 190px" value="${params.tradeId}"
                                            placeholder="订单号"/>
                                </div>

                                <div class="form-group">

                                    <button type="submit"
                                            class="btn btn-primary"><i
                                            class="fa fa-search">查询</i></button>
                                </div>

                            </td>
                        </tr>
                    </table>
                </g:form>
            </div>

        <div class="box-body clearfix">
                <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                    <tr>
                        <th><i class="fa fa-flag"></i>订单号</th>
                        <th><i class="fa fa-user"></i>id</th>
                        <th><i class="fa fa-map-marker"></i>总价</th>
                        <th><i class="fa fa-money"></i>实付</th>
                        <th><i class="fa fa-clock-o"></i>下单时间</th>
                        <th><i class="fa fa-clock-o"></i>订单状态</th>
                        <th><i class="fa fa-hand-o-down"></i>操作</th>
                    </tr>
                    <g:if test="${trade}">
                        <td>${trade.tradeId}</td>
                        <td>${trade.id}</td>
                        <td>${trade.price/100f}</td>
                        <td>${trade.totalFee/100f}</td>
                        <td>
                            ${trade.endTime?new org.joda.time.DateTime(trade.dateCreated).toString("yyyy-MM-dd HH:mm"):trade.dateCreated}
                        </td>
                        <td>
                            <g:if test="${trade.returnStatus==0 as byte}">
                                正常单状态
                            </g:if>
                            <g:elseif test="${trade.returnStatus==1 as byte}">
                                进行退款中
                            </g:elseif>
                            <g:elseif test="${trade.returnStatus==2 as byte}">
                                退款完成
                            </g:elseif>
                            (状态:
                            <g:if test="${trade.status==4 as byte}">
                                待处理
                            </g:if>
                            <g:elseif test="${trade.status==5 as byte}">
                                已发货
                            </g:elseif>
                            <g:elseif test="${trade.status==6 as byte}">
                                已备货
                            </g:elseif>
                            <g:elseif test="${trade.status==7 as byte || trade.status==20 as byte}">
                                交易成功
                            </g:elseif>
                            <g:elseif test="${trade.status==8 as byte}">
                                已退款
                            </g:elseif>
                            )
                        </td>
                        <td>
                            <button onclick="window.location.replace('/mikuReturnGoods/doforceTrade?tradeId='+${trade.tradeId})">强制退货处理</button>
                        </td>
                    </g:if>


                    <g:if test="${trade}">
                        <tr>
                            <th><i class="fa fa-flag"></i>分拆单号</th>
                            <th><i class="fa fa-flag"></i>订单号</th>
                            <th><i class="fa fa-user"></i>名称</th>
                            <th><i class="fa fa-map-marker"></i>单价</th>
                            <th><i class="fa fa-money"></i>数量</th>
                            <th><i class="fa fa-clock-o"></i>总付金额</th>
                            <th><i class="fa fa-hand-o-down"></i>操作</th>
                        </tr>
                    </g:if>



                    <g:each status="i" in="${orderList}" var="order">
                        <g:if test="${order.artificialId}">
                            <tr>
                                <td>${order.id}</td>
                                <td>${order.tradeId}</td>
                                <td>${order.title}</td>
                                <td>${order.price/100f}</td>
                                <td>${order.num}</td>
                                <td>${order.totalFee/100f}</td>
                                <td>
                                    <button onclick="window.location.replace('/mikuReturnGoods/doforceTrade?orderId='+${order.id})">拆单号处理</button>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>




                </table>
        </div><!-- /.box-body -->


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
<!-- InputMask -->
<asset:javascript src="input-mask/jquery.inputmask.js"/>
<asset:javascript src="input-mask/jquery.inputmask.date.extensions.js"/>
<asset:javascript src="input-mask/jquery.inputmask.extensions.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script type="text/javascript">


</script>
</body>
</html>
</html>
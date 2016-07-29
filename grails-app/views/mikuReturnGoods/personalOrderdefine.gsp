<%@ page import="org.joda.time.DateTime;com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
        退货管理
        <small>订单退货</small>
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li ><g:link action="hqindex" controller="mikuReturnGoods">(发货前)申请退货订单</g:link></li>
                    <li><g:link action="thwctradeinfo" controller="mikuReturnGoods">(发货前)完成退货订单</g:link></li>
                    <li ><g:link action="index" controller="mikuReturnGoods">申请退货货物</g:link></li>
                    <li><g:link action="jhinfo" controller="mikuReturnGoods">用户寄货中</g:link></li>
                    <li><g:link action="qrshinfo" controller="mikuReturnGoods">确认收货</g:link></li>
                    <li><g:link action="inginfo" controller="mikuReturnGoods">退货后订单</g:link></li>
                    <li ><g:link action="allinfo" controller="mikuReturnGoods">全部退货订单</g:link></li>
                    <li><g:link action="personaldefine" controller="mikuReturnGoods">个人自定义退款</g:link></li>
                    <li class="active"><g:link action="personalOrderdefine" controller="mikuReturnGoods">分拆号退款</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">

        <div class="box-header">
            <g:form action="personalOrderdefine" class="form-inline">
                <table style="width:100%">
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>拆单号：</label>
                                <input  name="tradeCode" class="form-control"
                                        style="width: 190px" value="${params.tradeCode}"
                                        placeholder="拆单号"/>
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

        <div class="box-body">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th><i class="fa fa-flag"></i>订单号</th>
                    <th><i class="fa fa-user"></i>退货人</th>
                    <th style="width: 10%"><i class="fa fa-map-marker"></i>退货原因</th>
                    <th>退货详情</th>
                    <th><i class="fa fa-money"></i>退货金额</th>
                    <th><i class="fa fa-clock-o"></i>退货时间</th>
                    <th><i class="fa fa-clock-o"></i>品牌名称</th>
                    <th>是否过期</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${mikuReturnGoodsList}" var="trade">
                        <tr id="${trade.id}" class="info">
                            <th>
                                ${trade.tradeId}
                                <g:if test="${trade?.tradeFrom == 1 as byte}">
                                    <div style="padding-top: 10px">
                                        <span style="color: #a47e3c">IOS</span>
                                    </div>
                                </g:if>

                                <g:if test="${trade?.tradeFrom == 2 as byte}">
                                    <div style="padding-top: 10px">
                                        <span style="color: #a47e3c">Android</span>
                                    </div>
                                </g:if>

                                <g:if test="${trade?.tradeFrom == 3 as byte}">
                                    <div style="padding-top: 10px">
                                        <span style="color: #a47e3c">微信</span>
                                    </div>
                                </g:if>

                                <g:if test="${trade?.tradeFrom == 4 as byte}">
                                    <div style="padding-top: 10px">
                                        <span style="color: #a47e3c">未知</span>
                                    </div>
                                </g:if>
                            </th>
                            <th>${trade?.buyername}
                                <div style="padding-top: 10px">
                                    <i class="fa fa-mobile-phone"></i>:${trade?.buyermobile}
                                </div>
                            </th>
                            <th>
                                ${trade?.buyerMemo}
                            </th>
                            <th>
                                ${trade?.title}[${trade?.price/100f} 元 x ${trade?.num}]
                            </th>
                            <th>
                                ${trade?.totalFee/100f}
                            </th>
                            <th>
                                ${new DateTime(trade?.lastUpdated).toString("yyyy-MM-dd HH:mm")}
                                <div style="padding-top: 10px">
                                    分拆单号: ${trade?.orderId}
                                </div>
                            </th>
                            <th>
                                ${trade?.brandName}
                            </th>
                            <th>

                                ${trade?.timeOutStatement}
                            </th>
                            <th>
                                <g:if test="${trade?.status == 0 as byte}">
                                    正常单
                                </g:if>
                                <g:elseif test="${trade?.status == 1 as byte}">
                                    待审核
                                </g:elseif>
                                <g:elseif test="${trade?.status== 2 as byte}">
                                    申请退货已审核
                                </g:elseif>
                                <g:elseif test="${trade?.status== 3 as byte}">
                                    退货中
                                </g:elseif>
                                <g:elseif test="${trade?.status== 4 as byte}">
                                    退货确认收货
                                </g:elseif>
                                <g:elseif test="${trade?.status== 5 as byte}">
                                    退货完成
                                </g:elseif>
                                <g:elseif test="${trade?.status== 6 as byte}">
                                    退货异常
                                </g:elseif>
                            </th>
                            <th>
                                <button type="button" class="btn btn-success btn-sm" onclick="finishGood(${trade.id})">完成拆单号退货标示改变</button>
                            </th>
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <div class="total pull-left">
                <i class="fa fa-check"></i>共计
                <span style="color: red">${total}</span>个订单
            </div>

            <div class="pagination pull-right">
                <g:paginate next="下一页" prev="上一页" params="${params}"
                            maxsteps="10" action="personalOrderdefine" total="${total}"/>
            </div>
        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->


<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel2">退货不通过原因:</h4>
            </div>
            <g:form useToken="true" action="noreturnGood">
                <input id="idflag" name="id" style="display: none;">

                <div class="modal-body">
                    <div class="form-horizontal">

                        <div class="form-group form-inline">
                            <label class="col-sm-2 control-label">退货不通过原因:</label>

                            <div class="col-sm-8">
                                <input name="errorcause" class="form-control">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="sjBtnOnsale">提交</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </g:form>
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
    function finishGood(id){
        $.ajax({
            url: '/mikuReturnGoods/refundOneOrder',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                var str='/mikuReturnGoods/personalOrderdefine';
                window.location.replace(str);
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }



</script>
</body>
</html>
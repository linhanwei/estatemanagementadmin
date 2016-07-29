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
                    <li><g:link action="index" controller="mikuReturnGoods">申请退货货物</g:link></li>
                    <li><g:link action="jhinfo" controller="mikuReturnGoods">用户寄货货物</g:link></li>
                    <li><g:link action="qrshinfo" controller="mikuReturnGoods">确认收货</g:link></li>
                    <li><g:link action="inginfo" controller="mikuReturnGoods">退货后订单</g:link></li>
                    <li  class="active"><g:link action="allinfo" controller="mikuReturnGoods">全部退货订单</g:link></li>
                    <li><g:link action="personaldefine" controller="mikuReturnGoods">个人自定义退款</g:link></li>
                    <li><g:link action="personalOrderdefine" controller="mikuReturnGoods">分拆号退款</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <g:form action="allinfo" class="form-inline">
                <table style="width:100%">
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>订单号：</label>
                                <input  name="tradeCode" class="form-control"
                                        style="width: 190px" value="${params.tradeCode}"
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
        <div class="box-body">
            <table style="table-layout:fixed" class="table table-hover table-striped table-bordered text-center">
                <tr>
                    <th><i class="fa fa-flag"></i>订单号</th>
                    <th><i class="fa fa-user"></i>退货人</th>
                    <th style="width: 20%"><i class="fa fa-map-marker"></i>退货原因</th>
                    <th>退货详情</th>
                    <th><i class="fa fa-money"></i>退货金额</th>
                    <th><i class="fa fa-clock-o"></i>退货时间</th>
                    <th><i class="fa fa-clock-o"></i>品牌名称</th>
                    <th>状态</th>
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
                                %{--//状态(-1=删除;0=正常单;1=待审核;2=申请退货已审核;3=退货中;4=退货确认收货;5=退货完成;6=退货异常)--}%
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

                            %{--<th class="tflag" falg="${trade?.status}" id="th${trade?.id}" style="color: red" info="${trade?.sellerMemo}">--}%
                                %{--${trade?.status}--}%
                                %{--<g:if test="${trade?.status==6}">--}%
                                    %{--${trade?.sellerMemo}--}%
                                %{--</g:if>--}%
                            %{--</th>--}%


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
                            maxsteps="10" action="allinfo" total="${total}"/>
            </div>
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
    $(function(){
        var obj=$('.tflag');
        $.each(obj,function(index,content){
            var onedata=$(content).attr("falg");
            var target=$("#"+$(content).attr("id"));
            if(onedata=="1")
            {
                target.html("<i class='fa fa-spinner'></i>待审核");
            }
            else if(onedata=="2")
            {
                target.html("<i class='fa fa-truck'></i>申请退货已审核");
            }
            else if(onedata=="3")
            {
                target.html("退货中");
//                target.html("<i class='fa fa-check'></i>退货中");
            }
            else if(onedata=="4")
            {
                target.html("退货确认收货<br/>("+target.html()+")");
//                target.html("退货确认收货<br/>("+target.html()+")");
            }
            else if(onedata=="5")
            {
                target.html("退货完成<br/>");
//                target.html("退货完成<br/>("+target.html()+")");
//                target.html("<i class='fa fa-times'></i>退货完成<br/>("+target.html()+")");
            }
            else if(onedata=="6")
            {
                target.html("退货异常<br/>("+target.attr("info")+")");
//                target.html("<i class='fa fa-times'></i>退货异常<br/>("+target.html()+")");
            }
        });

    });



    function lookTradeDetail(id) {
        $("#sendId").val(id)

        $("#tradeId").text('订单号:' + id)

        jQuery.ajax({
            type: 'POST', data: {'tradeId': id}, url: '/trade/lookTradeDetail', success: function (data, textStatus) {
                jQuery('#tradeDetail').html(data);
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    $("#query").inputmask();

</script>

</body>

</html>
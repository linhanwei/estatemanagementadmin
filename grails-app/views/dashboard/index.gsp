<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- page -->
    <asset:stylesheet src="page.css"/>

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
<!-- 引导图 -->
<section class="content">
    <div class="row">
        <!-- 入库与订单 -->
        <div class="col-lg-4 col-md-12 i_order">
            <div class="i_order_top">
                <asset:image src="one.png" class="img-circle" alt="User Image"/>
                <p>入库与订单</p>
            </div>
            <div class="i_order_view clearfix">
                <div class="view_l fl pr">
                    <a href="">
                        <div class="l_storage tc">
                            <i class="db wh30 bc"></i>
                            入库
                        </div>
                    </a>
                    <div class="l_storage_con">
                        <g:link controller="itemPublish" action="index">
                            <div class="con_commodity bc tc">
                                <i class="db wh30 bc"></i>
                                商品入库
                            </div>
                        </g:link>
                        <g:link controller="mikuCrowdfund" action="add">
                            <div class="con_crowd bc tc">
                                <i class="db wh30 bc"></i>
                                众筹入库
                            </div>
                        </g:link>
                    </div>

                    <div class="l_guide pa">
                        <!-- 指引 -->
                    </div>
                </div>

                <div class="view_r fl">
                    <div class="r_top">
                        <a href="">
                            <div class="top_order tc">
                                <i class="db wh30 bc"></i>
                                订单
                            </div>
                        </a>
                    </div>
                    <div class="r_left fl pr">
                        <g:link controller="tradeNoShip" action="index">
                            <div class="l_top tc">
                                <i class="db wh30 bc"></i>
                                订单管理
                            </div>
                        </g:link>

                        <div class="l_bottom bc mt35">
                            <g:link controller="trade" action="nopay">
                                <div class="b_npayment tc">
                                    <i class="db wh30 bc bg"></i>
                                    未付款
                                </div>
                            </g:link>
                            <g:link controller="tradeNoShip" action="index">
                                <div class="b_untreated tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    未处理
                                </div>
                            </g:link>
                            <g:link controller="trade" action="index">
                                <div class="b_delivery tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    待发货
                                </div>
                            </g:link>
                            <g:link controller="trade" action="shipped">
                                <div class="b_okgoods tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    已发货/待收货
                                </div>
                            </g:link>
                            <g:link controller="trade" action="allTrade">
                                <div class="b_allgoods tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    全部订单(售后)
                                </div>
                            </g:link>
                        </div>

                        <div class="b_add wh30 pa">
                            <!-- +号 -->
                        </div>
                    </div>
                    <div class="r_bottom fl">
                        <g:link controller="mikuCrowdfundTrade" action="zcSuccess">
                            <div class="b_ordermanagement tc">
                                <i class="db wh30 bc bg"></i>
                                众筹订单管理
                            </div>
                        </g:link>
                    </div>
                </div>
            </div>
        </div>
        <!-- 运营工具 -->
        <div class="col-lg-2 col-md-12 tools">
            <div class="o_tools">
                <div class="o_tools_top">
                    <asset:image src="two.png" class="img-circle" alt="User Image"/>
                    <p>运营工具</p>
                </div>
                <div class="o_tools_view">
                    <div class="view_con bc">
                        <g:link controller="banner" action="index">
                            <div class="view_banner tc mt38">
                                <i class="db wh30 bc bg"></i>
                                Banner管理
                            </div>
                        </g:link>
                        <g:link controller="mikuActiveTopic" action="list">
                            <div class="view_activity tc mt38">
                                <i class="db wh30 bc bg"></i>
                                活动管理
                            </div>
                        </g:link>
                        <g:link controller="tags" action="index">
                            <div class="view_label tc mt38">
                                <i class="db wh30 bc bg"></i>
                                标签管理
                            </div>
                        </g:link>
                        <g:link controller="operatingStatistic" action="index">
                            <div class="view_count tc mt38">
                                <i class="db wh30 bc bg"></i>
                                运营统计
                            </div>
                        </g:link>
                        <g:link controller="communityData" action="index">
                            <div class="view_data tc mt38">
                                <i class="db wh30 bc bg"></i>
                                站点数据
                            </div>
                        </g:link>
                    </div>
                </div>
            </div>
        </div>
        <!-- 进销存出入库 -->
        <div class="col-lg-6 col-md-12 inventory">
            <div class="inventory_con">
                <div class="con_top">
                    <asset:image src="three.png" class="img-circle" alt="User Image"/>
                    <p>进销存出入库</p>
                </div>
                <div class="inventory_view clearfix pr">
                    <div class="con_l fl">
                        <a href="">
                            <div class="l_storage tc mt38">
                                <i class="db wh30 bc bg"></i>
                                入库
                            </div>
                        </a>
                        <div class="l_bottom bc">
                            <g:link controller="mikuProvider" action="list">
                                <div class="b_supplier tc">
                                    <i class="db wh30 bc bg"></i>
                                    供应商管理
                                </div>
                            </g:link>
                            <g:link controller="mikuPiteminfo" action="list">
                                <div class="b_commodity tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    商品管理
                                </div>
                            </g:link>
                            <a href="">
                                <div class="b_sauditing tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    供应商审核
                                </div>
                            </a>
                            <a href="">
                                <div class="b_cauditing tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    供应商品审核
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="con_c fl">
                        <a href="">
                            <div class="c_order tc mt38">
                                <i class="db wh30 bc bg"></i>
                                订单
                            </div>
                        </a>
                        <div class="c_bottom bc">
                            <g:link controller="mikuPorderManger" action="index">
                                <div class="b_ordermanage tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    订单管理
                                </div>
                            </g:link>
                            <a href="">
                                <div class="b_successorder tc mt38">
                                    <i class="db wh30 bc bg"></i>
                                    完成订单
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="con_r_c clearfix">
                        <div class="con_r fl pr">
                            <a href="">
                                <div class="r_top_t tc">
                                    <i class="db wh30 bc bg"></i>
                                    出库
                                </div>
                            </a>
                            <div class="r_b_left fl">
                                <g:link controller="mikuPOperating" action="index">
                                    <div class="l_top tc">
                                        <i class="db wh30 bc bg"></i>
                                        统计
                                    </div>
                                </g:link>
                                <div class="l_bottom bc">
                                    <a href="">
                                        <div class="b_purchase tc">
                                            <i class="db wh30 bc bg"></i>
                                            采购统计
                                        </div>
                                    </a>
                                    <a href="">
                                        <div class="b_finance tc">
                                            <i class="db wh30 bc bg"></i>
                                            财务统计
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="r_b_right fl">
                                <a href="">
                                    <div class="r_top tc">
                                        <i class="db wh30 bc bg"></i>
                                        退货退款
                                    </div>
                                </a>
                                <div class="r_bottom bc">
                                    <g:link controller="mikuReturnGoods" action="hqindex">
                                        <div class="r_goodsmanage tc">
                                            <i class="db wh30 bc bg"></i>
                                            退货管理
                                        </div>
                                    </g:link>
                                </div>
                            </div>

                            <div class="b_add1 wh30 pa">
                                <!-- +号 -->
                            </div>
                        </div>
                    </div>

                    <div class="r_guide1 pa">
                        <!-- 指引1 -->
                    </div>
                    <div class="r_guide2 pa">
                        <!-- 指引2 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
%{--picchange--}%
<asset:javascript src="picchange.js"/>
<script type="text/javascript">

</script>

</body>

</html>
<%@ page import="org.apache.shiro.SecurityUtils" %>

<!-- Sidebar user panel -->
<div class="user-panel">
    <div class="pull-left image">
        <image src="http://mikumine.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151127/vNTT-0-1448596575359.jpg" class="img-circle" alt="User Image"/>
    </div>
    <div class="pull-left info">
        <p>您好，${SecurityUtils.subject.principal}</p>
        <a href="#"><i class="fa fa-circle text-success"></i>Online</a>
    </div>
</div>
<!-- search form -->
%{--<g:form action="allTrade" controller="trade" class="sidebar-form">--}%
%{--<div class="input-group">--}%
%{--<input type="text" name="itemQuery" value="${params.itemQuery}" class="form-control" placeholder="Search..."/>--}%
%{--<span class="input-group-btn">--}%
%{--<button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>--}%
%{--</span>--}%
%{--</div>--}%
%{--</g:form>--}%
<!-- /.search form -->

<!-- sidebar menu: : style can be found in sidebar.less -->
<ul class="sidebar-menu">
    <li class="header">功能菜单</li>
    <li class="treeview ${['tradeNoShip','tradeCalcu','mikuReturnGoods'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-money"></i> <span>订单管理</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'tradeNoShip' ? "class=active" : ''}>
                <g:link controller="tradeNoShip" action="index"><i
                        class="fa fa-angle-double-right"></i> 订单管理</g:link></li>
            %{--<li ${controllerName == 'tradeCalcu' ? "class=active" : ''}>--}%
                %{--<g:link controller="tradeCalcu" action="index"><i--}%
                        %{--class="fa fa-angle-double-right"></i>交易成功统计</g:link></li>--}%
            <li ${controllerName == 'mikuReturnGoods' ? "class=active" : ''}>
                <g:link controller="mikuReturnGoods" action="hqindex"><i
                        class="fa fa-angle-double-right"></i>退货管理</g:link></li>
        </ul>
    </li>


    <li class="treeview ${['mikuCrowdfund','mikuCrowdfundTrade'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-key"></i><span>众筹</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'mikuCrowdfund' ? "class=active" : ''}>
                <g:link controller="mikuCrowdfund" action="list"><i
                        class="fa fa-angle-double-right"></i> 众筹管理</g:link></li>
            <li ${controllerName == 'mikuCrowdfundTrade' ? "class=active" : ''}>
                <g:link controller="mikuCrowdfundTrade" action="zcSuccess"><i
                        class="fa fa-angle-double-right"></i> 众筹订单</g:link></li>
            %{--<li ${controllerName == 'mikuCrowdfund' ? "class=active" : ''}>--}%
            %{--<g:link controller="mikuCrowdfund" action="wxtradeindex"><i--}%
            %{--class="fa fa-angle-double-right"></i> 微信退款</g:link></li>--}%
            %{--<li ${controllerName == 'mikuCrowdfund' ? "class=active" : ''}>--}%
            %{--<g:link controller="mikuCrowdfund" action="index"><i--}%
            %{--class="fa fa-angle-double-right"></i> 测试页面</g:link></li>--}%
        </ul>
    </li>

    %{--<li class="treeview ${['shopItemManager'].contains(controllerName) ? 'active' : ''}">--}%
    %{--<a href="#">--}%
    %{--<i class="fa fa-globe"></i> <span>站点管理</span>--}%
    %{--<i class="fa fa-angle-left pull-right"></i>--}%
    %{--</a>--}%
    %{--<ul class="treeview-menu">--}%
    %{--<li ${actionName == 'index' ? "class=active" : ''}>--}%
    %{--<g:link controller="shopItemManager" action="index"><i--}%
    %{--class="fa fa-angle-double-right"></i> 在售商品</g:link></li>--}%
    %{--<li ${actionName == 'communityItemInstock' ? "class=active" : ''}>--}%
    %{--<g:link controller="shopItemManager" action="communityItemInstock"><i--}%
    %{--class="fa fa-angle-double-right"></i> 仓库商品</g:link></li>--}%
    %{--</ul>--}%
    %{--</li>--}%

    <li class="treeview ${['itemCategory', 'itemPublish', 'itemInStock', 'itemOnSale', 'groupon','shopItemManager','mikuBrand'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa  fa-list-ul"></i> <span>商品管理</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'itemCategory' ? "class=active" : ''}>
                <g:link controller="itemCategory" action="index"><i
                        class="fa fa-angle-double-right"></i> 商品类目</g:link></li>
            <li ${controllerName == 'itemPublish' ? "class=active" : ''}><g:link controller="itemPublish"
                                                                                 action="index"><i
                        class="fa fa-angle-double-right"></i> 发布商品</g:link></li>
            <li ${controllerName == 'itemInStock' ? "class=active" : ''}><g:link controller="itemInStock"
                                                                                 action="index"><i
                        class="fa fa-angle-double-right"></i> 仓库中的商品</g:link></li>
            %{--<li ${controllerName == 'itemOnSale' ? "class=active" : ''}><g:link controller="itemOnSale"--}%
                                                                                %{--action="index"><i--}%
                        %{--class="fa fa-angle-double-right"></i> 已上架的商品</g:link></li>--}%
            <li ${controllerName == 'shopItemManager' ? "class=active" : ''}><g:link controller="shopItemManager"
            action="index"><i
            class="fa fa-angle-double-right"></i> 在售商品</g:link></li>
            <li ${controllerName == 'mikuBrand' ? "class=active" : ''}>
                <g:link controller="mikuBrand" action="index"><i
                        class="fa fa-angle-double-right"></i> 品牌管理</g:link></li>
        </ul>
    </li>

    <li class="treeview ${['operatingStatistic', 'communityData', 'profile', 'companyData'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-superscript"></i> <span>数据统计</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'operatingStatistic' ? "class=active" : ''}>
                <g:link controller="operatingStatistic" action="index"><i
                        class="fa fa-angle-double-right"></i> 运营统计</g:link></li>
            <li ${controllerName == 'communityData' ? "class=active" : ''}>
                <g:link controller="communityData" action="index"><i
                        class="fa fa-angle-double-right"></i> 站点数据</g:link></li>
            <li ${controllerName == 'companyData' ? "class=active" : ''}>
                <g:link controller="companyData" action="index"><i
                        class="fa fa-angle-double-right"></i> 公司数据</g:link></li>
            <li ${controllerName == 'profile' ? "class=active" : ''}>
                <g:link controller="profile" action="index"><i
                        class="fa fa-angle-double-right"></i> 用户管理</g:link></li>
        </ul>
    </li>

    <li class="treeview ${['itemAtHalf', 'banner', 'coupon', 'tags','community','pageManage','mikuActiveTopic','mikuJGhttp'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-laptop"></i> <span>运营工具</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'itemAtHalf' ? "class=active" : ''}>
                <g:link controller="itemAtHalf" action="index"><i
                        class="fa fa-angle-double-right"></i> 半价活动</g:link></li>
            <li ${controllerName == 'banner' ? "class=active" : ''}>
                <g:link controller="banner" action="index"><i
                        class="fa fa-angle-double-right"></i> Banner管理</g:link></li>
            <li ${controllerName == 'mikuActiveTopic' ? "class=active" : ''}>
                <g:link controller="mikuActiveTopic" action="list"><i
                        class="fa fa-angle-double-right"></i> 活动管理[满减]</g:link></li>
            <li ${controllerName == 'coupon' ? "class=active" : ''}>
                <g:link controller="coupon" action="index"><i
                        class="fa fa-angle-double-right"></i> 优惠地带</g:link></li>
            <li ${controllerName == 'tags' ? "class=active" : ''}>
                <g:link controller="tags" action="index"><i
                        class="fa fa-angle-double-right"></i> 标签管理</g:link></li>
            <li ${controllerName == 'community' ? "class=active" : ''}>
                <g:link controller="community" action="index"><i
                        class="fa fa-angle-double-right"></i> 站点管理</g:link></li>
            %{--<li ${controllerName == 'mikuBrand' ? "class=active" : ''}>--}%
                %{--<g:link controller="mikuBrand" action="index"><i--}%
                        %{--class="fa fa-angle-double-right"></i> 品牌管理</g:link></li>--}%
            <li ${controllerName == 'pageManage' ? "class=active" : ''}>
                <g:link controller="pageManage" action="index"><i
                        class="fa fa-angle-double-right"></i>页面管理</g:link></li>
            <li ${controllerName == 'mikuJGhttp' ? "class=active" : ''}>
                <g:link controller="mikuJGhttp" action="index"><i
                        class="fa fa-angle-double-right"></i> APP推送管理</g:link></li>
        </ul>
    </li>

    <li class="treeview ${['systemMsg', 'employee', 'role', 'pagePermission'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-key"></i> <span>系统管理</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'systemMsg' ? "class=active" : ''}>
                <g:link controller="systemMsg" action="index"><i
                        class="fa fa-angle-double-right"></i> 商品同步开关</g:link></li>
            <li ${controllerName == 'employee' ? "class=active" : ''}>
                <g:link controller="employee" action="index"><i
                        class="fa fa-angle-double-right"></i> 员工管理</g:link></li>
            <li ${controllerName == 'role' ? "class=active" : ''}>
                <g:link controller="role" action="index"><i
                        class="fa fa-angle-double-right"></i> 角色管理</g:link></li>
            <li ${controllerName == 'pagePermission' ? "class=active" : ''}>
                <g:link controller="pagePermission" action="index"><i
                        class="fa fa-angle-double-right"></i> 权限管理</g:link></li>

        </ul>
    </li>





    <li class="treeview ${['profitManager','proFitGetPay','mikuSalesRecord','mikuUserAgency','mikuShareGetpay','mikuPayMoney','mikuAgencyLevel'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-key"></i> <span>分润详情</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            %{--<li ${controllerName == 'profitManager' ? "class=active" : ''}>--}%
                %{--<g:link controller="profitManager" action="index"><i class="fa fa-angle-double-right"></i>分润等级管理</g:link></li>--}%
            <li ${controllerName == 'mikuUserAgency' ? "class=active" : ''}>
                <g:link controller="mikuUserAgency" action="index"><i class="fa fa-angle-double-right"></i>代理关系</g:link></li>
            <li ${controllerName == 'mikuAgencyLevel' ? "class=active" : ''}>
                <g:link controller="mikuAgencyLevel" action="index"><i class="fa fa-angle-double-right"></i>代理关系名称</g:link></li>
            <li ${controllerName == 'mikuSalesRecord' ? "class=active" : ''}>
                <g:link controller="mikuSalesRecord" action="index"><i class="fa fa-angle-double-right"></i>分润信息</g:link></li>

            <li ${controllerName == 'mikuShareGetpay' ? "class=active" : ''}>
                <g:link controller="mikuShareGetpay" action="index"><i class="fa fa-angle-double-right"></i>提现分润信息</g:link></li>

            <li ${controllerName == 'mikuPayMoney' ? "class=active" : ''}>
                <g:link controller="mikuPayMoney" action="list"><i class="fa fa-angle-double-right"></i>平台支出</g:link></li>
        </ul>
    </li>



    <li class="treeview ${['mikuCustomizedOrder','mikuCustomizedExperienceDatabase','mikuCustomizedProductManage','mikuCustomizedMultimediaManage','mikuCourseManage','mikuPlanCourseManage','mikuTplCourseManage'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-key"></i> <span>私人定制 </span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${(controllerName == 'mikuCustomizedOrder') ? "class=active" : ''}>
                <g:link controller="MikuCustomizedOrder" action="zcSuccess"><i class="fa fa-angle-double-right"></i>订单管理</g:link></li>
            <li ${(controllerName == 'mikuCustomizedExperienceDatabase') ? "class=active" : ''}>
                <g:link controller="MikuCustomizedExperienceDatabase" action="index"><i class="fa fa-angle-double-right"></i>经验库管理</g:link></li>
            <li ${(controllerName == 'mikuCustomizedProductManage') ? "class=active" : ''}>
                <g:link controller="mikuCustomizedProductManage" action="index"><i class="fa fa-angle-double-right"></i>产品管理</g:link></li>
            <li ${(controllerName == 'mikuCustomizedMultimediaManage') ? "class=active" : ''}>
                <g:link controller="mikuCustomizedMultimediaManage" action="index"><i class="fa fa-angle-double-right"></i>多媒体管理</g:link></li>
            <li ${(controllerName == 'mikuCourseManage') ? "class=active" : ''}>
                <g:link controller="mikuCourseManage" action="index"><i class="fa fa-angle-double-right"></i>单次课程管理</g:link></li>
            <li ${(controllerName == 'mikuPlanCourseManage') ? "class=active" : ''}>
                <g:link controller="mikuPlanCourseManage" action="index"><i class="fa fa-angle-double-right"></i>计划课程管理</g:link></li>
            <li ${(controllerName == 'mikuTplCourseManage') ? "class=active" : ''}>
                <g:link controller="mikuTplCourseManage" action="index"><i class="fa fa-angle-double-right"></i>模板课程管理</g:link></li>
            <li ${(controllerName == 'mikuSnsContent') ? "class=active" : ''}>
                <g:link controller="mikuSnsContent" action="list"><i class="fa fa-angle-double-right"></i>发现管理</g:link></li>

        </ul>
    </li>

    <li class="treeview ${['mikuProvider','mikuPiteminfo','mikuPorderManger','mikuPGoods','mikuPOperating','mikuRefundGoods'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-key"></i> <span>进销存出入库 </span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${(controllerName == 'mikuProvider' && actionName == 'checkList') ? "class=active" : ''}>
                <g:link controller="mikuProvider" action="checkList"><i class="fa fa-angle-double-right"></i>待审核供应商管理</g:link></li>
            <li ${(controllerName == 'mikuPiteminfo' && actionName == 'checkList') ? "class=active" : ''}>
                <g:link controller="mikuPiteminfo" action="checkList"><i class="fa fa-angle-double-right"></i>待审核商品管理</g:link></li>
            <li ${controllerName == 'mikuPorderManger' ? "class=active" : ''}></li>
            <li ${(controllerName == 'mikuProvider' && actionName == 'list') ? "class=active" : ''}>
                <g:link controller="mikuProvider" action="list"><i class="fa fa-angle-double-right"></i>供应商管理</g:link></li>
            <li ${(controllerName == 'mikuPiteminfo' && actionName == 'list') ? "class=active" : ''}>
                <g:link controller="mikuPiteminfo" action="list"><i class="fa fa-angle-double-right"></i>商品管理</g:link></li>
            <li ${controllerName == 'mikuPorderManger' ? "class=active" : ''}>
                <g:link controller="mikuPorderManger" action="index"><i class="fa fa-angle-double-right"></i>订单管理</g:link></li>
            <li ${controllerName == 'mikuPGoods' ? "class=active" : ''}>
                <g:link controller="mikuPGoods" action="list"><i class="fa fa-angle-double-right"></i>出库订单</g:link></li>
            <li ${controllerName == 'mikuRefundGoods' ? "class=active" : ''}>
                <g:link controller="mikuRefundGoods" action="list"><i class="fa fa-angle-double-right"></i>退货管理</g:link></li>
            <li ${controllerName == 'mikuPOperating' ? "class=active" : ''}>
                <g:link controller="mikuPOperating" action="index"><i class="fa fa-angle-double-right"></i>进销存统计</g:link></li>

        </ul>
    </li>



    <li class="treeview ${['mikuOfficWriter'].contains(controllerName) ? 'active' : ''}">
        <a href="#">
            <i class="fa fa-key"></i> <span>文案推广</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li ${controllerName == 'mikuOfficWriter' ? "class=active" : ''}>
                <g:link controller="mikuOfficWriter" action="list"><i class="fa fa-angle-double-right"></i>软文管理</g:link></li>
        </ul>
    </li>

</ul>
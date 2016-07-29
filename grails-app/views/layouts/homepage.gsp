<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 8/9/14
  Time: 9:43
--%>
<!DOCTYPE html>
<%@ page import="grails.util.Environment; org.apache.shiro.SecurityUtils" contentType="text/html;charset=UTF-8" %>
<html>

<head>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <title><g:layoutTitle default="米酷"/></title>
    <link rel="shortcut icon" href="http://unesmall.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151118/vNTT-0-1447848511424.png">
    <g:layoutHead/>


    <script>
        //* hide all elements & show preloader

        document.documentElement.className += 'js';
    </script>
</head>

<body class="skin-blue">

    %{--加载进度等待开始--}%
        <style>
            .loading{
                display:none;
                width:100%;
                height:400%;
                position:absolute;
                top: 0%;
                left: 0%;
                z-index:999;
                -moz-opacity: 0.5;
                opacity:0.50;
                filter: alpha(opacity=50);
                background-color:black;
            }
            .loading .loading_img{
                display:block;
                position: absolute;
                top: 15%;
                left: 50%;
            }
        </style>
        <div class="loading">
            <img class="loading_img" src="http://mikumine.b0.upaiyun.com/common/images/loading.jpg"  alt="">
        </div>
    %{--加载进度等待结束--}%
<shiro:authenticated/>

<div class="wrapper">
    <g:render template="/layouts/header"/>

    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <g:render template="/layouts/nav"/>
        </section>
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
    <g:layoutBody/>
    </div><!-- /.content-wrapper -->

    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2014-2016 <a href="#">深圳米酷信息科技有限公司</a>.</strong> All rights reserved.
    </footer>
</div>

<g:if test="${Environment.PRODUCTION == Environment.current}">
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                        (i[r].q = i[r].q || []).push(arguments)
                    }, i[r].l = 1 * new Date();
            a = s.createElement(o),
                    m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-58339149-1', 'auto');
        ga('send', 'pageview');
    </script>

    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?75f3f8aba9b8f7bbe1d630df84a55dff";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>

</g:if>

</body>
</html>
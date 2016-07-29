<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 31/12/14
  Time: 07:09
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>高德地图</title>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- amap -->
    <link rel="stylesheet" type="text/css" href="http://developer.amap.com/Public/css/demo.Default.css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

    <style type="text/css">
    #iCenter {
        height: 100%;
    }
    </style>

</head>

<body>

<div>
    <div id='tips'>鼠标在地图上点击绘制多边形，点击右键或双击左键结束绘制</div>

    <div id="resultInfo"></div>
</div>

<div id="iCenter"></div>



<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>

<script language="javascript"
        src="http://webapi.amap.com/maps?v=1.3&key=${grailsApplication.config.amap.accessKey}"></script>

<script language="javascript">

    var mapObj, mouseTool;
    //初始化地图对象，加载地图
    function mapInit() {
        mapObj = new AMap.Map("iCenter", {
            keyboardEnable: false
        });

        mapObj.plugin(["AMap.ToolBar"], function () {   //在地图中添加ToolBar插件
            toolBar = new AMap.ToolBar();
            mapObj.addControl(toolBar);
        });

        mapObj.plugin(["AMap.OverView"], function () {
            view = new AMap.OverView();
            mapObj.addControl(view);
        });

        mapObj.plugin(["AMap.Scale"], function () {    //加载比例尺插件
            scale = new AMap.Scale();
            mapObj.addControl(scale);
            scale.show();
        });

        //设置多边形的属性
        var polygonOption = {
            strokeColor: "#FF33FF",
            strokeOpacity: 1,
            strokeWeight: 2
        };

        //在地图中添加MouseTool插件
        mapObj.plugin(["AMap.MouseTool"], function () {
            mouseTool = new AMap.MouseTool(mapObj);
            mouseTool.polygon(polygonOption);   //使用鼠标工具绘制多边形

            AMap.event.addListener(mouseTool, "draw", function (e) {
                var drawObj = e.obj;  //obj属性就是绘制完成的覆盖物对象。
                var pointsCount = e.obj.getPath().length; //获取节点个数
                $("#resultInfo").html("多边形节点数：" + pointsCount + "<br>节点坐标：" + e.obj.getPath())
                alert("配送区域已设定 ... ")
            });
        });
    }

    $(document).ready(function () {
        mapInit();
    })
</script>

</body>
</html>
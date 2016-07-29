<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 22/3/15
  Time: 10:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>地图边界查看</title>
    <style type="text/css">
    body {
        margin: 0;
        height: 100%;
        width: 100%;
        position: absolute;
    }

    #mapContainer {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
    }

    #tip {
        height: 45px;
        background-color: #fff;
        padding-left: 10px;
        padding-right: 10px;
        border: 1px solid #969696;
        position: absolute;
        font-size: 12px;
        right: 10px;
        bottom: 20px;
        border-radius: 3px;
        line-height: 45px;
    }

    #tip input[type='button'] {
        margin-left: 10px;
        margin-right: 10px;
        margin-top: 7px;
        background-color: #0D9BF2;
        height: 30px;
        text-align: center;
        line-height: 30px;
        color: #fff;
        font-size: 12px;
        border-radius: 3px;
        outline: none;
        border: 0;
        float: right;
    }
    </style>
</head>

<body>
<div id="mapContainer"></div>

<div id="tip">
    <input type="button" value="结束编辑多边形" onClick="endEddit()"/>
    <input type="button" value="开始编辑多边形" onClick="edditpolygon()"/>
</div>


<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=095a410b47da49ee0a4bbb5a5db34ef5"></script>
<script type="text/javascript">
    var editorTool;
    //初始化地图对象，加载地图
    var map = new AMap.Map("mapContainer", {
        resizeEnable: true,
        //二维地图显示视口
        view: new AMap.View2D({
            center: new AMap.LngLat(120.18252, 30.243753),//地图中心点
            zoom: 13 //地图显示的缩放级别
        })
    });
    var arr = new Array(); //构建多边形经纬度坐标数组

    <g:if test="${points != null}">
        <g:each in="${points}" var="point">
            arr.push(new AMap.LngLat("${point.split(',')[0]}", "${point.split(',')[1]}"));
        </g:each>
    </g:if>


    var polygon = new AMap.Polygon({
        map: map,
        path: arr,
        strokeColor: "#0000ff",
        strokeOpacity: 1,
        strokeWeight: 3,
        fillColor: "#f5deb3",
        fillOpacity: 0.35
    });

    //添加编辑控件
    map.plugin(["AMap.PolyEditor"], function () {
        editorTool = new AMap.PolyEditor(map, polygon);
    });

    function edditpolygon() {
        editorTool.open();
    }
    function endEddit() {
        editorTool.close();
    }
</script>
</body>
</html>


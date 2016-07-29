<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
    body,
    html {
        width: 100%;
        height: 100%;
        margin: 0;
        font-family: "微软雅黑";
    }

    #allmap {
        width: 100%;
        height: 100%;
    }

    p {
        margin-left: 5px;
        font-size: 14px;
    }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=${grailsApplication.config.baidu.js_key}"></script>
    <!--加载鼠标绘制工具-->
    <script type="text/javascript"
            src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css"/>
    <title>圆形区域搜索用户数据</title>
</head>

<body>
<div id="allmap"></div>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap"); // 创建地图实例
    var point = new BMap.Point(${longitude}, ${latitude}); // 创建点坐标

    var customLayer = new BMap.CustomLayer({
        geotableId: ${community.cloudTable},
        q: '', //检索关键字  
        tags: '', //空格分隔的多字符串  
        filter: '' //过滤条件,参考http://developer.baidu.com/map/lbs-geosearch.htm#.search.nearby  
    });
    map.addTileLayer(customLayer); //添加自定义图层

    map.centerAndZoom(point, 15); // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom();
    map.addControl(new BMap.NavigationControl()); //添加默认缩放平移控件


    var overlays = [];
    var styleOptions = {
        strokeColor: "red", //边线颜色。
        fillColor: "red", //填充颜色。当参数为空时，圆形将没有填充效果。
        strokeWeight: 1, //边线的宽度，以像素为单位。
        strokeOpacity: 0.5, //边线透明度，取值范围0 - 1。
        fillOpacity: 0.3, //填充的透明度，取值范围0 - 1。
        strokeStyle: 'solid' //边线的样式，solid或dashed。
    }
    //实例化鼠标绘制工具
    var drawingManager = new BMapLib.DrawingManager(map, {
        isOpen: false, //是否开启绘制模式
        enableDrawingTool: true, //是否显示工具栏
        drawingToolOptions: {
            anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
            offset: new BMap.Size(5, 5), //偏离值
            drawingModes: [
                BMAP_DRAWING_MARKER,
                BMAP_DRAWING_RECTANGLE
            ]
        },
        //circleOptions: styleOptions, //圆的样式
        //polylineOptions: styleOptions, //线的样式
        //polygonOptions: styleOptions, //多边形的样式
        rectangleOptions: styleOptions //矩形的样式
    });
    //添加鼠标绘制工具监听事件，用于获取绘制结果
    function rectanglecomplete(e, overlay) {
        console.log(overlay);
        var bs = overlay.getPath(); //自己规定范围

        var lbs = ''
        bs.forEach(function (entry) {
            lbs += entry.lng + ',' + entry.lat + ';'
        });
        console.log(lbs)

        $.ajax({
            url: "<g:createLink action="selectTradeMap"/>",
            data: {'lbs': lbs},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location = '/tradeNoShip/index?mapKey=' + data.key+'&communityId='+${communityId}
            },
            error: function (data) {
                alert(JSON.stringify(data))
            }
        });
    }
    drawingManager.addEventListener('rectanglecomplete', rectanglecomplete);


</script>

<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
</body>

</html>

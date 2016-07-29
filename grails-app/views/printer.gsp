<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 20/1/15
  Time: 16:30
--%>

<%@ page import="org.joda.time.DateTime" contentType="text/html;charset=UTF-8" %>
<head>
    <title>Print Test</title>
    <style type="text/css" media="print">
    @page {
        size: auto;   /* auto is the current printer page size */
        margin: 0mm;  /* this affects the margin in the printer settings */
    }

    body {
        font: 12px/1.5 'Microsoft YaHei', SimHei, sans-serif;
        background-color: #FFFFFF;
        margin: 3px; /* the margin on the content before printing */
    }

    </style>
</head>
<body>
<div>Top line</div>
<div>Line 2</div>

<p>
    -----------------------------------------------
</p>



<p>
    2015-01-18 日期
</p>

<p>
    中文字符测试
</p>

<p>
    特殊字符测试 @#$%^&*()!\{}~":?><
</p>

<p>

<div id="qrcode"></div>
</p>
<p>
    <canvas id="barcode"></canvas>
</p>
<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="plugins/qrcodejs/qrcode.min.js"/>
<asset:javascript src="plugins/jsbarcode/JsBarcode.js"/>
<asset:javascript src="plugins/jsbarcode/EAN_UPC.js"/>


<script type="text/javascript">
    new QRCode(document.getElementById("qrcode"), {
        text: "http://welinjia.com/",
        width: 128,
        height: 128,
        colorDark: "#000000",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.H
    });

    $("#barcode").JsBarcode("9780199532179", {
        format: "EAN",
        displayValue: true,
        fontSize: 16
    });

</script>

</body>
</html>
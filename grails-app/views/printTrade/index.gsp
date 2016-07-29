<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 20/1/15
  Time: 16:30
--%>

<%@ page import="org.apache.commons.lang3.StringUtils; org.joda.time.DateTime" contentType="text/html;charset=UTF-8" %>
<head>
    <title>果格格面单打印</title>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>

    <style type="text/css">
    @page {
        size: auto;   /* auto is the current printer page size */
        margin: 0mm;  /* this affects the margin in the printer settings */
    }

    body {
        font: 12px/1.5 'Microsoft YaHei', SimHei, sans-serif;
        background-color: #FFFFFF;
        margin: 3px; /* the margin on the content before printing */
    }

    .yingzhang {
        border: 1px solid #000;
        padding: 3px 5px;
        position: absolute;
        left: 234px;
        transform: scale(2) rotate(45deg);
        top: 18px;
    }

    .yingzhang:after {
        content: '未付款';
    }

    table {
        font-size: 10px;
        font-family: 'Microsoft YaHei';
    }

    table th {
        font-size: 10px;
        font-family: 'Microsoft YaHei';
        font-weight: normal;
    }

    table td {
        vertical-align: top;
    }

    img {
        vertical-align: bottom;
    }
    </style>
</head>

<body>
<div>
    <g:if test="${trade.type == 2}">
        <div class="yingzhang"></div>
    </g:if>
    <img src="http://welinklife.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20150123/vNTT-0-1422001290217.jpg">
    <span style="margin-left:2em;">${community.getName() ?: StringUtils.EMPTY}</span>
</div>

<p>
    -----------------------------------------------
</p>

<div>
    <table cellpadding="4">
        <tr>
            <th style="width: 140px">${new DateTime(trade.getDateCreated()).toString(formatter)}</th>
            <th style="width: 40px">单价</th>
            <th style="width: 40px">数量</th>
            <th style="width: 40px">规格</th>
            <th style="width: 40px">合计</th>
        </tr>
        <g:each status="i" in="${orders}" var="order">
            <tr>
                <th>${order.title}</th>
                <th>${order.price / 100f}</th>
                <th>${order.num}</th>
                <th>${(itemMap.get(order.artificialId)?.specification) ?: '无'}</th>
                <th>${order.totalFee / 100f}</th>
            </tr>
        </g:each>
        <tr><td colspan="4"
                style="font-size:12px; word-break: normal; white-space: nowrap;">-----------------------------------------------</td>
        </tr>
        <tr><td colspan="3" style="text-align: right">总价：</td><td>${trade.totalFee / 100f}</td></tr>
    </table>
</div>
<table cellpadding="2">
    <tr>
        <td style="width: 60px; font-size: 12px">联系方式：</td>
        <td style="font-size: 12px">${(logistics.contactName ?: "无") + "   " + logistics.mobile}</td>
    </tr>
    <tr>
        <td style="width: 60px; font-size: 12px">收货地址：</td>
        <td style="font-size: 12px">${logistics.addr}</td>
    </tr>
    <g:if test="${trade?.appointDeliveryTime != null}">
        <tr>
            <td style="width: 60px; font-size: 12px">预约时间：</td>
            <td style="font-size: 12px">${startTime}~${endTime}</td>
        </tr>
    </g:if>
    <g:if test="${trade?.buyerMessage != null}">
        <tr>
            <td style="width: 40px; font-size: 12px">备注：</td>
            <td style="font-size: 12px">${trade?.buyerMessage}</td>
        </tr>
    </g:if>
</table>
<br/>
<canvas id="barcode">
</canvas>

<p style="padding-left: 65px">${trade.id}</p>

<p>
    -----------------------------------------------<br/>
    亲，水果是时鲜食品，保质期短，请尽快食用。<br/>
    有任何问题或者建议，请扫描小票下方的二维码，
    或者联系站点电话：${community.phone ?: "400-683-1717"}，我们的全国统一服务热线是：400-683-1717
</p>

<div class="qcode clearfix" style="width:260px;">
    <div style="float: left; width:150px">
        <img style="float:left; max-width:100%;"
             src="http://welinklife.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20150323/vNTT-0-1427096410649.jpg">
    </div>

    <div style="float: left; width:110px; padding-top:50px">
        &lt;--&nbsp;微信扫一扫<br/>
        每日优惠早知道
    </div>
</div>




<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="qrcodejs/qrcode.min.js"/>
<asset:javascript src="jsbarcode/JsBarcode.js"/>
<asset:javascript src="jsbarcode/CODE128.js"/>


<script type="text/javascript">


    <g:if test="${trade.id != null}" >
    $("#barcode").JsBarcode("${trade.id}", {
        width: 2,
        height: 80,
        quite: 10,
        textAlign: "center",
        format: "CODE128",
        displayValue: false,
        fontSize: 12
    });
    </g:if>

</script>

</body>
</html>
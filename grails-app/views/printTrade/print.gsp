<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 23/1/15
  Time: 05:43
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Print Test</title>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
</head>

<body>

<div>
    <input id="tradeId" type="text">
</div>

<div id="printerDiv" style="display:none"></div>

<div>
    <button id="button" class="btn btn-primary" onclick="printPage()">打印测试</button>
</div>

<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>

<script type="text/javascript">

    function printPage() {
        var tradeId = $('#tradeId').val()
        printExternal("/printTrade/index?id=" + tradeId)
    }

    function printExternal(url) {
        var printWindow = window.open(url);
        printWindow.addEventListener('load', function () {
            printWindow.print();
            printWindow.close();
        }, true);
    }

</script>
</body>
</html>
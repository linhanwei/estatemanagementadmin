<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2016/2/17
  Time: 17:58
--%>

<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
</head>
<body>
<form id="alipaysubmit" name="alipaysubmit" action="set" method="get">
    <input type="hidden" name="id" value="${id}"/>
    <input type="hidden" name="title" value="${title}"/>
    <input type="submit" value="确认" style="display:none;">
</form>

<script>
    document.forms['alipaysubmit'].submit();</script>
</body>
</html>
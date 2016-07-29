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
<form id="alipaysubmit" name="alipaysubmit" action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8" method="get">
    <input type="hidden" name="seller_email" value="${sPara.get('seller_email')}"/>
    <input type="hidden" name="batch_no" value="${sPara.get('batch_no')}"/>
    <input type="hidden" name="partner" value="${sPara.get('partner')}"/>
    <input type="hidden" name="service" value="${sPara.get('service')}"/>
    <input type="hidden" name="_input_charset" value="${sPara.get('_input_charset')}"/>
    <input type="hidden" name="sign" value="${sPara.get('sign')}"/>
    <input type="hidden" name="notify_url" value="${sPara.get('notify_url')}"/>
    <input type="hidden" name="batch_num" value="${sPara.get('batch_num')}"/>
    <input type="hidden" name="sign_type" value="${sPara.get('sign_type')}"/>
    <input type="hidden" name="refund_date" value="${sPara.get('refund_date')}"/>
    <input type="hidden" name="detail_data" value="${sPara.get('detail_data')}"/>
    <input type="submit" value="确认" style="display:none;">
</form>

<script>document.forms['alipaysubmit'].submit();</script>
%{--${sHtmlText}--}%
</body>
</html>
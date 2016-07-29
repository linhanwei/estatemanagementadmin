<%@ page import="org.apache.commons.lang3.StringUtils" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 80px"><i class="fa fa-user"></i>收货人:</th>
            <th>${tradeDetail?.receiverName + '(' + tradeDetail?.receiverMobile + ')'}</th>
            <th style="width: 80px"><i class="fa fa-home"></i>小区:</th>
            <th>${tradeDetail?.communityName}</th>
        </tr>
        <tr>
            <th><i class="fa fa-map-marker"></i>地址:</th>
            <th>${tradeDetail?.address}</th>
            <th><i class="fa fa-tags"></i>总价:</th>
            <th style="color: #ff0000"><i
                    class="fa fa-jpy"></i>${Long.parseLong((tradeDetail?.totalPrice) ?: '0') / 100f}</th>
        </tr>
        <tr>
            <th><i class="fa fa-file-text-o"></i>备注:</th>
            <th>${tradeDetail?.buyerMessage}</th>
            <th><i class="fa fa-clock-o"></i>下单:</th>
            <th>${tradeDetail?.createTime}</th>
        </tr>
        <tr>
            <th>支付宝:</th>
            <th>${tradeDetail?.profileAlipay ?: '无记录'}</th>
            <th><i class="fa fa-user"></i>发货人:</th>
            <th>${tradeDetail?.courierName}</th>
        </tr>
        <tr>
            <th>微邻处理:</th>
            <th>${tradeDetail?.tradeMemo}</th>
            <th><i class="fa fa-clock-o"></i>发货:</th>
            <th>${tradeDetail?.consignTime}</th>
        </tr>
        </thead>

    </table>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th>名称</th>
            <th style="width: 50px">数量</th>
            <th style="width: 50px">单价</th>
            <th style="width: 70px"><i class="fa fa-tags"></i>小计</th>
        </tr>
        </thead>
        <tbody>
        <g:if test="${total > 0}">
            <g:each status="i" in="${orderList}" var="order">
                <tr>
                    <td>${order?.itemName}</td>
                    <td>${order?.itemNum}</td>
                    <td>${Long.parseLong(order?.itemPrice) / 100f}</td>
                    <td>${order?.orderPrice / 100f}元</td>
                </tr>
            </g:each>
        </g:if>
        </tbody>
    </table>
</div>
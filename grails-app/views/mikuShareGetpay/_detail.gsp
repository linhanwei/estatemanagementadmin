<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th>序列</th>
            <th  style="width: 136px">订单号</th>
            <th  style="width: 140px">商品名称</th>
            <th>商品数量</th>
            <th>单价</th>
            <th>总价</th>
            <th>分润金额</th>
            <th>状态</th>
        </tr>
        <g:each status="i" in="${list}" var="one">
            <tr>
                <th>${i+1}</th>
                <th style="word-wrap:break-word;">${one.tradeId}</th>
                <th>${one.itemName}</th>
                <th>${one.num}</th>
                <th>${one.price?one.price/100f:""}</th>
                <th>${one.amount/100f}</th>
                <th>${one.shareFee/100f}</th>
                <th>
                    <g:if test="${one.itemStatus==20}">
                        完成
                    </g:if>
                    <g:if test="${one.itemStatus==8}">
                        退款
                    </g:if>
                    <g:if test="${one.itemStatus==4 || one.itemStatus==5 || one.itemStatus==6 || one.itemStatus==7}">
                        交易中
                    </g:if>
                </th>
            </tr>
        </g:each>
        </thead>
    </table>

</div>

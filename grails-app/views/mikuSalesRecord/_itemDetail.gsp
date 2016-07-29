<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 90px">订单号:</th>
            <th>
                ${record.tradeId}
            </th>
            <th style="width: 90px">代理等级:</th>
            <th>
                ${record.agencyLevelName}
            </th>
        </tr>
        <tr>
            <th>代理信息:</th>
            <th>
                ${record.agencyName}(${record.agencyMoblie})
            </th>

            <th>商品信息:</th>
            <th>
                ${record.buyerName}(${record.itemId})
            </th>

        </tr>
        <tr>
            <th>交易数量:</th>
            <th style="word-wrap:break-word;">
                ${record.num}
            </th>
            <th>分润金额:</th>
            <th>
                ${(record?.shareFee ?: 0) / 100f}
            </th>
        </tr>
        <tr>
            <th>商品单价:</th>
            <th>
                ${(record?.price ?: 0) / 100f}
            </th>

            <th>总金额:</th>
            <th>
                ${(record?.amount ?: 0) / 100f}
            </th>
        </tr>
        <tr>
            <th><i class="fa fa-money"></i>确认日期:</th>
            <th>
                ${new DateTime(record.confirmDate).toString("yyyy-MM-dd HH:mm")}
            </th>
            <th><i class="fa fa-gavel"></i>付款时间:</th>
            <th>
                ${new DateTime(record.payTime).toString("yyyy-MM-dd HH:mm")}
            </th>
        </tr>

        </thead>

    </table>
    <table class="table table-bordered" style="table-layout: fixed">
        <thead>
        <tr>
            <th>分润比例:</th>
            <th colspan="3">
                <g:if test="${JSON.parse(record.parameter)!= null}">
                    <g:each in="${JSON.parse(record.parameter)}" var="info" status="i">
                        ${info.title} &nbsp;&nbsp;:&nbsp;&nbsp;${info.value}%
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </g:each>
                </g:if>
            </th>
        </tr>
        </thead>
    </table>
</div>
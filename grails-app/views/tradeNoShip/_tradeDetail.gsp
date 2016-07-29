<%@ page import="org.apache.commons.lang3.StringUtils " %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 80px"><i class="fa fa-user"></i>收货人:</th>
            <th>${tradeDetail?.receiverName?:'手机用户' + '(' + tradeDetail?.receiverMobile + ')'}</th>
            <th style="width: 80px"><i class="fa fa-home"></i>小区:</th>
            <th>${(tradeDetail?.communityName) ?: '北软旧订单'}</th>
        </tr>
        <tr>
            <th><i class="fa fa-map-marker"></i>地址:</th>
            <th>
                <g:if test="${tradeDetail?.modifiAddr != null}">

                    <span style="color: limegreen">${tradeDetail?.modifiAddr}</span>

                </g:if>
                <g:if test="${tradeDetail?.modifiAddr == null}">

                    <span>${tradeDetail?.address}</span>

                </g:if>
            </th>
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
            %{--<th><i class="fa fa-user"></i>送货人:</th>--}%
            %{--<th>${tradeDetail?.courierName}(${tradeDetail?.courierMobile})</th>--}%
        </tr>
        %{--<tr>--}%
        %{--<th>微邻处理:</th>--}%
        %{--<th>--}%
        %{--<g:if test="${tradeDetail?.tradeMemo == null}">--}%
        %{--正常--}%
        %{--</g:if>--}%
        %{--<g:if test="${tradeDetail?.tradeMemo != null}">--}%
        %{--<span style="color: orangered">${tradeDetail?.tradeMemo}</span>--}%
        %{--</g:if>--}%
        %{--</th>--}%
        %{--<th><i class="fa fa-clock-o"></i>发出:</th>--}%
        %{--<th>${tradeDetail?.confirmTime}</th>--}%
        %{--</tr>--}%
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

    <div class="row">
        <label class="col-sm-3 control-label"><i class="fa fa-edit"></i>用户需求:</label>

        <div class="col-sm-9">
            <input name="tid" value="${trade?.id}" style="display: none"/>
            <textarea rows="5" name="buyerMessage" class="form-control" id="buyerMessage"
                      placeholder="">${trade?.buyerMessage}</textarea>
        </div>
    </div>

    %{--<div class="row">--}%
    %{--<label class="col-sm-3 control-label"><i class="fa fa-edit"></i>微邻处理:</label>--}%

    %{--<div class="col-sm-9">--}%
    %{--<input name="tid" value="${trade?.id}" style="display: none"/>--}%
    %{--<textarea rows="5" name="dealcontent" class="form-control" id="dealcontent"--}%
    %{--placeholder="">${trade?.tradeMemo}</textarea>--}%
    %{--</div>--}%
    %{--</div>--}%

    <div style="padding-top: 10px" class="row">
        <label class="col-sm-6 control-label">客户的一切需求可以在上面的框框内记录哟~~！</label>

        <div class="col-sm-2">
            <g:if test="${(trade?.type == 2) && (trade?.status == 4)}">
                <input style="color: #ff0000" type="button" onclick="cancelTrade(${trade?.id})" value="关闭订单" class="btn">
            </g:if>
        </div>

        <div class="col-sm-2">
            <g:if test="${trade?.status == 5}">
                <input type="button" onclick="shipToNoShip(${trade?.id})" value="回退" class="btn btn-warning">
            </g:if>
        </div>

        <div class="col-sm-2">
            <input type="button" onclick="addTradeMemo(${trade?.id})" value="备注" class="btn btn-info">
        </div>
    </div>
</div>

<script>

    function shipToNoShip(id) {
        if (!confirm("您确定要回退该订单吗？回退之前填写好微邻处理")) {
            return;
        }
        var dealcontent = $("#dealcontent").val()
        <g:remoteFunction onSuccess="window.location.reload()" action="shipToNoShip" options="'[asynchronous: false]'"  params="{'tid':id, 'dealcontent':dealcontent}" />
    }

    function cancelTrade(id) {
        if (!confirm("您确定要取消该订单吗？取消前请将理由写在微邻处理！")) {
            return;
        }
        var dealcontent = $("#dealcontent").val()
        <g:remoteFunction onSuccess="window.location.reload()" action="cancelTrade" options="'[asynchronous: false]'"  params="{'tid':id, 'dealcontent':dealcontent}" />
    }

    function addTradeMemo(id) {

        var dealcontent = $("#dealcontent").val()

        var buyerMessage = $('#buyerMessage').val()

        if(!confirm('请再次确认用户要求和公司备注')) {
            return
        }

        <g:remoteFunction onSuccess="window.location.reload()" action="addTradeMemo" options="'[asynchronous: false]'"  params="{'tid':id, 'dealcontent':dealcontent, 'buyerMessage':buyerMessage}" />
    }
</script>
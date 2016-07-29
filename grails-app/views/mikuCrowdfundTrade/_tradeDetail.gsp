<%@ page import="org.apache.commons.lang3.StringUtils" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 80px"><i class="fa fa-user"></i>收货人:</th>
            <th></th>
            <th style="width: 80px"><i class="fa fa-home"></i>小区:</th>
            <th></th>
        </tr>
        <tr>
            <th><i class="fa fa-map-marker"></i>地址:</th>
            <th></th>
            <th><i class="fa fa-tags"></i>总价:</th>
            <th style="color: #ff0000"><i class="fa fa-jpy"></i></th>
        </tr>
        <tr>
            <th><i class="fa fa-file-text-o"></i>备注:</th>
            <th></th>
            <th><i class="fa fa-clock-o"></i>下单:</th>
            <th></th>
        </tr>
        <tr>
            <th>支付宝:</th>
            <th></th>
            <th><i class="fa fa-user"></i>发货人:</th>
            <th></th>
        </tr>
        %{--<tr>--}%
            %{--<th>微邻处理:</th>--}%
            %{--<th></th>--}%
            %{--<th><i class="fa fa-clock-o"></i>发货:</th>--}%
            %{--<th></th>--}%
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
        </tbody>
    </table>
</div>
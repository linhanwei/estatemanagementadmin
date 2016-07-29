<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead id="targethed">
        <tr>
            <th style="width: 90px"><i class="fa fa-list-ul"></i>ID</th>
            <th style="width: 90px"><i class="fa fa-list-ul"></i>商品名称</th>
            <th style="width: 90px"><i class="fa fa-list-ul"></i>品牌</th>
            <th style="width: 90px"><i class="fa fa-list-ul"></i>价格</th>
        </tr>

            <g:each status="i" in="${list}" var="goods">
                <tr>
                    <td>${goods.id}</td>
                    <td>${goods.title}</td>
                    <td>${goods.skus}</td>
                    <td>${goods.price/100f}</td>
                </tr>
            </g:each>

    </table>
</div>
<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<script>

</script>

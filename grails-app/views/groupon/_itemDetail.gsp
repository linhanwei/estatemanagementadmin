<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 90px"><i class="fa fa-user"></i>大类:</th>
            <th>${parentCategory}</th>
            <th style="width: 90px"><i class="fa fa-home"></i>类目:</th>
            <th>${childCategory}</th>
        </tr>
        <tr>
            <th><i class="fa fa-picture-o"></i>主图:</th>
            <th>
                <g:each status="i" in="${StringUtils.split(item?.picUrls, ';')}" var="picUrl">
                    <p class="imgWrap pull-left">
                        <img src="${picUrl}" style="width: 50px;height: 35px">
                        <input name="item-pic" value="${picUrl}" style="display: none">
                    </p>
                </g:each>
            </th>
            <th style="color: #ff0000"><i class="fa fa-truck"></i>团购价:</th>
            <th>${(grouponPrice ?: 0) / 100f}</th>
        </tr>
        <tr>
            <th><i class="fa fa-bookmark"></i>标题:</th>
            <th>${item?.title}</th>
            <th><i class="fa fa-flask"></i>规格:</th>
            <th>${item?.specification}</th>
        </tr>
        <tr>
            <th><i class="fa fa-map-marker"></i>产地:</th>
            <th>${item?.address}</th>
            <th><i class="fa fa-truck"></i>采购价:</th>
            <th>无</th>
        </tr>
        <tr>
            <th><i class="fa fa-money"></i>参考价:</th>
            <th>${(JSON.parseObject(item?.features, new TypeReference<Map<String, Long>>() {
            })?.get('referencePrice') ?: 0) / 100f}</th>
            <th><i class="fa fa-gavel"></i>销售价:</th>
            <th><span>${(item?.price ?: 0) / 100f}</span></th>
        </tr>
        </thead>

    </table>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>

        <tr>
            <th style="width: 80px">商品描述:</th>

            <th><textarea name="description" class="form-control"
                          rows="3">${item?.description}</textarea></th>
        </tr>
        <tr>
            <th>视频连接:</th>
            <th>${item?.video}</th>

        </tr>
        <tr>
            <th>图文详情:</th>
            <th>
                <g:each status="i" in="${StringUtils.split(item?.detail, ';')}" var="picUrl">
                    <p class="imgWrap pull-left">
                        <img src="${picUrl}" style="width: 50px;height: 35px">
                        <input name="item-pic" value="${picUrl}" style="display: none">
                    </p>
                </g:each>
            </th>

        </tr>
        </thead>
    </table>
</div>
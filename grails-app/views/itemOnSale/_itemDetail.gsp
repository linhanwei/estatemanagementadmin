<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 90px"><i class="fa fa-list-ul"></i>大类:</th>
            <th>${parentCategory}</th>
            <th style="width: 90px"><i class="fa fa-list"></i>类目:</th>
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

            <th>品牌:</th>
            <th>
                ${brandMap.get(item?.brandId)?.name}
                %{--${item?.brandId}--}%
            </th>

        </tr>
        <tr>
            <th><i class="fa fa-bookmark"></i>标题:</th>
            <th style="word-wrap:break-word;">${item?.title}</th>
            <th><i class="fa fa-flask"></i>规格:</th>
            <th>${item?.specification}</th>
        </tr>
        <tr>
            <th><i class="fa fa-truck"></i>采购价:</th>
            <th>${(JSON.parseObject(item?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f}</th>

            <th><i class="fa fa-map-marker"></i>商品编码:</th>
            <th>${item?.code}</th>
        </tr>
        <tr>
            <th><i class="fa fa-money"></i>参考价:</th>
            <th>${(JSON.parseObject(item?.features)?.getLongValue('referencePrice') ?: 0) / 100f}</th>
            <th><i class="fa fa-gavel"></i>销售价:</th>
            <th><span style="color: #ff0000">${(item?.price ?: 0) / 100f}</span></th>
        </tr>

        <tr>
            <th>特别说明:</th>
            <th>${JSON.parseObject(item?.features)?.get('ext')?.get('特别说明') ?: '无'}</th>
            <th>功效:</th>
            <th>${JSON.parseObject(item?.features)?.get('ext')?.get('功效') ?: '无'}</th>
        </tr>
        <tr>
            <th>保质期:</th>
            <th>${JSON.parseObject(item?.features)?.get('ext')?.get('保质期') ?: '无'}</th>
            <th>适用人群:</th>
            <th>${JSON.parseObject(item?.features)?.get('ext')?.get('适用人群') ?: '无'}</th>
        </tr>
        <tr>
            <th>销售基数:</th>
            <th>${item?.baseSoldQuantity}</th>
        </tr>

        </thead>

    </table>
    <table class="table table-bordered" style="table-layout: fixed">
        <thead>

        <tr>
            <th style="width: 80px">商品描述:</th>

            <th><textarea name="description" class="form-control"
                          rows="3">${item?.description}</textarea></th>
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
        <tr>
            <th>标签:</th>
            <th>
                <g:if test="${currentTags != null}">
                    <g:each in="${currentTags}" var="tag" status="i">
                        <small class="label pull-left bg-blue" style="white-space: normal;">${tag?.name}
                        <g:if test="${tag.bit == 1L}">
                            ${JSON.parseObject(OtMap.get(tag.id))?.get('xgLimitNum') ?: '无'}
                        </g:if>
                        <g:if test="${tag?.name=="抢购标"}">
                            ${xgcontent}
                        </g:if>
                        </small>
                    </g:each>
                </g:if>
            </th>
        </tr>
        <tr>
            <th>分润比例:</th>
            <th >
                <g:if test="${JSON.parse(str)!= null}">
                    <g:each in="${JSON.parse(str)}" var="fr" status="i">
                        ${fr.title} &nbsp;&nbsp;:&nbsp;&nbsp;${fr.price}元
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </g:each>
                </g:if>
                %{--一级 20元--}%
                %{--二级 15元--}%
                %{--三级 30元--}%
                %{--<span id="fenruncontent" onchange="alert()">${str}</span>--}%
            </th>
        </tr>
        </thead>
    </table>
</div>
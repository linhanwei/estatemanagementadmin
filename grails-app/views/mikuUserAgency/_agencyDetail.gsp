<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th style="width: 90px">id:</th>
            <th>
                ${agencyInfo.id}
            </th>
            <th style="width: 90px">姓名:</th>
            <th>
                ${agencyInfo.agencyName}
            </th>
        </tr>
        <tr>
            <th>联系电话:</th>
            <th>
                ${agencyInfo.agencyMobile}
            </th>

            <th>是否为代理:</th>
            <th>
                <g:if test="${agencyInfo.isAgency==0}">
                    消费者
                </g:if>
                <g:if test="${agencyInfo.isAgency==1}">
                    代理
                </g:if>
            </th>

        </tr>
        <tr>
            <th>代理等级:</th>
            <th>
                <g:if test="${agencyInfo.agencyLevel==0}">
                    总代
                </g:if>
                <g:if test="${agencyInfo.agencyLevel>0}">
                    ${agencyInfo.agencyLevel}
                </g:if>
            </th>
            <th>创建时间:</th>
            <th>
                ${new DateTime(agencyInfo.agencyDateCreate).toString("yyyy-MM-dd HH:mm")}
            </th>
        </tr>
        <tr>
            <th>
                下级代理:
            </th>
            <th colspan="3">
                ${agencyInfo.childCount}
            </th>
        </tr>

        </thead>

    </table>
    <table class="table table-bordered" style="table-layout: fixed">
        <thead>
        <g:if test="${agencyInfo.pUserId}">
            <tr>
                <th>上级代理:</th>
                <th colspan="3">
                    (ID:${agencyInfo.pUserId})
                    <br/>
                    名称:${agencyInfo.pUserName}
                    <br/>
                    <g:if test="${agencyInfo.pUserMobile}">
                       联系电话: (${agencyInfo.pUserMobile})
                    </g:if>
                </th>
            </tr>
        </g:if>

        <g:if test="${agencyInfo.p2UserId}">
            <tr>
                <th>上上级代理:</th>
                <th colspan="3">
                    (ID:${agencyInfo.p2UserId})
                    <br/>
                    名称:${agencyInfo.p2UserName}
                    <br/>
                    <g:if test="${agencyInfo.pUserMobile}">
                        联系电话: (${agencyInfo.p2UserMobile})
                    </g:if>
                </th>
            </tr>
        </g:if>

        <g:if test="${agencyInfo.p3UserId}">
            <tr>
                <th>前3级代理:</th>
                <th colspan="3">
                    (ID:${agencyInfo.p3UserId})
                    <br/>
                    名称:${agencyInfo.p3UserName}
                    <br/>
                    <g:if test="${agencyInfo.p3UserMobile}">
                        联系电话: (${agencyInfo.p3UserMobile})
                    </g:if>
                </th>
            </tr>
        </g:if>

        </thead>
    </table>
</div>
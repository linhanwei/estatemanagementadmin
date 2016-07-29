%{--<g:select optionKey="id" optionValue="title" name="permissionSelect" from="${controllerPermissionList}"  multiple="multiple"/>--}%
%{--<g:select optionKey="id" optionValue="title" name="permissionSelect" from="${controllerPermissionList}"  multiple="multiple"/>--}%
<g:each  in="${controllerPermissionList}" var="Permission">
    <g:if test="${Permission.description=="true"}">
        <g:checkBox name="permissionSelect" value="${true}" idflag="${Permission.id}" class="mycheckbox" checkedFlg="1"/>${Permission.title}
    </g:if>
    <g:else>
        <g:checkBox name="permissionSelect"  idflag="${Permission.id}" class="mycheckbox" checkedFlg="0"/>${Permission.title}
    </g:else>
    &nbsp;
</g:each>



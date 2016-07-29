<%@ page import="welink.estate.Department" %>



<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'communityId', 'error')} required">
    <label for="communityId">
        <g:message code="department.communityId.label" default="Community Id"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="communityId" type="number" value="${departmentInstance.communityId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="department.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${departmentInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: departmentInstance, field: 'status', 'error')} required">
    <label for="status">
        <g:message code="department.status.label" default="Status"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select name="status" from="${departmentInstance.constraints.status.inList}" required=""
              value="${fieldValue(bean: departmentInstance, field: 'status')}" valueMessagePrefix="department.status"/>

</div>


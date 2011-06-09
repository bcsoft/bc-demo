<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="module.title"/>' data-type='form'
	data-saveUrl='<s:url value="/bc/module/save" />'
	data-js='<s:url value="/bc/security/module/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.moduleForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":618,"minWidth":250,"minHeight":250,"modal":false
	}'>
	<s:form name="moduleForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label">* <s:text name="module.type"/>：</td>
					<td class="value" colspan="3"><s:radio name="e.type" list="types" listKey="key" listValue="value"
						value="e.type" cssStyle="width:auto;"/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="label.name"/>：</td>
					<td class="value w200"><s:textfield name="e.name" data-validate="required"/></td>
					<td data-name="belong" class="label"><s:text name="module.belong"/>:</td>
					<td data-name="belong" class="value"><s:textfield name="e.belong.name" 
						readonly="true" title='%{getText("module.title.click2selectBelong")}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="label.code"/>：</td>
					<td class="value"><s:textfield name="e.code" data-validate="required"/></td>
					<td data-name="iconClass" class="label"><s:text name="module.iconClass"/>:</td>
					<td data-name="iconClass" class="value"><s:textfield name="e.iconClass" 
						readonly="true"  title='%{getText("module.title.click2selectIconClass")}'/></td>
				</tr>
				<tr>
					<td data-name="url" id="urlText" class="label" data-text='<s:text name="module.url"/>'>* <s:text name="module.url"/>：</td>
					<td data-name="url" class="value"><s:textfield name="e.url" data-validate="required"/></td>
					<td data-name="option" class="label"><s:text name="module.option"/>:</td>
					<td data-name="option" class="value"><s:textfield name="e.option"/></td>
				</tr>
			</tbody>
		</table>
		<s:hidden name="e.status" />
		<s:hidden name="e.inner" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.belong.id" />
		<p class="formComment"><s:text name="module.form.comment"/></p>
	</s:form>
</div>
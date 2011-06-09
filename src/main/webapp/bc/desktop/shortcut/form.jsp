<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="shortcut.form.title"/>' class='bc-page'
	data-js='<s:url value="/bc/desktop/shortcut/form.js" />'
	data-saveUrl='<s:url value="/bc/shortcut/save" />'
	data-initMethod='bc.shortcutForm.init' data-type='form'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":415,"minWidth":300,"minHeight":200
	}'>
<s:form name="shortcutForm" theme="simple" cssClass="bc-form">
	<table class="ui-widget-content m8 w400" cellspacing="2" cellpadding="0">
		<tbody>
			<tr>
				<td class="label">* <s:text name="shortcut.name" />:</td>
				<td class="value"><s:textfield name="e.name" data-validate="required"/></td>
			</tr>
			<tr>
				<td class="label">* <s:text name="shortcut.url" />:</td>
				<td class="value"><s:textfield name="e.url" data-validate="required"/></td>
			</tr>
			<tr>
				<td class="label">* <s:text name="shortcut.iconClass" />:</td>
				<td class="value"><s:textfield name="e.iconClass" data-validate="required"
					readonly="true" title='%{getText("shortcut.title.click2selectIconClass")}'/></td>
			</tr>
			<tr>
				<td class="label"><s:text name="shortcut.standalone" />:</td>
				<td class="value"><s:radio name="e.standalone"
					list="#{'true':'外部链接','false':'内部链接'}" value="e.standalone"
					cssStyle="width:auto;" /></td>
			</tr>
			<tr>
				<td class="label">* <s:text name="label.order" />:</td>
				<td class="value"><s:textfield name="e.order" data-validate="required"/></td>
			</tr>
			<tr>
				<td class="label">&nbsp;</td>
				<td class="value">&nbsp;</td>
			</tr>
		</tbody>
	</table>
	<s:hidden name="e.status" />
	<s:hidden name="e.inner" />
	<s:hidden name="e.uid" />
	<s:hidden name="e.id" />
	<s:hidden name="e.actor.id" />
	<p class="formComment"><s:text name="shortcut.form.comment"/></p>
</s:form>
</div>
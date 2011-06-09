<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="user.password.title.reset"/>' data-type='form'
	data-saveUrl='<s:url value="/bc/auth/updatePassword" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"minWidth":270,"minHeight":100,"modal":false
	}'>
	<s:form name="userForm" theme="simple">
		<table class="formTable" cellspacing="2">
			<tbody>
				<tr>
					<td class="label">输入新密码:</td>
					<td class="value"><s:textfield name="password" data-validate="required"/></td>
				</tr>
			</tbody>
		</table>
		<s:hidden name="ids"/>
	</s:form>
</div>
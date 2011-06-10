<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="syslog.title"/>' data-type='form' class="bc-page"
	data-option='{"width":618,"minWidth":250,"minHeight":250,"modal":false}'>
	<s:form name="syslogForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label"><s:text name="syslog.userName"/>:</td>
					<td class="value w200"><s:textfield name="e.userName" readonly="true" cssClass="ui-state-disabled"/></td>
					<td class="label"><s:text name="syslog.type"/>:</td>
					<td class="value"><s:radio name="e.type" list="#{'0':'登录','1':'主动注销','2':'超时注销'}" 
						value="e.type" cssStyle="width:auto;" disabled="true"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="syslog.departName"/>:</td>
					<td class="value"><s:textfield name="e.departName" readonly="true" cssClass="ui-state-disabled"/></td>
					<td class="label"><s:text name="syslog.createDate"/>:</td>
					<td class="value"><input type="text" name="e.createDate" 
						value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.createDate" />' 
						readonly="readonly" class="ui-state-disabled"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="syslog.unitName"/>:</td>
					<td class="value" colspan="3"><s:textfield name="e.unitName" readonly="true" cssClass="ui-state-disabled"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="syslog.clientIp"/>:</td>
					<td class="value"><s:textfield name="e.clientIp" readonly="true" cssClass="ui-state-disabled"/></td>
					<td class="label"><s:text name="syslog.clientName"/>:</td>
					<td class="value"><s:textfield name="e.clientName" readonly="true" cssClass="ui-state-disabled"/></td>
				</tr>
				<tr>
					<td class="label top"><s:text name="syslog.clientInfo"/>:</td>
					<td class="value" colspan="3"><s:textarea name="e.clientInfo" readonly="true" cssClass="ui-state-disabled" rows="3"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="syslog.serverIp"/>:</td>
					<td class="value"><s:textfield name="e.serverIp" readonly="true" cssClass="ui-state-disabled"/></td>
					<td class="label"><s:text name="syslog.serverName"/>:</td>
					<td class="value"><s:textfield name="e.serverName" readonly="true" cssClass="ui-state-disabled"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="syslog.serverInfo"/>:</td>
					<td class="value" colspan="3"><s:textfield name="e.serverInfo" readonly="true" cssClass="ui-state-disabled"/></td>
				</tr>
			</tbody>
		</table>
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label"><s:text name="syslog.subject"/>:</td>
					<td class="value" colspan="3"><s:textfield name="e.subject" readonly="true" cssClass="ui-state-disabled"/></td>
				</tr>
				<tr>
					<td class="label top"><s:text name="syslog.content"/>:</td>
					<td class="value" colspan="3"><s:textarea name="e.content" readonly="true" cssClass="ui-state-disabled" rows="5"/></td>
				</tr>
			</tbody>
		</table>
		<s:hidden name="e.status" />
		<s:hidden name="e.inner" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
	</s:form>
</div>
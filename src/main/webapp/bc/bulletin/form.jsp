<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="bulletin.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc/bulletin/save" />'
	data-js='<s:url value="/bc/bulletin/form.js" />'
	data-initMethod='bc.bulletinForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":618,"minWidth":250,"minHeight":250,"modal":false
	}'>
	<s:form name="bulletinForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0">
			<tbody>
				<s:if test="%{e.issuerName == null}">
				<tr>
					<td class="label" colspan="4">
					<s:property value="e.authorName" />(<s:property value="e.departName" />) 创建于  <s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				</s:if>
				<s:else>
				<tr>
					<td class="label" colspan="4">
					<s:property value="e.issuerName" /> 发布于  <s:date name="e.issueDate" format="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				</s:else>
				<tr>
					<td class="label"><s:text name="bulletin.scope"/>:</td>
					<td class="value"><s:radio name="e.scope" list="#{'0':'本单位','1':'全系统'}" 
						value="e.scope" cssStyle="width:auto;"/></td>
					<td class="label"><s:text name="bulletin.unitName"/>:</td>
					<td class="value" colspan="3"><s:textfield name="e.unitName" readonly="true"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="bulletin.status"/>:</td>
					<td class="value"><s:radio name="e.status" list="#{'0':'待发布','1':'已发布','2':'已过期'}" 
						value="e.status" cssStyle="width:auto;"/></td>
					<td class="label"><s:text name="bulletin.overdueDate"/>:</td>
					<td class="value"><input type="text" name="e.overdueDate" data-validate="date"
						value='<s:date format="yyyy-MM-dd" name="e.overdueDate" />'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="bulletin.subject"/>:</td>
					<td class="value" colspan="3"><s:textfield name="e.subject" data-validate="required"/></td>
				</tr>
				<tr>
					<td class="label top">* <s:text name="bulletin.content"/>:</td>
					<td class="value" colspan="3"><s:textarea name="e.content" rows="8" data-validate="required"/></td>
				</tr>
			</tbody>
		</table>
		<s:hidden name="e.inner" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.author.name" />
		<s:hidden name="e.departId" />
		<s:hidden name="e.departName" />
		<s:hidden name="e.unitId" />
		<s:hidden name="e.issueDate" />
		<s:hidden name="e.issuer.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ taglib prefix="bc" uri="/bc-tags"%> --%>
<div title='<s:text name="bulletin.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc/bulletin/save" />'
	data-js='<s:url value="/ui-libs/xheditor/1.1.7/xheditor-zh-cn.min.js?ts=0" />,<s:url value="/bc/bulletin/form.js" />'
	data-initMethod='bc.bulletinForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","action":"save"}],
		"width":680,"minWidth":250,"minHeight":250,"modal":false
	}'>
	<s:form name="bulletinForm" theme="simple">
		<div class="formTopInfo">
			<s:if test="%{e.issuerName == null}">
				<s:property value="e.authorName" />(<s:property value="e.departName" />) 创建于  <s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>
			</s:if>
			<s:else>
				<s:property value="e.issuerName" /> 发布于  <s:date name="e.issueDate" format="yyyy-MM-dd HH:mm:ss"/>
			</s:else>
		</div>
		<div class="formFields ui-widget-content">
		<table class="formFields" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label"><s:text name="bulletin.scope"/>:</td>
					<td class="value"><s:radio name="e.scope" list="#{'0':'本单位','1':'全系统'}" 
						value="e.scope" cssStyle="width:auto;"/></td>
					<td class="label"><s:text name="bulletin.unitName"/>:</td>
					<td class="value" colspan="3"><s:textfield name="e.unitName" readonly="true" cssClass="ui-state-disabled"/></td>
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
			</tbody>
		</table>
		</div>
		<div class="formEditor">
			<s:textarea name="e.content" cssClass="bc-editor" data-validate="required"></s:textarea>
		</div>
		<div class="formAttachs attachs">
			<ul class="items">
				<li class="total">
					<span>2 个附件</span> -- 
					<a href="#" target="blank" data-url="/bc/bc/attach/downloadAll">下载所有附件</a>
					<a href="#" target="blank" data-url="/bc/bc/attach/deleteAll">删除所有附件</a>
					<input type="file" name="file" value="添加附件" multiple/>
				</li>
				<li class="item">
					<table class="item" cellpadding="0" cellspacing="0">
						<tr>
							<td class="icon"><span class="file-icon doc"></span></td>
							<td class="info">
								<div class="subject">附件名称</div>
								<div class="operate">
									<span>32KB</span>
									<a href="#">查看</a>
									<a href="#">下载</a>
									<a href="#">删除</a>
								</div>
							</td>
						</tr>
					</table>
				</li>
				<li class="item">
					<table class="item" cellpadding="0" cellspacing="0">
						<tr>
							<td class="icon"><span class="file-icon xls"></span></td>
							<td class="info">
								<div class="subject">附件名称</div>
								<div class="operate">
									<span>32KB</span>
									<a href="#">查看</a>
									<a href="#">下载</a>
									<a href="#">删除</a>
								</div>
							</td>
						</tr>
					</table>
				</li>
			</ul>
		</div>
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
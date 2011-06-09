<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="user.title"/>' data-type='form'
	data-saveUrl='<s:url value="/bc/user/save" />'
	data-js='<s:url value="/bc/identity/identity.js" />,<s:url value="/bc/identity/user/form.js" />'
	data-initMethod='bc.userForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","click":"bc.userForm.save"}],
		"width":618,"minWidth":250,"minHeight":250,"modal":false
	}'>
	<s:form name="userForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label">* <s:text name="user.name"/>:</td>
					<td class="value w200"><s:textfield name="e.name" data-validate="required"/></td>
					<td class="label">* <s:text name="actor.belong"/>:</td>
					<td class="value"><s:textfield name="belong.name" data-validate="required"
						readonly="true" title='%{getText("user.title.click2selectBelong")}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="user.code"/>:</td>
					<td class="value"><s:textfield name="e.code" data-validate="required"/></td>
					<td class="label"><s:text name="user.duty"/>:</td>
					<td class="value">
						<s:select name="e.detail.duty.id" list="duties" listKey="id" listValue="name" value="e.detail.duty.id"></s:select>
					</td>
				</tr>
				<tr>
					<td class="label">* <s:text name="label.order"/>:</td>
					<td class="value"><s:textfield name="e.order" data-validate='required'/></td>
					<td class="label"><s:text name="label.phone"/>:</td>
					<td class="value"><s:textfield name="e.phone" data-validate='{"type":"phone","required":false}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="user.card"/>:</td>
					<td class="value"><s:textfield name="e.detail.card" data-validate="required"/></td>
					<td class="label"><s:text name="label.email"/>:</td>
					<td class="value"><s:textfield name="e.email" data-validate='{"type":"email","required":false}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="user.workDate"/>:</td>
					<td class="value"><input type="text" name="e.detail.workDate" data-validate="required" 
						class="bc-date" title='%{getText("title.click2selectDate")}'
						value='<s:date format="yyyy-MM-dd" name="e.detail.workDate" />'/></td>
					<td class="label"><s:text name="user.gender"/>:</td>
					<td class="value"><s:radio name="e.detail.sex" list="#{'1':'男','2':'女','0':'不设置'}" 
						value="e.detail.sex" cssStyle="width:auto;"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="user.comment"/>:</td>
					<td class="value"><s:textfield name="e.detail.comment"/></td>
					<td class="label"><s:text name="label.status"/>:</td>
					<td class="value"><s:radio name="e.status" list="#{'1':'启用','0':'禁用','2':'已删除'}" 
						value="e.status" cssStyle="width:auto;"/></td>
				</tr>
			</tbody>
		</table>
		<!-- 已分派的岗位信息 -->
		<div id="assignGroups" class="formTable2 ui-widget-content" 
			data-removeTitle='<s:text name="title.click2remove"/>'>
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="actor.headerLabel.assignGroups"/>：
					<s:if test="%{ownedGroups == null || ownedGroups.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
				<span id="addGroups" class="verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="actor.title.click2addGroups"/>'></span>
			</div>
			<s:if test="%{ownedGroups != null && !ownedGroups.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="ownedGroups">
				<li class="horizontal ui-widget-content ui-corner-all" data-id='<s:property value="id" />'>
					<span class="text"><s:property value="name" /></span>
					<span class="click2remove verticalMiddle ui-icon ui-icon-close" title='<s:text name="title.click2remove"/>'></span>
				</li>
			</s:iterator>
			</ul>
			</s:if>	
		</div>
		<!-- 已分配的角色信息 -->
		<div id="assignRoles" class="formTable2 ui-widget-content" 
			data-removeTitle='<s:text name="title.click2remove"/>'>
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="actor.headerLabel.assignRoles"/>：
					<s:if test="%{ownedRoles == null || ownedRoles.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
				<span id="addRoles" class="verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="actor.title.click2addRoles"/>'></span>
			</div>
			<s:if test="%{ownedRoles != null && !ownedRoles.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="ownedRoles">
				<li class="horizontal ui-widget-content ui-corner-all" data-id='<s:property value="id" />'>
					<span class="text"><s:property value="name" /></span>
					<span class="click2remove verticalMiddle ui-icon ui-icon-close" title='<s:text name="title.click2remove"/>'></span>
				</li>
			</s:iterator>
			</ul>
			</s:if>	
		</div>
		<!-- 从上级组织继承的角色信息 -->
		<div id="inheritRolesFromOU" class="formTable2 ui-widget-content" >
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="actor.headerLabel.inheritRolesFromOU"/>：
					<s:if test="%{inheritRolesFromOU == null || inheritRolesFromOU.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
			</div>
			<s:if test="%{inheritRolesFromOU != null && !inheritRolesFromOU.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="inheritRolesFromOU">
				<li class="horizontal ui-widget-content ui-corner-all ui-state-disabled" data-id='<s:property value="id" />'>
					<span class="text2"><s:property value="name" /></span>
				</li>
			</s:iterator>
			</ul>
			</s:if>	
		</div>
		<!-- 从已分派岗位间接获取的角色 -->
		<div id="inheritRolesFromGroup" class="formTable2 ui-widget-content" >
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="actor.headerLabel.inheritRolesFromGroup"/>：
					<s:if test="%{inheritRolesFromGroup == null || inheritRolesFromGroup.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
			</div>
			<s:if test="%{inheritRolesFromGroup != null && !inheritRolesFromGroup.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="inheritRolesFromGroup">
				<li class="horizontal ui-widget-content ui-corner-all ui-state-disabled" data-id='<s:property value="id" />'>
					<span class="text"><s:property value="name" /></span>
				</li>
			</s:iterator>
			</ul>
			</s:if>	
		</div>
		<s:hidden name="e.type"/>
		<s:hidden name="e.inner" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="e.detail.id" />
		<s:hidden name="belong.id" />
		<input type="hidden" name="e.detail.createDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.detail.createDate" />'/>
		<s:hidden name="assignGroupIds" />
		<s:hidden name="assignRoleIds" />
	</s:form>
</div>
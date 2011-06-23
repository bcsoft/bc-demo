<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="group.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc/group/save" />'
	data-js='<s:url value="/bc/identity/group/form.js" />,<s:url value="/bc/identity/identity.js" />'
	data-initMethod='bc.groupForm.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.save"/>","click":"bc.groupForm.save"}],
		"width":618,"minWidth":250,"minHeight":250,"modal":false
	}'>
	<s:form name="groupForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0">
			<tbody>
				<tr>
					<td class="label">* <s:text name="label.name"/>:</td>
					<td class="value w200"><s:textfield name="e.name" data-validate="required"/></td>
					<td class="label">* <s:text name="actor.belong"/>:</td>
					<td class="value"><s:textfield name="belong.name" data-validate="required"
						readonly="true" title='%{getText("user.title.click2selectBelong")}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="label.code"/>:</td>
					<td class="value"><s:textfield name="e.code" data-validate="required"/></td>
					<td class="label"><s:text name="label.phone"/>:</td>
					<td class="value"><s:textfield name="e.phone" data-validate='{"type":"phone","required":false}'/></td>
				</tr>
				<tr>
					<td class="label">* <s:text name="label.order"/>:</td>
					<td class="value"><s:textfield name="e.orderNo" data-validate='required'/></td>
					<td class="label"><s:text name="label.email"/>:</td>
					<td class="value"><s:textfield name="e.email" data-validate='{"type":"email","required":false}'/></td>
				</tr>
			</tbody>
		</table>
		<!-- 包含的用户 -->
		<div id="assignUsers" class="formTable2 ui-widget-content" 
			data-removeTitle='<s:text name="title.click2remove"/>'>
			<div class="ui-state-active title" style="position:relative;">
				<span class="text"><s:text name="group.headerLabel.assignUsers"/>：
					<s:if test="%{ownedUsers == null || ownedUsers.isEmpty()}"><s:text name="label.empty"/></s:if>
				</span>
				<span id="addUsers" class="verticalMiddle ui-icon ui-icon-circle-plus" title='<s:text name="group.title.click2addUsers"/>'></span>
			</div>
			<s:if test="%{ownedUsers != null && !ownedUsers.isEmpty()}">
			<ul class="horizontal">
			<s:iterator value="ownedUsers">
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
		<s:hidden name="e.type"/>
		<s:hidden name="e.status" />
		<s:hidden name="e.inner" />
		<s:hidden name="e.uid" />
		<s:hidden name="e.id" />
		<s:hidden name="belong.id" />
		<s:hidden name="assignUserIds" />
		<s:hidden name="assignRoleIds" />
		<p class="formComment"><s:text name="group.form.comment"/></p>
	</s:form>
</div>
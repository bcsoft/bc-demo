<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="unitOrDepartment.title.select"/>'
	data-type='dialog' data-initMethod='bc.selectUnitOrDepartment.init'
	data-js='<s:url value="/bc/identity/department/select2.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectUnitOrDepartment.clickOk"}],
		"width":300,"modal":true
	}'>
	<div style="margin:4px;">
	<s:select name="es" list="es" listKey="id" listValue="name" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected"
		multiple="%{multiple}"></s:select>
	</div>
</div>
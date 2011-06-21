<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="bc-page" title='<s:text name="resource.title.select"/>'
	data-type='dialog' data-initMethod='bc.selectResource.init'
	data-js='<s:url value="/bc/identity/resource/select.js" />'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectResource.clickOk"}],
		"width":300,"modal":true
	}'>
	<div style="margin:4px;">
	<s:select name="es" list="es" listKey="id" listValue="name" theme="simple"
		size="10" cssStyle="width:100%;height:100%;" value="selected"
		multiple="%{multiple}"></s:select>
	</div>
</div>
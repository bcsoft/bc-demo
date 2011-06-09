<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title><s:text name="app.title" />
</title>
<link rel="stylesheet" type="text/css"
	href="<s:url value='/bc/libs/themes/default/login.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
</head>
<body>
	<table id="main" cellpadding="0" cellspacing="0" border="0">
		<tbody>
			<tr>
				<td id="imgTd">
					<div id="img"></div></td>
				<td id="inputTd">
					<div>
						<div class="label">帐号：</div>
						<div class="value">
							<input type="text" id="name" />
						</div>
						<div class="label">密码：</div>
						<div class="value">
							<input type="password" id="password" />
						</div>
					</div></td>
				<td id="btnTd">
					<button type="button" id="loginBtn">登录</button></td>
			</tr>
		</tbody>
	</table>
	<div id="msg"></div>
	<script type="text/javascript">
		var bc={};
		bc.root = "<%=request.getContextPath()%>";
		bc.debug = <s:text name="app.debug" />;
		bc.ts = bc.debug ? new Date().getTime() : "<s:text name="app.ts" />";
	</script>
	<script type="text/javascript"
		src="<s:url value='/ui-libs/jquery/1.5.1/jquery.min.js'/>"></script>
	<script type="text/javascript"
		src="<s:url value='/ui-libs/jshash/2.2/md5-min.js'/>"></script>
	<script type="text/javascript"
		src="<s:url value='/bc/login/login.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
</body>
</html>
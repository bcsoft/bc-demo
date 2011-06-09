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
<title><s:text name="app.title" /></title>
<script type="text/javascript">var ts = "<s:text name="app.ts" />";</script>
<link rel="stylesheet" type="text/css" href="<s:url value='/ui-libs/jquery-ui/1.8.13/themes/%{personalConfig.theme}/jquery-ui.css' />" />
<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/core.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/desktop.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/shortcuts.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/list.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/form.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/boxPointer.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/ui-libs/jquery-ui/plugins/menu/3.0/fg.menu.css' />" />
<style type="text/css">
	.fg-button { clear:left; margin:0 4px 40px 20px; padding: .4em 1em; text-decoration:none !important; 
	cursor:pointer; position: absolute; text-align: center; zoom: 1;top: 50%; left: 50%;}
	.fg-button .ui-icon { position: absolute; top: 50%; margin-top: -8px; left: 50%; margin-left: -8px; }
	.fg-button-icon-right { padding-right: 2.1em; }
	.fg-button-icon-right .ui-icon { left: auto; right: .2em; margin-left: 0; }
</style>
</head>
<body style='font-size:<s:property value="personalConfig.font" />px;'>
	<noscript>
		<div>请设置浏览器开启 JavaScript功能，然后重试。</div>
	</noscript>
	<div id="loader">正在加载......</div>
	<div id="setting">
		<div id="fontSliderContainer">
			<div style="margin-bottom:8px;">字体：<span id="fontSize">14</span>px</div>
			<div id="fontSlider"></div>
		</div>
		<div id="themeSwitcherContainer">
			<div id="themeSwitcher"></div>
		</div>
	</div>
	<div id="layout">
		<!-- 任务条 -->
		<table id="quickbar" class="" cellpadding="0" cellspacing="0" border="0">
			<tbody >
			<tr>
				<td id="quickStart"><a title="开始"></a></td>
				<td id="quickButtons">&nbsp;</td>
				<td id="quickLogout" title="点击注销并退出系统"><a>&nbsp;</a></td>
				<td id="quickShowHide" title="显示桌面"><a>&nbsp;</a></td>
			</tr>
			</tbody>
		</table>
		<!-- 桌面图标 -->
		<div id="desktop">
			<s:iterator value="shortcuts" status="stuts">
			<s:if test="module == null">
				<a class="shortcut" data-m="false"
					data-id='<s:property value="id" />'
					data-standalone='<s:property value="standalone" />'
					data-type='0' 
	 				data-mid='shortcut-<s:property value="id" />'
					data-option='{}' 
					data-order='<s:property value="order" />'
					data-iconClass='<s:property value="iconClass" />'
					data-name='<s:property value="name" />'
					data-url='<s:url value="%{url}" />'>
					<span class='icon <s:property value="iconClass" />'></span>
					<span class="text"><s:property value="name" /></span>
				</a>
            </s:if>
            <s:else>
				<a class="shortcut" data-m="true"
					data-id='<s:property value="id" />'
					data-standalone='<s:property value="standalone" />'
					data-type='<s:property value="module.type" />' 
	 				data-mid='<s:property value="module.id" />'
					data-option='<s:property value="module.option" />' 
					data-order='<s:property value="order" />'
					data-iconClass='<s:property value="module.iconClass" />'
					data-name='<s:property value="module.name" />'
					data-url='<s:url value="%{module.url}" />'>
					<span class='icon <s:property value="module.iconClass" />'></span>
					<span class="text"><s:property value="module.name" /></span>
				</a>
            </s:else>
			</s:iterator>
			<!-- 
			<a class="shortcut" data-mid="m03"
				data-type="2" data-url="/bc/duty/list"> <span class="icon i0001"></span>
				<span class="text">职务配置</span> </a>
			 -->
		</div>
	</div>
	<div id="rightPanel">
		<div class="item" id="indexCalendar"></div>
		<div class="item" id="bulletinBoard"></div>
	</div>
	<div id="copyrightBar"><a href="http://www.bctaxi.com.cn" target="_blank">Copyright ©2011 广州市宝城汽车出租有限公司</a></div>
	<div id="loginInfo">
	<s:property value="#session.user.name" />(<s:property value="#session.belong.name" />) 登录于  <s:date name="#session.loginTime" format="yyyy-MM-dd HH:mm"/>
	</div>
	<div id="quickStartMenu" class="hide" style="position:absolute; top:0; left:-9999px; width:1px; height:1px; overflow:hidden;">
		<s:property value="startMenu" escapeHtml="false"/>
	</div>
	
	<!-- 空白框架，通常用于下载附件 -->
	<iframe id="blank" name="blank" style="width:0; height:0; display:hidden;" src="about:blank" scrolling="no" frameborder="0"></iframe>

	<s:if test='{getText("app.debug") == "true"}'>
	<div id="heavyControl" style="display: none">
		<h1>重型控件测试</h1>
		<form>
			<p>
				<input value="普通文本" style="width: 90%;" />
			</p>
			<p>
				<input type="checkbox" />多选框1<input type="checkbox" />多选框2
			</p>
			<p>
				<input type="radio" name="radio" />单选框1<input type="radio"
					name="radio" />单选框2
			</p>
			<p>
				<select>
					<option>选择1</option>
					<option>选择2</option>
					<option>选择选择选择选择3</option>
				</select>
			</p>
			<p>
				<textarea style="width: 90%;">多行文本框</textarea>
			</p>
		</form>
	</div>
	</s:if>

	<script type="text/javascript" src="<s:url value='/ui-libs/jquery/1.5.1/jquery.min.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/ui-libs/jquery/plugins/metadata/jquery.metadata.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/ui-libs/jquery-ui/1.8.13/ui/minified/i18n/jquery-ui-i18n.min.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/ui-libs/jquery-ui/1.8.13/ui/minified/jquery-ui.min.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/ui-libs/jquery-ui/plugins/menu/3.0/fg.menu.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/core.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/ajax.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/msg.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/validate.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/page.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/toolbar.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/list.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/list.export.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/form.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/boxPointer.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/loader.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<s:if test='{getText("app.debug") == "true"}'>
	<link rel="stylesheet" type="text/css" href="<s:url value='/bc/libs/themes/default/logger.css' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>" />
	<script type="text/javascript" src="<s:url value='/bc/libs/logger.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript" src="<s:url value='/bc/libs/debug.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	</s:if>
	<s:else>
	<script type="text/javascript">
	if(!window['logger']){
		/** JavaScript日志组件的幻象，实际的见logger.js */
		window['logger'] = {
			debugEnabled:false,infoEnabled:false,warnEnabled:false,profileEnabled:false,
			clear:$.noop,debug:$.noop,info:$.noop,warn:$.noop,error:$.noop,
			profile:$.noop,enable:$.noop,disabled:$.noop,show:$.noop,test:true
		};
	}
	</script>
	</s:else>
	<script type="text/javascript" src="<s:url value='/bc/libs/desktop.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
	<script type="text/javascript">
		bc.root = "<%=request.getContextPath()%>";
		bc.debug = <s:text name="app.debug" />;
		if (bc.debug) {
			bc.ts = new Date().getTime();//首次打开主页的时间
			jQuery(function() {
				//logger.toggle();
				//logger.enable("debug");
			});
		}else{
			bc.ts = "<s:text name="app.ts" />";//系统编译发布的时间
		}
		var userCode = '<s:property value="#session.user.code" />';
		var userName = '<s:property value="#session.user.name" />';
	</script>
	<script type="text/javascript" src="<s:url value='/ui-libs/jquery-ui/themeSwitcher/switcher.js' ><s:param name='ts' value='%{getText("app.ts")}'/></s:url>"></script>
</body>
</html>
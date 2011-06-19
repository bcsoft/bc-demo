<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ taglib prefix="bc" uri="/bc-tags"%> --%>
<div title='附件控件设计' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-test/attach/tag.js" />'
	data-initMethod='bc.attachTagDesign.init'
	data-option='{"width":680,"minWidth":250,"minHeight":100,"modal":false}'>
	<s:form name="attachTagDesignForm" theme="simple">
		<div class="formAttachs ui-widget-content attachs" data-ptype="attach.main"
			 data-maxCount="2" data-maxSize="524288000" data-extends="doc,xls,docx,xlsx,png,mp3,mkv,avi,wmv">
			<div class="header">
				<span class="summary">2 个附件共 100KB</span>
				<span class="uploadFile">添加附件<input type="file" class="uploadFile" name="uploadFile" multiple/></span>
				<a href="#" class="operation" data-url="/bc/bc/attach/downloadAll">下载所有附件</a>
				<a href="#" class="operation" data-url="/bc/bc/attach/deleteAll">删除所有附件</a>
			</div>
			<table class="attach" cellpadding="0" cellspacing="0">
				<tr>
					<td class="icon"><span class="file-icon doc"></span></td>
					<td class="info">
						<div class="subject">附件名称</div>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td class="size">32KB</td>
								<td class="operations">
									<a href="#" class="operation" data-action="open">查看</a>
									<a href="#" class="operation" data-action="download">下载</a>
									<a href="#" class="operation" data-action="delete">删除</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table class="attach" cellpadding="0" cellspacing="0">
				<tr>
					<td class="icon"><span class="file-icon xls"></span></td>
					<td class="info">
						<div class="subject">附件名称</div>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td class="size">32KB</td>
								<td><div class="progressbar"></div></td>
								<td class="operations"><a href="#" class="operation" data-action="abort">取消</a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" name="e.uid" value='attach.uid'/>
	</s:form>
</div>
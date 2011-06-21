<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ taglib prefix="bc" uri="/bc-tags"%> --%>
<div title='附件控件设计' data-type='form' class="bc-page"
	data-js='<s:url value="/bc-test/attach/tag.js" />'
	data-initMethod='bc.attachTagDesign.init'
	data-option='{"width":680,"minWidth":250,"minHeight":100,"modal":false}'>
	<s:form name="attachTagDesignForm" theme="simple">
		<div class="formAttachs ui-widget-content attachs" 
			data-ptype="attach.main" 
			data-puid="attach.uid"
			data-maxCount="6" 
			data-maxSize="524288000" 
			data-extensions="pdf,txt,doc,xls,docx,xlsx,ppt,pptx,png,jpg,jpeg,gif,mp3,mkv,avi,wmv">
			<div class="header">
				<span class="summary"><span id="totalCount">0</span> 个附件共 <span id="totalSize" data-size="0">0</span></span>
				<span class="uploadFile">添加附件<input type="file" class="uploadFile" name="uploadFile" multiple/></span>
				<a href="#" class="operation" data-action="downloadAll">打包下载</a>
				<a href="#" class="operation" data-action="deleteAll">全部删除</a>
			</div>
			<table class="attach" cellpadding="0" cellspacing="0" data-size="32768">
				<tr>
					<td class="icon"><span class="file-icon doc"></span></td>
					<td class="info">
						<div class="subject">附件名称</div>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td class="size">32KB</td>
								<td class="operations">
									<a href="#" class="operation" data-action="inline" data-to="pdf" title="在线查看文档，需要浏览器支持直接浏览pdf文档的功能，如Chrome">在线查看</a>
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
						<table cellpadding="0" cellspacing="0" data-size="32768">
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
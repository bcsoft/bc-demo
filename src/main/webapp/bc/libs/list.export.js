/**
 * 列表视图插件：导出为Excel
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend list.js
 */
(function($) {

/**
 * 显示导出视图数据的配置界面-->用户选择-->导出excel
 * @param $grid 表格的jquery对象
 * @param el 导出按钮对应的dom元素
 */
bc.grid.export2Excel = function($grid,el) {
	//获取要导出的列名
	
	var html=[];
	html.push('<form name="exporter" method="post" style="margin:8px;">');
	
	//分页时添加“确认导出范围”
	var paging = $grid.find("li.pagerIconGroup.seek").size() > 0;
	if(paging){//分页
		html.push('<div style="height:22px;line-height:22px;font-size:14px;font-weight:bold;color:#333;">确认导出范围</div>'
			+'<ul style="list-style:none;margin:0;padding:0;">'
			+'<li style="margin:2px;_margin:0;">'
			+'<label for="exportScope1">'
			+'<input style="margin:2px 0;_margin:0;" type="radio" id="exportScope1" name="exportScope" value="1" checked>'
			+'<span style="margin:0 4px;_margin:0 2px;">当前页</span></label>'
			+'&nbsp;&nbsp;<label for="exportScope2">'
			+'<input style="margin:2px 0;_margin:0;" type="radio" id="exportScope2" name="exportScope" value="2">'
			+'<span style="margin:0 4px;_margin:0 2px;">全部</span></label></li>'
			+'</ul>');
	}
	
	//添加剩余的模板内容
	html.push('<div style="margin-top:8px;height:22px;line-height:22px;font-size:14px;font-weight:bold;color:#333;">选择导出字段</div>'
		+'<ul style="list-style:none;margin:0;padding:0;">{0}</ul>'
		+'<div style="padding:0 4px;text-align:right;">'
		+'<a id="continue" style="text-decoration:underline;cursor:pointer;">继续</a>&nbsp;&nbsp;'
		+'<a id="cancel" style="text-decoration:underline;cursor:pointer;">取消</a></div>'
		+'<input type="hidden" name="searchText">'
		+'<input type="hidden" name="exportKeys">'
		+'</form>');
	
	//获取列的定义信息
	var headerIds=[],headerNames=[];
	var fields = []
	var columns = $grid.find("div.header>div.right>table.table td");
	columns.each(function(i){
		var $this = $(this);
		headerIds.push($this.attr("data-id"));
		headerNames.push($this.attr("data-label"));
		fields.push('<li style="margin:2px;_margin:0;">'
			+'<label for="field'+i+'">'
			+'<input style="margin:2px 0;_margin:0;" type="checkbox" id="field'+i+'" name="field" value="'+headerIds[i]+'" checked>'
			+'<span style="margin:0 4px;_margin:0 2px;">'+headerNames[i]+'</span></label></li>');
	});
	html = html.join("").format(fields.join(""));
	
	//显示“确认导出”窗口
	var boxPointer = bc.boxPointer.show({
		of:el,dir:"top",close:"click",
		offset:"-8 -4",
		iconClass:null,
		content:html
	});
	
	//取消按钮
	boxPointer.find("#cancel").click(function(){
		boxPointer.remove();
		return false;
	});
	
	//继续按钮
	boxPointer.find("#continue").click(function(){
		var $page = $grid.parents(".bc-page");
		var url=$page.attr("data-namespace") + "/export";
		logger.info("export grid data by url=" + url);
		var data = {};
		
		//导出格式
		data.exporting=true;
		data.exportFormat="xls";
		
		//导出范围
		data.exportScope = boxPointer.find(":radio:checked[name='exportScope']").val();
		
		//分页参数
		var $pager_seek = $page.find("ul.pager>li.seek");
		if(paging && data.exportScope != "2"){//视图为分页视图，并且用户没有选择导出范围为"全部"
			data["page.pageNo"] = $pager_seek.find("#pageNo").text();
			data["page.pageSize"] = $pager_seek.parent().find("li.size>a.ui-state-active>span.pageSize").text();
		}
		
		//TODO 排序参数
		
		//将简单的参数附加到url后
		url += "?" + $.param(data);
		
		//附加要导出的列参数到隐藏域
		var $fields = boxPointer.find(":checkbox:checked[name='field']");
		if($fields.size() != columns.size()){//用户去除了部分的列没选择
			var t="";
			$fields.each(function(i){
				t+= (i == 0 ? "" : ",") + this.value;
			});
			boxPointer.find(":hidden[name='exportKeys']").val(t);
		}
		
		//附加搜索条件的参数到隐藏域(避免中文乱码) TODO 高级搜索
		var $search = $page.find(".bc-toolbar #searchText");
		if($search.size()){
			var searchText = $search.val();
			if(searchText && searchText.length > 0)
				boxPointer.find(":hidden[name='searchText']").val(searchText);
		}
		
		//提交表单
		var _form = boxPointer.find("form")[0];
		_form.action = url;
		_form.target = "blank";//这个需要在主页中配置一个名称为blank的iframe来支持
		_form.submit();
		
		//删除弹出的窗口
		boxPointer.remove();
		return false;
	});
};

})(jQuery);
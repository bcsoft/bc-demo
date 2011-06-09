/**
 * 列表视图的全局处理
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-05-25
 * @depend jquery-ui-1.8,bc.core
 */
(function($) {
bc.grid = {
	/**
	 * 表格型页面的初始化
	 * @param container 对话框内容的jquery对象
	 */
	init: function(container) {
		var $grid = container.find(".bc-grid");
		//滚动条处理
		$grid.find(".data .right").scroll(function(){
			//logger.info("scroll");
			container.find(".header .right").scrollLeft($(this).scrollLeft());
			container.find(".data .left").scrollTop($(this).scrollTop());
		});
		//记录表格的原始宽度
		var $data_table = $grid.find(".data .right .table");
		var originWidth = $data_table.width();
		$data_table.data("originWidth", originWidth);
		
		//绑定并触发一下对话框的resize事件
		//container.trigger("dialogresize");
		bc.grid.resizeGridPage(container);
		container.bind("dialogresize", function(event, ui) {
			bc.grid.resizeGridPage(container);
		})
		
		//禁止选择文字
		$grid.disableSelection();
	},
	/**
	 * 表格型页面改变对话框大小时的处理
	 * @param container 对话框内容的jquery对象
	 */
	resizeGridPage: function(container) {
		var $grid = container.find(".bc-grid");
		if($grid.size()){
			//data宽度
			var $data_right = $grid.find(".data .right");
			var $data_left = $grid.find(".data .left");
			var $header_right = $grid.find(".header .right");
			var sw = 0, sh = 0 ;//边框加补白的值
			if($.support.boxModel){
				sw = $grid.outerWidth()-$grid.width() + ($data_left.outerWidth()-$data_left.width());
				sh = $grid.outerHeight()-$grid.height();
			}
			$data_right.width(container.width()-$data_left.width()-sw);
			var $data_table = $data_right.find(".table");
			var originWidth = $data_table.data("originWidth");//原始宽度
			var clientWidth = $data_right[0].clientWidth;
			var newTableWidth = Math.max(originWidth, clientWidth);
			$data_table.width(newTableWidth);
			
			//其他元素高度累计
			var otherHeight = 0;
			$grid.siblings().each(function(){
				otherHeight += $(this).outerHeight(true);//累计表格兄弟的高度
			});
			$grid.height(container.height()-otherHeight-sh);//重设表格的高度
			$data_right.parent().siblings().each(function(){
				otherHeight += $(this).outerHeight(true);//再累计表格头和分页条的高度
			});
			
			//data高度(id列要减去data区的水平滚动条高度)
			$data_right.height(container.height()-otherHeight - sh);
			
			//如果导致滚动条切换显示了，再重新计算一下
			var _clientWidth = $data_right[0].clientWidth;
			if(_clientWidth != clientWidth){//从无垂直滚动条到出现滚动条的处理
				logger.info("clientWidth");
				$data_table.width(_clientWidth);
				newTableWidth = _clientWidth;
			}
			//header宽度(要减去data区的垂直滚动条宽度)
			$header_right.width($data_right[0].clientWidth);
			$header_right.find(".table").width(newTableWidth);
			
			$grid.find(".data .left").height($data_right[0].clientHeight);
		}
	},
	/**
	 * 对指定table的tbody的行数据进行排序
	 * @param $tbody table的tbody对应的jquery对象
	 * @param tdIndex 要进行排序的单元格在行中的索引号
	 * @param dir 排序的方向：1--正向，-1--反向
	 */
	sortTable: function($tbody,tdIndex,dir){
		var tbody = $tbody[0];
		var rows = tbody.rows;
		var trs = new Array(rows.length);
		for(var i=0;i<trs.length;i++){
			trs[i]=rows[i];//rows(i)
			trs[i].setAttribute("prevIndex",i);//记录未排序前的顺序
		}
		//数组排序
		trs.sort(function(tr1,tr2){
			var v1 = tr1.cells[tdIndex].innerHTML;
			var v2 = tr2.cells[tdIndex].innerHTML;
			//英文永远在中文前面，子chrome11测试不通过
			return dir * v1.localeCompare(v2);
		});
		//交换表格的行到新的顺序
		var t = [];
		var notFirefox = !$.browser.mozilla;
		for(var i=0;i<trs.length;i++){
			//firefox不支持outerHTML;
			t.push(notFirefox ? trs[i].outerHTML : document.createElement("div").appendChild(trs[i].cloneNode(true)).parentNode.innerHTML);
		}
		$tbody.html(t.join(""));
		//tbody.innerHTML = t.join("");//ie中不支持，tbody的innerHTML为只读
		
		return trs;//返回排好序的tr列表
	},
	/**重新加载表格的数据部分
	 * @param $page 页面dom的jquery对象
	 * @param option 特殊配置参数
	 * @option url 加载数据的url
	 * @option data 请求将附加的数据
	 * @option callback 请求数据完毕后的处理函数
	 */
	reloadData: function($page,option) {
		// 显示加载动画
		var $win = $page.parent();
		var $loader = $win.append('<div id="bc-grid-loader"></div>').find("#bc-grid-loader");
		$loader.css({
			top: ($win.height() - $loader.height())/2,
			left: ($win.width() - $loader.width())/2
		});
		
		option = option || {};
		var url=option.url || $page.attr("data-namespace") + "/data";
		logger.info("reloadWin:loading grid data from url=" + url);
		
		var data = option.data || {};
		
		//附加分页参数
		var $pager_seek = $page.find("ul.pager>li.seek");
		if($pager_seek.size()){
			data["page.pageNo"] = $pager_seek.find("#pageNo").text();
			data["page.pageSize"] = $pager_seek.parent().find("li.size>a.ui-state-active>span.pageSize").text();
		}
		
		//附加搜索条件的参数  TODO 高级搜索
		var $search = $page.find(".bc-toolbar #searchText");
		if($search.size()){
			var searchText = $search.val();
			if(searchText && searchText.length > 0)data.search = searchText;
		}
		
		//重新加载数据
		bc.ajax({
			url : url, data: data,
			dataType : "html",
			type: "POST",
			success : function(html) {
				var $data = $page.find(".bc-grid .data");
				$data.empty().replaceWith(html);//整个data更换
				bc.grid.init($page);
				
				//如果总页数变了，就更新一下
				//var newPageCount = $data.find(".left").attr("data-pageCount");
				var newPageCount = $data.attr("data-pageCount");
				if(newPageCount){
					var $pageCount = $page.find("#pageCount");
					if($pageCount.text() != newPageCount)
						$pageCount.text(newPageCount);
					//logger.info(newPageCount + "," + $pageCount.text());
				}
				
				//删除加载动画
				$loader.remove();
				
				//调用回调函数
				if(typeof option.callback == "function")
					option.callback.call($page[0]);
			}
		});
	}
};

//表格分页条按钮控制
$("ul .pagerIcon").live("mouseover", function() {
	$(this).addClass("ui-state-hover");
}).live("mouseout", function() {
	$(this).removeClass("ui-state-hover");
});
//点击扩展按钮
$("ul li.pagerIcon").live("click", function() {
	var $this = $(this);
	var action = $this.attr("data-action");//内定的操作
	var callback = $this.attr("data-callback");//回调函数
	callback = callback ? bc.getNested(callback) : undefined;//转换为函数
	var $page = $this.parents(".bc-page");
	switch (action){
	case "refresh"://刷新视图
		//重新加载列表数据
		bc.grid.reloadData($page);
		break;
	case "print"://打印视图
		window.print();
		break;
	case "export"://导出视图
		if(bc.grid.export2Excel)
			bc.grid.export2Excel($page.find(".bc-grid"),this);
		else
			alert("'bc.grid.export2Excel'未定义");
		break;
	default ://调用自定义的函数
		var click = $this.attr("data-click");
		if(typeof click == "string")
			click = bc.getNested(click);//将函数名称转换为函数
		if(typeof click == "function")
			click.call(pageEl,callback);
		break;
	}
	
	return false;
});
//点击分页按钮
$("ul li.pagerIconGroup.seek>.pagerIcon").live("click", function() {
	var $this = $(this);
	var $seek = $this.parent();
	var $pageNo = $seek.find("#pageNo");
	var curPageNo = parseInt($pageNo.text());
	var curPageCount = parseInt($seek.find("#pageCount").text());
	
	var reload = false;
	switch (this.id){
	case "toFirstPage"://首页
		if(curPageNo > 1){
			$pageNo.text(1);
			reload = true;
		}
		break;
	case "toPrevPage"://上一页
		if(curPageNo > 1){
			$pageNo.text(curPageNo - 1);
			reload = true;
		}
		break;
	case "toNextPage"://下一页
		if(curPageNo < curPageCount){
			$pageNo.text(curPageNo + 1);
			reload = true;
		}
		break;
	case "toLastPage"://尾页
		if(curPageNo < curPageCount){
			$pageNo.text(curPageCount);
			reload = true;
		}
		break;
	default :
		//do nothing
	}
	logger.info("reload=" + reload + ",id=" + this.id + ",curPageNo=" + curPageNo + ",curPageCount=" + curPageCount);
	
	//重新加载列表数据
	if(reload) bc.grid.reloadData($seek.parents(".bc-page"));
	
	return false;
});
//点击pageSize按钮
$("ul li.pagerIconGroup.size>.pagerIcon").live("click", function() {
	var $this = $(this);
	if($this.hasClass("ui-state-active")) return;//不处理重复的点击
	
	$this.addClass("ui-state-active").siblings().removeClass("ui-state-active");
	
	//重设置为第一页
	$this.parents("ul.pager").find("#pageNo").text(1);

	//重新加载列表数据
	bc.grid.reloadData($this.parents(".bc-page"));
	
	return false;
});
/*
//点击刷新按钮
$("ul #refresh").live("click", function() {
	//重新加载列表数据
	bc.grid.reloadData($(this).parents(".bc-page"));
});
//点击打印按钮
$("ul #print").live("click", function() {
	window.print();
});
*/

//单击行切换样式
$(".bc-grid>.data>.right tr.row").live("click",function(){
	var $this = $(this);
	var index = $this.toggleClass("ui-state-focus").index();
	$this.parents(".right").prev()
		.find("tr.row:eq("+index+")").toggleClass("ui-state-focus")
		.find("td.id>span.ui-icon").toggleClass("ui-icon-check");
});

//双击行执行编辑
$(".bc-grid>.data>.right tr.row").live("dblclick",function(){
	var $this = $(this);
	var index = $this.toggleClass("ui-state-focus",true).index();
	var $row = $this.parents(".right").prev()
		.find("tr.row:eq("+index+")").add(this);
	$row.toggleClass("ui-state-focus",true)
		.siblings().removeClass("ui-state-focus")
		.find("td.id>span.ui-icon").removeClass("ui-icon-check");
	$row.find("td.id>span.ui-icon").toggleClass("ui-icon-check",true);

	var $content = $this.parents(".ui-dialog-content");
	//alert($content.html());
	bc.page.edit.call($content);
});

//全选与反选
$(".bc-grid>.header td.id>span.ui-icon").live("click",function(){
	var $this = $(this).toggleClass("ui-icon-notice ui-icon-check");
	var check = $this.hasClass("ui-icon-check");
	$this.parents(".header").next().find("tr.row")
	.toggleClass("ui-state-focus",check)
	.find("td.id>span.ui-icon").toggleClass("ui-icon-check",check);
});

//列表的本地排序
$(".bc-grid>.header>.right tr.row>td.sortable").live("click",function(){
	logger.info("sortable");
	//标记当前列处于排序状态
	var $this = $(this).toggleClass("current",true);
	
	//将其他列的排序去除
	$this.siblings(".current").removeClass("current")
	.find("span.ui-icon").addClass("hide");
	
	var $icon = $this.find("span.ui-icon");
	//切换排序图标
	var dir = 0;
	if($icon.hasClass("ui-icon-triangle-1-n")){//正序
		$icon.removeClass("hide ui-icon-triangle-1-n").addClass("ui-icon-triangle-1-s");
		dir = -1;
	}else if($icon.hasClass("ui-icon-triangle-1-s")){//逆序
		$icon.removeClass("hide ui-icon-triangle-1-s").addClass("ui-icon-triangle-1-n");
		dir = 1;
	}else{
		$icon.removeClass("hide").addClass("ui-icon-triangle-1-s");//逆序
	}

	//排序列表中的行
	var $grid = $this.parents(".bc-grid");
	var tdIndex = this.cellIndex;//要排序的列索引
	var remoteSort = $grid.attr("remoteSort") === "true";//是否远程排序，默认本地排序
	if(remoteSort){//远程排序
		logger.profile("do remote sort");
		//TODO
		
		logger.profile("do remote sort");
	}else{//本地排序
		logger.profile("do local sort");
		//对数据所在table和id所在table进行排序
		var rightTrs = bc.grid.sortTable($grid.find(">.data>.right>table.table>tbody"), tdIndex, dir);
		
		//根据上述排序结果对id所在table进行排序
		var $tbody = $grid.find(">.data>.left>table.table>tbody");
		var rows = $tbody[0].rows;
		var trs = new Array(rows.length);
		for(var i=0;i<trs.length;i++){
			trs[i]=rows[parseInt(rightTrs[i].getAttribute("prevIndex"))];//rows(i)
		}
		//交换表格的行到新的顺序
		var t = [];
		var notFirefox = !$.browser.mozilla;
		for(var i=0;i<trs.length;i++){
			//firefox不支持outerHTML;
			t.push(notFirefox ? trs[i].outerHTML : document.createElement("div").appendChild(trs[i].cloneNode(true)).parentNode.innerHTML);
		}
		$tbody.html(t.join(""));
		
		logger.profile("do local sort");
	}
});

})(jQuery);
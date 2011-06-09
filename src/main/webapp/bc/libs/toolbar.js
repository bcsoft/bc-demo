/**
 * 工具条的全局处理
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-05-26
 * @depend jquery-ui-1.8,bc.core
 */
(function($) {

bc.toolbar = {
	/**执行搜索操作
	 * @param $page 页面dom的jquery对象
	 * @param option 
	 * @option action 
	 * @option callback 
	 * @option click 
	 */
	doSearch: function($page,option) {
		var action = option.action;//内定的操作
		var callback = option.callback;//回调函数
		callback = callback ? bc.getNested(callback) : undefined;//转换为函数

		switch (action){
		case "search"://内置的搜索处理
			//重设置为第一页
			$page.find("ul.pager #pageNo").text(1);
			
			//重新加载列表数据
			bc.grid.reloadData($page, callback);
			break;
		default ://调用自定义的函数
			var click = option.click;
			if(typeof click == "string")
				click = bc.getNested(click);//将函数名称转换为函数
			if(typeof click == "function")
				click.call($page[0],{callback:callback});
			break;
		}
	}
};
	
//顶部工具条按钮控制
$(".bc-toolbar .bc-button").live("mouseover", function() {
	$(this).addClass("ui-state-hover");
}).live("mouseout", function() {
	$(this).removeClass("ui-state-hover");
}).live("click", function() {
	var $this = $(this);
	var action = $this.attr("data-action");//内定的操作
	var callback = $this.attr("data-callback");//回调函数
	callback = callback ? bc.getNested(callback) : undefined;//转换为函数
	var pageEl = $this.parents(".bc-page")[0];
	switch (action){
	case "create"://新建--视图中
		bc.page.create.call(pageEl,callback);
		break;
	case "edit"://编辑----视图
		bc.page.edit.call(pageEl,callback);
		break;
	case "delete"://删除----视图
		bc.page.delete_.call(pageEl,callback);
		break;
	case "save"://保存----表单
		bc.page.save.call(pageEl,callback);
		break;
	case "cancel"://关闭对话框
		bc.page.cancel.call(pageEl,callback);
		break;
	default ://调用自定义的函数
		var click = $this.attr("data-click");
		if(typeof click == "string")
			click = bc.getNested(click);//将函数名称转换为函数
		if(typeof click == "function")
			click.call(pageEl,callback);
		break;
	}
});


//右侧的搜索框处理：回车执行搜索（TODO alt+enter执行本地搜索）
$(".bc-toolbar #searchText").live("keyup", function(e) {
	var $this = $(this);
	if(e.which == 13){//按下回车键
		var $page = $this.parents(".bc-page");
		var $search = $this.parent();
		bc.toolbar.doSearch($page,{
			action: $search.attr("data-action"),//内定的操作
			callback: $search.attr("data-callback"),//回调函数
			click: $search.attr("data-click")//自定义的函数
		});
	}
});
$(".bc-toolbar #searchBtn").live("click", function(e) {
	var $this = $(this);
	var $page = $this.parents(".bc-page");
	var $search = $this.parent();
	bc.toolbar.doSearch($page,{
		action: $search.attr("data-action"),//内定的操作
		callback: $search.attr("data-callback"),//回调函数
		click: $search.attr("data-click")//自定义的函数
	});
	
	return false;
});

})(jQuery);
bc.shortcutForm = {
	init : function() {
		var $form = $(this);
		//绑定选择图标样式的按钮事件处理
		$form.find("#selectIconClass,:input[name='e.iconClass']").click(function(){
			bc.page.newWin({
				url: bc.root + "/bc/shortcut/selectIconClass",
				name: "选择图标样式",
				mid: "selectShortcutIconClass",
				afterClose: function(iconClass){
					logger.info("iconClass=" + iconClass);
					if(iconClass){
						$form.find(":input[name='e.iconClass']").val(iconClass);
					}
				}
			});
		});
	}
};
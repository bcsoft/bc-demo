bc.roleForm = {
	init : function() {
		var $form = $(this);
		
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
			'<span class="text">{1}</span>'+
			'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';
		var title = $form.find("#assignModules").attr("data-removeTitle");
		//绑定添加模块的按钮事件处理
		$form.find("#addModules").click(function(){
			var data = "multiple=true";//可多选
			data += "&types=1&types=2&types=3&types=4";//可选择模块和连接
			var $ul = $form.find("#assignModules ul");
			var $lis = $ul.find("li");
			$lis.each(function(){
				data += "&selected=" + $(this).attr("data-id");//已选择的id
			});
			bc.identity.selectModule({
				data: data,
				onOk: function(modules){
					//添加当前没有分派的模块
					$.each(modules,function(i,module){
						if($lis.filter("[data-id='" + module.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + module.id + ",name=" + module.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($form.find("#assignModules"));
							}
							$(liTpl.format(module.id,module.name,title))
							.appendTo($ul).find("span.click2remove")
							.click(function(){
								$(this).parent().remove();
							});
						}
					});
				}
			});
		});

		//绑定删除角色的按钮事件处理
		$form.find("span.click2remove").click(function(){
			$(this).parent().remove();
		});
	},
	/**保存的处理*/
	save:function(){
		$page = $(this);
		//先将模块的id合并到隐藏域
		var ids=[];
		$page.find("#assignModules li").each(function(){
			ids.push($(this).attr("data-id"));
		});
		$page.find(":input[name=assignModuleIds]").val(ids.join(","));
		
		//调用标准的方法执行保存
		bc.page.save.call(this);
	}
};
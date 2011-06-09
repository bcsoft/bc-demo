bc.userForm = {
	init : function() {
		var $form = $(this);
		//绑定选择上级的按钮事件处理
		$form.find("#selectBelong,:input[name='belong.name']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='belong.id']").val();
			if(selected && selected.length > 0)
				data.selected = selected;
			
			bc.identity.selectUnitOrDepartment({
				data: data,
				onOk: function(actor){
					$form.find(":input[name='belong.name']").val(actor.name);
					$form.find(":input[name='belong.id']").val(actor.id);
				}
			});
		});
		
		var liTpl = '<li class="horizontal ui-widget-content ui-corner-all ui-state-highlight" data-id="{0}">'+
			'<span class="text">{1}</span>'+
			'<span class="click2remove verticalMiddle ui-icon ui-icon-close" title={2}></span></li>';
		var ulTpl = '<ul class="horizontal"></ul>';

		var title = $form.find("#assignGroups").attr("data-removeTitle");
		//绑定添加岗位的按钮事件处理
		$form.find("#addGroups").click(function(){
			var data = "multiple=true";//可多选
			var $ul = $form.find("#assignGroups ul");
			var $lis = $ul.find("li");
			$lis.each(function(){
				data += "&selected=" + $(this).attr("data-id");//已选择的岗位id
			});
			bc.identity.selectGroup({
				data: data,
				onOk: function(groups){
					//添加当前没有分派的岗位
					$.each(groups,function(i,group){
						if($lis.filter("[data-id='" + group.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + group.id + ",name=" + group.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($form.find("#assignGroups"));
							}
							$(liTpl.format(group.id,group.name,title))
							.appendTo($ul).find("span.click2remove")
							.click(function(){
								$(this).parent().remove();
							});
						}
					});
				}
			});
		});

		//绑定添加角色的按钮事件处理
		$form.find("#addRoles").click(function(){
			var data = "multiple=true";//可多选
			var $ul = $form.find("#assignRoles ul");
			var $lis = $ul.find("li");
			$lis.each(function(){
				data += "&selected=" + $(this).attr("data-id");//已选择的岗位id
			});
			bc.identity.selectRole({
				data: data,
				onOk: function(roles){
					//添加当前没有分派的岗位
					$.each(roles,function(i,role){
						if($lis.filter("[data-id='" + role.id + "']").size() > 0){//已存在
							logger.info("duplicate select: id=" + role.id + ",name=" + role.name);
						}else{//新添加的
							if(!$ul.size()){//先创建ul元素
								$ul = $(ulTpl).appendTo($form.find("#assignRoles"));
							}
							$(liTpl.format(role.id,role.name,title))
							.appendTo($ul).find("span.click2remove")
							.click(function(){
								$(this).parent().remove();
							});
						}
					});
				}
			});
		});

		//绑定删除岗位或角色的按钮事件处理
		$form.find("span.click2remove").click(function(){
			$(this).parent().remove();
		});
	},
	/**保存的处理*/
	save:function(){
		$page = $(this);
		//先将岗位和角色的id合并到隐藏域
		var ids=[];
		$page.find("#assignGroups li").each(function(){
			ids.push($(this).attr("data-id"));
		});
		$page.find(":input[name=assignGroupIds]").val(ids.join(","));
		ids=[];
		$page.find("#assignRoles li").each(function(){
			ids.push($(this).attr("data-id"));
		});
		$page.find(":input[name=assignRoleIds]").val(ids.join(","));
		
		//调用标准的方法执行保存
		bc.page.save.call(this);
	}
};
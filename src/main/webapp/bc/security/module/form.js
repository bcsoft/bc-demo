bc.moduleForm = {
	init : function() {
		var $form = $(this);
		//绑定选择隶属模块的按钮事件处理
		$form.find("#selectBelong,:input[name='e.belong.name']").click(function(){
			var data = {};
			var selected = $form.find(":input[name='e.belong.id']").val();
			var myId = $form.find(":input[name='e.id']").val();
			if(selected && selected.length > 0)
				data.selected = selected;
			if(myId && myId.length > 0)
				data.exclude = myId;
			
			bc.identity.selectModule({
				data: data,
				onOk: function(module){
					if(myId != module.id){
						$form.find(":input[name='e.belong.name']").val(module.name);
						$form.find(":input[name='e.belong.id']").val(module.id);
					}else{
						alert("不能选择自己作为自己的所属模块！");
					}
				}
			});
		});
		
		var urlText = $form.find("#urlText").attr("data-text");
		//绑定模块类型选择变动事件
		$form.find(":radio").change(function(){
			var $this = $(this);
			var type = $this.val()
			logger.info("select:" + this.id + "," + type);
			if(type == "5"){//操作--无需相关配置
				$form.find("td[data-name='iconClass'],td[data-name='option'],td[data-name='url']").hide();
				$form.find(":input[name='e.url']").removeAttr("data-validate");
				$form.find("#urlText").text(urlText + "：");
			}else{//链接
				$form.find("td[data-name='iconClass'],td[data-name='option'],td[data-name='url']").show();
				
				//如果是链接了类型，强制链接为必填域
				if(type == "2" || type == "3"){
					$form.find(":input[name='e.url']").attr("data-validate","required");
					$form.find("#urlText").text("* " + urlText + "：");
				}else{
					$form.find(":input[name='e.url']").removeAttr("data-validate");
					$form.find("#urlText").text(urlText + "：");
				}
			}
		});
		//以当前选中的选项触发一下change事件对界面做一下处理
		$form.find(":radio:checked").trigger("change");
		$form.find(":input[name='e.name']").focus();
		
		//绑定选择图标样式的按钮事件处理
		$form.find(":input[name='e.iconClass']").click(function(){
			bc.page.newWin({
				url: bc.root + "/bc/shortcut/selectIconClass",
				name: "选择图标样式",
				mid: "selectShortcutIconClass4Module",
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
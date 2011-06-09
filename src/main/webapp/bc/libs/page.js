/**
 * 表单及表格常用函数
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.page = {
	/**创建窗口
	 * @param {Object} option
	 * @option {String} url 地址
	 * @option {String} data 附加的数据
	 * @option {String} afterOpen 窗口新建好后的回调函数
	 * @option {String} afterClose 窗口关闭后的回调函数。function(event, ui)
	 * @option {String} beforeClose 窗口关闭前的回调函数，返回false将阻止关闭窗口。function(event, ui)
	 */
	newWin: function(option) {
		option = option || {};
		
		//在单独的浏览器窗口中打开
		if(option.standalone){
			logger.info("newWin:option.standalone=" + option.standalone);
			window.open(option.url,"_blank");
			return;
		}
		
		// 任务栏显示正在加载的信息
		if(bc.page.quickbar.has(option.mid)){
			logger.info("newWin:active=" + option.mid);
			bc.page.quickbar.active(option.mid);//仅显示现有的窗口
			return;
		}else{
			logger.info("newWin:create=" + option.mid);
			bc.page.quickbar.loading(option);
		}
		
		//内部处理
		logger.info("newWin:loading html from url=" + option.url);
		bc.ajax({
			url : option.url, data: option.data || null,
			dataType : "html",
			success : function(html) {
				logger.info("success loaded html");
				//var tc = document.getElementById("tempContainer");
				//if(!tc){
				//	tc=$('<div id="tempContainer"></div>').appendTo("body")[0];
				//}
				//tc.innerHTML=html;
				var $dom = $(html);
				if($dom.size() > 1){
					//logger.error("error page. try set theme='simple' for struts2 tag");
					alert("error page dom. try set theme='simple' for struts2 tag: size=" + $dom.size());
					$dom = $($dom[0]);
				}
				function _init(){
					//从dom构建并显示桌面组件
					var cfg = jQuery.parseJSON($dom.attr("data-option"));
					cfg.dialogClass=cfg.dialogClass || "bc-ui-dialog";// ui-widget-header";
					//cfg.afterClose=option.afterClose || null;//传入该窗口关闭后的回调函数
					if(!$dom.attr("title"))
						cfg.title=option.name;
					$dom.dialog(bc.page._rebuildWinOption(cfg));
					$dom.bind("dialogbeforeclose",function(event,ui){
						var status = $dom.data("data-status");
						//调用回调函数
						if(option.beforeClose) 
							return option.beforeClose(status);
					}).bind("dialogclose",function(event,ui){
						var status = $dom.data("data-status");
						//调用回调函数
						if(option.afterClose) option.afterClose(status);
						
						//彻底删除所有相关的dom元素
						$(this).dialog("destroy").remove();
						//删除任务栏对应的dom元素
						$(bc.page.quickbar.id).find(">a.quickButton[data-mid='" + option.mid + "']").unbind().remove();
					}).attr("data-src",option.url).attr("data-mid",option.mid)
					.bind("dialogfocus", function(event, ui) {
						//logger.debug("dialogfocus");
						var cur = $(bc.page.quickbar.id).find(">a.quickButton[data-mid='" + option.mid + "']");
						if(!cur.hasClass("ui-state-active"))
							cur.addClass("ui-state-active").siblings().toggleClass("ui-state-active",false);
					});
					//.disableSelection();这个会导致表单中输入框部分浏览器无法获取输入焦点
					
					var dataType = $dom.attr("data-type");
					if(dataType == "list"){//视图
						if($dom.find(".bc-grid").size()){//表格的额外处理
							bc.grid.init($dom);
						}
					}else if(dataType == "form"){//表单
						bc.form.init($dom);//如绑定日期选择事件等
					}
					
					//插入最大化|还原按钮、最小化按钮
					if(cfg.maximize !== false){
						//$dom.dialog(
					}
					
					//执行组件指定的额外初始化方法，上下文为$dom
					var method = $dom.attr("data-initMethod");
					logger.debug("initMethod="+method);
					if(method){
						method = bc.getNested(method);
						if(typeof method == "function"){
							method.call($dom, cfg);
						}else{
							alert("undefined function: " + $dom.attr("data-initMethod"));
						}
					}
					
					//通知任务栏模块加载完毕
					bc.page.quickbar.loaded(option.mid);
					
					//调用回调函数
					if(option.afterOpen) option.afterOpen();
				}
				//alert(html);
				var dataJs = $dom.attr("data-js");
				if(dataJs && dataJs.length > 0){
					//先加载js文件后执行模块指定的初始化方法
					dataJs = dataJs.split(",");//逗号分隔多个文件
					dataJs.push(_init);
					bc.load(dataJs);
				}else{
					//执行模块指定的初始化方法
					_init();
				}
			},
			error: function(request, textStatus, errorThrown) {
				var msg = "bc.ajax: textStatus=" + textStatus + ";errorThrown=" + errorThrown;
				logger.error(msg);
				alert(msg);
				
				//出错后通知任务栏模块加载完毕，避免长期显示加载动画
				bc.page.quickbar.loaded(option.mid);
			}
		});
	},
	/**
	 * 初始化表单或列表中的元数据信息：表单验证、列表的行操作处理
	 * 上下文为插入到对话框中的元素
	 * TODO 迁移到分散的组件文件中各自定义
	 */
	innerInit: function() {

	},
	_rebuildWinOption: function(option){
		var _option = option || {};
		if(_option.buttons){
			var btn;
			for(var i in _option.buttons){
				btn = _option.buttons[i];
				if(btn.action == "save"){//内部的表单保存
					btn.click = bc.page.save;
				}else if(btn.action == "cancel"){//关闭对话框
					btn.click = bc.page.cancel;
				}else if(btn.action == "create"){//新建
					btn.click = bc.page.create;
				}else if(btn.action == "delete"){//删除
					btn.click = bc.page.delete_;
				}else if(btn.action == "edit"){//编辑
					btn.click = bc.page.edit;
				}else if(btn.fn){//调用自定义函数
					btn.click = bc.getNested(btn.fn);
				}
				
				//如果click为字符串，当成是函数名称处理
				if(typeof btn.click == "string"){
					var c = btn.click;
					btn.click = bc.getNested(btn.click);
					if(!btn.click)
						alert("函数'"+c+"'没有定义！");
				}
			}
			//delete _option.buttons;
		}
		return _option;
	},
	/**保存表单数据，上下文为dialog的原始dom元素*/
	save: function(callback) {
		$this = $(this);
		var url=$this.attr("data-saveUrl");
		if(!url || url.length == 0){
			alert("Error:页面没有定义属性data-saveUrl的值");
			return;
		}
		logger.info("saveUrl=" + url);
		var $form = $("form",this);
		
		//表单验证
		if(!bc.validator.validate($form))
			return;
		
		//使用ajax保存数据
		var data = $form.serialize();
		bc.ajax({
			url: url, data: data, dataType: "json",
			success: function(json) {
				if(logger.debugEnabled)logger.debug("save success.json=" + jQuery.param(json));
				if(json.id){
					$form.find("input[name='e.id']").val(json.id);
				}
				//记录已保存状态
				$this.attr("data-status","saved").data("data-status","saved");
				
				//调用回调函数
				var showMsg = true;
				if(typeof callback == "function"){
					//返回false将禁止保存提示信息的显示
					if(callback.call($this[0],json) === false)
						showMsg = false;;
				}
				if(showMsg)
					bc.msg.slide(json.msg);
			}
		});
	},
	/**删除*/
	delete_: function() {
		var $this = $(this);
		var url=$this.attr("data-deleteUrl");
		var data=null;
		var $tds = $this.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
		if($tds.length == 1){
			data = "id=" + $tds.attr("data-id");
		}else if($tds.length > 1){
			data = "ids=";
			$tds.each(function(i){
				data += $(this).attr("data-id") + (i == $tds.length-1 ? "" : ",");
			});
		}
		if(logger.infoEnabled) logger.info("bc.page.delete_: data=" + data);
		if(data == null){
			bc.msg.slide("请先选择要删除的条目！");
			return;
		}
		bc.msg.confirm("确定要删除选定的 <b>"+$tds.length+"</b> 项吗？",function(){
			bc.ajax({
				url: url, data: data, dataType: "json",
				success: function(json) {
					if(logger.debugEnabled)logger.debug("delete success.json=" + jQuery.param(json));
					bc.msg.slide(json.msg);
					//重新加载列表
					bc.grid.reloadData($this);
				}
			});
		});
	},
	/**关闭表单对话框，上下文为dialog的原始dom元素*/
	cancel: function(option){
		$(this).dialog("destroy").remove();
	},
	/**新建表单*/
	create: function(callback){
		var $this = $(this);
		bc.page.newWin({
			url: $this.attr("data-createUrl"),
			mid: $this.attr("data-mid") + ".0",
			name: "新建" + ($this.attr("data-name") || "未定义"),
			afterClose: function(status){
				if(status)bc.grid.reloadData($this);
			},
			afterOpen: callback
		});
	},
	/**编辑*/
	edit: function(){
		var $this = $(this);
		var url = $this.attr("data-editUrl");
		var $tds = $this.find(".bc-grid>.data>.left tr.ui-state-focus>td.id");
		if($tds.length == 1){
			var data = "id=" + $tds.attr("data-id");
			bc.page.newWin({
				url:url, data: data || null,
				mid: $this.attr("data-mid") + "." + $tds.attr("data-id"),
				name: $tds.attr("data-name") || "未定义",
				afterClose: function(status){
					if(status == "saved")
						bc.grid.reloadData($this);
				}
			});
		}else if($tds.length > 1){
			bc.msg.slide("一次只可以编辑一条信息，请确认您只选择了一条信息！");
			return;
		}else{
			bc.msg.slide("请先选择要编辑的条目！");
			return;
		}
	}
};

jQuery(function($) {
	bc.page.innerInit();
});

bc.page.quickbar={
	id:"#quickButtons",
	/**  
	 * 判断指定的模块当前是否已经加载
	 * @param mid 模块的id
	 */
	has: function(mid){
		return $(bc.page.quickbar.id).find(">a.quickButton[data-mid='" + mid + "']").length > 0;
	},
	/**  
	 * 激活已经加载的现有模块
	 * @param mid 模块的id
	 */
	active: function(mid){
		$(".ui-dialog>.ui-dialog-content[data-mid='" + mid + "']").parent().show()
		.end().siblings().toggleClass("ui-state-active",false)
		.end().dialog("moveToTop");
	},
	/**  
	 * 设置指定的模块开始加载中
	 * @param option 模块的配置
	 */
	loading: function(option){
		$(bc.page.quickbar.id).append('<a id="quickButton-'+option.mid
				+'" class="quickButton ui-corner-all ui-state-default" data-mid="'+option.mid
				+'" data-name="'+option.name+'">'
				+'<span class="ui-icon loading"></span>'
				+'<span class="text">正在加载：'+option.name+'</span></a>');
	},
	/**  
	 * 设置指定的模块加载完毕
	 * @param mid 模块的id
	 */
	loaded: function(mid){
		var $item = $(bc.page.quickbar.id).find(">a.quickButton[data-mid='" + mid + "']");
		$item.find(">span.text").text($item.attr("data-name"));
		$item.find(">span.ui-icon").removeClass("loading").addClass("ui-icon-folder-open");
		$item.toggleClass("ui-state-active",true).siblings().toggleClass("ui-state-active",false);
	}
};
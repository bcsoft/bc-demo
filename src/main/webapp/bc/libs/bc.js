/**
 * 核心处理函数集
 *
 * @author rongjihuang@gmail.com
 * @date 2011-04-11
 * @dep jquery
 */

if(!window['bc'])window['bc']={};

/**
 * 字符串格式化处理函数
 * 使用方式：
 * 1) var t="({0}),FF{1}".format("value0","value1") -->t=(value0),FFvalue1
 * 2) var t=String.format("({0}),FF{1}","value0","value1") -->t=(value0),FFvalue1
 */
String.format=function(format){
	var args = Array.prototype.slice.call(arguments, 1);
	return (format+"").replace(/\{(\d+)\}/g, function(m, i){
        return args[i];
    });
};
String.prototype.format=function(){
    var args = arguments;
    return (this+"").replace(/\{(\d+)\}/g, function(m, i){
        return args[i];
    });
};

/**
 * 日期格式化处理函数
 * 对Date的扩展，将 Date 转化为指定格式的String
 * 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
 * 例子： 
 * (new Date()).format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
 * (new Date()).format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
 */
Date.format=function(_date){
	var args = Array.prototype.slice.call(arguments, 1);
	return _date.format.apply(_date,args);
};
Date.prototype.format = function(format){ 
  var o = {
    "M+" : this.getMonth()+1, //month 
    "d+" : this.getDate(),    //day 
    "h+" : this.getHours(),   //hour 
    "m+" : this.getMinutes(), //minute 
    "s+" : this.getSeconds(), //second 
    "q+" : Math.floor((this.getMonth()+3)/3),  //quarter 
    "S" : this.getMilliseconds() //millisecond 
  } 
  if(/(y+)/.test(format)) 
	  format=format.replace(RegExp.$1,(this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o)
	  if(new RegExp("("+ k +")").test(format)) 
		  format = format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
  return format; 
}

/** 获取新的唯一id值: var newId = bc.nextId();*/
bc.id=0;
bc.nextId=function(prefix){return (prefix ? prefix : "bc") + (bc.id++)};

/** 获取使用符号"."连接的嵌套对象,如a.b.c返回window[a][b][c]或eval(a.b.c) */
bc.getNested=function(nestedName){
	try{
		var names = nestedName.split(".");
		var result = window[names[0]];
		for(var i=1;i<names.length;i++)
			result = result[names[i]];
		return result;
	}catch(e){
		logger.error("error get:" + nestedName + ";e=" + e);
	}
};
/** 得到字符串的真实长度（双字节换算为两个单字节）*/
bc.getStringActualLen=function(sourceString){  
    return sourceString.replace(/[^\x00-\xff]/g,"xx").length;  
};
/** 向指定的url路径末端添加参数
 * @param url url路径
 * @param keyValue 名值对，格式为“key=value”
 * @return 添加参数/值后的url
 */
bc.addParamToUrl=function(url,keyValue){  
    if (url == null) return url;
    if (!keyValue) return url;
    var hasParam = (url.indexOf("?") != -1);
    if(url.indexOf("ts=0") != -1){//强制不添加ts的配置
    	return url;
    }else{
    	return url + (hasParam?"&":"?") + keyValue;
    }
};

/** 
 * 格式化数字显示方式  
 * 用法 
 * bc.formatNumber(12345.999,'#,##0.00'); 
 * bc.formatNumber(12345.999,'#,##0.##'); 
 * bc.formatNumber(123,'000000'); 
 * @param num 
 * @param pattern 
 */  
bc.formatNumber = function(num, pattern) {
	var strarr = num ? num.toString().split('.') : [ '0' ];
	var fmtarr = pattern ? pattern.split('.') : [ '' ];
	var retstr = '';

	// 整数部分  
	var str = strarr[0];
	var fmt = fmtarr[0];
	var i = str.length - 1;
	var comma = false;
	for ( var f = fmt.length - 1; f >= 0; f--) {
		switch (fmt.substr(f, 1)) {
		case '#':
			if (i >= 0)
				retstr = str.substr(i--, 1) + retstr;
			break;
		case '0':
			if (i >= 0)
				retstr = str.substr(i--, 1) + retstr;
			else
				retstr = '0' + retstr;
			break;
		case ',':
			comma = true;
			retstr = ',' + retstr;
			break;
		}
	}
	if (i >= 0) {
		if (comma) {
			var l = str.length;
			for (; i >= 0; i--) {
				retstr = str.substr(i, 1) + retstr;
				if (i > 0 && ((l - i) % 3) == 0)
					retstr = ',' + retstr;
			}
		} else
			retstr = str.substr(0, i + 1) + retstr;
	}

	retstr = retstr + '.';
	// 处理小数部分  
	str = strarr.length > 1 ? strarr[1] : '';
	fmt = fmtarr.length > 1 ? fmtarr[1] : '';
	i = 0;
	for ( var f = 0; f < fmt.length; f++) {
		switch (fmt.substr(f, 1)) {
		case '#':
			if (i < str.length)
				retstr += str.substr(i++, 1);
			break;
		case '0':
			if (i < str.length)
				retstr += str.substr(i++, 1);
			else
				retstr += '0';
			break;
		}
	}
	return retstr.replace(/^,+/, '').replace(/\.$/, '');
}
/**
 * 对$.ajax的通用封装
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.ajax = function(option){
	option = option || {};
	$.extend(option,{
		type: "POST",
		error: function(request, textStatus, errorThrown) {
			var msg = "bc.ajax: textStatus=" + textStatus + ";errorThrown=" + errorThrown;
			logger.error(msg);
			alert(msg);
		}
	});
	jQuery.ajax(option);
};
/**
 * 消息框控件
 *
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 * @dep jqueryui-dialog
 */
bc.msg = {
	id:0,
	
	/** 默认的对话框常数定义 */
	DEFAULT_TITLE: "系统提示",
	OK: "确定",
	CANCEL: "取消",
	YES: "是",
	NO: "否",
	
    /** 提示框 
     * @param {String} msg 提示信息
     * @param {String} onOk [可选]点击确认按钮的回调函数
     * @param {String} title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
     * @param {String} icon [可选]显示的图标类型：error,question,info,warning，默认不显示图标
     */
    alert: function(msg, title, onOk, icon){
    	$('<div data-type="msg" id="msg-' + (bc.msg.id++) + '">' + (msg || 'no message.') + '</div>').dialog({
			modal: true, title: title || bc.msg.DEFAULT_TITLE
		}).bind("dialogclose",function(event,ui){
			$(this).dialog("destroy").remove();//彻底删除所有相关的dom元素
			if(typeof onOk == "function")
				onOk.call();
		});
    },
    /** 确认框 
     * @param {String} msg 提示信息
     * @param {String} onOk 点击确认|是按钮的回调函数
     * @param {String} onCancel [可选]点击取消|否按钮的回调函数
     * @param {String} title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
     */
    confirm: function(msg, onOk, onCancel, title){
    	$('<div data-type="msg" id="msg-' + (bc.msg.id++) + '">' + (msg || 'no message.') + '</div>').dialog({
			modal: true, title: title || bc.msg.DEFAULT_TITLE,
			buttons:[
			    {
			    	text:bc.msg.YES,
			    	click:function(){
			    		if(typeof onOk == "function"){
			    			if(onOk.call() !== false){//不保留窗口
			    				$(this).dialog("destroy").remove();
			    			}
			    		}else{
			    			$(this).dialog("destroy").remove();
			    		}
			    	}
			    },{
			    	text:bc.msg.NO,
			    	click:function(){
			    		$(this).dialog("destroy").remove();
			    		if(typeof onCancel == "function")
			    			onCancel.call();
			    	}
			    }]
		}).bind("dialogclose",function(event,ui){
			$(this).dialog("destroy").remove();//彻底删除所有相关的dom元素
			if(typeof onCancel == "function")
				onCancel.call();
		});
    },
    /** 输入框 
     * @param {String} msg 提示信息
     * @param {String} onOk 点击确认按钮的回调函数
     * @param {String} onCancel [可选]点击取消按钮的回调函数
     * @param {String} value [可选]文本输入框默认显示的内容
     * @param {Boolean} multiline [可选]是否为多行文本输入，默认为false(单行文本输入)
     * @param {String} title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
     * @param {Boolean} isPassword [可选]是否是密码输入框，默认为false(文本输入框)，只有在multiline为非true的情况下有效
     * @param {Boolean} showIcon [可选]是否显示图标，默认为false(不显示)
     */
    prompt: function(msg, onOk, onCancel, value, multiline, title, isPassword, showIcon){
    	$.messager.prompt(title||OZ.Messager.DEFAULT_TITLE, msg, 
    		function(value,isOk,oldValue){
	    		if (isOk){
	    			if(typeof onOk == "function") onOk.call(this,value,oldValue);
	    		}else{
	    			if(typeof onCancel == "function") onCancel.call(this,value,oldValue);
	    		}
    		},
    		value, multiline, isPassword, showIcon
    	);
    },
    /** 信息提示框：提示框icon=info的简化使用版 */
    info: function(msg, title, onOk){
    	alert("TODO");
    },
    /** 信息警告框：提示框icon=warning的简化使用版 */
    warn: function(msg, title, onOk){
    	alert("TODO");
    },
    /** 错误提示框：提示框icon=error的简化使用版 */
    error: function(msg, title, onOk){
    	alert("TODO");
    },
    /** 信息提问框：提示框icon=question的简化使用版 */
    question: function(msg, title, onOk){
    	alert("TODO");
    },
    /** 自动提醒框：显示在页面右下角并可以自动隐藏的消息提示框 */
    show: function(config){
    	alert("TODO");
    },
    /** 自动提醒框的slide简化使用版:滑出滑入效果 */
    slide: function(msg,timeout,width,height){
    	//构造容器
    	var me = $('<div class="bc-slide ui-widget ui-state-highlight ui-corner-all"><div class="content"></div></div>');
    	me.find(".content").append(msg || 'undefined message!');
    	//显示
    	me.hide().appendTo("body").slideDown("fast",function(){
			//自动隐藏
			setTimeout(function(){
		    	me.slideUp("slow",function(){
		    		me.unbind().remove();
				});
			},timeout || 2000);
		});
    },
    /** 自动提醒框的fade简化使用版：渐渐显示消失效果 */
    fade: function(msg,timeout,width,height){
    	alert("TODO");
    },
    /** 自动提醒框的show简化使用版：从角落飞出飞入效果 */
    fly: function(msg,timeout,width,height){
    	alert("TODO");
    }
};
/**
 * 表单验证常用函数
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.validator = {
	/**
	 * 表单验证
	 * <input ... data-validate='{required:true,type:"number",max:10,min:5}'/>
	 * type的值控制各种不同的验证方式：
	 * 1) undefined或required 最简单的必填域验证，值不为空即可
	 * 2) number 数字(正数、负数、小数)
	 * 3) digits 整数
	 * 4) email 电子邮件 TODO
	 * 5) url 网址 TODO
	 * 6) date 日期 TODO
	 * 7) datetime 日期时间 TODO
	 * 8) time 时间 TODO
	 * 9) phone 电话号码
	 * min的值控制数字的最小值
	 * max的值控制数字的最大值
	 * minLen的值控制字符串的最小长度(中文按两个字符长度计算)
	 * maxLen的值控制字符串的最大长度(中文按两个字符长度计算)
	 * 如果无需配置其他属性，type的值可以直接配置为validate的值，如<input ... data-validate="number"/>
	 * required的值控制是否必须填写true|false
	 * @$form 表单form的jquery对象
	 */
	validate: function($form) {
		var ok = true;
		$form.find(":input:enabled:not(:hidden):not(:button)")
		.each(function(i, n){
			var validate = $(this).attr("data-validate");
			if(logger.debugEnabled)
				logger.debug(this.nodeName + "," + this.name + "," + this.value + "," + validate);
			if(validate && $.trim(validate).length > 0){
				if(!/^\{/.test(validate)){//不是以字符{开头
					validate = '{"required":true,"type":"' + validate + '"}';//默认必填
				}
				validate = jQuery.parseJSON(validate);
				var method = bc.validator.methods[validate.type];
				if(method){
					var value = $(this).val();
					if(validate.required || (value && value.length > 0)){//必填或有值时
						ok = method.call(validate, this, $form);
						if(!ok){//验证不通过，增加界面的提示
							bc.validator.remind(this,validate.type);
						}
					}
					return ok;
				}else{
					logger.error("undefined method: bc.validator.methods['" + validate.type + "']");
				}
			}
		});
		return ok;
	},
	/**各种验证方法，可以自行扩展新的验证方法，方法的上下文为对象的验证配置*/
	methods:{
		/**必填*/
		required: function(element, $form) {
			switch( element.nodeName.toLowerCase() ) {
			case 'select':
				// could be an array for select-multiple or a string, both are fine this way
				var val = $(element).val();
				return val && val.length > 0;
			case 'input':
				if(/radio|checkbox/i.test(element.type)){//多选和单选框
					return $form.find("input:checked[name='" + element.name + "']").length > 0;
				}
			default:
				return $.trim($(element).val()).length > 0;
			}
		},
		/**数字*/
		number: function(element) {
			return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(element.value);
		},
		/**电话号码与手机号码同时验证
		 * 匹配格式：11位手机号码;3-4位区号、7-8位直播号码、1－4位分机号
		 */
		phone: function(element) {
			return /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/.test(element.value);
		},
		/**正数*/
		digits: function(element) {
			return /^\d+$/.test(element.value);
		},
		/**字符串最小长度*/
		minLen: function(element) {
			return bc.getStringActualLen(element.value) >= this.minLen;
		},
		/**字符串最大长度*/
		maxLen: function(element) {
			return bc.getStringActualLen(element.value) <= this.maxLen;
		},
		/**最小值*/
		min: function(element) {
			return element.value >= this.minValue;
		},
		/**最大值*/
		max: function(element) {
			return element.value <= this.maxValue;
		},
		/**email*/
		email: function(element) {
			return /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/.test(element.value);
		}
	},
	/**
	 * 显示验证不通过的提示信息
	 * @element 验证不通过的dom元素
	 * @validateType 验证的类型
	 */
	remind: function(element,validateType){
		bc.boxPointer.show({of:element,content:bc.validator.messages[validateType]});
	},
	messages:{
		required:"这里必须填写哦！",
		number: "这里必须填写数字哦！<br>如 12、1.2。",
		digits: "这里必须填写整数哦！<br>如 12。",
		email: "请输入正确格式的电子邮件！<br>如 bc@163.com。",
		phone: "请输入正确格式的电话号码！<br>如 13011112222、88887777、88887777-800、020-88887777-800。",
		url: "请输入正确格式的网址！<br>如 http://www.google.com。",
		date: "请输入正确格式的日期！<br>如 2011-01-01。",
		datetime: "请输入正确格式的日期时间！<br>如 2011-01-01 13:30。",
		time: "请输入正确格式的时间！<br>如 13:30。",
		maxLen: "这里至少需要输入 {0}个字符！",
		minLen: "这里最多只能输入 {0}个字符！",
		max: "这个值不能小于 {0}！",
		min: "这个值不能大于 {0}！"
	}
};
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
						var $this = $(this);
						var status = $dom.data("data-status");
						//调用回调函数
						if(option.afterClose) option.afterClose(status);
						
						//在ie9，如果内涵<object>,$this.remove()会报错,故先处理掉object
						//ie8试过没问题
						if(jQuery.browser.msie && jQuery.browser.version >= 9){
							logger.info("IE9坑爹啊");
							$this.find("object").each(function(){
								this.parentNode.innerHTML="";
							});
						}
						//彻底删除所有相关的dom元素
						$this.dialog("destroy").remove();
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
				}else if(btn.action == "preview"){//预览xheditor的内容
					btn.click = bc.page.preview;
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
	edit: function(readOnly){
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
			bc.msg.slide(!readOnly ? "一次只可以编辑一条信息，请确认您只选择了一条信息！" : "一次只可以查看一条信息，请确认您只选择了一条信息！");
			return;
		}else{
			bc.msg.slide(!readOnly ? "请先选择要编辑的信息！" : "请先选择要查看的信息！");
			return;
		}
	},
	/**预览xheditor的内容*/
	preview: function(){
		$(this).find(".bc-editor").xheditor({tools:'mini'}).exec("Preview");
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
		//var $data_table = $grid.find(".data .right .table");
		//var originWidth = parseInt($data_table.attr("originWidth"));
		//$data_table.data("originWidth", originWidth);
		//logger.info("originWidth:" + originWidth);
		
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
			var $data_right = $grid.find(".data .right");
			var $data_left = $grid.find(".data .left");
			var $header_right = $grid.find(".header .right");
			
			//边框加补白的值
			var sw = 0, sh = 0 ;
			if($.support.boxModel){
				sw = $grid.outerWidth()-$grid.width() + ($data_left.outerWidth()-$data_left.width());
				sh = $grid.outerHeight()-$grid.height();
			}
			
			//设置右容器的宽度
			$data_right.width(container.width()-$data_left.width()-sw);
			$header_right.width($data_right[0].clientWidth);//当缩小宽度时，因float，会换行导致高度增高，故在设置高度前必须设置一下
			
			//设置右table的宽度
			var $data_table = $data_right.find(".table");
			var $header_table = $header_right.find(".table");
			var originWidth = parseInt($data_table.attr("originWidth"));//$data_table.data("originWidth");//原始宽度
			var clientWidth = $data_right[0].clientWidth;
			var newTableWidth = Math.max(originWidth, clientWidth);
			$data_table.width(newTableWidth);
			$header_table.width(newTableWidth);
			logger.info("originWidth=" + originWidth);
			logger.info("newTableWidth=" + newTableWidth);
			
			//累计表格兄弟的高度
			var otherHeight = 0;
			$grid.siblings().each(function(i){
				otherHeight += $(this).outerHeight(true);
				logger.info(i + ":" + $(this).outerHeight(true));
			});
			
			//重设表格的高度
			$grid.height(container.height()-otherHeight-sh);
			
			//再累计表格头和分页条的高度
			$data_right.parent().siblings().each(function(i){
				otherHeight += $(this).outerHeight(true);
			});
			
			//data右容器高度
			$data_right.height(container.height()-otherHeight - sh);
			
			//如果设置data右容器高度后导致垂直滚动条切换显示了，须额外处理一下
			var _clientWidth = $data_right[0].clientWidth;
			if(_clientWidth != clientWidth){//从无垂直滚动条到出现滚动条的处理
				//logger.info("clientWidth");
				//$data_table.width(_clientWidth);
				//newTableWidth = _clientWidth;
				$header_right.width($data_right[0].clientWidth);
			}
			
			//header宽度(要减去data区的垂直滚动条宽度)
			//$header_right.width($data_right[0].clientWidth);
			//$header_right.find(".table").width(newTableWidth);
			
			//data左容器高度(要考虑data右容器水平滚动条高度)
			$grid.find(".data .left").height($data_right[0].clientHeight);
			
			logger.info(":::" + $grid.find(".header").outerHeight(true)  + "," + $grid.find(".header")[0].clientHeight);
			logger.info("width2:" + $data_table.width());
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
		
		//附加排序参数
		var $sortColumn = $page.find(".bc-grid .header .table td.sortable.asc,.bc-grid .header .table td.sortable.desc");
		if($sortColumn.size()){
			var sort = "";
			var $t;
			$sortColumn.each(function(i){
				$t = $(this);
				sort += (i == 0 ? "" : ",") + $t.attr("data-id") + ($t.hasClass("asc") ? " asc" : " desc");
			});
			data["sort"] = sort;
		}
		
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
	case "changeSortType"://切换本地排序和远程排序
		$this.toggleClass("ui-state-active");
		if($this.hasClass("ui-state-active")){
			$this.attr("title",$this.attr("title4clickToLocalSort"));
			$this.parents(".bc-grid").attr("remoteSort","true");
		}else{
			$this.attr("title",$this.attr("title4clickToRemoteSort"));
			$this.parents(".bc-grid").attr("remoteSort","false");
		}
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

//列表的排序
$(".bc-grid>.header>.right tr.row>td.sortable").live("click",function(){
	logger.info("sortable");
	//标记当前列处于排序状态
	var $this = $(this).toggleClass("current",true);
	
	//将其他列的排序去除
	$this.siblings(".current").removeClass("current asc desc")
	.find("span.ui-icon").addClass("hide").removeClass("ui-icon-triangle-1-n ui-icon-triangle-1-s");
	
	var $icon = $this.find("span.ui-icon");
	//切换排序图标
	var dir = 0;
	if($this.hasClass("asc")){//正序变逆序
		$this.removeClass("asc").addClass("desc");
		$icon.removeClass("hide ui-icon-triangle-1-n").addClass("ui-icon-triangle-1-s");
		dir = -1;
	}else if($this.hasClass("desc")){//逆序变正序
		$this.removeClass("desc").addClass("asc");
		$icon.removeClass("hide ui-icon-triangle-1-s").addClass("ui-icon-triangle-1-n");
		dir = 1;
	}else{//无序变正序
		$this.addClass("asc");
		$icon.removeClass("hide").addClass("ui-icon-triangle-1-n");
		dir = 1;
	}

	//排序列表中的行
	var $grid = $this.parents(".bc-grid");
	var tdIndex = this.cellIndex;//要排序的列索引
	var remoteSort = $grid.attr("remoteSort") === "true";//是否远程排序，默认本地排序
	if(remoteSort){//远程排序
		logger.profile("do remote sort:");
		bc.grid.reloadData($grid.parents(".bc-page"),{
			callback:function(){
				logger.profile("do remote sort:");
			}
		});
	}else{//本地排序
		logger.profile("do local sort:");
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
		
		logger.profile("do local sort:");
	}
});

})(jQuery);
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
		+'<input type="hidden" name="search">'
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
				boxPointer.find(":hidden[name='search']").val(searchText);
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
/**
 * 表单的全局处理
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.form = {
	/** 全局初始化表单元素的事件绑定,
	 * 在表单加载后由系统自动调用进行绑定，
	 * 函数的第一参数为表单元素的容器对象
	 */
	init : function($form) {
		logger.info("bc.form.init");
		//选择日期
		$form.find('.bc-date[readonly!="readonly"]').datepicker({
			showWeek: true,
			//showButtonPanel: true,//现时今天按钮
			firstDay: 7,
			dateFormat:"yy-mm-dd"//yy4位年份、MM-大写的月份
		});
		
		//flash上传附件
		$form.find(".attachs.flashUpload").has(":file.uploadFile").each(function(){
			bc.attach.flash.init.call(this);
		});
	}
};
/**
 * BoxPointer控件
 *
 * @author rongjihuang@gmail.com
 * @date 2011-05-04
 * @dep jquery
 */
bc.boxPointer = {
	id:0,
	
	/** 默认的 */
	TPL: '<div class="boxPointer ui-widget ui-state-error ui-corner-all"><div class="content"></div><s class="pointerBorder"><i class="pointerColor"></i></s></div>',
	OK: "确定",
	CANCEL: "取消",
	CSS_TOP:{},
	
    /** 提示框 
     * @param {Object} option 配置对象
     * @param {option} dir 箭头的指向，默认为auto,可强制top、bottom、left、right 4个方向
     * @param {option} content 显示的内容
     * @param {option} close 关闭方式：click--默认的点击关闭、auto--自动关闭(5秒后)、[number]--多少毫秒后关闭
     * @param {option} my 参考position插件
     * @param {option} at 参考position插件
     * @param {option} of 参考position插件
     * @param {option} offset 参考position插件
     */
    show: function(option){
    	option = $.extend({
    		close:"auto",
    		dir:"bottom",
    		content:"undefined content!",
    		of: document.body,
    		iconClass: "ui-icon-alert"
    	},option);
		var target = $(option.of);
		
		var id = bc.boxPointer.id++;
		
		//附加bpid到dom中
		target.data("bpid",id);

		//自动生成容器
		var boxPointer = $(bc.boxPointer.TPL).appendTo("body").attr("id","boxPointer"+id);
		
		//添加关闭按钮
		if(option.close == "click"){
			boxPointer.append('<a href="#" class="close ui-state-default ui-corner-all"><span class="ui-icon ui-icon-closethick"></span></a>')
			.find("a.close")
			.click(function(){
				$(this).parent().unbind().remove();
				return false;
			}).hover(
			  function () {
			    $(this).addClass("ui-state-hover");
			  },
			  function () {
			    $(this).removeClass("ui-state-hover");
			  }
			);
		}else{
			if(option.close == "auto")
				option.close = 5000;
			
			//自动关闭
			setTimeout(function(){
				boxPointer.unbind().hide("fast",function(){
					//移除之前记录到dom中的bpid
					target.removeData("bpid");
					//彻底删除元素
					boxPointer.remove();
				});
			},option.close);
		}
		
		//添加内容
		var content = boxPointer.find(".content");
		if(option.iconClass)
			content.append('<span class="ui-icon '+option.iconClass+'" style="float:left;margin-right:.3em;;margin-top:.2em;"></span>')//图标
		content.append(option.content);//内容
		
		//控制小箭头的生成及定位
		var p={};
		var borderColor = boxPointer.css("border-top-color");
		var backColor = boxPointer.css("background-color");
		if(logger.debugEnabled)logger.debug("border-color=" + borderColor + ",background-color=" + backColor);
		var pointerBorder = boxPointer.find(".pointerBorder").css({
			"border-color": "transparent",
			"border-style": "dashed"
		});
		var pointerColor = boxPointer.find(".pointerColor").css({
			"border-color": "transparent",
			"border-style": "dashed"
		});
		if(option.dir=="top"){
			p.my="left bottom";
			p.at="left top";
			p.offset = option.offset || "0 -4";
			//border颜色设置为与boxPointer的边框色相同
			pointerBorder.css({
				"border-top-color": borderColor,
				"border-top-style": "solid",
				"bottom": "-20px","left": "10px"
			});
			//border颜色设置为与boxPointer的背景色相同
			pointerColor.css({
				"border-top-color": backColor,
				"border-top-style": "solid",
				"bottom": "-9px","left": "-10px"
			});
		}else if(option.dir=="right"){
			p.my="left top";
			p.at="right top";
			p.offset = option.offset || "4 -10";
			//border颜色设置为与boxPointer的边框色相同
			pointerBorder.css({
				"border-right-color": borderColor,
				"border-right-style": "solid",
				"top": "10px","left": "-20px"
			});
			//border颜色设置为与boxPointer的背景色相同
			pointerColor.css({
				"border-right-color": backColor,
				"border-right-style": "solid",
				"top": "-10px","left": "-9px"
			});
		}else if(option.dir=="left"){
			p.my="right top";
			p.at="left top";
			p.offset = option.offset || "-4 -10";
			//border颜色设置为与boxPointer的边框色相同
			pointerBorder.css({
				"border-left-color": borderColor,
				"border-left-style": "solid",
				"top": "10px","right": "-20px"
			});
			//border颜色设置为与boxPointer的背景色相同
			pointerColor.css({
				"border-left-color": backColor,
				"border-left-style": "solid",
				"top": "-10px","right": "-9px"
			});
			boxPointer.find("a.close").css({
				"left":"-8px",
				"right":"auto"
			});
		}else{//bottom
			p.my="left top";
			p.at="left bottom";
			p.offset = option.offset || "0 4";
			//border颜色设置为与boxPointer的边框色相同
			pointerBorder.css({
				"border-bottom-color": borderColor,
				"border-bottom-style": "solid",
				"top": "-20px","left": "10px"
			});
			//border颜色设置为与boxPointer的背景色相同
			pointerColor.css({
				"border-bottom-color": backColor,
				"border-bottom-style": "solid",
				"top": "-9px","left": "-10px"
			});
		}
		p.of=option.of;
		
		//显示及定位
		boxPointer.show().position(p);
		return boxPointer;
    }
};
/**
 * JS、CSS文件加载器
 *
 * @author rongjihuang@gmail.com
 * @date 2011-04-11
 * @ref modify from nbl.plus.js v2.0
 */

if(!window['bc'])window['bc']={};
bc.loader = {
	c: document,
	q: {}, // The dictionary that will hold the script-queue
	n: null,
	
	// The loader function
	//
	// Called with an array, it will interpret the options array
	// Called without an array it will try to load the options from the script-tag's data-nbl attribute
	l: function(a) { 
		//alert(a);
		var b, c, x, y, z, s, l, i = j = 0, m = bc.loader; m.h = m.c.head || m.c.body;
		
		// The timeout counter, counts backwards every 50ms from 50 ticks (50*50=2500ms by default)
		if (!m.i) {
			m.s = m.f = 0; // Reset counters: completed, created, timeout function
			m.i = setInterval(
				function() { 
					//logger.info("setInterval0");
					// If the timeout counter dips below zero, or the amount of completed scripts equals the amount 
					// of created script-tags, we can clear the interval
					if (m.o < 0 || m.s == 0) { 
						m.i = clearInterval(m.i); 
						// If the amount of completed scripts is smaller than the amount of created script-tags,
						// and there is a timeout function available, call it with the current script-queue.
						(m.s > 0 && m.f) && m.f(m.q)
					} 
					m.o--
					//logger.info("setInterval1");
				},
				m.o = 50 // Set the initial ticks at 50, as well as the interval at 50ms
			);
		}

		// If no arguments were given (a == l, which is null), try to load the options from the script tag
		if (a == m.n) {
			s = m.c.getElementsByTagName("script"); // Get all script tags in the current document
			while (j < s.length) {
				if ((a = eval("("+s[j].getAttribute("data-nbl")+")")) && a) { // Check for the data-nbl attribute
					m.h = s[j].parentNode;
					break
				}
				j++
			}
		}
		
		// If an options array was provided, proceed to interpret it
		if (a&&a.shift) {
			while (i < a.length) { // Loop through the options
				//logger.info("i="+i);
				b = a[i]; // Get the current element
				c = a[i+1]; // Get the next element
				x = 'function';
				y = typeof b; 
				z = typeof c;
				l = (z == x) ? c : (y == x) ? b : m.n; // Check whether the current or next element is a function and store it
				if (y == 'number') m.o = b/50; // If the current element is a number, set the timeout interval to this number/50
				// If the current element is a string, call this.a() with the string as a one-element array and the callback function l
				if (y == 'string') m.a([b], l); 
				// If the current element is an array, call this.a() with a two-element array of the string and the next element
				// as well as the callback function l
				b.shift && m.a([b.shift(), b], l); 
				if (!m.f && l) m.f = l; // Store the function l as the timeout function if it hasn't been set yet
				i++;
			}
		}
	},
	a: function(u,l) {
		logger.info("call a");
		var s, t, m = this, n = u[0].replace(/.+\/|\.min\.js|\.js|\?.+|\W/g, ''), k = {js: {t: "script", a: "src"}, css: {t: "link", a: "href", r: "stylesheet"}, "i": {t: "img", a: "src"}}; // Clean up the name of the script for storage in the queue
		t = u[0].match(/\.(js|css).*$/i); t = (t) ? t[1] : "i";
		n=u[0];
		if(m.q[n] === true){
			if(logger.debugEnabled)logger.debug("loader: skip load '" + u[0] + "'");
			l && l(); // Call the callback function l
			if(u[1]){
				logger.debug("loader: start load next after skip '" + u[0] + "'");
				m.l(u[1]);
			}
			return;//避免重复加载和解析
		}
		s = m.q[n] = m.c.createElement(k[t].t);
		var file = u[0];
		file = bc.addParamToUrl(file,"ts="+bc.ts);// 附加时间挫
			
		s.setAttribute(k[t].a, file);
		// Fix: CSS links do not fire onload events - Richard Lopes
		// Images do. Limitation: no callback function possible after CSS loads
		if (k[t].r){
			s.setAttribute("rel", k[t].r);
			m.q[n] = true;//强制设为true
			clearInterval(m.i); 
			if(logger.debugEnabled)logger.debug("loader|css: loading css '" + file + "'" + (l ? " and call the callback" : ""));
			l && l(); // Call the callback function l
			if(logger.debugEnabled)logger.debug("loader|css: append '" + file + "' to head");
			if(u[1]){
				logger.debug("loader|css: start load next after loaded '" + file + "'");
				m.l(u[1]);
			}
		}else {
			// When this script completes loading, it will trigger a callback function consisting of two things:
			// 1. It will call nbl.l() with the remaining items in u[1] (if there are any)
			// 2. It will execute the function l (if it is a function)
			s.onload = function(){
				clearInterval(m.i); 
				if(logger.debugEnabled)logger.debug("loader|js: finished loaded js'" + file + "'" + (l ? " and call the callback" : ""));
				var s = this, d = function(){
					var s = m, r = u[1]; 
					s.q[n] = true; // Set the entry for this script in the script-queue to true
					//r && s.l(r); // Call nbl.l() with the remaining elements of the original array
					if(r){
						logger.debug("loader|js: start load next after loaded '" + file + "'");
						s.l(r);
					}
					
					l && l(); // Call the callback function l
					s.s--
				};
				if ( !s.readyState || /de|te/.test( s.readyState ) ) {
					s.onload = m.n;
					s.onreadystatechange = m.n;
					d(); // On completion execute the callback function as defined above
				}
			};
			s.onreadystatechange = s.onload;
			m.s++;
			if(logger.debugEnabled)logger.debug("loader|js: append '" + file + "' to head");
		}
		m.h.appendChild(s) // Add the script to the document
	}
};
bc.loader.l();
//bc.load=bc.loader.l;//快捷方式

/** 简易调用方式的封装，如果参数不是如下格式请直接调用bc.loader.l：
 * 将[a1.js,a2.js,...,an.js,fn]转换为[[a1.js, [[a2.js, [[...[an.js,fn]...]] ]] ]]格式，
 * 保证所有js按顺序加载，并在全部加载完毕后再调用fn函数
 */
bc.load = function(args){
	function rebuildArgs(args,lastIsFn){
		//用数组的第1个元素和剩余元素组成的数组生成新的数组
		args=[args.shift(),args];
		
		//如果依然超过2个元素，递归处理
		if(args[1].length > (lastIsFn ? 3 : 2)){
			args[1] = rebuildArgs(args[1],lastIsFn);
		}
		return args;
	};
	if(args && args.shift && args.length > 2){//参数为数组,且长度大于2，执行转换
		var lastIsFn = (typeof args[args.length - 1] == "function");
		if(lastIsFn){
			if(args.length > 3){
				args = rebuildArgs(args,true);
				//if(logger.debugEnabled)logger.debug("newArgs=" + array2string(args));
			}
		}else{
			args = rebuildArgs(args,false);
		}
		bc.loader.l([args]);
	}else{
		bc.loader.l(args);
	}
}
function array2string(array){
	//alert("0:" + array);
	var t=["["];
	for(var i=0;i<array.length;i++){
		if(i>0 && i<array.length)
			t.push(",");
		if(typeof array[i] != "function"){
			if(array[i].shift){
				//alert("1:" + array[i]);
				t.push(array2string(array[i]));
			}else{
				t.push(array[i]);
			}
		}else{
			t.push("fn");
		}
	}
	t.push("]");
	return t.join("");
}
/*
function rebuildArgs1(args,lastIsFn){
	//用数组的第1个元素和剩余元素组成的数组生成新的数组
	args=[args.shift(),args];
	
	//如果依然超过2个元素，递归处理
	if(args[1].length > (lastIsFn ? 3 : 2)){
		args[1] = rebuildArgs1(args[1],lastIsFn);
	}
	return args;
};
var a = ["a","b","c",function(){}];
a = [rebuildArgs1(a,false)];
alert(array2string(a));
*/
/**
 * 富文本编辑器
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 */
bc.editor={
	/**
	 * 构建富文本编辑器的默认配置
	 * @param {Object} option 配置参数
	 * @option {String} ptype 上传附件所属文档的类型，一般是使用类名的小写开头字母
	 * @option {String} puid 上传附件所属文档的uid
	 */
	getConfig:function(option){
		if(typeof option != "object")
			option = {};
		
		var urlEx = "";
		if(option.ptype){
			urlEx += "&ptype=" + option.ptype;
		}
		if(option.puid){
			urlEx += "&puid=" + option.puid;
		}
			
		return jQuery.extend({
			//参考：http://xheditor.com/manual/2
			//参数值：full(完全),mfull(多行完全),simple(简单),mini(迷你)
			//或者自定义字符串，例如：'Paste,Pastetext,|,Source,Fullscreen,About'
			tools:'mfull'
			//图片上传接口地址
			,upImgUrl:bc.root + "/upload4xhEditor/?type=img" + urlEx
			//图片上传前限制的文件扩展名列表，默认为：jpg,jpeg,gif,png
			//,upImgExt:"jpg,jpeg,gif,png"
			//动画上传接口地址
			,upFlashUrl:bc.root + "/upload4xhEditor/?type=flash" + urlEx
			//动画上传前限制的文件扩展名列表，默认为：swf
			//,upFlashExt:"swf"
			//视频上传接口地址
			,upMediaUrl:bc.root + "/upload4xhEditor/?type=media" + urlEx
			//视频上传前限制的文件扩展名列表，默认为：avi
			//,upMediaExt:"avi"
		},option);
	},
	readOnly:{
		tools:''
	}
};
/**
 * 附件上传
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend attach.css
 */
bc.attach={
	clearFileSelect:function($attachs){
		//清空file控件:file.outerHTML=file.outerHTML; 
		var file = $attachs.find(":file.uploadFile");
		if(file.size())
			file[0].outerHTML=file[0].outerHTML;
	},
	/** 在线打开附件 */
	inline: function(attachEl,callback){
		//在新窗口中打开文件
		var url = bc.root + "/bc/attach/inline?id=" + $(attachEl).attr("data-id");
		var to = $(attachEl).attr("data-to");
		if(to && to.length > 0)
			url += "&to=" + to;
		window.open(url, "_blank");
	},
	/** 下载附件 */
	download: function(attachEl,callback){
		window.open(bc.root + "/bc/attach/download?id=" + $(attachEl).attr("data-id"), "blank");
	},
	/** 打包下载所有附件 */
	downloadAll: function(attachsEl,callback){
		var $attachs = $(attachsEl);
		if($attachs.find(".attach").size()){
			window.open(bc.root + "/bc/attach/downloadAll?ptype=" + $attachs.attr("data-ptype"), "blank");
		}else{
			bc.msg.slide("当前没有可下载的附件！");
		}
	},
	/** 删除附件 */
	delete_: function(attachEl,callback){
		var $attach = $(attachEl);
		var fileName = $attach.find(".subject").text();
		bc.msg.confirm("确定要删除附件<b>《"+fileName+"》</b>吗？",function(){
			bc.ajax({
				url: bc.root + "/bc/attach/delete?id=" + $attach.attr("data-id"),
				type: "GET",dataType:"json",
				success: function(json){
					//json:{success:true,msg:"..."}
					if(typeof(json) != "object"){
						alert("删除操作异常！");
						return;
					}
					
					if(json.success == false){
						alert(json.msg);//删除失败了
					}else{
						//附件总数减一
						var $totalCount = $attach.parent().find("#totalCount");
						$totalCount.text(parseInt($totalCount.text()) - 1);
						
						//附件总大小减去该附件的部分
						var $totalSize = $attach.parent().find("#totalSize");
						var newSize = parseInt($totalSize.attr("data-size")) - parseInt($attach.attr("data-size"));
						$totalSize.attr("data-size",newSize).text(bc.attach.getSizeInfo(newSize));
						
						//删除该附件的dom
						$attach.remove();
						
						//提示用户已删除
						bc.msg.slide("已删除附件<b>《"+fileName+"》</b>！");
					}
				}
			});
		});
	},
	/** 删除所有附件 */
	deleteAll: function(attachsEl,callback){
		var $attachs = $(attachsEl);
		if($attachs.find(".attach").size()){
			bc.msg.confirm("确定要将全部附件删除吗？",function(){
				bc.ajax({
					url: bc.root + "/bc/attach/deleteAll?ptype=" + $attachs.attr("data-ptype"),
					type: "GET",dataType:"json",
					success: function(json){
						//json:{success:true,msg:"..."}
						if(typeof(json) != "object"){
							alert("删除操作异常！");
							return;
						}
						
						if(json.success == false){
							alert(json.msg);//删除失败了
						}else{
							//附件总数清零
							$attachs.find("#totalCount").text("0");
							
							//附件总大小清零
							$attachs.find("#totalSize").text("0Bytes").attr("data-size","0");
							
							//清空file控件
					    	bc.attach.clearFileSelect($attachs);
							
							//删除附件的dom
							$attachs.find(".attach").remove();
							
							//提示用户已删除
							bc.msg.slide("已删除全部附件！");
						}
					}
				});
			});
		}else{
			bc.msg.slide("当前没有可删除的附件！");
		}
	},
    /**将字节单位的数值转换为较好看的文字*/
	getSizeInfo: function(size){
		if (size < 1024)
			return bc.formatNumber(size,"#.#") + "Bytes";
		else if (size < 1024 * 1024)
			return bc.formatNumber(size/1024,"#.#") + "KB";
		else
			return bc.formatNumber(size/1024/1024,"#.#") + "MB";
		
    },
    /**单个附件容器的模板*/
    tabelTpl:[
		'<table class="attach" cellpadding="0" cellspacing="0" data-size="{0}">',
			'<tr>',
				'<td class="icon"><span class="file-icon {2}"></span></td>',
				'<td class="info">',
					'<div class="subject">{3}</div>',
					'<table class="operations" cellpadding="0" cellspacing="0">',
						'<tr>',
						'<td class="size">{1}</td>',
						'<td><div class="progressbar"></div></td>',
						'<td><a href="#" class="operation" data-action="abort">取消</a></td>',
						'</tr>',
					'</table>',
				'</td>',
			'</tr>',
		'</table>'
    ].join(""),
    /**单个附件操作按钮的模板*/
    operationsTpl:[
		'<a href="#" class="operation" data-action="inline">在线查看</a>',
		'<a href="#" class="operation" data-action="download">下载</a>',
		'<a href="#" class="operation" data-action="delete">删除</a>'
	].join(""),
    /**判断浏览器是否可使用html5上传文件*/
	isHtml5Upload: function(attachEl){
		//return $.browser.safari || $.browser.mozilla;//Chrome12、Safari5、Firefox4
		return $(attachEl).filter("[data-flash]").size() == 0;
	}
};

(function($){

//初始化文件控件的选择事件
if(bc.attach.isHtml5Upload()){
	$(":file.uploadFile").live("change",function(e){
		var $atm = $(this).parents(".attachs");
		if(bc.attach.isHtml5Upload()){
			logger.info("uploadFile with html5");
			bc.attach.html5.upload.call($atm[0],e.target.files,{
				ptype: $atm.attr("data-ptype")
				,puid: $atm.attr("data-puid") || $atm.parents("form").find(":input:hidden[name='e.uid']").val()
			});
		}else{//Opera、IE等其他
			logger.info("uploadFile with html4");
			bc.attach.flash.upload.call($atm[0],e.target.files,{
				ptype: $atm.attr("data-ptype")
				,puid: $atm.attr("data-puid") || $atm.parents("form").find(":input:hidden[name='e.uid']").val()
			});
		}
	});
}else{
	
}

//单个附件的操作按钮
$(".attachs .operation").live("click",function(e){
	$this = $(this);
	var action = $this.attr("data-action");//内定的操作
	var callback = $this.attr("data-callback");//回调函数
	callback = callback ? bc.getNested(callback) : undefined;//转换为函数
	$attach = $this.parents(".attach");
	switch (action){
	case "abort"://取消附件的上传
		if(bc.attach.isHtml5Upload($attach[0])){
			bc.attach.html5.abortUpload($attach[0],callback);
		}else{
			bc.attach.flash.abortUpload($attach[0],callback);
		}
		break;
	case "inline"://在线打开附件
		bc.attach.inline($attach[0],callback);
		break;
	case "delete"://删除附件
		bc.attach.delete_($attach[0],callback);
		break;
	case "download"://下载附件
		bc.attach.download($attach[0],callback);
		break;
	case "downloadAll"://打包下载所有附件
		bc.attach.downloadAll($this.parents(".attachs")[0],callback);
		break;
	case "deleteAll"://删除所有附件
		bc.attach.deleteAll($this.parents(".attachs")[0],callback);
		break;
	default ://调用自定义的函数
		var click = $this.attr("data-click");
		if(typeof click == "string"){
			var clickFn = bc.getNested(click);//将函数名称转换为函数
			if(typeof clickFn == "function")
				clickFn.call($attach[0],callback);
			else
				alert("没有定义'" + click + "'函数");
		}else{
			alert("没有定义的action：" + action);
		}
		break;
	}
	
	return false;
});

})(jQuery);
/**
 * html5附件上传
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend attach.js,attach.css
 */
bc.attach.html5={
	xhrs:{},
	/**
	 * 基于html5的文件上传处理
	 * <p>函数上下文为附件控件的容器dom</p>
	 * @param {Array} files 要上传的文件列表
	 * @param {Object} option 配置参数
	 * @option {String} ptype 
	 * @option {String} puid 
	 * @option {String} url 
	 */
	upload:function(files,option){
		var $atm = $(this);
	    //html5上传文件(不要批量异步上传，实测会乱，如Chrome后台合并为一个文件等，需逐个上传)
		//用户选择的文件(name、fileName、type、size、fileSize、lastModifiedDate)
	    var url = option.url || bc.root+"/upload4xhEditor/?type=img";
	    if(option.ptype) url+="&ptype=" + option.ptype;
	    if(option.puid) url+="&puid=" + option.puid;
	    
	    //检测文件数量的限制
	    var maxCount = parseInt($atm.attr("data-maxCount"));
	    var curCount = parseInt($atm.find("#totalCount").text());
	    logger.info("maxCount=" + maxCount + ",curCount=" + curCount);
	    if(!isNaN(maxCount) && files.length + curCount > maxCount){
	    	alert("上传附件总数已限制为最多" + maxCount + "个，已超出上限了！");
	    	bc.attach.clearFileSelect($atm);
	    	return;
	    }
	    
	    //检测文件大小的限制
	    var maxSize = parseInt($atm.attr("data-maxSize"));
	    var curSize = parseInt($atm.find("#totalSize").attr("data-size"));
	    logger.info("maxSize=" + maxSize + ",curSize=" + curSize);
	    if(!isNaN(maxSize)){
	    	var nowSize = curSize;
	    	for(var i=0;i<files.length;i++){
	    		nowSize += files[i].fileSize;
	    	}
    		if(nowSize > maxSize){
	    		alert("上传附件总容量已限制为最大" + bc.attach.getSizeInfo(maxSize) + "，已超出上限了！");
		    	bc.attach.clearFileSelect($atm);
	    		return;
    		}
	    }
	    
	    //检测文件类型的限制
	    var _extensions = $atm.attr("data-extensions");//用逗号连接的扩展名列表
	    var fileName;
	    if(_extensions && _extensions.length > 0){
	    	for(var i=0;i<files.length;i++){
	    		fileName = files[i].fileName;
	    		if(_extensions.indexOf(fileName.substr(fileName.lastIndexOf(".") + 1)) == -1){
		    		alert("只能上传扩展名为\"" + _extensions.replace(/,/g,"、") + "\"的文件！");
			    	bc.attach.clearFileSelect($atm);
		    		return;
	    		}
	    	}
	    }
	    
	    //显示所有要上传的文件
	    var f;
	    var batchNo = "k" + new Date().getTime() + "-";//批号
	    for(var i=0;i<files.length;i++){
	    	f=files[i];
	    	var key = batchNo + i;
			//上传进度显示
			var fileName = f.fileName;
			var extend = fileName.substr(fileName.lastIndexOf(".")+1);
			var attach = bc.attach.tabelTpl.format(f.fileSize,bc.attach.getSizeInfo(f.fileSize),extend,fileName);
			$(attach).attr("data-xhr",key).insertAfter($atm.find(".header")).find(".progressbar").progressbar();
	    }

	    //开始上传
	    var $newAttachs = $atm.find(".attach[data-xhr]");//含有data-xhr属性的代表还没上传
	    var i = 0;
	    setTimeout(function(){
	    	uploadNext();
	    },500);//延时小许时间再上传，避免太快看不到效果
		
	    //逐一上传文件
		function uploadNext(){
	    	if(i >= files.length){
		    	bc.attach.clearFileSelect($atm);
	    		return;//全部上传完毕
	    	}
	    	
	    	var key = batchNo + i;
			logger.info("uploading:i=" + i);
			//继续上传下一个附件
			uploadOneFile(key,files[i],url,uploadNext);
		}
	   
		//上传一个文件
	    function uploadOneFile(key,f,url,callback){
	    	var xhr = new XMLHttpRequest();
	    	bc.attach.html5.xhrs[key] = xhr;
	    	var $attach = $newAttachs.filter("[data-xhr='" + key + "']");
	    	var $progressbar = $attach.find(".progressbar");
			if($.browser.safari){//Chrome12、Safari5
				xhr.upload.onprogress=function(e){
					var progressbarValue = Math.round((e.loaded / e.total) * 100);
					logger.info(i + ":upload.onprogress:" + progressbarValue + "%");
					$progressbar.progressbar("option","value",progressbarValue);
				};
			}else if($.browser.mozilla){//Firefox4
				xhr.onuploadprogress=function(e){
					var progressbarValue = Math.round((e.loaded / e.total) * 100);
					logger.info(i + ":upload.onprogress:" + progressbarValue + "%");
					$progressbar.progressbar("option","value",progressbarValue);
				};
			}
			
			//上传完毕的处理
			xhr.onreadystatechange=function(){
				if(xhr.readyState===4){
					bc.attach.html5.xhrs[key] = null;
					//累计上传的文件数
					i++;
					logger.info(i + ":" + xhr.responseText);
					var json = eval("(" + xhr.responseText + ")");
					
					//附件总数加一
					var $totalCount = $atm.find("#totalCount");
					$totalCount.text(parseInt($totalCount.text()) + 1);
					
					//附件总大小添加该附件的部分
					var $totalSize = $atm.find("#totalSize");
					var newSize = parseInt($totalSize.attr("data-size")) + f.fileSize;
					$totalSize.attr("data-size",newSize).text(bc.attach.getSizeInfo(newSize));
					
					//删除进度条、显示附件操作按钮（延时1秒后执行）
					setTimeout(function(){
						var tds = $progressbar.parent();
						var $operations = tds.next();
						tds.remove();
						$operations.empty().append(bc.attach.operationsTpl);
						
						$attach.attr("data-id",json.msg.id)
							.attr("data-name",json.msg.localfile)
							.attr("data-url",json.msg.url)
							.removeAttr("data-xhr");
					},1000);
					
					//调用回调函数
					if(typeof callback == "function")
						callback(json);
				}
			};
			
			xhr.onabort=function(){
				logger.info("onabort:i=" + i);
				$attach.remove();
			}
//			xhr.upload.onabort=function(){
//				logger.info("upload.onabort:i=" + i);
//			}

			xhr.open("POST", url);
			xhr.setRequestHeader('Content-Type', 'application/octet-stream');
			//对文件名进行URI编码避免后台中文乱码（后台需URI解码）
			xhr.setRequestHeader('Content-Disposition', 'attachment; name="filedata"; filename="'+encodeURIComponent(f.fileName)+'"');
			if(xhr.sendAsBinary)//Firefox4
				xhr.sendAsBinary(f.getAsBinary());
			else //Chrome12
				xhr.send(f);
	    }
	},
	/** 取消正在上传的附件 */
	abortUpload: function(attachEl,callback){
		var $attach = $(attachEl);
		var key = $attach.attr("data-xhr");
		logger.info("key=" + key);
		var xhr = bc.attach.html5.xhrs[key];
		if(xhr){
			logger.info("xhr.abort");
			xhr.abort();
			xhr = null;
		}
	}
};

(function($){

})(jQuery);
/**
 * flash附件上传
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend attach.js,attach.css
 */
bc.attach.flash={
	init:function(){
		var $atm = $(this);
		var fileId = $atm.find(":file.uploadFile").attr("id");
		logger.info("bc.attach.flash.init:file.id=" + fileId);
		//,bc.root + "/ui-libs/swfupload/2.2.0.1/plugins/swfupload.cookies.js?ts=0"
		bc.load([bc.root + "/ui-libs/swfupload/2.2.0.1/swfupload.js?ts=0",function(){
		    var url = bc.root+"/upload4xhEditor/?type=img";
		    url += "&ptype=" + $atm.attr("data-ptype");
		    url += "&puid=" + $atm.attr("data-puid") || $atm.parents("form").find(":input:hidden[name='e.uid']").val();
			var swfuCfg = {
				upload_url : url,
				prevent_swf_caching: false,
				flash_url : bc.root+"/ui-libs/swfupload/2.2.0.1/swfupload.swf",
				file_post_name : "filedata",
				file_types : "*.*",
				file_types_description: "所有文件",
				//button_image_url : bc.root + "/bc/libs/themes/default/images/swfuploadButton.png", 
				button_width: "60",
				button_height: "22",
				button_placeholder_id: fileId,
				button_text: '<span class="theFont">添加附件</span>',
				button_text_style: '.theFont{font-size:13px;color:#2A5DB0;text-decoration:underline;font-family:"微软雅黑","宋体",sans-serif;}',
				button_text_left_padding: 0,
				button_text_top_padding: 1,
				button_action : SWFUpload.BUTTON_ACTION.SELECT_FILES, 
				button_disabled : false, 
				button_cursor : SWFUpload.CURSOR.HAND, 
				button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
				debug:false,
				custom_settings : {
					totalSize: 0,//已上传文件的大小累计
					fileCount: 0,//用户选中的文件数量
					finishedSize: 0,//当前已上传完毕的文件数量
					fileNames: []//用户选中的文件名称
				},
			
				// The event handler functions
				file_dialog_complete_handler : bc.attach.flash.handlers.fileDialogComplete,
				file_queued_handler : bc.attach.flash.handlers.fileQueued,
				file_queue_error_handler : bc.attach.flash.handlers.fileQueueError,
				upload_start_handler : bc.attach.flash.handlers.uploadStart,
				upload_progress_handler : bc.attach.flash.handlers.uploadProgress,
				upload_error_handler : bc.attach.flash.handlers.uploadError,
				upload_success_handler : bc.attach.flash.handlers.uploadSuccess,
				upload_complete_handler : bc.attach.flash.handlers.uploadComplete,
				
				// 浏览器flash插件的控制：需要swfupload.swfobject.js插件的支持
				//minimum_flash_version: "9.0.28",
				swfupload_pre_load_handler: bc.attach.flash.handlers.swfuploadPreLoad,
				swfupload_load_failed_handler: bc.attach.flash.handlers.swfuploadLoadFailed
			};
			logger.info("upload_url=" + swfuCfg.upload_url);
			
			//文件大小限制
			var maxSize = parseInt($atm.attr("data-maxSize"));
			if(maxSize > 0){
				logger.info("maxSize=" + maxSize);
				swfuCfg.file_size_limit = maxSize/1024;
			}
			
			//文件过滤控制
			var extensions = $atm.attr("data-extensions");
			if(extensions.length > 0){
				logger.info("extensions=" + extensions);
				//var all = $atm.attr("filter").split("|");
				//swfuCfg.file_types=all[0];
				//if(all.length >1)swfuCfg.file_types_description=all[1];
			}
			
			new SWFUpload(swfuCfg);
		}]);
	},
	/** 取消正在上传的附件 */
	abortUpload: function(attachEl,callback){
		var $attach = $(attachEl);
		var fileId = $attach.attr("data-flash");
		var swfId = $attach.parents(".attachs").find("object").attr("id");
		logger.info("abortUpload:swfId=" + swfId + ",fileId=" + fileId);
		//取消上传中的文件
		var swf = SWFUpload.instances[swfId];
		if(swf){
			swf.cancelUpload(fileId);
		}
		
		//删除dom
		$attach.remove();
	}
};
bc.attach.flash.handlers={
	/**file_queued_handler
	 * 当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会
	 * 触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
	 */
	fileQueued:function(file){
		this.customSettings.totalSize += file.size;
		this.customSettings.fileCount += 1;
		this.customSettings.fileNames.push(file.name);
	},
	/**file_queue_error_handler
	 * 当选择文件对话框关闭消失时，如果选择的文件加入到上传队列中失败，那么针对每个出错的文件都会触发一次该事件
	 * (此事件和fileQueued事件是二选一触发，文件添加到队列只有两种可能，成功和失败)。
	 * 文件添加队列出错的原因可能有：超过了上传大小限制，文件为零字节，超过文件队列数量限制，设置之外的无效文件类型。
	 * 具体的出错原因可由error code参数来获取，error code的类型可以查看SWFUpload.QUEUE_ERROR中的定义。
	 */
	fileQueueError:function(file, errorCode, message){
		logger.info("fileQueueError:errorCode=" + errorCode + ",message=" + message + ",file=" + file.name);
		bc.msg.slide("您选择的文件《" + file.name + "》为空文件！");
	},
	/**file_dialog_complete_handler
	 * 当选择文件对话框关闭，并且所有选择文件已经处理完成（加入上传队列成功或者失败）时，此事件被触发，
	 * number of files selected是选择的文件数目，number of files queued是此次选择的文件中成功加入队列的文件数目。
	 * totalNumber:total number of files in the queued
	 */
	fileDialogComplete:function(numberOfFilesSelected, numberOfFilesQueued, totalNumber){
		logger.info("selected:" + numberOfFilesSelected + ";queued:" + numberOfFilesQueued + ";totalNumber:" + totalNumber+";totalSize:" + this.customSettings.totalSize);
		try {
			if (numberOfFilesSelected > 0 && numberOfFilesSelected != numberOfFilesQueued) {
		    	alert("无法上传所选择的文件，可能的原因为：空文件、文件大小超出上限或文件类型超出限制！");
		    	this.cancelUpload();
	    		return false;
			}
			if (numberOfFilesQueued > 0) {
				var $atm = $("#" + this.movieName).parents(".attachs");
			    //检测文件数量的限制
			    var maxCount = parseInt($atm.attr("data-maxCount"));
			    var curCount = parseInt($atm.find("#totalCount").text());
			    logger.info("maxCount=" + maxCount + ",curCount=" + curCount);
			    if(!isNaN(maxCount) && numberOfFilesSelected + curCount > maxCount){
			    	alert("上传附件总数已限制为最多" + maxCount + "个，已超出上限了！");
			    	this.cancelUpload();
			    	return false;
			    }
			    
			    //检测文件大小的限制
			    var maxSize = parseInt($atm.attr("data-maxSize"));
			    var curSize = parseInt($atm.find("#totalSize").attr("data-size"));
			    logger.info("maxSize=" + maxSize + ",curSize=" + curSize);
			    if(!isNaN(maxSize)){
			    	var nowSize = curSize + this.customSettings.totalSize;
		    		if(nowSize > maxSize){
			    		alert("上传附件总容量已限制为最大" + bc.attach.getSizeInfo(maxSize) + "，已超出上限了！");
				    	this.cancelUpload();
			    		return false;
		    		}
			    }
			    
			    // 检测文件类型的限制
			    var _extensions = $atm.attr("data-extensions");//用逗号连接的扩展名列表
			    logger.info("_extensions=" + _extensions);
			    if(_extensions && _extensions.length > 0){
			    	var fileNames = this.customSettings.fileNames;
				    var fileName;
			    	for(var i=0;i<fileNames.length;i++){
			    		fileName = fileNames[i];
			    		if(_extensions.indexOf(fileName.substr(fileName.lastIndexOf(".") + 1)) == -1){
				    		alert("只能上传扩展名为\"" + _extensions.replace(/,/g,"、") + "\"的文件！");
					    	this.cancelUpload();
				    		return false;
			    		}
			    	}
			    }
			    
			    //显示所有要上传的文件
			    var f,fileName;
			    for(var i=0;i<numberOfFilesQueued;i++){
			    	f=this.getFile(i);
				    logger.info("f.id=" + f.id + ",f.name=" + f.name);
					//上传进度显示
					fileName = f.name;
				    logger.info("fileName=" + fileName);
					var extend = fileName.substr(fileName.lastIndexOf(".")+1);
					var attach = bc.attach.tabelTpl.format(f.size,bc.attach.getSizeInfo(f.size),extend,fileName);
					$(attach).attr("data-flash", f.id).insertAfter($atm.find(".header"))
					.find(".progressbar").progressbar();
			    }
			    
//				//绑定取消事件
//				var othis = this;
//				infoWraper.find(".btn").click(function(){
//					logger.warn("cancelUpload");
//					othis.cancelUpload();
//					othis.customSettings.cancel = true;
//				});
				
				//自动开始上传:默认只会上传第一个文件，需要在uploadComplete控制继续上传
				this.startUpload();
			}
		} catch(ex){
	        logger.error(""+ex);
		}
	},
	/**upload_start_handler
	 * 在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作，例如添加、修改、删除post数据等。
	 * 在完成最后的操作以后，如果函数返回false，那么这个上传不会被启动，并且触发uploadError事件（code为ERROR_CODE_FILE_VALIDATION_FAILED），
	 * 如果返回true或者无返回，那么将正式启动上传。
	 */
	uploadStart:function(file){
		logger.info("uploadStart:" + file.name);
		//document.getElementById(this.customSettings.infoId).innerHTML = OZ.Attachment.Flash.defaults.START_INFO;
	},
	/**upload_progress_handler
	 * 该事件由flash定时触发，提供三个参数分别访问上传文件对象、已上传的字节数，总共的字节数。
	 * 因此可以在这个事件中来定时更新页面中的UI元素，以达到及时显示上传进度的效果。
	 * 注意: 在Linux下，Flash Player只在所有文件上传完毕以后才触发一次该事件，官方指出这是
	 * Linux Flash Player的一个bug，目前SWFpload库无法解决
	 */
	uploadProgress:function(file, bytesComplete, totalBytes){
		var progressbarValue = Math.round((bytesComplete / totalBytes) * 100);
		logger.info("uploadProgress:" + progressbarValue + "%");
		var $attach = $("#" + this.movieName).parents(".attachs").find(".attach[data-flash='" + file.id + "']");
		logger.info("$attach:" + $attach.size());
		$attach.find(".progressbar").progressbar("option","value",progressbarValue);
	},
	/**upload_success_handler
	 * 当文件上传的处理已经完成（这里的完成只是指向目标处理程序发送了Files信息，只管发，不管是否成功接收），
	 * 并且服务端返回了200的HTTP状态时，触发此事件。
	 * 此时文件上传的周期还没有结束，不能在这里开始下一个文件的上传。
	 */
	uploadSuccess:function(file, serverData){
		logger.info("uploadSuccess:" + file.name + ";serverData=" + serverData);
		this.customSettings.finishedSize+=file.size;//累计已上传的字节数
		var $attach = $("#" + this.movieName).parents(".attachs").find(".attach[data-flash='" + file.id + "']");
		//删除进度条、显示附件操作按钮（延时1秒后执行）
		var json = eval("(" + serverData + ")");
		if(json.err && json.err.length > 0){
			alert("上传文件《" + file.name + "》出现异常，" + json.err);
		}else{
			setTimeout(function(){
				var tds = $attach.find(".progressbar").parent();
				var $operations = tds.next();
				tds.remove();
				$operations.empty().append(bc.attach.operationsTpl);
				$attach.attr("data-id",json.msg.id)
					.attr("data-name",json.msg.localfile)
					.attr("data-url",json.msg.url)
					.removeAttr("data-flash");
			},1000);
		}
	},
	/**upload_complete_handler
	 * 当上传队列中的一个文件完成了一个上传周期，无论是成功(uoloadSuccess触发)还是失败(uploadError触发)，此事件都会被触发，
	 * 这也标志着一个文件的上传完成，可以进行下一个文件的上传了。
	 */
	uploadComplete:function(file){
		logger.info("uploadComplete:" + file.name);
		var stats = this.getStats();
		if (stats.files_queued > 0 && !this.customSettings.cancel){
			this.startUpload();
		}else{
			logger.info("all complete");
			//全部上传完毕后的处理
			this.customSettings.totalSize=0;
			this.customSettings.finishedSize=0;
			if (this.customSettings.cancel){
				logger.info("cancel");
			}
		}
	},
	/**upload_error_handler
	 * SWFUpload.UPLOAD_ERROR
	 */
	uploadError:function(file, errorCode, message){
		logger.error("uploadError:" + file.name + ";errorCode:" + errorCode + ";message:" + message);
	},
	/**swfupload_pre_load_handler
	 */
	swfuploadPreLoad:function(){
		logger.info("swfuploadPreLoad");
	},
	/**swfupload_load_failed_handler
	 */
	swfuploadLoadFailed:function(){
		logger.error("swfuploadLoadFailed");
	}
};

(function($){

})(jQuery);
/**
 * desktop桌面
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-11
 * @ref ext桌面 http://dev.sencha.com/deploy/ext-4.0-beta1/examples/sandbox/sandbox.html,http://web2.qq.com/
 * @ref jquery桌面 http://desktop.sonspring.com/
 */

if (!window['bc'])
	window['bc'] = {};
bc.desktop = {
	/**桌面布局的初始化*/
	init : function(option) {
		// 执行桌面布局
		$(window).resize(function() {
			bc.desktop.doResize();
		});
		
		//开始菜单
		var positionOpts = jQuery.extend({
			posX: 'left', 
			posY: 'bottom',
			offsetX: 0,
			offsetY: 0,
			directionH: 'right',
			directionV: 'down', 
			detectH: true, // do horizontal collision detection  
			detectV: true, // do vertical collision detection
			linkToFront: false
		},{directionH: 'left'});
		$('#quickStart').menu({ 
			content: $('#quickStartMenu').html(), 
			flyOut: true,
			positionOpts:positionOpts,
			clickMenuItem:function(name, href){
				logger.info("click:" + $(this).text() + ";name=" + name + ";href=" + href);
				$this = $(this);
				$parent = $this.parent();
				var option = $parent.attr("data-option");
				if(!option || option.length == 0) option="{}";
				option = eval("("+option+")");
				option.mid=$parent.attr("data-mid");
				option.name=$this.text();
				option.type=$parent.attr("data-type");
				option.url=$this.attr("href");
				if(option.url && option.url.length>0 && option.url.indexOf("#")!=0)
					bc.page.newWin(option);
			}
		});
		
		//对ie，所有没有定义href属性的a，自动设置该属性为"#"，避免css中的:hover等没有效果
		if(true || $.browser.msie){
			$("a[href=''],a:not([href])").each(function(){
				this.setAttribute("href","#");
			});
		}

		// 双击打开桌面快捷方式
		var shortcuts = $("#desktop > a.shortcut");
		shortcuts.live("dblclick",bc.desktop.openModule);
		
		// 禁用桌面快捷方式的默认链接打开功能
		shortcuts.live("click",function(){logger.debug("a:click");return false;});
		
		//允许图标拖动
		$("a.shortcut").draggable({containment: '#desktop'});
		//$("a.shortcut").draggable({containment: '#desktop',grid: [20, 20]});
		//$("#shortcuts" ).selectable();

		// 快速工具条中条目的鼠标控制
		$("#quickButtons > .quickButton").live("mouseover", function() {
			$(this).addClass("ui-state-hover");
		}).live("mouseout", function() {
			$(this).removeClass("ui-state-hover");
		}).live("click", function() {
			$this = $(this);
			var mid = $this.attr("data-mid");
			var $dialogContainer = $("body>.ui-dialog>.ui-dialog-content[data-mid='" + mid + "']").parent();
			if ($this.hasClass("ui-state-active")) {
				$this.removeClass("ui-state-active")
				.find(">span.ui-icon").removeClass("ui-icon-folder-open").addClass("ui-icon-folder-collapsed");
				$dialogContainer.hide();
			} else {
				$this.addClass("ui-state-active")
				.find(">span.ui-icon").removeClass("ui-icon-folder-collapsed").addClass("ui-icon-folder-open")
				.end().siblings().toggleClass("ui-state-active",false);
				$dialogContainer.show().end().dialog("moveToTop");
			}
			// $this.toggleClass("ui-state-active")
			return false;
		});

		// 显示隐藏桌面的控制
		$("#quickShowHide").click(function() {
			var $this = $(this);
			var $dialogContainer = $("body>.ui-dialog");
			if ($this.attr("data-hide") == "true") {
				$this.attr("data-hide","false");
				$dialogContainer.show();
			} else {
				$this.attr("data-hide","true");
				$dialogContainer.hide();
			}
			return false;
		});

		// 注销的控制
		$("#quickLogout").click(function() {
			window.open(bc.root + "/logout","_self");
			return false;
		});
		
		// 桌面日历
		$("#indexCalendar").datepicker({
			showWeek: true,
			//showButtonPanel: true,//现时今天按钮
			firstDay: 7
		});
		
		bc.desktop.doResize();
		
		//默认打开待办事务窗口
		//$(shortcuts[0]).trigger("dblclick");
	},
	/**重新调整桌面的布局*/
	doResize : function() {
		$("#desktop").height($("#layout").height() - $("#quickbar").height());
		
		// 桌面右侧边栏
		$("#rightPanel").css("top",$("#quickbar").height());
		
		$("#desktop").width($("#layout").width() - $("#rightPanel").width());
	},
	/**双击打开桌面快捷方式*/
	openModule: function(option) {
		$this = $(this);
		var type = $this.attr("data-type");
		var option = $this.attr("data-option");
		if(!option || option.length == 0) option="{}";
		option = eval("("+option+")");
		option.mid=$this.attr("data-mid");
		option.iconClass=$this.attr("data-iconClass");
		option.name=$this.attr("data-name");
		option.order=$this.attr("data-order");
		option.type=$this.attr("data-type");
		option.url=$this.attr("data-url");
		option.standalone=$this.attr("data-standalone")=="true";
		if(logger.debugEnabled)
			logger.debug("a:dblclick,type=" + type);
		bc.page.newWin(option);
		//if(type == "2"){//打开内部链接
		//}
	}
};
jQuery(function($) {
	bc.desktop.init();
	
	//字体设置:初始化为14px=0.87em(浏览器默认为1em=16px)
//	var curSize = $("body").css("fontSize");
//	curSize= parseInt(curSize.replace("px","")) || 14;
//	$("#fontSize").html(curSize+"");
//	//$("body").css("fontSize", 14/16 + 'em');
//	$( "#fontSlider" ).slider({
//		value:curSize,min: 12,max: 20,step: 2,
//		slide: function( event, ui ) {
//			$("#fontSize").html(ui.value);
//			$("body").css("fontSize",ui.value + 'px');
//			logger.info(ui.value);
//			
//			//使用ajax保存数据
//			var data = "font=" + ui.value;
//			bc.ajax({
//				url: bc.root + "/bc/desktop/personalConfig/update", data: data, dataType: "json",
//				success: function(json) {
//					if(logger.debugEnabled)logger.debug("save success.json=" + jQuery.param(json));
//					bc.msg.slide(json.msg);
//				}
//			});
//		}
//	});
	
	//主题设置
	//$('#themeSwitcher').themeswitcher({closeOnSelect:false,height:340,root:bc.root});
	
	//显示设置
	//$("#setting").show();
});

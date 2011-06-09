/**
 * JavaScript日志组件
 * 
 * 1)使用Ctrl+Home快捷键或logger.toggle()可以切换控制台的显示隐藏状态。
 * 2)使用logger.debugEnabled|infoEnabled|warnEnabled|profileEnabled判断当前日志级别的配置，
 *   默认debugEnabled=false,其余为true。
 * 3)使用logger.debug|info|warn|error|profile(msg)输出调试信息。
 * 4)使用logger.enable|disabled(type)禁用或启用指定级别的信息输出。
 * 5)使用logger.clear()清空输出。
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-11
 * @dep jquery[,jquery.ui.draggable]
 */
window['logger'] = (function($){
	var msgTpl = '<li class="{1}"><span></span>{0} {2}</li>';
	var tpl = '<div id="loggerPanel" class="logger" unselectable="on" onselectstart="return false;">'+
		'<div class="top">'+
			'<div class="leftSide"></div>'+
			'<div class="center"></div>'+
			'<div class="rightSide"></div>'+
		'</div>'+
		'<div id="loggerHeader" class="header">'+
			'<div class="leftSide"></div>'+
			'<div class="left">'+
				'<span id="logger-btn-debug" class="debugDisabled" title="已禁用debug"></span>'+
				'<span id="logger-btn-info" class="info" title="已启用info"></span>'+
				'<span id="logger-btn-warn" class="warn" title="已启用warn"></span>'+
				'<span id="logger-btn-error" class="error" title="已启用error"></span>'+
				'<span id="logger-btn-profile" class="profile" title="已启用profile"></span>'+
			'</div>'+
			'<div class="right">'+
				'<span id="logger-btn-close" class="close" title="关闭"></span>'+
				'<span id="logger-btn-clear" class="clear" title="清空"></span>'+
				'<span id="logger-btn-desc" class="desc" title="切换方向"></span>'+
			'</div>'+
			'<div class="rightSide"></div>'+
		'</div>'+
		'<div class="content">'+
			'<div class="leftSide"></div>'+
			'<div class="center">'+
				'<ol id="loggerContent"></ol>'+
			'</div>'+
			'<div class="rightSide"></div>'+
		'</div>'+
		'<div class="footer">'+
			'<div class="leftSide"></div>'+
			'<div class="center"></div>'+
			'<div class="rightSide"></div>'+
		'</div>'+
		'</div>';
		
	var num=0,panel,content;
	var unInit = true;
	var profiler = [];
	var desc = true;
	var visible = false;
	// 快捷键设置
	$(document).keyup(function(evt){
		//logger.info(logger.infoEnabled);
		if (evt.which == 36 && evt.metaKey) { //切换显示隐藏：Ctrl(metaKey) + Home(36)
			toggleShow();
		}else if(visible && evt.which == 39 && evt.metaKey){//切换位置：Ctrl(metaKey) + ->(39)
			logger.info(evt.which + ";" + evt.metaKey);
		}
	});
	function toggleShow(){
		if(unInit) init();
		if (visible){
			panel.hide();
			visible = false;
		}else{
			panel.show();
			visible = true;
		}
	};
	
	// 初始化函数
	function init(){
		panel = $(tpl).appendTo("body").css("z-index",20000);
		content = $("#loggerContent");
		unInit = false;
		
		// 绑定工具条事件
		$("#logger-btn-debug").click(function(){changeBtn("debug",this);});
		$("#logger-btn-info").click(function(){changeBtn("info",this);});
		$("#logger-btn-warn").click(function(){changeBtn("warn",this);});
		$("#logger-btn-error").click(function(){changeBtn("error",this);});
		$("#logger-btn-profile").click(function(){changeBtn("profile",this);});
		
		$("#logger-btn-clear").click(function(){logger.clear()});
		$("#logger-btn-close").click(function(){panel.hide();visible = false;});
		$("#logger-btn-desc").click(function(){changeBtn("desc",this);desc=!desc});
		
		visible=true;
		out("info", "日志组件初始化完毕 ");
		visible=false;
		
		// 使控制台可以移动
		try{$("#loggerPanel").draggable({handle:"#loggerHeader"})}catch(e){};
	};
	function changeBtn(type,source){
		if(source.className == type){
			source.className = type + "Disabled";
			source.title = "已禁用";
			out(type,"已禁用" + type);
			logger[type + "Enabled"] = false;
			if(type=="profile")delete profiler["已禁用" + type];
		}else{
			source.className = type;
			source.title = "已启用" + type;
			logger[type + "Enabled"] = true;
			out(type,"已启用" + type);
			if(type=="profile")delete profiler["已启用" + type];
		}
	};
	/** 第一个参数为类型（"debug"、"info"、"warn"、"error"、"profile"），第二个参数为调试信息，第三个参数开始为格式化的值 */
	function out(){
		if(unInit) init();
		if(logger[arguments[0] + "Enabled"] && visible){
			var html = buildItemHtml(arguments);
			if(desc){
				content.prepend(html);
				content.attr("scrollTop",0);
			}else{
				content.append(html);
				content.attr("scrollTop",content.attr("scrollHeight"));
			}
		}
	};
	function buildItemHtml(arguments){
		var args = Array.prototype.slice.call(arguments, 1);
		var _num = (logger.showTime && Date.prototype.format) ? new Date().format("hh:mm:ss"): (++num);
		return msgTpl.format(_num,arguments[0],String.format.apply(null,args));
	};
	return {
		debugEnabled: false,
		infoEnabled: true,
		warnEnabled: true,
		profileEnabled: true,
		/**在每条日志信息前显示时间还是序号*/
		showTime: true,
		debug:function(){
			out.apply(this,["debug"].concat(jQuery.makeArray(arguments)));
		},
		info:function(){
			out.apply(this,["info"].concat(jQuery.makeArray(arguments)));
		},
		warn:function(){
			out.apply(this,["warn"].concat(jQuery.makeArray(arguments)));
		},
		error:function(){
			out.apply(this,["error"].concat(jQuery.makeArray(arguments)));
		},
		profile:function(label){
			var currentTime = new Date(); //record the current time when profile() is executed
			
			if ( label == undefined || label == '' ) {
				out.apply(this,["error",'<b>错误:</b>必须为profile指定参数！']);
			}
			else if(profiler[label]) {
				out.apply(this,["profile",label + ": " + (currentTime-profiler[label]) + 'ms']
					.concat(jQuery.makeArray(Array.prototype.slice.call(arguments, 1))));
				delete profiler[label];
			}
			else{
				profiler[label] = currentTime;
				out.apply(this,["profile"].concat(jQuery.makeArray(arguments)));
			}
			return currentTime;
		},
		clear:function(){content.empty();num=0;},
		enable: function(type){
			$("#logger-btn-" + type).attr("class",type);
			logger[type + "Enabled"] = true;
			return this;
		},
		disabled: function(type){
			$("#logger-btn-" + type).attr("class",type + "Disabled");
			logger[type + "Enabled"] = false;
			return this;
		},
		toggle: function(){
			toggleShow();
			return this;
		}
	};
})(jQuery);
if(!String.format){
	String.format=function(format){
		var args = Array.prototype.slice.call(arguments, 1);
		return format.replace(/\{(\d+)\}/g, function(m, i){
	        return args[i];
	    });
	};
	String.prototype.format=function(){
	    var args = arguments;
	    return this.replace(/\{(\d+)\}/g, function(m, i){
	        return args[i];
	    });
	};
}
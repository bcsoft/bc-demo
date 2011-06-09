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
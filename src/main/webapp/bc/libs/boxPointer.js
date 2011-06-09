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
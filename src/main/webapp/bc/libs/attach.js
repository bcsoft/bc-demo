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
/**
 * 附件上传
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend attach.css
 */
bc.attach={
	xhrs:{},
	clearFileSelect:function($attachs){
		//清空file控件:file.outerHTML=file.outerHTML; 
		var file = $attachs.find(":file")[0];
		file.outerHTML=file.outerHTML
	},
	/**
	 * 基于html5的文件上传处理
	 * <p>函数上下文为附件控件的容器dom</p>
	 * @param {Array} files 要上传的文件列表
	 * @param {Object} option 配置参数
	 * @option {String} ptype 
	 * @option {String} puid 
	 * @option {String} url 
	 */
	html5upload:function(files,option){
		var $atm = $(this);
	    //html5上传文件(不要批量异步上传，实测会乱，如Chrome后台合并为一个文件等，需逐个上传)
		//用户选择的文件(name、fileName、type、size、fileSize、lastModifiedDate)
	    var url = option.url || bc.root+"/upload4xhEditor/?type=img";
	    if(option.ptype) url+="&ptype=" + option.ptype;
	    if(option.puid) url+="&puid=" + option.puid;
	    
	    //检测文件数量的限制
	    var maxCount = parseInt($atm.attr("data-maxCount"));
	    var curCount = parseInt($atm.find("#totalCount"));
	    if(!isNaN(maxCount) && files.length + curCount > maxCount){
	    	alert("上传附件总数已限制为最多" + maxCount + "个，已超出上限了！");
	    	bc.attach.clearFileSelect($atm);
	    	return;
	    }
	    
	    //检测文件大小的限制
	    var maxSize = parseInt($atm.attr("data-maxSize"));
	    var curSize = parseInt($atm.find("#totalSize").attr("data-size"));
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
			var attach = ''+
				'<table class="attach" cellpadding="0" cellspacing="0" data-size="' + f.fileSize + '" data-xhr=' + key + '>'+
					'<tr>'+
						'<td class="icon"><span class="file-icon ' + extend + '"></span></td>'+
						'<td class="info">'+
							'<div class="subject">' + fileName + '</div>'+
							'<table class="operations" cellpadding="0" cellspacing="0">'+
								'<tr>'+
								'<td class="size">' + bc.attach.getSizeInfo(f.fileSize) + '</td>'+
								'<td><div class="progressbar"></div></td>'+
								'<td><a href="#" class="operation" data-action="abort">取消</a></td>'+
								'</tr>'+
							'</table>'+
						'</td>'+
					'</tr>'+
				'</table>';
			$(attach).appendTo($atm).find(".progressbar").progressbar();
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
	    	bc.attach.xhrs[key] = xhr;
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
					bc.attach.xhrs[key] = null;
					//累计上传的文件数
					i++;
					logger.info(i + ":" + xhr.responseText);
					var json = eval("(" + xhr.responseText + ")");
					
					//附件总数加一
					var $totalCount = $atm.find("#totalCount");
					$totalCount.text(parseInt($totalCount.text()) + 1);
					
					//附件总大小添加该附件的部分
					var $totalSize = $atm.find("#totalSize");
					var newSize = parseInt($totalSize.attr("data-size")) + parseInt($attach.attr("data-size"));
					$totalSize.attr("data-size",newSize).text(bc.attach.getSizeInfo(newSize));
					
					//删除进度条、显示附件操作按钮（延时1秒后执行）
					setTimeout(function(){
						var tds = $progressbar.parent();
						var $operations = tds.next();
						tds.remove();
						$operations.empty().append('<a href="#" class="operation" data-action="inline">在线查看</a>'+
							'<a href="#" class="operation" data-action="download">下载</a>'+
							'<a href="#" class="operation" data-action="delete">删除</a>');
						
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
	/** 删除正在上传的附件 */
	abortHtml5Upload: function(attachEl,callback){
		var $attach = $(attachEl);
		var key = $attach.attr("data-xhr");
		logger.info("key=" + key);
		var xhr = bc.attach.xhrs[key];
		if(xhr){
			logger.info("xhr.abort");
			xhr.abort();
			xhr = null;
		}
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
				}
			}
		});
	},
	/** 删除所有附件 */
	deleteAll: function(attachsEl,callback){
		var $attachs = $(attachsEl);
		if($attachs.find(".attach").size()){
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
					}
				}
			});
		}else{
			bc.msg.slide("当前没有可删除的附件！");
		}
	},
	/**
	 * 经典的文件上传处理
	 * @param {Object} option 配置参数
	 * @option {String} ptype 
	 */
	html4upload:function(option){
		
	},
	getSizeInfo: function(size){
		if (size < 1024)
			return bc.formatNumber(size,"#.#") + "Bytes";
		else if (size < 1024 * 1024)
			return bc.formatNumber(size/1024,"#.#") + "KB";
		else
			return bc.formatNumber(size/1024/1024,"#.#") + "MB";
		
    }
};

(function($){

//初始化文件控件的选择事件
$(":file.uploadFile").live("change",function(e){
	var $atm = $(this).parents(".attachs");
	if($.browser.safari || $.browser.mozilla){//Chrome12、Safari5、Firefox4
		logger.info("uploadFile with html5");
		bc.attach.html5upload.call($atm[0],e.target.files,{
			ptype: $atm.attr("data-ptype")
			,puid: $atm.attr("data-puid") || $atm.parents("form").find(":input:hidden[name='e.uid']").val()
		});
	}else{//Opera、IE等其他
		logger.info("uploadFile with html4");
	}
});

//单个附件的操作按钮
$(".attachs .operation").live("click",function(e){
	$this = $(this);
	var action = $this.attr("data-action");//内定的操作
	var callback = $this.attr("data-callback");//回调函数
	callback = callback ? bc.getNested(callback) : undefined;//转换为函数
	$attach = $this.parents(".attach");
	switch (action){
	case "abort"://取消附件的上传
		bc.attach.abortHtml5Upload($attach[0],callback);
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
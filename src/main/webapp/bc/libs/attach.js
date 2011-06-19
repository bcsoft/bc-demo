/**
 * 附件上传
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend attach.css
 */
bc.attach={
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
	html5upload:function(files,option){
		var $atm = $(this);
	    //html5上传文件(不要批量异步上传，实测会乱，如Chrome后台合并为一个文件等，需逐个上传)
		//用户选择的文件(name、fileName、type、size、fileSize、lastModifiedDate)
	    var url = option.url || bc.root+"/upload4xhEditor/?type=img";
	    if(option.ptype) url+="&ptype=" + option.ptype;
	    if(option.puid) url+="&puid=" + option.puid;
	    
	    //检测文件数量的限制
	    var maxCount = parseInt($atm.attr("data-maxCount"));
	    if(!isNaN(maxCount) && files.length > maxCount){
	    	alert("请不要一次上传超过" + maxCount + "个文件！");
	    	return;
	    }
	    
	    //检测文件大小的限制
	    var maxSize = parseInt($atm.attr("data-maxSize"));
	    if(!isNaN(maxSize)){
	    	for(var i=0;i<files.length;i++){
	    		if(files[i].fileSize > maxSize){
		    		alert("请不要上传大小超过" + getSizeInfo(maxSize) + "的文件！");
		    		return;
	    		}
	    	}
	    }
	    
	    //检测文件类型的限制
	    var _extends = $atm.attr("data-extends");//用逗号连接的扩展名列表
	    var fileName;
	    if(_extends && _extends.length > 0){
	    	for(var i=0;i<files.length;i++){
	    		fileName = files[i].fileName;
	    		if(_extends.indexOf(fileName.substr(fileName.lastIndexOf(".") + 1)) == -1){
		    		alert("只能上传扩展名为\"" + _extends.replace(/,/g,"、") + "\"的文件！");
		    		return;
	    		}
	    	}
	    }

	    //开始上传
	    var i = 0;
	    uploadNext();
		
	    //逐一上传文件
		function uploadNext(){
	    	if(i >= files.length)
	    		return;//全部上传完毕
	    	
			logger.info("uploading:i=" + i);
			//继续上传下一个附件
			uploadOneFile(files[i],url,uploadNext);
		}
	   
		//上传一个文件
	    function uploadOneFile(f,url,callback){
	    	var xhr = new XMLHttpRequest();
	    	var key = "k" + new Date().getTime();
	    	bc.attach.xhrs[key] = xhr;
			//上传进度显示
			var fileName = f.fileName;
			var extend = fileName.substr(fileName.lastIndexOf(".")+1);
			var attach = ''+
				'<table class="attach" cellpadding="0" cellspacing="0" data-xhr=' + key + '>'+
					'<tr>'+
						'<td class="icon"><span class="file-icon ' + extend + '"></span></td>'+
						'<td class="info">'+
							'<div class="subject">' + fileName + '</div>'+
							'<table class="operations" cellpadding="0" cellspacing="0">'+
								'<tr>'+
								'<td class="size">' + getSizeInfo(f.fileSize) + '</td>'+
								'<td><div class="progressbar"></div></td>'+
								'<td><a href="#" class="operation" data-action="abort">取消</a></td>'+
								'</tr>'+
							'</table>'+
						'</td>'+
					'</tr>'+
				'</table>';
			var $attach = $(attach).appendTo($atm);
			var $progressbar = $attach.find(".progressbar").progressbar();
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
					
					//删除进度条显示附件操作按钮（延时2秒后执行）
					setTimeout(function(){
						var tds = $progressbar.parent();
						var $operations = tds.next();
						tds.remove();
						$operations.empty().append('<a href="#" class="operation" data-action="open">查看</a>'+
							'<a href="#" class="operation" data-action="download">下载</a>'+
							'<a href="#" class="operation" data-action="delete">删除</a>');
						
						$attach.attr("data-id",json.msg.id)
							.attr("data-name",json.msg.localfile)
							.attr("data-url",json.msg.url);
					},2000000000);
					
					//调用回调函数
					if(typeof callback == "function")
						callback();
				}else{
					//alert("upload error!");
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
	    
	    function getSizeInfo(size){
			if (size < 1024)
				return size + "Bytes";
			else if (size < 1024 * 1024)
				return size/1024 + "KB";
			else
				return size/1024/1024 + "MB";
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
	open: function(attachEl,callback){
		
	},
	/** 下载附件 */
	download: function(attachEl,callback){
		
	},
	/** 删除附件 */
	delete_: function(attachEl,callback){
		
	},
	/**
	 * 经典的文件上传处理
	 * @param {Object} option 配置参数
	 * @option {String} ptype 
	 */
	html4upload:function(option){
		
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
$(".attach .operation").live("click",function(e){
	$this = $(this);
	var action = $this.attr("data-action");//内定的操作
	var callback = $this.attr("data-callback");//回调函数
	callback = callback ? bc.getNested(callback) : undefined;//转换为函数
	$attach = $this.parents(".attach");
	switch (action){
	case "abort"://取消附件的上传
		bc.attach.abortHtml5Upload($attach[0],callback);
		break;
	case "open"://打开附件
		bc.attach.open($attach[0],callback);
		break;
	case "delete"://删除附件
		bc.attach.delete_($attach[0],callback);
		break;
	case "download"://下载附件
		bc.attach.download($attach[0],callback);
		break;
	default ://调用自定义的函数
		var click = $this.attr("data-click");
		if(typeof click == "string"){
			var clickFn = bc.getNested(click);//将函数名称转换为函数
			if(typeof clickFn == "function")
				clickFn.call($attach[0],callback);
			else
				alert("没有定义'" + click + "'函数");
		}
		break;
	}
	
	return false;
});

})(jQuery);
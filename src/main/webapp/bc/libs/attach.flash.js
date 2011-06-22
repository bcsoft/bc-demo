/**
 * flash附件上传
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 * @depend attach.js,attach.css
 */
bc.attach.flash={
	init:function(option){
		var $atm = $(this);
	    var url = option.url || bc.root+"/upload4xhEditor/?type=img";
	    if(option.ptype) url+="&ptype=" + option.ptype;
	    if(option.puid) url+="&puid=" + option.puid;
		var swfuCfg = {
			upload_url : url,
			flash_url : bc.root+"/ui-libs/swfupload/2.2.0.1/swfupload.swf",
			file_post_name : "filedata",
			file_types : "*.*",
			file_types_description: "所有文件",
			button_width: "60",
			button_height: "21",
			button_placeholder_id: $atm.attr("id")+"_UPLOAD_PLACEHOLDER",
			button_text: '<span class="theFont">上传</span>',
			button_text_style: ".theFont{font-size:12;}",
			button_text_left_padding: 25,
			button_text_top_padding: 0,
			button_action : SWFUpload.BUTTON_ACTION.SELECT_FILES, 
			button_disabled : false, 
			button_cursor : SWFUpload.CURSOR.HAND, 
			button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
			button_image_url : contextPath + "/oz-platform/themes/default/images/attachment/upload-button_60x21.png", 
			debug:false,
			custom_settings : {
				atmId : $atm.attr("id"),
				infoId : $atm.attr("id")+"_INFO",
				totalSize: 0,
				finishedSize: 0
			},
			
			// The event handler functions
			file_queued_handler : OZ.Attachment.Flash.EventFn.fileQueued,
			file_queue_error_handler : OZ.Attachment.Flash.EventFn.fileQueueError,
			file_dialog_complete_handler : OZ.Attachment.Flash.EventFn.fileDialogComplete,
			upload_start_handler : OZ.Attachment.Flash.EventFn.uploadStart,
			upload_progress_handler : OZ.Attachment.Flash.EventFn.uploadProgress,
			upload_error_handler : OZ.Attachment.Flash.EventFn.uploadError,
			upload_success_handler : OZ.Attachment.Flash.EventFn.uploadSuccess,
			upload_complete_handler : OZ.Attachment.Flash.EventFn.uploadComplete,
			
			// 浏览器flash插件的控制：需要swfupload.swfobject.js插件的支持
			minimum_flash_version: "9.0.28",
			swfupload_pre_load_handler: OZ.Attachment.Flash.EventFn.swfuploadPreLoad,
			swfupload_load_failed_handler: OZ.Attachment.Flash.EventFn.swfuploadLoadFailed
		};
		ozlog.info("upload_url=" + swfuCfg.upload_url);
		//文件大小限制
		if($atm.attr("maxSize").length>0)swfuCfg.file_size_limit=$atm.attr("maxSize");
		//文件过滤控制
		if($atm.attr("filter").length>0){
			var all = $atm.attr("filter").split("|");
			swfuCfg.file_types=all[0];
			if(all.length >1)swfuCfg.file_types_description=all[1];
		}
		OZ.Attachment.Flash.Controls.push(new SWFUpload(swfuCfg));
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
			$(attach).attr("data-xhr",key).insertBefore($atm.find(".attach:first")).find(".progressbar").progressbar();
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
					var newSize = parseInt($totalSize.attr("data-size")) + parseInt($attach.attr("data-size"));
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
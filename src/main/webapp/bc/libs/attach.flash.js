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
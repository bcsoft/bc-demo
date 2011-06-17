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
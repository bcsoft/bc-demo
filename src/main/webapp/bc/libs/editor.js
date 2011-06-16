/**
 * 富文本编辑器
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 */
bc.editor={
	/**
	 * 构建富文本编辑器的默认配置
	 */
	getConfig:function(option){
		var belong = "";
		if(typeof option == "string"){
			belong = "&belong=" + option;
			option = {};
		}else if(typeof option == "object" && option.belong){
			belong = "&belong=" + option.option;
		}else{
			option = {};
		}
			
		return jQuery.extend({
			//参考：http://xheditor.com/manual/2
			//参数值：full(完全),mfull(多行完全),simple(简单),mini(迷你)
			//或者自定义字符串，例如：'Paste,Pastetext,|,Source,Fullscreen,About'
			tools:'mfull'
			//图片上传接口地址
			,upImgUrl:bc.root + "/upload4xhEditor/?type=img" + belong
			//图片上传前限制的文件扩展名列表，默认为：jpg,jpeg,gif,png
			//,upImgExt:"jpg,jpeg,gif,png"
			//动画上传接口地址
			,upFlashUrl:bc.root + "/upload4xhEditor/?type=flash" + belong
			//动画上传前限制的文件扩展名列表，默认为：swf
			//,upFlashExt:"swf"
			//视频上传接口地址
			,upMediaUrl:bc.root + "/upload4xhEditor/?type=media" + belong
			//视频上传前限制的文件扩展名列表，默认为：avi
			//,upMediaExt:"avi"
		},option);
	},
	readOnly:{
		tools:''
	}
};
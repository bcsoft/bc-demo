/**
 * 对$.ajax的通用封装
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.ajax = function(option){
	option = option || {};
	$.extend(option,{
		type: "POST",
		error: function(request, textStatus, errorThrown) {
			var msg = "bc.ajax: textStatus=" + textStatus + ";errorThrown=" + errorThrown;
			logger.error(msg);
			alert(msg);
		}
	});
	jQuery.ajax(option);
};
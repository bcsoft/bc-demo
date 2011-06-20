/**
 * 核心处理函数集
 *
 * @author rongjihuang@gmail.com
 * @date 2011-04-11
 * @dep jquery
 */

if(!window['bc'])window['bc']={};

/**
 * 字符串格式化处理函数
 * 使用方式：
 * 1) var t="({0}),FF{1}".format("value0","value1") -->t=(value0),FFvalue1
 * 2) var t=String.format("({0}),FF{1}","value0","value1") -->t=(value0),FFvalue1
 */
String.format=function(format){
	var args = Array.prototype.slice.call(arguments, 1);
	return (format+"").replace(/\{(\d+)\}/g, function(m, i){
        return args[i];
    });
};
String.prototype.format=function(){
    var args = arguments;
    return (this+"").replace(/\{(\d+)\}/g, function(m, i){
        return args[i];
    });
};

/**
 * 日期格式化处理函数
 * 对Date的扩展，将 Date 转化为指定格式的String
 * 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
 * 例子： 
 * (new Date()).format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
 * (new Date()).format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
 */
Date.format=function(_date){
	var args = Array.prototype.slice.call(arguments, 1);
	return _date.format.apply(_date,args);
};
Date.prototype.format = function(format){ 
  var o = {
    "M+" : this.getMonth()+1, //month 
    "d+" : this.getDate(),    //day 
    "h+" : this.getHours(),   //hour 
    "m+" : this.getMinutes(), //minute 
    "s+" : this.getSeconds(), //second 
    "q+" : Math.floor((this.getMonth()+3)/3),  //quarter 
    "S" : this.getMilliseconds() //millisecond 
  } 
  if(/(y+)/.test(format)) 
	  format=format.replace(RegExp.$1,(this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o)
	  if(new RegExp("("+ k +")").test(format)) 
		  format = format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
  return format; 
}

/** 获取新的唯一id值: var newId = bc.nextId();*/
bc.id=0;
bc.nextId=function(prefix){return (prefix ? prefix : "bc") + (bc.id++)};

/** 获取使用符号"."连接的嵌套对象,如a.b.c返回window[a][b][c]或eval(a.b.c) */
bc.getNested=function(nestedName){
	try{
		var names = nestedName.split(".");
		var result = window[names[0]];
		for(var i=1;i<names.length;i++)
			result = result[names[i]];
		return result;
	}catch(e){
		logger.error("error get:" + nestedName + ";e=" + e);
	}
};
/** 得到字符串的真实长度（双字节换算为两个单字节）*/
bc.getStringActualLen=function(sourceString){  
    return sourceString.replace(/[^\x00-\xff]/g,"xx").length;  
};
/** 向指定的url路径末端添加参数
 * @param url url路径
 * @param keyValue 名值对，格式为“key=value”
 * @return 添加参数/值后的url
 */
bc.addParamToUrl=function(url,keyValue){  
    if (url == null) return url;
    if (!keyValue) return url;
    var hasParam = (url.indexOf("?") != -1);
    if(url.indexOf("ts=0") != -1){//强制不添加ts的配置
    	return url;
    }else{
    	return url + (hasParam?"&":"?") + keyValue;
    }
};

/** 
 * 格式化数字显示方式  
 * 用法 
 * bc.formatNumber(12345.999,'#,##0.00'); 
 * bc.formatNumber(12345.999,'#,##0.##'); 
 * bc.formatNumber(123,'000000'); 
 * @param num 
 * @param pattern 
 */  
bc.formatNumber = function(num, pattern) {
	var strarr = num ? num.toString().split('.') : [ '0' ];
	var fmtarr = pattern ? pattern.split('.') : [ '' ];
	var retstr = '';

	// 整数部分  
	var str = strarr[0];
	var fmt = fmtarr[0];
	var i = str.length - 1;
	var comma = false;
	for ( var f = fmt.length - 1; f >= 0; f--) {
		switch (fmt.substr(f, 1)) {
		case '#':
			if (i >= 0)
				retstr = str.substr(i--, 1) + retstr;
			break;
		case '0':
			if (i >= 0)
				retstr = str.substr(i--, 1) + retstr;
			else
				retstr = '0' + retstr;
			break;
		case ',':
			comma = true;
			retstr = ',' + retstr;
			break;
		}
	}
	if (i >= 0) {
		if (comma) {
			var l = str.length;
			for (; i >= 0; i--) {
				retstr = str.substr(i, 1) + retstr;
				if (i > 0 && ((l - i) % 3) == 0)
					retstr = ',' + retstr;
			}
		} else
			retstr = str.substr(0, i + 1) + retstr;
	}

	retstr = retstr + '.';
	// 处理小数部分  
	str = strarr.length > 1 ? strarr[1] : '';
	fmt = fmtarr.length > 1 ? fmtarr[1] : '';
	i = 0;
	for ( var f = 0; f < fmt.length; f++) {
		switch (fmt.substr(f, 1)) {
		case '#':
			if (i < str.length)
				retstr += str.substr(i++, 1);
			break;
		case '0':
			if (i < str.length)
				retstr += str.substr(i++, 1);
			else
				retstr += '0';
			break;
		}
	}
	return retstr.replace(/^,+/, '').replace(/\.$/, '');
}
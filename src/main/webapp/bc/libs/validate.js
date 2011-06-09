/**
 * 表单验证常用函数
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.validator = {
	/**
	 * 表单验证
	 * <input ... data-validate='{required:true,type:"number",max:10,min:5}'/>
	 * type的值控制各种不同的验证方式：
	 * 1) undefined或required 最简单的必填域验证，值不为空即可
	 * 2) number 数字(正数、负数、小数)
	 * 3) digits 整数
	 * 4) email 电子邮件 TODO
	 * 5) url 网址 TODO
	 * 6) date 日期 TODO
	 * 7) datetime 日期时间 TODO
	 * 8) time 时间 TODO
	 * 9) phone 电话号码
	 * min的值控制数字的最小值
	 * max的值控制数字的最大值
	 * minLen的值控制字符串的最小长度(中文按两个字符长度计算)
	 * maxLen的值控制字符串的最大长度(中文按两个字符长度计算)
	 * 如果无需配置其他属性，type的值可以直接配置为validate的值，如<input ... data-validate="number"/>
	 * required的值控制是否必须填写true|false
	 * @$form 表单form的jquery对象
	 */
	validate: function($form) {
		var ok = true;
		$form.find(":input:enabled:not(:hidden):not(:button)")
		.each(function(i, n){
			var validate = $(this).attr("data-validate");
			if(logger.debugEnabled)
				logger.debug(this.nodeName + "," + this.name + "," + this.value + "," + validate);
			if(validate && $.trim(validate).length > 0){
				if(!/^\{/.test(validate)){//不是以字符{开头
					validate = '{"required":true,"type":"' + validate + '"}';//默认必填
				}
				validate = jQuery.parseJSON(validate);
				var method = bc.validator.methods[validate.type];
				if(method){
					var value = $(this).val();
					if(validate.required || (value && value.length > 0)){//必填或有值时
						ok = method.call(validate, this, $form);
						if(!ok){//验证不通过，增加界面的提示
							bc.validator.remind(this,validate.type);
						}
					}
					return ok;
				}else{
					logger.error("undefined method: bc.validator.methods['" + validate.type + "']");
				}
			}
		});
		return ok;
	},
	/**各种验证方法，可以自行扩展新的验证方法，方法的上下文为对象的验证配置*/
	methods:{
		/**必填*/
		required: function(element, $form) {
			switch( element.nodeName.toLowerCase() ) {
			case 'select':
				// could be an array for select-multiple or a string, both are fine this way
				var val = $(element).val();
				return val && val.length > 0;
			case 'input':
				if(/radio|checkbox/i.test(element.type)){//多选和单选框
					return $form.find("input:checked[name='" + element.name + "']").length > 0;
				}
			default:
				return $.trim($(element).val()).length > 0;
			}
		},
		/**数字*/
		number: function(element) {
			return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(element.value);
		},
		/**电话号码与手机号码同时验证
		 * 匹配格式：11位手机号码;3-4位区号、7-8位直播号码、1－4位分机号
		 */
		phone: function(element) {
			return /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/.test(element.value);
		},
		/**正数*/
		digits: function(element) {
			return /^\d+$/.test(element.value);
		},
		/**字符串最小长度*/
		minLen: function(element) {
			return bc.getStringActualLen(element.value) >= this.minLen;
		},
		/**字符串最大长度*/
		maxLen: function(element) {
			return bc.getStringActualLen(element.value) <= this.maxLen;
		},
		/**最小值*/
		min: function(element) {
			return element.value >= this.minValue;
		},
		/**最大值*/
		max: function(element) {
			return element.value <= this.maxValue;
		},
		/**email*/
		email: function(element) {
			return /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/.test(element.value);
		}
	},
	/**
	 * 显示验证不通过的提示信息
	 * @element 验证不通过的dom元素
	 * @validateType 验证的类型
	 */
	remind: function(element,validateType){
		bc.boxPointer.show({of:element,content:bc.validator.messages[validateType]});
	},
	messages:{
		required:"这里必须填写哦！",
		number: "这里必须填写数字哦！<br>如 12、1.2。",
		digits: "这里必须填写整数哦！<br>如 12。",
		email: "请输入正确格式的电子邮件！<br>如 bc@163.com。",
		phone: "请输入正确格式的电话号码！<br>如 13011112222、88887777、88887777-800、020-88887777-800。",
		url: "请输入正确格式的网址！<br>如 http://www.google.com。",
		date: "请输入正确格式的日期！<br>如 2011-01-01。",
		datetime: "请输入正确格式的日期时间！<br>如 2011-01-01 13:30。",
		time: "请输入正确格式的时间！<br>如 13:30。",
		maxLen: "这里至少需要输入 {0}个字符！",
		minLen: "这里最多只能输入 {0}个字符！",
		max: "这个值不能小于 {0}！",
		min: "这个值不能大于 {0}！"
	}
};
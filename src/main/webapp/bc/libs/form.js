/**
 * 表单的全局处理
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-04-24
 */
bc.form = {
	/** 全局初始化表单元素的事件绑定,
	 * 在表单加载后由系统自动调用进行绑定，
	 * 函数的第一参数为表单元素的容器对象
	 */
	init : function($form) {
		//选择日期
		$form.find('.bc-date[readonly!="readonly"]').datepicker({
			showWeek: true,
			//showButtonPanel: true,//现时今天按钮
			firstDay: 7,
			dateFormat:"yy-mm-dd"//yy4位年份、MM-大写的月份
		});
	}
};
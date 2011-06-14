bc.bulletinForm = {
	init : function() {
		var $form = $(this);

		//绑定日期选择
		$form.find(":input[name='e.overdueDate']").datepicker({
			dateFormat:"yy-mm-dd",firstDay: 7
			//,showButtonPanel: true	今天按钮
		});
	}
};
bc.bulletinForm = {
	init : function() {
		var $form = $(this);

		//绑定日期选择$('#elm1').xheditor({tools:'full'});
		$form.find(":input[name='e.overdueDate']").datepicker({
			dateFormat:"yy-mm-dd",firstDay: 7
			//,showButtonPanel: true	今天按钮
		});

		//绑定富文本编辑
		$form.find("textarea").xheditor(bc.editor.getConfig({
			ptype: "bulletin.editor",
			puid: $form.find(":input[name='e.uid']").val()
		}));
	}
};
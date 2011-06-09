bc.selectGroup = {
	init : function() {
		var $page = $(this);
		//绑定双击事件
		$page.find("select").dblclick(function(){
			bc.selectGroup.clickOk.call($page[0]);
		});
	},
	clickOk : function() {
		var $page = $(this);
		var select = $page.find("select")[0];
		if(select.selectedIndex == -1){
			bc.msg.slide("必须先选择岗位信息！");
			return false;
		}
		var item;
		if(select.multiple){
			item=[];
			// 循环选定的每一个项目，将该项添加到列表中
			for (var i = 0; i < select.length; i++){
				if (select.options[i].selected){
					item.push({id: select.options[i].value,name: select.options[i].text});
				}
			}
		}else{
			item={id: select.value,name: select.options[select.selectedIndex].text};
		}
		$page.data("data-status",item);
		$page.dialog("close");
	}
}
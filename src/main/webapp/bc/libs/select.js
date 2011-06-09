/**
 * select列表框常用函数
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-06-01
 */
bc.select={
	/**
	 * 将指定源列表选中的选项添加到指定的目标列表中(会自动处理重复)
	 * @param sourceEl 源列表
	 * @param targetEl 目标列表
	 * @param clear [可选]是否删除源列表中选中的项，默认为false
	 */
	appendSelected:function(sourceEl,targetEl,clear){
		if (sourceEl==null || targetEl==null)
			return;
		
		// 循环用户选定的每一个项目，将该项添加到指定列表中
		for (var i = 0; i < sourceEl.length; i++){
			if (sourceEl.options[i].selected){
				var selValue = sourceEl.options[i].value;
				
				// 判断是否已经添加
				if(!bc.select.isExist(targetEl, selValue)){
					targetEl.options[targetEl.length] = new Option(sourceEl.options[i].text, sourceEl.options[i].value);
				}
			}
		}
		
	     // 删除源列表中选中的项
		 if(clear) bc.select.removeSelected(sourceEl);
	},
	/** */
	appendAll:function(sourceEl,targetEl,clear){
		if (sourceEl==null || targetEl==null)
			return;
		
		// 循环用户选定的每一个项目，将该项添加到指定列表中
		for (var i = 0; i < sourceEl.length; i++){
			var selValue = sourceEl.options[i].value;
			
			// 判断是否已经添加
			if(!bc.select.isExist(targetEl, selValue)){
				targetEl.options[targetEl.length] = new Option(sourceEl.options[i].text, sourceEl.options[i].value);
			}
		}
		
		// 删除源列表中选中的项
		if(clear) bc.select.removeAll(sourceEl);
	},
	/**
	 * 删除列表中选中的项
	 * @param selectEl 列表
	 */
	removeSelected:function(selectEl){
		if (selectEl==null) return;
	
		var len = selectEl.length;
		for(var i=len-1; i>=0; i--){
			if(selectEl.options[i].selected){
				selectEl.options[i] = null;//删掉该选项
			}
		}
	},
	/**
	 * 删除列表中的所有项
	 * @param selectEl 列表
	 */
	removeAll:function(selectEl){
		if (selectEl==null) return;
		selectEl.length = 0;
	},
	/**
	 * 判断指定的列表中是否存在指定的值
	 * @param selectEl 列表
	 * @param value 要判断的值
	 */
	isExist:function(selectEl, value){
		if(null == selectEl) return false;
		
		for(var j = 0; j < selectEl.length; j++){
			if(selectEl.options[j].value == value)
				return true;
		}
		return false;
	},
	/**
	 * 选中指定列表中的所有选项
	 * @param selectEls 列表数组
	 * @param value 要判断的值
	 */
	selectAll:function(selectEls){
		if(!selectEls) return;
		var selectEl;
		for(var i=0; i<selectEls.length; i++){
			selectEl = document.getElementById(selectEls[i]);
			for(var j = 0; j < selectEl.length; j++){
				selectEl.options[j].selected = true;
			}
		}
	}
};
/**
 * 混合图表
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-05-28
 * @depend highcharts/2.1.4
 */
(function($) {

bc.mixChartDemo = {
	init: function() {
		var config = eval("("+this.find(".config").text()+")");
		new Highcharts.Chart(config);
	}
};

})(jQuery);
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='柱图演示'' 
	class="bc-page chart" style="overflow: auto;"
	data-type='chart' 
	data-js='<s:url value="/ui-libs/highcharts/2.1.4/highcharts.min.js?ts=0" />,<s:url value="/ui-libs/highcharts/2.1.4/modules/exporting.min.js?ts=0" />,<s:url value="/bc-test/chart/bar.js" />'
	data-initMethod='bc.barDemo.init'
	data-option='{"width":500,"height":300}'>
<div class="chartContainer" style="height:100%;width:100%;"></div>
<pre class="config hide">
{
	chart: {
		renderTo: this.find(".chartContainer")[0],
		defaultSeriesType: 'column'
	},
	title: {
		text: '带负值的柱图演示'
	},
	xAxis: {
		categories: ['苹果', '橙子', '梨子', '葡萄', '香蕉']
	},
	yAxis: {
		title: {
			text: '数值'
		}
	},
	tooltip: {
		formatter: function() {
			return ''+
				 this.series.name +': '+ this.y +'';
		}
	},
	credits: {
		enabled: false
	},
	series: [{
		name: '小红',
		data: [5, 3, 4, 7, 2]
	}, {
		name: '小明',
		data: [2, -2, -3, 2, 1]
	}, {
		name: '老李',
		data: [3, 4, 4, -2, 5]
	}],
	exporting:{url:'<s:url value="/bc/exportsvg" />'}
}
</pre>
</div>
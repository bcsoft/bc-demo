<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='混合图表'' 
	class="bc-page chart" style="overflow: auto;"
	data-type='chart' 
	data-js='<s:url value="/ui-libs/highcharts/2.1.4/highcharts.min.js?ts=0" />,<s:url value="/ui-libs/highcharts/2.1.4/modules/exporting.min.js?ts=0" />,<s:url value="/bc-test/chart/mix.js" />'
	data-initMethod='bc.mixChartDemo.init'
	data-option='{"width":600,"height":350}'>
<div class="chartContainer" style="height:100%;width:100%;"></div>
<pre class="config hide">
{
	chart: {
		renderTo: this.find(".chartContainer")[0],
	},
	title: {
		text: '混合图表'
	},
	xAxis: {
		categories: ['苹果', '橙子', '梨子', '葡萄', '香蕉']
	},
	tooltip: {
		formatter: function() {
			var s;
			if (this.point.name) { // the pie chart
				s = ''+
					this.point.name +': '+ this.y +' fruits';
			} else {
				s = ''+
					this.x  +': '+ this.y;
			}
			return s;
		}
	},
	labels: {
		items: [{
			html: '总消费量',
			style: {
				left: '40px',
				top: '8px',
				color: 'black'				
			}
		}]
	},
	series: [{
		type: 'column',
		name: '小红',
		data: [3, 2, 1, 3, 4]
	}, {
		type: 'column',
		name: '小明',
		data: [2, 3, 5, 7, 6]
	}, {
		type: 'column',
		name: '老李',
		data: [4, 3, 3, 9, 0]
	}, {
		type: 'spline',
		name: '平均',
		data: [3, 2.67, 3, 6.33, 3.33]
	}, {
		type: 'pie',
		name: 'Total consumption',
		data: [{
			name: '小红',
			y: 13,
			color: '#4572A7' // Jane's color
		}, {
			name: '小明',
			y: 23,
			color: '#AA4643' // John's color
		}, {
			name: '老李',
			y: 19,
			color: '#89A54E' // Joe's color
		}],
		center: [100, 80],
		size: 100,
		showInLegend: false,
		dataLabels: {
			enabled: false
		}
	}],
	exporting:{url:'<s:url value="/bc/exportsvg" />'}
}
</pre>
</div>
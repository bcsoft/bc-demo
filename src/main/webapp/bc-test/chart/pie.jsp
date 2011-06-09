<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='浏览器市场份额比例图'' 
	class="bc-page chart" style="overflow: auto;"
	data-type='chart' 
	data-js='<s:url value="/ui-libs/highcharts/2.1.4/highcharts.min.js?ts=0" />,<s:url value="/ui-libs/highcharts/2.1.4/modules/exporting.min.js?ts=0" />,<s:url value="/bc-test/chart/pie.js" />'
	data-initMethod='bc.pieDemo.init'
	data-option='{"width":450,"height":350}'>
<div class="chartContainer" style="height:100%;width:100%;"></div>
<pre class="config hide">
{
	chart: {
		renderTo: this.find(".chartContainer")[0],
		plotBackgroundColor: null,
		plotBorderWidth: null,
		plotShadow: false
	},
	title: {
		text: '2010年度浏览器市场份额'
	},
	tooltip: {
		formatter: function() {
			return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
		}
	},
	plotOptions: {
		pie: {
			allowPointSelect: true,
			cursor: 'pointer',
			dataLabels: {
				enabled: true,
				color: '#000000',
				connectorColor: '#000000',
				formatter: function() {
					return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
				}
			}
		}
	},
    series: [{
		type: 'pie',
		name: 'Browser share',
		data: [
			['Firefox',   45.0],
			['IE',       26.8],
			{
				name: 'Chrome',    
				y: 12.8,
				sliced: true,
				selected: true
			},
			['Safari',    8.5],
			['Opera',     6.2],
			['Others',   0.7]
		]
	}],
	exporting:{url:'<s:url value="/bc/exportsvg" />'}
}
</pre>
</div>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='动态曲线图'' 
	class="bc-page chart" style="overflow: auto;"
	data-type='chart' 
	data-js='<s:url value="/ui-libs/highcharts/2.1.4/highcharts.min.js?ts=0" />,<s:url value="/bc-test/chart/spline.js" />'
	data-initMethod='bc.splineDemo.init'
	data-option='{"width":600,"height":350}'>
<div class="chartContainer" style="height:100%;width:100%;"></div>
<pre class="config hide">
{
	chart: {
		renderTo: this.find(".chartContainer")[0],
		defaultSeriesType: 'spline',
		marginRight: 10,
		events: {
			load: function() {

				// set up the updating of the chart each second
				var series = this.series[0];
				setInterval(function() {
					var x = (new Date()).getTime(), // current time
						y = Math.random();
					series.addPoint([x, y], true, true);
				}, 1000);
			}
		}
	},
	title: {
		text: '动态统计'
	},
	xAxis: {
		type: 'datetime',
		tickPixelInterval: 150
	},
	yAxis: {
		title: {
			text: '数值'
		},
		plotLines: [{
			value: 0,
			width: 1,
			color: '#808080'
		}]
	},
	tooltip: {
		formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+
				Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+ 
				Highcharts.numberFormat(this.y, 2);
		}
	},
	legend: {
		enabled: false
	},
	exporting: {
		enabled: false
	},
	series: [{
		name: 'Random data',
		data: (function() {
			// generate an array of random data
			var data = [],
				time = (new Date()).getTime(),
				i;
			for (i = -19; i <= 0; i++) {
				data.push({
					x: time + i * 1000,
					y: Math.random()
				});
			}
			return data;
		})()
	}]
}
</pre>
</div>
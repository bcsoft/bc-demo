/**
 * JS、CSS文件加载器
 *
 * @author rongjihuang@gmail.com
 * @date 2011-04-11
 * @ref modify from nbl.plus.js v2.0
 */

if(!window['bc'])window['bc']={};
bc.loader = {
	c: document,
	q: {}, // The dictionary that will hold the script-queue
	n: null,
	
	// The loader function
	//
	// Called with an array, it will interpret the options array
	// Called without an array it will try to load the options from the script-tag's data-nbl attribute
	l: function(a) { 
		//alert(a);
		var b, c, x, y, z, s, l, i = j = 0, m = bc.loader; m.h = m.c.head || m.c.body;
		
		// The timeout counter, counts backwards every 50ms from 50 ticks (50*50=2500ms by default)
		if (!m.i) {
			m.s = m.f = 0; // Reset counters: completed, created, timeout function
			m.i = setInterval(
				function() { 
					//logger.info("setInterval0");
					// If the timeout counter dips below zero, or the amount of completed scripts equals the amount 
					// of created script-tags, we can clear the interval
					if (m.o < 0 || m.s == 0) { 
						m.i = clearInterval(m.i); 
						// If the amount of completed scripts is smaller than the amount of created script-tags,
						// and there is a timeout function available, call it with the current script-queue.
						(m.s > 0 && m.f) && m.f(m.q)
					} 
					m.o--
					//logger.info("setInterval1");
				},
				m.o = 50 // Set the initial ticks at 50, as well as the interval at 50ms
			);
		}

		// If no arguments were given (a == l, which is null), try to load the options from the script tag
		if (a == m.n) {
			s = m.c.getElementsByTagName("script"); // Get all script tags in the current document
			while (j < s.length) {
				if ((a = eval("("+s[j].getAttribute("data-nbl")+")")) && a) { // Check for the data-nbl attribute
					m.h = s[j].parentNode;
					break
				}
				j++
			}
		}
		
		// If an options array was provided, proceed to interpret it
		if (a&&a.shift) {
			while (i < a.length) { // Loop through the options
				//logger.info("i="+i);
				b = a[i]; // Get the current element
				c = a[i+1]; // Get the next element
				x = 'function';
				y = typeof b; 
				z = typeof c;
				l = (z == x) ? c : (y == x) ? b : m.n; // Check whether the current or next element is a function and store it
				if (y == 'number') m.o = b/50; // If the current element is a number, set the timeout interval to this number/50
				// If the current element is a string, call this.a() with the string as a one-element array and the callback function l
				if (y == 'string') m.a([b], l); 
				// If the current element is an array, call this.a() with a two-element array of the string and the next element
				// as well as the callback function l
				b.shift && m.a([b.shift(), b], l); 
				if (!m.f && l) m.f = l; // Store the function l as the timeout function if it hasn't been set yet
				i++;
			}
		}
	},
	a: function(u,l) {
		logger.info("call a");
		var s, t, m = this, n = u[0].replace(/.+\/|\.min\.js|\.js|\?.+|\W/g, ''), k = {js: {t: "script", a: "src"}, css: {t: "link", a: "href", r: "stylesheet"}, "i": {t: "img", a: "src"}}; // Clean up the name of the script for storage in the queue
		t = u[0].match(/\.(js|css).*$/i); t = (t) ? t[1] : "i";
		n=u[0];
		if(m.q[n] === true){
			if(logger.debugEnabled)logger.debug("loader: skip load '" + u[0] + "'");
			l && l(); // Call the callback function l
			if(u[1]){
				logger.debug("loader: start load next after skip '" + u[0] + "'");
				m.l(u[1]);
			}
			return;//避免重复加载和解析
		}
		s = m.q[n] = m.c.createElement(k[t].t);
		var file = u[0];
		file = bc.addParamToUrl(file,"ts="+bc.ts);// 附加时间挫
			
		s.setAttribute(k[t].a, file);
		// Fix: CSS links do not fire onload events - Richard Lopes
		// Images do. Limitation: no callback function possible after CSS loads
		if (k[t].r){
			s.setAttribute("rel", k[t].r);
			m.q[n] = true;//强制设为true
			clearInterval(m.i); 
			if(logger.debugEnabled)logger.debug("loader|css: loading css '" + file + "'" + (l ? " and call the callback" : ""));
			l && l(); // Call the callback function l
			if(logger.debugEnabled)logger.debug("loader|css: append '" + file + "' to head");
			if(u[1]){
				logger.debug("loader|css: start load next after loaded '" + file + "'");
				m.l(u[1]);
			}
		}else {
			// When this script completes loading, it will trigger a callback function consisting of two things:
			// 1. It will call nbl.l() with the remaining items in u[1] (if there are any)
			// 2. It will execute the function l (if it is a function)
			s.onload = function(){
				clearInterval(m.i); 
				if(logger.debugEnabled)logger.debug("loader|js: finished loaded js'" + file + "'" + (l ? " and call the callback" : ""));
				var s = this, d = function(){
					var s = m, r = u[1]; 
					s.q[n] = true; // Set the entry for this script in the script-queue to true
					//r && s.l(r); // Call nbl.l() with the remaining elements of the original array
					if(r){
						logger.debug("loader|js: start load next after loaded '" + file + "'");
						s.l(r);
					}
					
					l && l(); // Call the callback function l
					s.s--
				};
				if ( !s.readyState || /de|te/.test( s.readyState ) ) {
					s.onload = m.n;
					s.onreadystatechange = m.n;
					d(); // On completion execute the callback function as defined above
				}
			};
			s.onreadystatechange = s.onload;
			m.s++;
			if(logger.debugEnabled)logger.debug("loader|js: append '" + file + "' to head");
		}
		m.h.appendChild(s) // Add the script to the document
	}
};
bc.loader.l();
//bc.load=bc.loader.l;//快捷方式

/** 简易调用方式的封装，如果参数不是如下格式请直接调用bc.loader.l：
 * 将[a1.js,a2.js,...,an.js,fn]转换为[[a1.js, [[a2.js, [[...[an.js,fn]...]] ]] ]]格式，
 * 保证所有js按顺序加载，并在全部加载完毕后再调用fn函数
 */
bc.load = function(args){
	function rebuildArgs(args,lastIsFn){
		//用数组的第1个元素和剩余元素组成的数组生成新的数组
		args=[args.shift(),args];
		
		//如果依然超过2个元素，递归处理
		if(args[1].length > (lastIsFn ? 3 : 2)){
			args[1] = rebuildArgs(args[1],lastIsFn);
		}
		return args;
	};
	if(args && args.shift && args.length > 2){//参数为数组,且长度大于2，执行转换
		var lastIsFn = (typeof args[args.length - 1] == "function");
		if(lastIsFn){
			if(args.length > 3){
				args = rebuildArgs(args,true);
				//if(logger.debugEnabled)logger.debug("newArgs=" + array2string(args));
			}
		}else{
			args = rebuildArgs(args,false);
		}
		bc.loader.l([args]);
	}else{
		bc.loader.l(args);
	}
}
function array2string(array){
	//alert("0:" + array);
	var t=["["];
	for(var i=0;i<array.length;i++){
		if(i>0 && i<array.length)
			t.push(",");
		if(typeof array[i] != "function"){
			if(array[i].shift){
				//alert("1:" + array[i]);
				t.push(array2string(array[i]));
			}else{
				t.push(array[i]);
			}
		}else{
			t.push("fn");
		}
	}
	t.push("]");
	return t.join("");
}
/*
function rebuildArgs1(args,lastIsFn){
	//用数组的第1个元素和剩余元素组成的数组生成新的数组
	args=[args.shift(),args];
	
	//如果依然超过2个元素，递归处理
	if(args[1].length > (lastIsFn ? 3 : 2)){
		args[1] = rebuildArgs1(args[1],lastIsFn);
	}
	return args;
};
var a = ["a","b","c",function(){}];
a = [rebuildArgs1(a,false)];
alert(array2string(a));
*/
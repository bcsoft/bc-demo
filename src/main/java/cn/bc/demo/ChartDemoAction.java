/**
 * 
 */
package cn.bc.demo;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.bc.web.ui.html.page.HtmlPage;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author dragon
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ChartDemoAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	//private static Log logger = LogFactory.getLog(ChartDemoAction.class);
	private HtmlPage html;

	public HtmlPage getHtml() {
		return html;
	}

	public void setHtml(HtmlPage html) {
		this.html = html;
	}

	public String execute() throws Exception {
		return SUCCESS;
	}

	public String pie() throws Exception {
//		html = new HtmlPage();
//		html.addClazz("bc-page chart pie");
//		html.addJs("/ui-libs/highcharts/2.1.4/highcharts.min.js");
//		html.addJs("/ui-libs/highcharts/2.1.4/modules/exporting.min.js");
//		html.addJs("/bc-test/chart/pie.js");
//		html.setInitMethod("bc.pieDemo.init");
//		html.setOption(new PageOption().setWidth(500).setHeight(400).toString());
//		html.addStyle("overflow", "auto");
		return "pie";
	}
	public String bar() throws Exception {
		return "bar";
	}
	public String spline() throws Exception {
		return "spline";
	}
	public String mix() throws Exception {
		return "mix";
	}
}

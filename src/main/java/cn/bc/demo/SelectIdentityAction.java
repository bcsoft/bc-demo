/**
 * 
 */
package cn.bc.demo;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author dragon
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class SelectIdentityAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	//private static Log logger = LogFactory.getLog(SelectIdentityAction);

	public String execute() throws Exception {
		return SUCCESS;
	}

	public String selectIdentity() throws Exception {
		return SUCCESS;
	}
}

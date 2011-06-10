/**
 * 
 */
package cn.bc.login;

import java.util.Map;

import cn.bc.identity.domain.Actor;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * @author dragon
 * 
 */
public class SessionIterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext ctx = ActionContext.getContext();
		Map<String, Object> session = ctx.getSession();
		Action action = (Action) invocation.getAction();
		if (action instanceof LoginAction) {
			return invocation.invoke();
		}
		Actor user = (Actor) session.get("user");
		if (user == null) {
			return Action.LOGIN;
		} else {
			return invocation.invoke();
		}
	}
}

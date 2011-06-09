/**
 * 
 */
package cn.bc.login;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;

import cn.bc.identity.domain.Actor;
import cn.bc.identity.domain.ActorRelation;
import cn.bc.identity.domain.AuthData;
import cn.bc.identity.service.UserService;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 登录处理
 * 
 * @author dragon
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class LoginAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;
	private static Log logger = LogFactory.getLog(LoginAction.class);
	public String name;// 帐号
	public String password;// 密码
	public String msg;// 登录信息
	public boolean success;// 登录是否成功
	private UserService userService;
	private Map<String, Object> session;

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() throws Exception {
		return SUCCESS;
	}

	public String doLogin() throws Exception {
		success = true;

		Actor user = this.userService.loadByCode(name);
		if (user == null) {
			msg = "该用户未注册，如有问题请联系系统管理员！";
			success = false;
		} else {
			// 检测用户的密码是否正确
			AuthData authData = this.userService.loadAuthData(user.getId());
			if (authData == null) {
				msg = "系统错误！没有为用户(" + user.getCode() + ")配置认证信息。";
				success = false;
			} else {
				// 密码验证
				String md5;
				if (this.password.length() != 32) {// 明文密码先进行md5加密
					md5 = DigestUtils.md5DigestAsHex(this.password
							.getBytes("UTF-8"));
				} else {// 已加密的密码
					md5 = this.password;
				}

				if (!md5.equals(authData.getPassword())) {
					msg = "密码错误！";
					success = false;
				} else {
					String info = user.getName() + "登录系统,ip=";
					HttpServletRequest request = ServletActionContext
							.getRequest();
					info += request.getRemoteAddr();
					info += ",host=" + request.getRemoteHost();
					logger.fatal(info);
					msg = "登录成功，跳转到系统主页！";

					// TODO 记录登录日志

					// 将登录信息记录到session中
					this.session.put("user", user);

					// 用户所隶属的单位或部门
					Actor belong = this.userService.loadBelong(user.getId(),
							new Integer[] { Actor.TYPE_UNIT,
									Actor.TYPE_DEPARTMENT });
					this.session.put("belong", belong);

					// 用户所在的岗位
					List<Actor> groups = this.userService.findMaster(
							user.getId(),
							new Integer[] { ActorRelation.TYPE_BELONG },
							new Integer[] { new Integer(Actor.TYPE_GROUP) });
					this.session.put("groups", groups);
					this.session.put("loginTime", new Date());
				}
			}
		}

		return SUCCESS;
	}

	// 注销
	public String doLogout() throws Exception {
		((org.apache.struts2.dispatcher.SessionMap<String, Object>) this.session)
				.invalidate();
		return SUCCESS;
	}
}
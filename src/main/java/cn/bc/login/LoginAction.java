/**
 * 
 */
package cn.bc.login;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.util.StringUtils;

import cn.bc.Context;
import cn.bc.identity.domain.Actor;
import cn.bc.identity.domain.ActorRelation;
import cn.bc.identity.domain.AuthData;
import cn.bc.identity.domain.Role;
import cn.bc.identity.service.UserService;
import cn.bc.identity.web.SystemContext;
import cn.bc.identity.web.SystemContextImpl;
import cn.bc.log.domain.Syslog;
import cn.bc.log.service.SyslogService;
import cn.bc.log.web.struts2.SyslogAction;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.LocalizedTextUtil;

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
	private SyslogService syslogService;
	private Map<String, Object> session;

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Autowired
	public void setSyslogService(SyslogService syslogService) {
		this.syslogService = syslogService;
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
					logger.info(info);
					msg = "登录成功，跳转到系统主页！";

					// 创建默认的上下文实现并保存到session中
					Context context = new SystemContextImpl();
					this.session.put(SystemContext.KEY, context);

					// 将登录信息记录到session中
					context.setAttr(SystemContext.KEY_USER, user);

					// 用户所隶属的单位或部门
					Actor belong = this.userService.loadBelong(user.getId(),
							new Integer[] { Actor.TYPE_UNIT,
									Actor.TYPE_DEPARTMENT });
					context.setAttr(SystemContext.KEY_BELONG, belong);
					Actor unit = this.loadUnit(belong);
					context.setAttr(SystemContext.KEY_UNIT, unit);

					// 用户所在的岗位
					List<Actor> groups = this.userService.findMaster(
							user.getId(),
							new Integer[] { ActorRelation.TYPE_BELONG },
							new Integer[] { new Integer(Actor.TYPE_GROUP) });
					List<String> gcs = new ArrayList<String>();
					for (Actor group : groups) {
						gcs.add(group.getCode());
					}
					context.setAttr(SystemContext.KEY_GROUPS, gcs);

					// 用户的角色（包含继承自上级组织和隶属岗位的角色）
					Set<Role> roles = new LinkedHashSet<Role>();// 可用的角色
					List<Actor> ancestors = this.userService
							.findAncestorOrganization(user.getId());
					for (Actor ancestor : ancestors) {
						roles.addAll(ancestor.getRoles());
					}
					List<String> rcs = new ArrayList<String>();
					for (Role role : roles) {
						rcs.add(role.getCode());
					}
					context.setAttr(SystemContext.KEY_ROLES, rcs);
					
					//debug
					if(logger.isDebugEnabled()){
						logger.debug("groups=" + StringUtils.collectionToCommaDelimitedString(gcs));
						logger.debug("roles=" + StringUtils.collectionToCommaDelimitedString(rcs));
					}

					// 用户的权限

					// 登录时间
					Calendar now = Calendar.getInstance();
					this.session.put("loginTime", now);

					// 记录登陆日志
					Syslog log = SyslogAction
							.buildSyslog(
									now,
									Syslog.TYPE_LOGIN,
									user,
									belong,
									unit,
									user.getName()
											+ LocalizedTextUtil.findText(
													SyslogAction.class,
													"syslog.login",
													this.getLocale()),
									"true".equalsIgnoreCase(getText("app.traceClientMachine")),
									ServletActionContext.getRequest());
					syslogService.save(log);
				}
			}
		}

		return SUCCESS;
	}

	// 递归向上查找部门所属的单位
	private Actor loadUnit(Actor belong) {
		belong = this.userService.loadBelong(belong.getId(),
				new Integer[] { Actor.TYPE_UNIT });
		if (belong.getType() != Actor.TYPE_UNIT) {
			return loadUnit(belong);
		} else {
			return belong;
		}
	}

	// 注销
	public String doLogout() throws Exception {
		SystemContext context = (SystemContext) this.session.get(Context.KEY);
		Actor user = null;
		if (context != null)
			user = context.getUser();
		if (user != null) {// 表明之前session还没过期
			Actor belong = context.getBelong();
			Actor unit = context.getUnit();
			Calendar now = Calendar.getInstance();
			Syslog log = SyslogAction.buildSyslog(
					now,
					Syslog.TYPE_LOGOUT,
					user,
					belong,
					unit,
					user.getName()
							+ LocalizedTextUtil.findText(SyslogAction.class,
									"syslog.logout", this.getLocale()),
					"true".equalsIgnoreCase(getText("app.traceClientMachine")),
					ServletActionContext.getRequest());
			syslogService.save(log);

			((org.apache.struts2.dispatcher.SessionMap<String, Object>) this.session)
					.invalidate();
		}
		return SUCCESS;
	}
}
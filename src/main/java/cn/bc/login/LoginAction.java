/**
 * 
 */
package cn.bc.login;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
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
import cn.bc.core.exception.CoreException;
import cn.bc.core.util.DateUtils;
import cn.bc.desktop.service.LoginService;
import cn.bc.identity.domain.Actor;
import cn.bc.identity.domain.ActorHistory;
import cn.bc.identity.domain.AuthData;
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
	private LoginService loginService;
	private SyslogService syslogService;
	private Map<String, Object> session;

	@Autowired
	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
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
		Date startTime = new Date();
		success = true;

		Map<String, Object> map = this.loginService.loadActorByCode(name);
		Actor user = (Actor) map.get("actor");
		// logger.info("doLoginUser：" + DateUtils.getWasteTime(startTime));
		if (user == null) {
			msg = "该用户未注册，如有问题请联系系统管理员！";
			success = false;
		} else {
			// 检测用户的密码是否正确
			AuthData authData = (AuthData) map.get("auth");
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
					logger.info("doLogin.authOk："
							+ DateUtils.getWasteTime(startTime));

					// 创建默认的上下文实现并保存到session中
					Context context = new SystemContextImpl();
					this.session.put(SystemContext.KEY, context);

					// 将登录信息记录到session中
					context.setAttr(SystemContext.KEY_USER, user);

					// 用户隶属历史的当前信息
					ActorHistory userHistory = (ActorHistory) map
							.get("history");
					context.setAttr(SystemContext.KEY_USER_HISTORY, userHistory);

					// 获取用户的祖先组织信息（单位、部门、岗位及上级的上级）
					List<Map<String, String>> uppers = this.loginService
							.findActorAncestors(user.getId());
					List<Actor> belongs = new ArrayList<Actor>();// 直属上级（单位或部门）
					List<Actor> groups = new ArrayList<Actor>();// 直接拥有的岗位
					String userId = user.getId().toString();
					String tu = String.valueOf(Actor.TYPE_UNIT);
					String td = String.valueOf(Actor.TYPE_DEPARTMENT);
					String tg = String.valueOf(Actor.TYPE_GROUP);
					Set<Long> actorIds = new HashSet<Long>();
					actorIds.add(user.getId());
					for (Map<String, String> upper : uppers) {
						actorIds.add(new Long(upper.get("id")));
						if (userId.equals(upper.get("fid"))) {
							if (tu.equals(upper.get("type"))
									|| td.equals(upper.get("type"))) {
								belongs.add(mapActor(upper));
							} else if (tg.equals(upper.get("type"))) {
								groups.add(mapActor(upper));
							}
						}
					}
					if (belongs.isEmpty())
						throw new CoreException("belongs can not be empty.");
					context.setAttr(SystemContext.KEY_BELONG, belongs.get(0));// 单个隶属关系的处理
					context.setAttr(SystemContext.KEY_BELONGS, belongs);// 多个隶属关系的处理

					// 直属单位
					List<Actor> units = this.loadUnits(belongs, uppers);
					context.setAttr(SystemContext.KEY_UNIT, units.get(0));
					context.setAttr(SystemContext.KEY_UNITS, units);

					// 用户所在的岗位的code
					List<String> gcs = new ArrayList<String>();
					for (Actor group : groups) {
						gcs.add(group.getCode());
					}
					context.setAttr(SystemContext.KEY_GROUPS, gcs);
					logger.info("doLogin.findUppers："
							+ DateUtils.getWasteTime(startTime));

					// 用户的角色（包含继承自上级组织和隶属岗位的角色）
					if (logger.isDebugEnabled()) {
						logger.debug("actorIds="
								+ StringUtils
										.collectionToCommaDelimitedString(actorIds));
					}
					Long[] aids = actorIds.toArray(new Long[0]);
					List<Map<String, String>> roles = this.loginService
							.findActorRoles(aids);
					List<String> roleCodes = new ArrayList<String>();
					List<Long> roleIds = new ArrayList<Long>();
					for (Map<String, String> role : roles) {
						roleCodes.add(role.get("code"));
						roleIds.add(new Long(role.get("id")));
					}
					context.setAttr(SystemContext.KEY_ANCESTORS, aids);
					context.setAttr(SystemContext.KEY_ROLES, roleCodes);
					context.setAttr(SystemContext.KEY_ROLEIDS,
							roleIds.toArray(new Long[0]));

					// debug
					if (logger.isDebugEnabled()) {
						logger.debug("roles="
								+ StringUtils
										.collectionToCommaDelimitedString(roleCodes));
					}
					logger.info("doLogin.roles："
							+ DateUtils.getWasteTime(startTime));

					// 登录时间
					Calendar now = Calendar.getInstance();
					this.session.put("loginTime", now);

					// 记录登陆日志
					Syslog log = SyslogAction
							.buildSyslog(
									now,
									Syslog.TYPE_LOGIN,
									userHistory,
									userHistory.getName()
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

		if (logger.isInfoEnabled())
			logger.info("doLogin耗时：" + DateUtils.getWasteTime(startTime));
		return SUCCESS;
	}

	private Actor mapActor(Map<String, String> upper) {
		Actor actor = new Actor();
		actor.setId(new Long(upper.get("id")));
		actor.setType(Integer.parseInt(upper.get("type")));
		actor.setCode(upper.get("code"));
		actor.setName(upper.get("name"));
		actor.setPcode(upper.get("pcode"));
		actor.setPname(upper.get("pname"));
		return actor;
	}

	private List<Actor> loadUnits(List<Actor> belongs,
			List<Map<String, String>> uppers) {
		Set<Actor> units = new HashSet<Actor>();
		Actor unit;
		boolean exists;
		for (Actor belong : belongs) {
			unit = this.loadUnit(belong, uppers);
			exists = false;
			for (Actor _unit : units) {
				if (_unit.getId().equals(unit.getId())) {
					exists = true;
					break;
				}
			}
			if (!exists) {
				units.add(unit);
			}
		}
		List<Actor> _units = new ArrayList<Actor>();
		_units.addAll(units);
		return _units;
	}

	private Actor loadUnit(Actor belong, List<Map<String, String>> uppers) {
		if (belong.getType() == Actor.TYPE_UNIT) {
			return belong;
		}

		String belongId = belong.getId().toString();
		Map<String, String> _upper = null;
		for (Map<String, String> upper : uppers) {
			if (belongId.equals(upper.get("fid"))) {
				_upper = upper;
				break;
			}
		}
		if (_upper != null) {
			return loadUnit(mapActor(_upper), uppers);
		} else {
			throw new CoreException("department must belong unit:departmentId="
					+ belongId);
		}
	}

	// 注销
	public String doLogout() throws Exception {
		SystemContext context = (SystemContext) this.session.get(Context.KEY);
		ActorHistory user = null;
		if (context != null)
			user = context.getUserHistory();
		if (user != null) {// 表明之前session还没过期
			Calendar now = Calendar.getInstance();
			Syslog log = SyslogAction.buildSyslog(
					now,
					Syslog.TYPE_LOGOUT,
					user,
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
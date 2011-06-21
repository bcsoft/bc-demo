/**
 * 
 */
package cn.bc.index;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.bc.Context;
import cn.bc.core.exception.CoreException;
import cn.bc.desktop.domain.Personal;
import cn.bc.desktop.domain.Shortcut;
import cn.bc.desktop.service.PersonalService;
import cn.bc.desktop.service.ShortcutService;
import cn.bc.identity.domain.Actor;
import cn.bc.identity.domain.Resource;
import cn.bc.identity.domain.Role;
import cn.bc.identity.web.SystemContext;
import cn.bc.web.ui.html.menu.Menu;
import cn.bc.web.ui.html.menu.MenuItem;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author dragon
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class IndexAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;
	private static Log logger = LogFactory.getLog(IndexAction.class);
	private String msg;
	private ShortcutService shortcutService;
	private PersonalService personalConfigService;
	private List<Shortcut> shortcuts;
	private String startMenu;// 开始菜单
	private Personal personalConfig;// 个人配置
	private Map<String, Object> session;

	public String contextPath;

	public IndexAction() {
		contextPath = ServletActionContext.getRequest().getContextPath();
	}

	public Context getContext() {
		return (Context) this.session.get(Context.KEY);
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	@Autowired
	public void setShortcutService(ShortcutService shortcutService) {
		this.shortcutService = shortcutService;
	}

	@Autowired
	public void setPersonalConfigService(PersonalService personalConfigService) {
		this.personalConfigService = personalConfigService;
	}

	public Personal getPersonalConfig() {
		return personalConfig;
	}

	public void setPersonalConfig(Personal personalConfig) {
		this.personalConfig = personalConfig;
	}

	public String getStartMenu() {
		return startMenu;
	}

	public void setStartMenu(String startMenu) {
		this.startMenu = startMenu;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public List<Shortcut> getShortcuts() {
		return shortcuts;
	}

	public void setShortcuts(List<Shortcut> shortcuts) {
		this.shortcuts = shortcuts;
	}

	public String execute() throws Exception {
		// 检测用户是否登录,未登录则跳转到登录页面
		SystemContext context = (SystemContext) this.session.get(Context.KEY);
		if (context == null || context.getUser() == null) {
			return "redirect";
		}
		Actor user = context.getUser();

		// 个人配置
		this.personalConfig = this.personalConfigService.loadByActor(
				user.getId(), true);
		if (this.personalConfig == null)
			throw new CoreException("缺少配置信息！");

		// 快捷方式
		Set<Resource> resources = new LinkedHashSet<Resource>();// 有权限使用的资源
		Set<Role> roles = new LinkedHashSet<Role>();// 可用的角色
		this.shortcuts = this.shortcutService.findByActor(user.getId(), null,
				roles, resources);
		if (logger.isDebugEnabled()) {
			logger.debug("shortcuts=" + shortcuts.size());
			int i = 0;
			for (Resource m : resources) {
				logger.debug(++i + ") " + m);
			}
		}

		// 将可用的角色记录到上下文
//		List<String> roleCodes = new ArrayList<String>();
//		for (Role role : roles) {
//			roleCodes.add(role.getCode());
//		}
//		context.setAttr(SystemContext.KEY_ROLES, roleCodes);

		// 找到顶层模块
		Map<Resource, Set<Resource>> parentChildren = new LinkedHashMap<Resource, Set<Resource>>();
		Set<Resource> topResources = this.findTopResources(resources, parentChildren);
		if (logger.isDebugEnabled()) {
			int i = 0;
			for (Resource m : topResources) {
				logger.debug(++i + ") " + m);
			}
			i = 0;
			for (Entry<Resource, Set<Resource>> m : parentChildren.entrySet()) {
				logger.debug(++i + ") " + m.getKey() + " "
						+ m.getValue().size());
			}
		}

		// 循环顶层模块生成菜单
		Menu menu = this.buildMenu4Resources(topResources, parentChildren);
		menu.addClazz("startMenu");

		this.startMenu = menu.toString();
		if (logger.isDebugEnabled())
			logger.debug("startMenu=" + startMenu);
		return SUCCESS;
	}

	private Set<Resource> findTopResources(Set<Resource> resources,
			Map<Resource, Set<Resource>> parentChildren) {
		Set<Resource> topResources = new LinkedHashSet<Resource>();
		for (Resource m : resources) {
			this.dealParentChildren(m, parentChildren, topResources);
		}
		return topResources;
	}

	private void dealParentChildren(Resource m,
			Map<Resource, Set<Resource>> parentChildren, Set<Resource> topResources) {
		Resource parent = m.getBelong();
		if (parent != null) {// 有隶属的父模块
			Set<Resource> childResources = parentChildren.get(parent);
			if (childResources == null) {
				childResources = new LinkedHashSet<Resource>();
				parentChildren.put(parent, childResources);
			}
			childResources.add(m);

			this.dealParentChildren(parent, parentChildren, topResources);
		} else {// 顶层模块
			topResources.add(m);
		}
	}

	private Menu buildMenu4Resources(Set<Resource> resources,
			Map<Resource, Set<Resource>> parentChildren) {
		Menu menu = new Menu();
		MenuItem menuItem;
		for (Resource m : resources) {
			menuItem = buildMenuItem4Resource(m, parentChildren);
			menu.addMenuItem(menuItem);
		}
		return menu;
	}

	private MenuItem buildMenuItem4Resource(Resource m,
			Map<Resource, Set<Resource>> parentChildren) {
		MenuItem menuItem;
		menuItem = new MenuItem();
		menuItem.setUrl(buildMenuItemUrl(m)).setLabel(m.getName())
				.setType(String.valueOf(m.getType())).setAction("menuItem")
				.setAttr("data-mid", m.getId().toString());// .addStyle("z-index",
															// "10000");
		if (m.getType() == Resource.TYPE_FOLDER) {// 文件夹
			Set<Resource> childResources = parentChildren.get(m);// 模块下的子模块
			if (childResources != null && !childResources.isEmpty()) {
				menuItem.setChildMenu(buildMenu4Resources(childResources,
						parentChildren));
			}
		}
		return menuItem;
	}

	private String buildMenuItemUrl(Resource m) {
		String url = m.getUrl();
		if (url != null && url.length() > 0) {
			if (m.getType() == Resource.TYPE_OUTER_LINK) {// 不处理外部链接
				return url;
			} else {
				return contextPath + url;// 内部的url需要附加部署路路径
			}
		} else {
			return null;
		}
	}
}

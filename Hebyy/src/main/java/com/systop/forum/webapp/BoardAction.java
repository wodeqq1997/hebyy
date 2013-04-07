package com.systop.forum.webapp;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.forum.model.Board;
import com.systop.forum.service.BoardManager;

/**
 * 论坛模块信息Action,负责处理与之相关的各种请求
 * 
 * @author GaoRuofan
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class BoardAction extends DefaultCrudAction<Board, BoardManager> {

	/**
	 * 后台论坛板块管理入口
	 * 
	 * @return
	 */
	public String adminIndex() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page,
				"from Board b order by b.orderId asc");
		restorePageData(page);
		return "adminIndex";
	}

	/**
	 * 论坛入口，显示论坛的全部板块，
	 * 
	 * @return
	 */
	public String index() {
		items = getManager().getOrberBoards();
		return INDEX;
	}

	@Override
	public String remove() {
		return super.remove();
	}
}

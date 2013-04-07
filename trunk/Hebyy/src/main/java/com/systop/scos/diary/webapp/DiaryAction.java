package com.systop.scos.diary.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.diary.model.Diary;
import com.systop.scos.diary.service.DiaryManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class DiaryAction extends DefaultCrudAction<Diary, DiaryManager> {


	private List<Map<String, Object>> subUserDiarys;

	private Date queryDate;
	
	/**
	 * 日志编辑
	 */
	public String edit() {
		if (getModel().getId() == null) {
			getModel().setTitle(DateUtil.getDate(new Date()) + "工作日志");
		}
		return INPUT;
	}

	/**
	 * 显示日志信息
	 */
	public String index() {
		StringBuffer sql = new StringBuffer("from Diary d where user.id = ?");
		List<Object> args = new ArrayList<Object>();
		args.add(getLoginUser().getId());
		
		if (StringUtils.isNotBlank(getModel().getTitle())) {
			sql.append(" and d.title like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getTitle()));
		}
		
		if(queryDate != null){
			sql.append(" and d.createTime >= ?");
			args.add(DateUtil.firstSecondOfDate(queryDate));
			sql.append(" and d.createTime <= ?");
			args.add(DateUtil.lastSecondOfDate(queryDate));
		}
		
		sql.append(" order by d.createTime desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}


	/**
	 * 日志保存
	 */
	public String save() {
		if (getModel().getId() == null) {
			getModel().setUser(getLoginUser());
		}
		return super.save();
	}



    public String indexByUser() {
        if (getModel().getUser() != null
                && getModel().getUser().getId() != null) {
            StringBuffer hql = new StringBuffer("from Diary d where d.user.id = ?");
            List<Object> args = new ArrayList<Object>();
            args.add(getModel().getUser().getId());

            if (StringUtils.isNotBlank(getModel().getTitle())) {
                hql.append(" and d.title like ?");
                args.add(MatchMode.ANYWHERE.toMatchString(getModel().getTitle()));
            }

            if(queryDate != null){
                hql.append(" and d.createTime >= ?");
                args.add(DateUtil.firstSecondOfDate(queryDate));
                hql.append(" and d.createTime <= ?");
                args.add(DateUtil.lastSecondOfDate(queryDate));
            }
            hql.append("order by d.createTime desc");

            page = PageUtil.getPage(getPageNo(), getPageSize());
            page  = getManager().pageQuery(page, hql.toString(), args.toArray());
            restorePageData(page);
        }
        return "indexByUser";
    }

	public Date getQueryDate() {
		return queryDate;
	}

	public void setQueryDate(Date queryDate) {
		this.queryDate = queryDate;
	}

	public List<Map<String, Object>> getSubUserDiarys() {
		return subUserDiarys;
	}
}

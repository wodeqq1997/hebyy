<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>简历管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该简历？")) {
			window.location.href = URL_PREFIX+"/resume/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">简历管理</div>
</div>
<div class="x-toolbar">
	<s:form action="index.do" cssStyle="margin: 2px auto;"  method="post">
	<table width="100%" cellpadding="0" cellspacing="0">
	  <tr>
	  	<td>
	  		&nbsp;毕业时间：<input type="text" name="model.graduationTime" readonly="readonly" 
							   value='<s:date name="model.graduationTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />&nbsp;
	  		&nbsp;姓名：<s:textfield id="name"  name="model.name" />&nbsp;
	  		&nbsp; 学历：<s:textfield id="degree" name="model.degree"/>&nbsp;
	  		<input type="submit" value="查询" class="button" />
	  	</td> 
	  	<td align="right">
			<a href="${ctx}/resume/edit.do">
			<img src="${ctx}/images/icons/add.gif">&nbsp;添加简历</a>&nbsp;&nbsp;
		</td>
	</tr>
	</table>
	</s:form>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="index.do" 
		useAjax="false"
		doPreload="false" 
		pageSizeList="20,50" 
		editable="false"
		sortable="false" 
		rowsDisplayed="20"
		generateScript="true" 
		resizeColWidth="true" 
		classic="true" 
		width="100%"
		height="460px"
		minHeight="460"
		toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
	<ec:row>
	    <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
	    <ec:column width="80" property="name" title="姓名" style="text-align:center" ellipsis="true"/>
		<ec:column width="150" property="major" title="专业" ellipsis="true"/>
		<ec:column width="100" property="degree"  title="学历" ellipsis="true"/>
		<ec:column width="150" property="graduatCollege"  title="毕业院校" ellipsis="true"/>
		<ec:column width="170" property="_0" title="操作" style="text-align:center" sortable="false">
			<a href="view.do?model.id=${item.id}" title="查看档案信息">详情</a> | 
			<a href="edit.do?model.id=${item.id}" title="修改档案信息">编辑</a> |
			<a href="#" onclick="remove('${item.id}')" title="删除档案信息">删除</a>
		</ec:column>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
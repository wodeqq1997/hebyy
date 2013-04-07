<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/meta.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>请假记录管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该请假信息？")) {
			window.location.href = URL_PREFIX + "/article/type/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">
		<div style="float: left;">请假记录管理</div>
		<div style="float: right"><a href="${ctx}/article/type/edit.do"> <img
			src="${ctx}/images/icons/add_2.gif">&nbsp;添加请假记录</a></div>
	</div>
	<div class="x-toolbar">
		<table width="100%">
			<tr>
				<s:form action="index.do">
			 		请假记录名称：<s:textfield id="name" name="model.name" ></s:textfield>
					<input type="submit" value="查询" class="button" />
				</s:form>
			</tr>
		</table>
	</div>
	<div><%@ include file="/common/messages.jsp"%></div>
	<div class="x-panel-body">
		<ec:table items="items" var="item"
			retrieveRowsCallback="limit"
			sortRowsCallback="limit"
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
				<ec:column width="40" property="_s" title="No."	value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center" />
				<ec:column width="100" property="name" title="名称" style="text-align:center" ellipsis="true" />
				<ec:column width="160" property="descn" viewsAllowed="html" title="描述" />
				<ec:column width="170" property="_0" title="操作" viewsAllowed="html"
					style="text-align:center" sortable="false">
					<a href="view.do?model.id=${item.id}" title="查看请假记录">详情</a> | 
					<a href="edit.do?model.id=${item.id}" title="修改请假记录">编辑</a> |
					<a href="#" onclick="remove('${item.id}')" title="删除请假记录">删除</a>
				</ec:column>
			</ec:row>
		</ec:table>
	</div>
</div>
</body>
</html>
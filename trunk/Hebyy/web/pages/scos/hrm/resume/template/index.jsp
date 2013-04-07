<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>简历模板管理</title>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该简历模板？")) {
			window.location.href = URL_PREFIX+"/resume/template/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">简历模板管理</div>
</div>
<div class="x-toolbar">
<table width="100%">
<tr><td><div style="float: right"><a href="${ctx}/resume/template/edit.do">
	<img src="${ctx}/images/icons/add_2.gif">&nbsp;添加简历模板</a></div>
	</td></tr></table>
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
		<ec:column width="100" property="remark"  title="备注" ellipsis="true"/>
		<ec:column width="170" property="_0" title="操作" style="text-align:center" sortable="false">
			<a href="edit.do?model.id=${item.id}" title="修改档案信息">编辑</a> |
			<a href="#" onclick="remove('${item.id}')" title="删除档案信息">删除</a>
		</ec:column>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>员工合同信息</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<style type="text/css">
.title {
	border-bottom: 1px solid #99BBE8;
	font-size: 13px;
	font-weight: bold;
	color: #15428b;
}
</style>
<script type="text/javascript">
function remove(id){
	if (confirm("确认要删除合同信息?")){
		window.location.href=URL_PREFIX+"/empcontract/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel-header">
	<div style="float: left;">员工合同信息</div>	<div style="float: right">
				<a href="${ctx}/empcontract/edit.do?model.user.id=${model.user.id}">
				<img src="${ctx}/images/icons/add_2.gif">&nbsp;添加员工合同</a>
				</div>
</div>
<div>
<div class="x-toolbar">
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="view.do" 
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
	     <ec:column width="100" property="user.name" title="员工姓名" style="text-align:center"  ellipsis="true"/>
	      <ec:column width="100" property="user.dept.name" title="所在部门" style="text-align:center" ellipsis="true"/>
	      <ec:column width="100" property="user.duty" title="职务" style="text-align:center" ellipsis="true"/>
	    <ec:column width="100" property="startTime" title="合同起始时间" style="text-align:center"  cell="date" format="yyyy-MM-dd" ellipsis="true"/>
		<ec:column width="100" property="endTime"  title="合同截止时间" style="text-align:center" cell="date" format="yyyy-MM-dd" ellipsis="true"/>
		<ec:column width="170" property="_0" title="操作" style="text-align:center" sortable="false">
			<a href="${ctx }/empcontract/edit.do?model.id=${item.id}" title="修改合同信息">编辑</a> |
			<a href="#" onclick="remove('${item.id}')" title="删除合同信息">删除</a>
		</ec:column>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
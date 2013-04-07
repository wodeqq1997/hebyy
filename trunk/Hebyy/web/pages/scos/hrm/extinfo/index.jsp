<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>企业档案管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/hrm/extinfo/showUser.js"></script>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该员工企业档案？")) {
			window.location.href = URL_PREFIX+"/enterpriseext/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">企业档案管理</div>
</div>
<div class="x-toolbar"><s:hidden id="uid" name="model.user.id"/>
</div>
	<s:if test="#request.items == null || #request.items.size == 0"><br>&nbsp;未添加员工企业档案信息
		<a href="${ctx}/enterpriseext/edit.do?model.user.id=${model.user.id}">
		<img src="${ctx}/images/icons/add.gif" style="width: 12px; height: 12px;" />&nbsp;添加员工企业档案信息</a>
	</s:if>
    <s:else>
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
	    <ec:column width="100" property="user.name" title="员工姓名" style="text-align:center" ellipsis="true"/>
		<ec:column width="100" property="user.dept.name" title="部门名称" ellipsis="true"/>
		<ec:column width="100" property="user.duty" title="职位名称" ellipsis="true"/>
		<ec:column width="170" property="_0" title="操作" style="text-align:center" sortable="false">
			<a href="edit.do?model.id=${item.id}" title="修改企业档案信息">查看</a> |
			<a href="#" onclick="remove('${item.id}')" title="删除企业档案信息">删除</a>
		</ec:column>
	</ec:row>
</ec:table>
</div>
</s:else>
</div>
</body>
</html>
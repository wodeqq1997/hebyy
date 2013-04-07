<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>职位管理</title>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该职位吗？")) {
			window.location.href = "remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-body">
		<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
				action="showPosition.do" 
				useAjax="false"
				doPreload="false" 
				pageSizeList="20,50" 
				editable="false"
				sortable="false" 
				rowsDisplayed="20"
				generateScript="true" 
				resizeColWidth="false" 
				classic="true" 
				width="100%"
				height="460px"
				minHeight="460"
				toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
			<ec:row>
			    <ec:column width="45" property="_s" title="No." value="${GLOBALROWCOUNT}" style="text-align:center"/>
			    <ec:column width="150" property="name" title="职位名称" ellipsis="true"><a href="view.do?model.id=${item.id}" target="blank">${item.name}</a></ec:column>
			    <ec:column width="150" property="dept.name" title="部门名称" ellipsis="true"></ec:column>
				<ec:column width="150" property="_0" title="操作" style="text-align:center">
					<a href="edit.do?model.id=${item.id}" title="修改职位"><img src="${ctx}/images/icons/modify.gif" class="edit-button"></a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除职位"><img src="${ctx}/images/icons/remove.gif" class="remove-button"></a>
				</ec:column>
			</ec:row>
		</ec:table>
	</div>
</div>
</body>
</html>
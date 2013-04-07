<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>新闻管理</title>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该条新闻（及该新闻下所有评论）？")) {
			window.location.href = "remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel-view">
	<div class="x-panel-header">
		&nbsp;新闻管理
	</div>
	<div class="x-toolbar">
		<a href="edit.do"><img src="${ctx}/images/icons/add.gif">&nbsp;添加职位</a>
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
				resizeColWidth="false" 
				classic="true" 
				width="100%"
				height="460px"
				minHeight="460"
				toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
			<ec:row>
			    <ec:column width="45" property="_s" title="No." value="${GLOBALROWCOUNT}" style="text-align:center"/>
			    <ec:column width="350" property="_jobName" title="职位名称" ellipsis="true">
			    	<a href="view.do?model.id=${item.id}" target="_blank">${item.jobName}</a>
			    </ec:column>
			    <ec:column width="180" property="dept.name" title="部门名称"/>
				<ec:column width="80" property="orderId" title="排序编号"/>
				<ec:column width="100" property="_0" title="操作" style="text-align:center">
					<a href="edit.do?model.id=${item.id}" title="修改"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a>
				</ec:column>
			</ec:row>
		</ec:table>
	</div>
</div>
</body>
</html>
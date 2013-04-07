<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/meta.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文档管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除？")) {
		window.location.href = URL_PREFIX+"/document/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">共享文档列表</div>
</div>
<div class="x-toolbar">
	<table width="100%" style="margin: 4px 0px;" cellpadding="0" cellspacing="0">
	  <tr>
	    <td width="70%">
	      <s:form action="shareDocumentIndex.do" method="post">
	        &nbsp;&nbsp;标题：<s:textfield id="title" name="model.title"  maxlength="40"/>&nbsp;&nbsp;
	        &nbsp;&nbsp;关键字：<s:textfield id="keyWord" name="model.keyWord"  maxlength="20"/>&nbsp;&nbsp;&nbsp;&nbsp;
	        &nbsp;&nbsp;<input type="submit" value="查询" class="button"/>
	      </s:form>
	    </td>
	    <td width="30%" align="right">
	    	&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	  </tr>
	</table>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="shareDocumentIndex.do" 
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
	    <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" style="text-align:center"/>
	    <ec:column width="300" property="_title" title="标题" ellipsis="true">
	      <a href="view.do?model.id=${item.id}" title="${item.title}" target="_blank">${item.title}</a>
	    </ec:column>
	    <ec:column width="150" property="keyWord" title="关键字" ></ec:column>
		<ec:column width="120" property="owner.name" title="作者" />
		<ec:column width="120" property="createTime" title="上传日期 " cell="date" format="yyyy-MM-dd" style="text-align:center"/>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
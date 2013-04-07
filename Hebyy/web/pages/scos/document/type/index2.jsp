<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec.jsp"%>
<title>类别管理</title>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除该类别?")) {
		window.location.href = URL_PREFIX+"/document/type/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">
		&nbsp;文档类别管理.
		<s:if test='model.isPublic == "1"'>
		<span style="color: green;">(公共)</span>
		</s:if>
		<s:else>
		<span style="color: blue;">(个人)</span>
		</s:else>
	</div>
	<div class="x-toolbar">
		<table width="100%">
			<tr>
				<td align="right" style="padding-right: 30px;">
				  <a href="${ctx}/document/type/edit.do?model.isPublic=${model.isPublic}">
				  <img src="${ctx}/images/icons/add.gif">&nbsp;添加类别</a>
				  &nbsp;&nbsp;
				  <s:if test='model.isPublic == "1"'>
					  <img src="${ctx}/images/icons/rem-all.gif">
					  <a href="${ctx}/document/publicDocumentIndex.do">
					  &nbsp;返回文档<span style="color: green; font-weight: bold;">(公共)</span></a>
					</s:if>
					<s:else>
					  <img src="${ctx}/images/icons/rem-all.gif">
					  <a href="${ctx}/document/myDocumentIndex.do">
					  &nbsp;返回文档<span style="color: blue; font-weight: bold;">(个人)</span></a>
					</s:else>
				</td>
			</tr>
		</table>
	</div>
	<div><%@ include file="/common/messages.jsp"%></div>
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
			<ec:row ondblclick="openView('${item.id}');">
			    <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
			    <ec:column width="300" property="name" title="名称" />
			    <ec:column width="350" property="descn" title="描述"  ellipsis="true"/>
				<ec:column width="100" property="_0" title="操作" style="text-align:center">
					<a href="edit.do?model.id=${item.id}">
						<img src="${ctx}/images/icons/modify.gif"></a> 
					<a href="#" onclick="remove('${item.id}')" title="删除">
						<img src="${ctx}/images/icons/remove.gif"></a>
				</ec:column>
			</ec:row>
		</ec:table>
	</div>
</div>
<script type="text/javascript">
	function openView(id){
		 window.showModalDialog("view.do?model.id=" + id, null, "status:false;dialogWidth:460px;dialogHeight:300px");
	}
</script>
</body>
</html>
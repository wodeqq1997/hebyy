<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>
<title>属性列表选择器</title>
</head>
<body>
<br>
<table align="center">
	<tr>
		<td>
			选择商品类型:</td>
		<td>
			<div id='comboxWithTree' style=""></div></td>
	</tr>
	<tr>
		<td>商品类型ID:</td>
		<td>
			<input type="text" id="docTypeId"></td>
	</tr>
</table>
<script type="text/javascript"
	src="${ctx}/pages/scos/document/publicType/docTypeCombox.js"></script>
<script type="text/javascript">
	Ext.onReady(function() {
		var pstree = new ProsortTree({
			el : 'comboxWithTree',
			target : 'docTypeId',
			//emptyText : '选择商品类型',
			url : '${ctx}/document/type/docTypeTree.do?model.isPublic=${model.isPublic}'
		});
		pstree.init();
	});
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>物资类别管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该物资类别？")) {
			window.location.href = URL_PREFIX
					+ "/asset/type/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">物资类别管理</div>
</div>
<div class="x-toolbar"><s:form action="index.do"
	id="pageQueryForm">
	<table width="100%">
		<tr>
			<td><s:hidden name="ec_p" id="ec_p" /> 物资类别名称：<s:textfield
				id="name" name="model.name"></s:textfield> <input type="submit"
				value="查询" class="button" /></td>
			<td align="right"><a href="${ctx}/asset/type/edit.do"><img
				src="${ctx}/images/icons/add_2.gif">&nbsp;添加物资类别</a></td>
		</tr>
	</table>
</s:form></div>
<div class="x-panel-body" align="center">
<div  align="right">
<table>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;" align="right"><%@include
			file="/pages/common/messages.jsp"%></td>
	</tr>
</table>
</div>
<table id="fineTable" width="800">
	<tr>
		<th>序号</th>
		<th>名称</th>
		<th>描述</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td>${item.name}</td>
			<td>${item.descn}</td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				title="查看物资类别">详情</a> | <a href="edit.do?model.id=${item.id}"
				title="修改物资类别">编辑</a> | <a href="#" onclick="remove('${item.id}')"
				title="删除物资类别">删除</a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="4" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>
</body>
</html>
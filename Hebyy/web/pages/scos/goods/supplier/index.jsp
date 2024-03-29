<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>供应商管理</title>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该供应商吗?")) {
			window.location.href = URL_PREFIX
					+ "/goods/supplier/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div id="r_main">
<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
<div style="float: left;">供应商管理</div>
</div>
<div class="x-toolbar">

<table width="100%" cellpadding="0" cellspacing="0"
	style="margin-left: 0px; margin-top: 0px">
	<tr>
		<td width="70%"><s:form action="index" theme="simple"
			id="pageQueryForm">
					&nbsp;&nbsp;供应商名称： <s:textfield id="name" name="model.name" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value="查询" class="button" />
			<s:hidden name="ec_p" id="ec_p" />
		</s:form></td>
		<td align="right"><img src="${ctx}/images/icons/add.gif" /><a
			href="${ctx}/goods/supplier/edit.do">添加供应商</a></td>
	</tr>
</table>

</div>
<div class="x-panel-body">
<div>
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
		<th>供应商名称</th>
		<th>电话</th>
		<th>联系人</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center"><a
				href="${ctx}/goods/supplier/view.do?model.id=${item.id}"
				target="_blank"><font color="blue">${item.name}</font></a></td>
			<td>${item.phone }</td>
			<td>${item.linkman }</td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				target="_blank" title="查看详情"><img
				src="${ctx}/images/icons/zoom.gif"></a>&nbsp; <a
				href="edit.do?model.id=${item.id}" title="编辑"><img
				src="${ctx}/images/icons/modify.gif"></a>&nbsp; <a href="#"
				onclick="remove('${item.id}')" title="删除"><img
				src="${ctx}/images/icons/remove.gif"></a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>
</body>
</html>
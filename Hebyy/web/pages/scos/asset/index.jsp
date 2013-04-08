<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物资管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript"
	src="${ctx}/scripts/calendar/WdatePicker.js"></script>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该物资？")) {
			window.location.href = URL_PREFIX + "/asset/remove.do?model.id="
					+ id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">物资管理</div>
</div>
<div class="x-toolbar"><s:form action="index.do"
	id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table width="100%">
		<tr>
			<td>&nbsp;物资名称：<s:textfield id="title" name="model.name" />
			物资状态：<s:select list="#{'好':'好','损坏':'损坏','报废':'报废'}"
				name="model.status" headerKey="" id="status" headerValue="全部"
				cssStyle="width:80px;" cssClass="statusCheck" /> 物资类型：<s:select
				list="assetTypeMap" name="model.assetType.id" headerKey=""
				id="assetTypeId" headerValue="全部" cssStyle="width:110px;" /> <input
				type="submit" value="查询" class="button" /></td>
			<td align="right"><a href="${ctx}/asset/edit.do"><img
				src="${ctx}/images/icons/add_2.gif">&nbsp;添加物资</a> <a
				href="${ctx}/asset/type/index.do"><img
				src="${ctx}/images/icons/add.gif">物资类型</a> <img
				src="${ctx}/images/icons/folder.gif" class="icon"> <a
				href="${ctx}/asset/instock/index.do">入库单管理</a></td>
		</tr>
	</table>
</s:form></div>
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
		<th>名称</th>
		<th>编号</th>
		<th>规格</th>
		<th>物资类别</th>
		<th>物资状态</th>
		<th>购买日期</th>
		<th>保管人</th>
		<th>物资值</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center">${item.name }</td>
			<td align="center">${item.assetNo}</td>
			<td>${item.stardard }</td>
			<td>${item.assetType.name}</td>
			<td>${item.status }</td>
			<td align="center"><fmt:formatDate value="${item.buyDate }" /></td>
			<td>${item.custodian }</td>
			<td>${item.assetValue }</td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				title="查看详情"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
			<a href="edit.do?model.id=${item.id}" title="编辑"><img
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
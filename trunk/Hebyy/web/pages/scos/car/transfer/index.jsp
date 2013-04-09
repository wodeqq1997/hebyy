<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>车辆交接记录</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">车辆交接记录</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar"><s:form action="index.do"
	id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table width="100%">
		<tr>
			<td>交接日期：<input id="date" name="date"
				value='<s:date name="date" format="yyyy-MM-dd"/>'
				onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly"
				style="height: 20px; width: 200px;" /> <input type="submit"
				value="查询" class="button" /></td>
			<td width="20%" align="right"><a
				href="${ctx}/car/transfer/edit.do"><img
				src="${ctx}/images/icons/add.gif" />添加车辆交接记录</a></td>
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
		<th>交付人</th>
		<th>接收人</th>
		<th>交接日期</th>
		<th>车辆</th>
		<th>车辆状态</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center">${item.delivery}</td>
			<td align="center">${item.recipient }</td>
			<td align="center"><fmt:formatDate value="${item.date}"
				pattern="yyyy-MM-dd" /></td>
			<td>${item.car.carNo}</td>
			<td align="center"><s:if test="#attr.item.status == 1">
				可用
			</s:if> <s:elseif test="#attr.item.status == 0">
				报废
			</s:elseif> <s:else>
				维修中
			</s:else></td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				title="查看详情"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
			<a href="edit.do?model.id=${item.id}" title="编辑"><img
				src="${ctx}/images/icons/modify.gif"></a>&nbsp;</td>
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
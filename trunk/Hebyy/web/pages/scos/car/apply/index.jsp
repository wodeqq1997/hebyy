<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>汽车申请记录</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">汽车申请记录</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar"><s:form action="index" theme="simple"
	id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table width="99%">
		<tr>
			<td>车辆牌照：<s:textfield id="carNo" name="model.car.carNo" />
			审核状态：<s:select name="model.status" id="status" list="statusMap"
				headerKey="" headerValue="全部" /> 申请日期：<input id="startDate"
				name="startDate"
				value="<s:date name='startDate' format='yyyy-MM-dd'/>"
				onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" />&nbsp; ~&nbsp;<input
				id="endDate" name="endDate"
				value="<s:date name='endDate' format='yyyy-MM-dd'/>"
				onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" /></td>
			<td width="20%" align="left"><input type="submit" value="查询"
				class="button" /></td>
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
		<th>申请人</th>
		<th>申请日期</th>
		<th>申请车辆</th>
		<th>事由</th>
		<th>申请状态</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center">${item.proposer.name}</td>
			<td align="center"><fmt:formatDate value="${item.applyDate}"
				pattern="yyyy-MM-dd" /></td>
			<td><a href="${ctx}/car/view.do?model.id=${item.car.id}"
				target="_blank">${item.car.carNo}</a>&nbsp;</td>
			<td>${item.reason}</td>
			<td><s:if test="#attr.item.status == 1">
				审核通过
			</s:if> <s:elseif test="#attr.item.status == 2">
				审核未通过
			</s:elseif> <s:else>
			         未进行审核
			</s:else></td>
			<td align="center"><s:if
				test="#attr.item.status == @com.systop.scos.car.CarConstants@CAR_APPLY_NOT_EXAMINE">
				<a href="passCarApply.do?model.id=${item.id}" title="批准">批准</a>&nbsp;|
				<a href="noPassCarApply.do?model.id=${item.id}" title="不批准">不批准</a>&nbsp;|
			</s:if> <s:else>
				<a href="javascript:;" title="批准"><font color="#D4D0C8">批准</font></a>&nbsp;|
				<a href="javascript:;" title="不批准"><font color="#D4D0C8">不批准</font></a>&nbsp;|
			</s:else> <a href="view.do?model.id=${item.id}" title="查看">详情</a></td>
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
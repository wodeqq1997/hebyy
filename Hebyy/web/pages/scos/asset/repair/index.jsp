<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物资维修记录管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/car/selector.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">物资维修记录管理</div>
</div>
<div class="x-toolbar"><s:form action="index.do"
	id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table width="100%">
		<tr>
			<td>维修类型：<s:select list="#{'维修':'维修','保养':'保养'}"
				name="model.repairType" headerKey="" id="carType" headerValue="全部"
				cssStyle="width:60px;" /> 物资名称：<s:textfield id="engineNo"
				name="assetName" style="width:100px;" /> 开始日期：<input id="startDate"
				name="startDate"
				value="<s:date name='startDate' format='yyyy-MM-dd'/>"
				onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" />&nbsp; 结束日期：<input id="endDate"
				name="endDate" value="<s:date name='endDate' format='yyyy-MM-dd'/>"
				onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" /> <input type="submit"
				value="查询" class="button" /></td>
			<td align="right"><a href="${ctx}/asset/repair/edit.do"><img
				src="${ctx}/images/icons/add.gif">添加物资维修记录</a></td>
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
		<th>物资名称</th>
		<th>维修类型</th>
		<th>维修日期</th>
		<th>经办人</th>
		<th>费用</th>
		<th>维修原因</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center"><a
				href="${ctx}/asset/view.do?model.id=${item.asset.id}"
				target="_blank"><font color="blue">${item.asset.name}</font></a></td>
			<td>${item.repairType }</td>
			<td align="center"><fmt:formatDate value="${item.repairDate}"
				pattern="yyyy-MM-dd" /></td>
			<td>${item.executant}</td>
			<td>${item.fee}</td>
			<td>${item.reason}</td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>设备检测记录管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/car/selector.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">设备检测记录管理</div>
</div>
<div class="x-toolbar">
	<s:form action="index.do"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	<table width="100%">
	  <tr>
			<td>
				设备物资名称：<s:textfield id="model.asset.name" name="assetName" style="width:200px;"/>
				<input type="submit" value="查询" class="button" />
			</td>
			<td align="right">
				<a href="${ctx}/asset/check/edit.do"><img src="${ctx}/images/icons/add.gif">添加检测记录</a>
			</td>
		</tr>
	</table>
	</s:form>
</div>
<div class="x-panel-body">
<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>序号</th>
        <th>设备名称</th>
		<th>送检日期</th>
		<th>效验日期</th>
		<th>送检人</th>
		<th>备注</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			 <td align="center">${st.index + 1}</td>
            <td align="center">${item.asset.name}</td>
			<td align="center"><fmt:formatDate value="${item.checkDate}" pattern="yyyy-MM-dd"/></td>
			 <td><fmt:formatDate value="${item.correctDate}" pattern="yyyy-MM-dd"/></td>
			<td>${item.executant}</td>
			<td>${item.notes}</td>
			<td align="center">
				<a href="view.do?model.id=${item.id}" title="查看详情"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
			<a href="edit.do?model.id=${item.id}" title="编辑"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
			</td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;"
			align="right"><%@include file="/pages/common/page.jsp"%>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
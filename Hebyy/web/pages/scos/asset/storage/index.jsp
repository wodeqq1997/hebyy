<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物资进出库记录管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/car/selector.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">物资进出库记录管理</div>
</div>
<div class="x-toolbar">
	<s:form action="index.do"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	<table width="100%">
	  <tr>
			<td>
				物资状态：<s:select list="#{'已归还':'已归还','出库':'出库'}" name="model.status" headerKey="" id="status" headerValue="全部" cssStyle="width:80px;" cssClass="statusCheck"/>
				开始日期：<input id="startDate" name="startDate"  value="<s:date name='startDate' format='yyyy-MM-dd'/>"  onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
				结束日期：<input id="endDate" name="endDate"  value="<s:date name='endDate' format='yyyy-MM-dd'/>"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				物资名称：<s:textfield id="assetName" name="model.asset.name" />
				<input type="submit" value="查询" class="button" />
			</td>
			<td align="right">
				<a href="${ctx}/asset/storage/editTakeInput.do">
					<img src="${ctx}/images/icons/add.gif">
					添加出库记录
				</a>
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
        <th>物资名称</th>
		<th>状态</th>
		<th>出库日期</th>
		<th>领用人</th>
		<th>出库经办人</th>
		<th>归还日期</th>
		<th>归还人</th>
		<th>方量</th>
		<th>入库经办人</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			 <td align="center">${st.index + 1}</td>
            <td align="center"><a href="${ctx}/asset/view.do?model.id=${item.asset.id}" target="_blank">${item.asset.name}</a></td>
            <td>${item.status}</td>
			<td align="center"><fmt:formatDate value="${item.takeTime}" pattern="yyyy-MM-dd"/></td>
			 <td>${item.takePerson}</td>
			<td>${item.takeOperator.name}</td>
			<td><fmt:formatDate value="${item.bringTime}" pattern="yyyy-MM-dd"/></td>
			<td>${item.bringPerson }</td>
			<td>${item.square }</td>
			
			<td>${item.bringOperator.name}</td>
			<td align="center">
				<c:if test='${item.status != "已归还"}'>
				<a href="editBringInput.do?model.id=${item.id}" title="归还">归还</a>&nbsp;|&nbsp;
			</c:if>
			<a href="view.do?model.id=${item.id}" title="查看">查看</a>
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
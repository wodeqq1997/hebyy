<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>车辆信息管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除该车辆信息？")) {
		window.location.href = URL_PREFIX+"/car/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">车辆信息管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
	<s:form action="index.do" id="pageQueryForm">
	<table width="100%"><s:hidden name="ec_p" id="ec_p"/>
	  <tr>
			<td>
				车牌：<s:textfield id="carNo" name="model.carNo" />
				汽车类型：<s:select list="#{'轿车':'轿车','货车':'货车','商务车':'商务车'}" name="model.carType" headerKey="" id="carType" headerValue="全部" cssStyle="width:110px;" />
				购买日期：<input id="startDate" name="startDate"  value="<s:date name='startDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				~&nbsp;<input id="endDate" name="endDate"  value="<s:date name='endDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
			</td>
			<td valign="middle">
				<input type="submit" value="查询" class="button" />
			</td>
			<td width="20%" align="right">
				<a href="${ctx}/car/edit.do"><img src="${ctx}/images/icons/add.gif"/>添加车辆信息</a>				
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
        <th>车牌</th>
		<th>车辆类型</th>
		<th>发动机号</th>
		<th>购置日期</th>
		<th>保险购买日期</th>
		<th>年审时间</th>
		<th>状态</th>
		<th>服务电话</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
            <td align="center">${item.carNo }</td>
			<td align="center">${item.carType }</td>
			<td>${item.engineNo }</td>
			<td><fmt:formatDate value="${item.buyDate}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${item.buyInsureTime}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${item.auditTime}" pattern="yyyy-MM-dd"/></td>
			<td><s:if test="#attr.item.status == 1">
				可用
			</s:if>
			<s:elseif test="#attr.item.status == 0">
				报废
			</s:elseif>
			<s:else>
				维修中
			</s:else></td>
			<td>${item.servicePhone}</td>
			<td align="center">
				<a href="view.do?model.id=${item.id}" title="查看详情"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
			<a href="edit.do?model.id=${item.id}" title="编辑"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
			<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a>
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
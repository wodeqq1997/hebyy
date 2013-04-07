<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>汽车使用记录</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除该车辆使用记录信息？")) {
		window.location.href = URL_PREFIX+"${ctx}/car/record/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">汽车使用记录</div>
</div>
<div class="x-toolbar">
	<s:form action="index" theme="simple"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
		<table width="99%">
			<tr>
				<td>
					车辆牌照：<s:textfield id="carNo" name="model.car.carNo"  />
					申请日期：<input id="startDate" name="startDate"  value="<s:date name='startDate' format='yyyy-MM-dd'/>"  onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
					~&nbsp;<input id="endDate" name="endDate"  value="<s:date name='endDate' format='yyyy-MM-dd'/>"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</td>
				<td width="20%" align="left">
					<input type="submit" value="查询" class="button" />
				</td>
				<td align="right">
					<img src="${ctx}/images/icons/add.gif" style="width: 12px; height: 12px;">&nbsp;<a href="${ctx}/car/record/edit.do">添加车辆使用</a>
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
        <th>申请人</th>
		<th>申请日期</th>
		<th>申请车辆</th>
		<th>事由</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
	     	<td align="center">${st.index + 1}</td>
            <td align="center">${item.proposer.name}</td>
			<td align="center"><fmt:formatDate value="${item.applyDate}" pattern="yyyy-MM-dd"/></td>
			 <td><a href="${ctx}/car/view.do?model.id=${item.car.id}" target="_blank">${item.car.carNo}</a>&nbsp;</td>
			<td>${item.reason}</td>
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
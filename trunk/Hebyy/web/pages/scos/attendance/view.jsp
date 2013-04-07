<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>考勤信息</title>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<%@include file="/common/meta.jsp"%>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">考勤信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
	<s:hidden name="model.id" />
	<table width="700" id="fineTable" style="margin-top: 10px;" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<th colspan="11" class="title"><fmt:formatDate value="${model.attendanceDate}" pattern="yyyy年MM月"/>考勤信息</th>
		</tr>
		<tr>
			<th width="80">No.</th>
			<th width="140">姓名</th>
			<th width="80">应出勤天数</th>
			<th width="80">实际出勤天数</th>
            <th style="width: 80px;">外业天数</th>
            <th style="width: 80px;">内业天数</th>
			<th width="80">病假天数</th>
			<th width="80">事假天数</th>
			<th width="80">迟到次数</th>
			<th width="80">旷工次数</th>
			<th width="80">备注</th>
		</tr>
		<s:iterator value="model.items" var="item" status="status">
		<tr>
			<td align="center">${status.index +1}</td>
			<td align="center">${item.person.name}</td>
			<td align="right">${item.attendance.shouldDays}&nbsp;</td>
			<td align="right">${item.actualDays}&nbsp;</td>
			<td align="right">${item.outDays}&nbsp;</td>
			<td align="right">${item.inDays}&nbsp;</td>
			<td align="right">${item.diseaseDays}&nbsp;</td>
			<td align="right">${item.leaveDays}&nbsp;</td>
			<td align="right">${item.lateCount}&nbsp;</td>
			<td align="right">${item.absentCount}&nbsp;</td>
            <td>${item.remark}</td>
		</tr>
		</s:iterator>
	</table>
	<table width="700" cellpadding="0" cellspacing="0" align="center" style="margin-top: 10px;">
		<tr>
			<td width="80" align="right">考勤部门：</td>
			<td align="left" width="420">&nbsp;${model.dept.name}</td>
			<td align="right">考勤人：</td>
			<td align="left">&nbsp;${model.user.name}</td>
		</tr>
	</table>
	<div align="center" style="margin-top: 15px;">
		<input type="button" value="打印" class="button" onclick="javascript:">
		<input type="button" value="关闭" class="button" onclick="javascript:window.close();">
	</div>
</div>
</div>
</body>
</html>
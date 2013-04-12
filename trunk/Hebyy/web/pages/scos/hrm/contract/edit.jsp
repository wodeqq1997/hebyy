<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/validator.jsp"%>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/hrm/extinfo/showUser.js"></script>
<style type="text/css">
.warn {
	color: red;
}
.title {
	border-bottom: 1px solid #99BBE8;
	font-size: 14px;
	font-weight: bold;
	color: #15428b;
}
</style>
<title>编辑员工合同</title>
</head>
<body>
<div class="x-panel">
<div class="x-toolbar" style="padding: 5px; font-weight: bold;">员工合同信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<s:form action="save" id="save" validate="true" method="post">
<s:hidden name="model.id" id="id"/>
<s:hidden name="model.employee.id" id="uId"/>
	<table width="800" align="center"style="margin: 10px; border-bottom: 1px solid #99BBE8;">
		<tr>
			<td colspan="2" class="title"><span>员工合同信息</span>&nbsp;</td>
		</tr>
		<tr>
			<td>
			<br>
			<table width="800" border="0" style="line-height: 25px;" >
				<tr>
					<td align="right">员工姓名：</td>
					<td align="left" colspan="3"> ${model.employee.name}</td>
				</tr>
				<tr>
					<td align="right">员工部门：</td>
					<td align="left" colspan="3"> ${model.employee.dept.name}</td>
				</tr>
				
				<tr>
					<td align="right">起始时间：</td>
					<td>
					<c:if test="${!empty model.startTime}">
					   <input id="startTime" name="model.startTime"  style="height:25px;width:200px;" value='<fmt:formatDate value="${model.startTime}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				    </c:if>
				<c:if test="${empty model.startTime}">
					<input id="startTime" name="model.startTime"  style="height:25px;width:200px;" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</c:if>
				</tr>
				<tr>
					<td align="right">截止时间：</td>
					<td>
					<c:if test="${!empty model.endTime}">
					   <input id="endTime" name="model.endTime"  style="height:25px;width:200px;" value='<fmt:formatDate value="${model.endTime}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				    </c:if>
				<c:if test="${empty model.endTime}">
					<input id="endTime" name="model.endTime"  style="height:25px;width:200px;" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</c:if>
				</tr>
				<!--<tr>
					<td align="right">起始时间：</td>
					<td>
					<input id="startDate" name="startDate"  value='<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly"/></td>
				</tr>
				<tr>
					<td align="right">截止时间：</td>
					<td>
					<input id="endDate" name="endDate"  value='<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" /></td>
				</tr>
				--><tr>
					<td align="right" valign="top">合同备注：</td>
					<td><s:textarea name="model.remark" cssStyle="width:500px" rows="4" /></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<div align="left" style="margin-top: 5px;margin-left:300px;"><input type="submit"
		value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp; <input
		type="reset" value="重置" class="button"></div>
</s:form></div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
</script>
</body>
</html>
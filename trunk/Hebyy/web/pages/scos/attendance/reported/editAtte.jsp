<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>考勤管理</title>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
	<div style="float: left;">考勤管理</div>
</div>
<div align="center" style="width: 100%">
<s:form action="saveAtte.do" id="save" validate="true" method="POST">
	<s:hidden name="model.id" />
	<table width="1100" id="fineTable" cellpadding="0" cellspacing="0" align="center" style="margin-bottom:10px;">
		<tr>
			<th colspan="7" style="margin:0 auto;font-weight:700;height: 22px;">员工考勤</th>
			<th><input id="date" name="model.date" size="100px" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" style="height: 20px;"/>
				<span id="attendanceDateDescn"></span>
			</th>
		</tr>
		<tr class="title">
			<th width="90" align="center">No.</th>
			<th width="110" align="center">姓名</th>
			<th width="100" align="center">病假天数</th>
			<th width="100" align="center">事假天数</th>
			<th width="100" align="center">迟到次数</th>
			<th width="100" align="center">旷工次数</th>
			<th width="250" align="center">备注</th>
			<th width="100" align="center">
			</th>
		</tr>
		<tr class="title">
			<td width="90" align="center">1</td>
			<td width="110" align="center">
				${model.user.name}
				<input type="hidden" id="auditor" name="${model.id}">
			</td>
			<td width="100" align="center"><s:textfield type="text" name="model.diseaseDay"></s:textfield></td>
			<td width="100" align="center"><s:textfield type="text" name="model.leaveDay"/></td>
			<td width="100" align="center"><s:textfield type="text" name="model.lateCount"/></td>
			<td width="100" align="center"><s:textfield type="text" name="model.absentCount"/></td>
			<td width="250" align="center"><s:textfield type="text" name="model.mark" style="size: 190"></s:textfield></td>
			<td width="100" align="center">
			</td>
		</tr>
	</table>
	<table width="100%" style="margin-bottom: 10px;">
		<tr>
			<td align="center" class="font_white">
				<input type="submit" value="保存" class="button"/>&nbsp;&nbsp;
				<input type="button" value="重置" class="button" onclick="formReset()"/>&nbsp;&nbsp;
			</td>
		</tr>
	</table>
</s:form>
</div>
</div>
<script type="text/javascript">
	/** ready */
	$(document).ready(function() {
		$("#save").validate();
	});
	
	$(function(){
		$.validator.addMethod("Wdate", function(value, element) {
			var res = "";
			if (value == null || value.length == 0) {
				res = "err";
				$("#attendanceDateDescn").html("<font color='red'>考勤月份不能为空</font>");
			}else {
				$("#attendanceDateDescn").html("");
			}
			return res != "err";
		}, "");
	});
</script>
</body>
</html>
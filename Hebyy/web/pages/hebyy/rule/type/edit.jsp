<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
 
<title>类别编辑页面</title>
</head>
<body>
<div class="x-panel-header">
<div style="float: left;">类别编辑页面</div>
</div>
<div id="content">
	<table id="fineTable" width="750"  align="center" style="margin-top: 20px;margin-bottom: 10px;">
	<s:form id="save" method="post" validate="true">
		<tr>
			<th colspan="2">类别信息</th>
		</tr>
		<tr>
			<td class="td1">类别名称：</td>
			<td><s:hidden name="model.id" /> 
				<s:textfield name="model.zcMc" cssStyle="width:360px; height:22px;" cssClass="required" maxlength="255" /> <font color="red">*</font>
		</tr>
		<tr>
			<td class="td1">类别备注：</td>
			<td>
			<s:textarea id="content" name="model.remark" cssStyle="width:360px;height: 45px;" />
			</td>
		</tr>
		
		<tr>
			<td colspan="2" style="border: 0px;" align="center"><%@include file="/pages/common/messages.jsp"%>
			 <input type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
			 <input type="button" onclick="javascript:window.location.href='${ctx}/ruleType/queryxx.do';" class="button" value=" 返 回 "></td>
		</tr>
		
		</s:form>
	</table>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	function jkjsSave() {
		$('#save').attr("action", "${ctx}/ruleType/zcsave.do");
		$('#save').submit();
	}
</script>
</body>
</html>
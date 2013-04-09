<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	var URL_CTX = '${ctx}';
</script>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<style type="text/css">
td {
	padding: 4px 2px 2px 3px;
}

select {
	border: 1px solid #CCC;
}

textarea {
	padding: 5px;
	width: 520px;
	height: 70px;
}

.td1 {
	text-align: right;
}
</style>
<title>章程目录编辑页面</title>
</head>
<body>
<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
当前位置： <span class="r_nav_item">章程目录</span> <span class="r_nav_item">章程目录编辑页面</span>
</div>

<div id="content"><s:form id="save" method="post"
	validate="true">

	<table id="fineTable" width="780">
		<tr>
			<td class="td1"><span class="warn">*</span> 章程目录序号</td>
			<td>
				<s:hidden name="model.id" />
			 	<s:if test='#attr.model.id == 0 || #attr.model.id == null'>
			 	第&nbsp; <s:textfield
				name="model.zcxh" cssClass="required number"
				style="width:20px; height:18px;" /> &nbsp;章&nbsp;
				</s:if>
				<s:if test='#attr.model.id != 0 &&#attr.model.id != null'>
					<s:textfield name="model.zcxh"
				style="width:260px; height:18px;" cssClass="required"
				maxlength="255" /> 
					
					</s:if>
				
				 <font color="red">*</font>
			</td>

		</tr>
		<tr>
			<td class="td1"><span class="warn">*</span> 章程目录名称</td>
			<td><s:textfield name="model.zcMc"
				style="width:650px; height:18px;" cssClass="required"
				maxlength="255" /> <font color="red">*</font></td>

		</tr>

		<tr>
			<td colspan="6" style="border: 0px;" align="center"><%@include
				file="/pages/common/messages.jsp"%> <input
				type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;<input type="button"
				onclick="javascript:window.location.href='${ctx}/zcxx/queryxx.do';"
				class="button" value=" 返 回 "></td>

		</tr>
	</table>

</s:form></div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	function jkjsSave() {
		$('#save').attr("action", "${ctx}/zcxx/zcsave.do");
		$('#save').submit();
	}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<title>图书类别编辑页面</title>
</head>
<body>
<div class="x-panel-header">
<div style="float: left;">图书类别编辑页面</div>
</div>
	<div id="content">
		<s:form id="save" method="post" validate="true">

			<table id="fineTable" width="750"  align="center" style="margin-top: 20px;margin-bottom: 10px;">
				<tr>
					<th colspan="2">图书类别信息</th>
				</tr>
				<tr>
					<td class="td1"> 图书类别名称：</td>
					<td><s:hidden name="model.id" />
					<s:textfield name="model.lbMc"   style="width:380px;height:22px;"  cssClass="required"  maxlength="255"/>
						<font color="red">*</font>
					</td>

				</tr>
				<tr>
					<td class="td1" > 图书类别备注：</td>  
					<td>
					<s:textfield name="model.descn"   style="width:380px;height:22px;"   maxlength="255"/>
					
					</td>

				</tr>

				<tr>
					<td colspan="2" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/lbxx/queryxx.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>

		</s:form>

	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	function jkjsSave() {
			$('#save').attr("action", "${ctx}/lbxx/lbsave.do");
			$('#save').submit();
		}
	</script>
</body>
</html>
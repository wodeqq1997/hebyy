<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>论坛版块编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加论坛版块</div>
		<div class="x-panel-body">
			<form action="save.do" id="save" method="post" style="margin: auto;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>论坛版块信息编辑</legend>
				<table width="700" border="0" align="center" style="line-height: 30px; margin: 20px auto;">
					<tr>
						<td width="100" align="right">版块名称：</td>
						<td width="420">
							<s:textfield name="model.name" id="title"  maxlength="100" cssClass="required"/>
							<font color="red">*</font>
						</td>
						<td width="60" align="right">排序：</td>
						<td width="120">
							<s:textfield name="model.orderId" id="orderId"  maxlength="3" cssClass="required"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">板块描述：</td>
						<td colspan="3">
							<s:textarea name="model.descn" id="descn"  cssStyle=" width: 580px; height: 60px;"/>
						</td>
					</tr>
				</table>
			  </fieldset><br>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	</script>
</body>
</html>
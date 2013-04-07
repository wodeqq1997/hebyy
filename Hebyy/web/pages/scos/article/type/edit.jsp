<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>新闻类型编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">新闻类型编辑</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div class="x-panel-body">
			<form id="save" action="save.do" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>类型编辑</legend>
				<table border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">类型名称：</td>
						<td>
							<s:textfield name="model.name" id="title" cssStyle="width: 635px;" tyle="" maxlength="255" cssClass="required" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">描　述：</td>
						<td>
							<s:textarea name="model.descn" id="descn"  cssStyle="margin:3px 0px; width: 635px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物资类别信息编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加物资类别</div>
		<div class="x-panel-body" style="text-align: center;">
			<s:form id="save" action="save.do" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset style="width: 75%;  padding:10px 10px 10px 10px;">
			    <legend>物资类别信息编辑</legend>
				<table width="750" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="200" align="right">物资类别名称：</td>
						<td width="550">
							<s:textfield name="model.name" id="title"  maxlength="255" cssClass="required"/>
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
			</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
</script>
</html>
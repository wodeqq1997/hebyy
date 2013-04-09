<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物品类别编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加类别</div>
		<div align="center" style="width: 100%">
			<s:form action="save.do" id="save" method="post">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>物品类别编辑</legend>
				<table width="400" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="200" align="right">类别名称:</td>
						<td width="300">
							<s:textfield name="model.name" id="name"  maxlength="20" style="width:260px; " cssClass="required"/>
							<span id="nameDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top" >描述:</td>
						<td>
							<s:textarea name="model.descn" id="descn"  cssStyle="margin:2px 1px; width: 332px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			 <table align="center" width="600px" style="margin-bottom: 10px;">
				<tr>
					<td style="text-align: center;">
					  <s:submit value="保存" cssClass="button" /> 
					  &nbsp;&nbsp;
					  <s:reset value="重置" cssClass="button" />
					</td>
				</tr>
			</table>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>文档类别编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">
			&nbsp;添加类别.
			<s:if test='model.isPublic == "1"'>
			<span style="color: green;">(公共)</span>
			</s:if>
			<s:else>
			<span style="color: blue;">(个人)</span>
			</s:else>
		</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div class="x-panel-body">
			<form action="save.do" id="save" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>文档类别编辑</legend>
				<table width="500" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">名称:</td>
						<td width="400">
							<s:textfield name="model.name" id="name"  maxlength="50" cssClass="required"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top" >备注:</td>
						<td>
							<s:textfield name="model.descn" id="descn"  maxlength="50"/>
							<s:hidden name="model.isPublic" />
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
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
	</script>
</body>
</html>
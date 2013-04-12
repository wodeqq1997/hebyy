<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>通讯录编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加通讯录</div>
		<div class="x-panel-body" style="padding-top: 10px;">
			<form action="save.do" id="save" method="post" style="margin: 0px;" enctype="multipart/form-data">
			  <s:hidden name="model.id"/>
				<table width="800" border="0" align="center" style="line-height: 30px;" cellpadding="0" cellspacing="0">
					<tr>
						<td width="90" align="right">姓名：</td>
						<td width="710">
							<s:textfield name="model.name" id="title" maxlength="255" cssStyle="width:670px;" cssClass="required"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">手机号：</td>
						<td> 
							<s:textfield name="model.number" id="source" maxlength="255" cssClass="required number" cssStyle="width:670px;"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">类别：</td>
						<td>
						<s:select list="addressBookTypeMap" name="model.addressBookType.id" value="model.addressBookType.id" headerKey="" id="addressbookTypeId" headerValue="全部" cssStyle="width:200px;" cssClass="addressBookType required"/>
						</td>
					</tr>
					<tr>
						<td align="right">办公电话：</td>
						<td> 
							<s:textfield name="model.officeNumber" id="source" maxlength="255" cssClass="required number" cssStyle="width:670px;"/>
						</td>
					</tr>
					<tr>
						<td align="right">家庭电话：</td>
						<td>
							<s:textfield name="model.homeNumber" id="source" maxlength="255" cssClass="required number" cssStyle="width:670px;"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">备注：</td>
						<td>
							<s:textarea name="model.descn" id="content"  cssStyle="margin:3px 0px; width: 635px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			
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
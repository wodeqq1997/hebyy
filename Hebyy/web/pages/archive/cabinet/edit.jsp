<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案柜信息</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">档案柜信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
<s:form action="save.do" id="save" method="post">
	<s:hidden name="model.id" id="customerId"/>
	<fieldset style="width: 75%; padding:10px 10px 10px 10px;">
	<legend>档案柜信息</legend>
	<table width="100%" align="left">
		<tr>
			<td align="right" width="100">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
			<td align="left" colspan="3">
				<s:textfield id="name" name="model.name" maxLength="10" cssStyle="width:197px;" cssClass="required"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
           <td align="right">
				保管位置：
           </td>
           <td align="left" colspan="3">
           		<s:textfield id="location" name="model.location" cssStyle="width: 560px;" cssClass="required"/>
           		<font color="red">*</font>
			</td>
        </tr>		
        <tr>
           <td align="right">
           	备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：
           </td>
           <td align="left" colspan="3">
           		<s:textarea id="" name="model.remark" cols="55" rows="4" cssStyle="margin:3px 0px; width: 600px; height: 150px; overflow: auto; border: 1px solid #C3c3c3;"></s:textarea>
			</td>
        </tr>		
	</table>
	</fieldset>
	<table width="600px" style="margin-bottom: 10px;">
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
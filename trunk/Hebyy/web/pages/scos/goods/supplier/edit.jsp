<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>供应商信息</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<script type="text/javascript" src="${ctx}/pages/scos/goods/supplier/edit.js"></script>
<style type="text/css">
	/*去掉checkbox边框 ，适用于struts2 checkboxlist*/
	input{
		behavior:url(${ctx}/styles/input.htc);
	}
</style>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header">供应商信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
<s:form action="save.do" id="save" method="post">
	<s:hidden name="model.id" id="customerId"/>
	<fieldset style="width: 75%; padding:10px 10px 10px 10px;">
	<legend>供应商信息</legend>
	<table width="100%" align="left">
		<tr>
			<td align="right" width="100">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
			<td align="left" colspan="3">
				<s:textfield id="name" name="model.name" cssStyle="width:197px;" cssClass="required" maxLength="255"/>
				<span id="nameDescn"></span>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td align="right">联&nbsp;系&nbsp;人：</td>
			<td align="left" colspan="3">
				<s:textfield id="linkman" name="model.linkman" maxLength="15" cssStyle="width:197px;"/>
			</td>
		</tr>
		<tr>
			<td align="right">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
			<td align="left" colspan="3">
				<s:textfield id="" name="model.phone" maxLength="15" cssStyle="width:197px;" cssClass="phoneValidator"/>
				<span id="phoneDescn"></span>
			</td>
		</tr>
		<tr>
			<td align="right">开&nbsp;户&nbsp;行：</td>
			<td align="left" colspan="3">
				<s:textfield id="openBank" name="model.openBank"  maxlength="15" cssStyle="width:197px;"/>
				<span id="openBankDesc"></span>
			</td>
		</tr>
		<tr>
			<td align="right">银行账号：</td>
			<td align="left" colspan="3">
				<s:textfield id="bankAccount" name="model.bankAccount"  maxlength="15" cssStyle="width:197px;"/>
				<span id="bankAccount"></span>
			</td>
		</tr>
        <tr>
			<td align="right">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
			<td align="left" colspan="3">
				<s:textfield id="fax" name="model.fax" maxLength="15" cssStyle="width:197px;"/>
			</td>
		</tr>
		<tr>
			<td align="right">电子邮件：</td>
			<td align="left" colspan="3">
				<s:textfield id="emailId" name="model.email" maxLength="50" cssStyle="width:197px;" cssClass="emailValidator"/>
				<span id="emailDescn"></span>
			</td>
		</tr>
		<tr>
			<td align="right">邮&nbsp;&nbsp;&nbsp;&nbsp;编：</td>
			<td align="left" colspan="3">
				<s:textfield id="zipId" name="model.zip" maxLength="6" cssStyle="width:197px;" cssClass="zipValidator"/>
				<span id="zipx"></span>
			</td>
		</tr>
        <tr>
           <td align="right">
           	地&nbsp;&nbsp;&nbsp;&nbsp;址：
           </td>
           <td align="left" colspan="3">
           		<s:textarea id="" name="model.address"  cols="55" rows="4" cssStyle="margin:3px 0px; width: 400px; height: 60px; overflow: auto; border: 1px solid #C3c3c3;"></s:textarea>
			</td>
        </tr>
        <tr>
           <td align="right">
           	备&nbsp;&nbsp;&nbsp;&nbsp;注：
           </td>
           <td align="left" colspan="3">
           		<s:textarea id="" name="model.notes" cols="55" rows="4" cssStyle="margin:3px 0px; width: 400px; height: 60px; overflow: auto; border: 1px solid #C3c3c3;"></s:textarea>
			</td>
        </tr>		
	</table>
	</fieldset>
	<table width="600px" style="margin-bottom: 10px;">
		<tr>
			<td style="text-align: center;">
			  <s:submit value="保存" cssClass="button"/>
			  &nbsp;&nbsp;
			  <s:reset value="重置" cssClass="button" />
			</td>
		</tr>
	</table>
</s:form>
</div>
</div>
<script type="text/javascript">

</script>
</body>
</html>
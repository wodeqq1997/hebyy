<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物资归还记录编辑</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加物资归还记录</div>
		<div class="x-panel-body">
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <s:hidden name="inOrOut" value="in"/>
			  <fieldset style="width: 75%;  padding:10px 10px 10px 10px;">
			    <legend>物资归还记录编辑</legend>
				<table width="750" border="0" style="line-height: 30px;">
					<tr>
						<td align="right">
						归&nbsp;&nbsp;还&nbsp;&nbsp;人：</td>
						<td >
							<s:textfield name="model.bringPerson" id="bringPerson"  cssClass="required" maxLength="8"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">
						方&nbsp;&nbsp;量：</td>
						<td >
							<s:textfield name="model.square" id="square"  cssClass="required" maxLength="8"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">
						归还时间：
						</td>
						<td>
						<input id="bringTime" name="model.bringTime"  value="<s:date name='startDate' format='yyyy-MM-dd'/>"  onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'bringTime\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="required Wdate" readonly="readonly" />&nbsp;
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">出库明细：</td>
						<td>
							<s:textarea value="%{#attr.model.takeDetail}" 
							id="takeDetail" disabled="true" 
							cssStyle="margin:3px 0px; width: 450px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;resize: none;"/>
						</td>
					</tr>
					<tr>
						<td align="right">归还明细：</td>
						<td>
							<s:textarea name="model.bringDetail" id="takeDetail" 
							cssStyle="margin:3px 0px; width: 450px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;resize: none;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center" id="test" style="margin-top: 10px;">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
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
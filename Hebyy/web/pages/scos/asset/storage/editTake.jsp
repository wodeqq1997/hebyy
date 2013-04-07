<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/pages/scos/asset/selector.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<%@include file="/common/validator.jsp"%>
<title>物资出场记录编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加物资出场记录</div>
		<div class="x-panel-body">
			<div><%@ include file="/common/messages.jsp"%></div>
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <s:hidden name="inOrOut" value="out"/>
			  <fieldset style="width: 75%;  padding:10px 10px 10px 10px;">
			    <legend>物资出场记录编辑</legend>
				<table width="750" border="0" style="line-height: 30px;">
					<tr>
						<td width="200" align="right">选择物资：</td>
						<td width="550">
							<s:textfield id="name" name="model.asset.name" onclick="showAsset()"  readonly="true" cssClass="required"/>
							<s:hidden name="model.asset.id" id="assetId" />
							<span id="nameDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">
							领&nbsp;&nbsp;取&nbsp;&nbsp;人：
						</td>
						<td >
							<s:textfield name="model.takePerson" id="takePerson"  cssClass="required" maxLength="8"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">明细：</td>
						<td>
							<s:textarea name="model.takeDetail" id="takeDetail"
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
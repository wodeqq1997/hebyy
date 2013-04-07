<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物品添加</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
			<div style="float: left;">物品添加</div>
		</div>
		<div align="center" style="width: 100%">
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
					<tr>
						<th colspan="4">办公用品信息</th>
					<tr>
						<td width="100" align="right">物品编号：</td>
						<td width="250">
							<s:textfield name="model.goodsNo" id="goodsNo"  maxlength="20"/>
						</td>
						<td width="100" align="right">物品名称：</td>
						<td width="250">
							<s:textfield name="model.name" id="name"  maxlength="20" cssClass="required"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">规格：</td>
						<td>
							<s:textfield name="model.specifications" id="specifications"  maxlength="20"/>
						</td>
						<td align="right">物品类别：</td>
						<td>
							<s:select list="goodsTypeMap" name="model.goodsType.id" cssStyle="width: 150px" cssClass="goodsTypeCheck" headerKey="" headerValue="请选择类别"/><span id="goodsTypeDescn"></span><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">库存量：</td>
						<td>
							<s:textfield name="model.stockCounts" id="stockCounts"  maxlength="20" cssClass="digits" value="0" readonly="true"/>
						</td>
						<td align="right">计量单位：</td>
						<td >
							<s:textfield name="model.unit" id="unit"  maxlength="20" />
						</td>
					</tr>
					<tr>
						<td align="right">上限库存量：</td>
						<td >
							<s:textfield name="model.maxCount" id="maxCount"  maxlength="20" cssClass="digits"/>
						</td>
						<td align="right">下限库存量：</td>
						<td >
							<s:textfield name="model.minCount" id="minCount"  maxlength="20" cssClass="digits"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top" >备注：</td>
						<td colspan="3">
							<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 2px; width: 532px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				 </table>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  </div>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		
		$(function() {
			$.validator.addMethod("goodsTypeCheck", function(value, element) {
				if (value == null || value.length == 0) {
					return false;
				} else {
					$("#goodsTypeDescn").html("");
					return true;
				}
			}, "必填");
		});
	</script>
</body>
</html>

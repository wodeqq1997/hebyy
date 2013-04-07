<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/pages/scos/goods/selector.js"></script>
<%--<script type="text/javascript" src="${ctx}/pages/zjimis/project/project/selector.js"></script>--%>
<script type="text/javascript" src="${ctx}/scripts/calendar/WdatePicker.js"></script>
<%@include file="/common/validator.jsp"%>
<title>办公用品登记单编辑</title>
</head>
<body>
<div class="x-panel">
	<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
		<div style="float: left;">办公用品登记单</div>
	</div>
	<div align="center" style="width: 100%">
		<form action="save.do" id="save" method="post">
			<s:hidden name="model.id" />
			<table width="500" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
				<tr>
					<th colspan="2">办公用品使用登记单</th>
				</tr>
				<tr>
					<td align="right">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
					<td>
						<s:textfield name="model.applyNo" readonly="true" id="applyNo" maxlength="20" cssStyle="width: 332px;"/>
					</td>
					
				</tr>
				<tr>
					<td align="right">物&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;品：</td>
					<td>
						<s:hidden id="goodsId" name="model.goods.id"/>
						<s:textfield id="goodsName"  readonly="true" name="model.goods.name" cssClass="required" onclick="showGoods()" cssStyle="width: 332px;"/>
						<font color="red">*</font>
					</td>
				</tr> 
				<tr>
					<td align="right">剩余数量：</td>
					<td>
						<s:textfield name="model.goods.stockCounts" id="count" readonly="true"  maxlength="20" cssStyle="width: 332px;" cssClass="checkCount"/>
					</td>
				</tr>
				<tr>
					<td align="right">申请数量：</td>
					<td>
						<s:textfield name="model.useCount" id="useCount" cssClass="required digits"  maxlength="20" cssStyle="width: 332px;"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top" >备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					<td>
						<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 2px; width: 332px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
					</td>
				</tr>
			</table>
			<div align="center">
				<input type="button" value="保存" onclick="checkForm()" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button"
				onclick="javascript:window.location.href='${ctx}/goods/apply/myIndex.do';"
				class="button" value=" 返 回 ">
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	$(function() {
		$.validator.addMethod("checkCount", function(value, element) {
			if (Number(value) <= 0) {
				return false;
			} 
			return true;
		}, "库存数量不足，不允许申请领用");
	});
	function checkForm(){
		if(checkUseCount()){
			$("#save").submit();
		}
	}
	function checkUseCount(){
		var useCount = $('#useCount');
		if(parseInt(useCount.val()) > parseInt($('#count').val())){
			alert('申请数量大于库存数量，不允许申请');
			return false;
		}else{
			return true;
		}
	}
	

</script>
<script type="text/javascript" src="${ctx}/scripts/select.project.js"></script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/styles/select.project.css" rel="stylesheet"/>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
</body>
</html>
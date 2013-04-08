<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />

<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>物资信息编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加物资</div>
		<div class="x-panel-body">
			<form id="save" action="save.do" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="700" id="fineTable" align="center" style="margin-top: 20px;margin-bottom: 10px;">
					<tr>
						<th colspan="4">设备/物资</th>
					</tr>
					<tr>
						<td width="100" align="right">物资名称：</td>
						<td width="200">
							<s:textfield name="model.name" id="name"  maxlength="255" cssClass="required"/>
							<font color="red">*</font>
						</td>
						<td width="100" align="right">物资编号：</td>
						<td width="200">
							<s:textfield name="model.assetNo" id="assetNo"  maxlength="255" />
						</td>
					</tr>
					<tr>
						<td align="right">规格类型：</td>
						<td>
							<s:textfield name="model.stardard" id="stardard"  maxlength="255" />
						</td>
						<td align="right">配套物品：</td>
						<td>
							<s:textfield name="model.matchItems" id="matchItems"  maxlength="255" />
						</td>
					</tr>
					<tr>
						<td align="right">物资类别：</td>
						<td> 
							<s:select list="assetTypeMap" name="model.assetType.id" headerKey="" id="assetTypeId" headerValue="全部" cssStyle="width:146px;" cssClass="assetTypeCheck"/>
							<font color="red">*</font>
						</td>
						<td align="right">物资状态：</td>
						<td> 
							<s:select list="#{'好':'好','损坏':'损坏','报废':'报废'}" name="model.status" headerKey="" id="status" headerValue="全部" cssStyle="width:146px;" cssClass="statusCheck"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" >出厂日期：</td>
						<td class="simple">
							<input id="exFactoryDate" name="model.exFactoryDate"  value='<s:date name="model.exFactoryDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
						</td>
						<td align="right" >购买日期：</td>
						<td class="simple">
							<input id="buyDate" name="model.buyDate"  value='<s:date name="model.buyDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							<span id="buyDateDescn"></span>
						</td>
					</tr>
					<tr>
						<td align="right">资&nbsp;产&nbsp;值：</td>
						<td> 
							<input type="text" name="model.assetValue" id="assetValue"  maxlength="255" class="number" value='<fmt:formatNumber value="${model.assetValue}" pattern="##.##" />'>
							
						</td>
						<td align="right">保&nbsp;管&nbsp;人：</td>
						<td> 
							<s:textfield name="model.custodian" id="custodian"  maxlength="255" />
						</td>
					</tr>
					<tr>
						<td align="right">厂&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
						<td colspan="3"> 
							<s:textfield name="model.manufacturer" id="manufacturer" cssStyle="width:600px;" />
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td colspan="3">
							<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 0px; width: 600px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
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
		$(function(){
			$.validator.addMethod("assetTypeCheck", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必选项");
		});
		$(function(){
			$.validator.addMethod("statusCheck", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必选项");
		});
	</script>
</body>
</html>
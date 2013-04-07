<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>物资信息</title>
<%@include file="/common/meta.jsp"%>
</head>
<body>
	<div class="x-panel" style="width: 100%">
		<div class="x-panel-header">物资信息</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div align="center" style="width: 100%">
			<s:hidden name="model.id" />
			<fieldset style="width: 50%; padding:10px 10px 10px 10px;">
			<legend>物资信息</legend>
			<table width="100%" align="left">
				<tr>
					<td align="right" width="200">物资名称：</td>
					<td align="left" colspan="3">
					    ${model.name}
					</td>
				</tr>
				<tr>
					<td align="right" width="200">物资编号：</td>
					<td align="left" colspan="3">
					    ${model.assetNo}
					</td>
				</tr>
				<tr>
					<td align="right" width="200">物资类别：</td>
					<td align="left" colspan="3">
					    ${model.assetType.name}
					</td>
				</tr>
				<tr>
					<td align="right">物资状态：</td>
					<td> 
						${model.status}
					</td>
				</tr>
				<tr>
					<td align="right" width="200">规格类型：</td>
					<td align="left" colspan="3">
					    ${model.stardard}
					</td>
				</tr>
				<tr>
					<td align="right">配套物品：</td>
					<td>
						${model.matchItems }
					</td>
				</tr>
				<tr>
					<td align="right" width="200">厂&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
					<td align="left" colspan="3">
					    ${model.manufacturer}
					</td>
				</tr>
				<tr>
					<td align="right">出厂日期：</td>
					<td align="left" colspan="3">
						<s:date name="model.exFactoryDate" format="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td align="right">购买日期：</td>
					<td align="left" colspan="3">
						<s:date name="model.buyDate" format="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td align="right" width="200">资&nbsp;&nbsp;产&nbsp;&nbsp;值：</td>
					<td align="left" colspan="3">
					    ${model.assetValue}
					</td>
				</tr>
		        <tr>
					<td align="right">保&nbsp;&nbsp;管&nbsp;&nbsp;人：</td>
					<td align="left" colspan="3">
						${model.custodian}
					</td>
				</tr>
		        <tr>
		           <td align="right">
		           	备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：
		           </td>
		           <td align="left" colspan="3">
		           		${model.notes}
					</td>
		        </tr>
			</table>
			</fieldset>
			<table width="600px" style="margin-bottom: 10px;">
				<tr>
					<td style="text-align: center;">
					  <input type="button" value="返回" onclick="history.go(-1)" class="button"/> 
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
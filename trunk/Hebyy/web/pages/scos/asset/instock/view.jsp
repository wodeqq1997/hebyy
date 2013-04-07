<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>物资入库单信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">物资入库单</div>
		<div class="x-panel-body">
			<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
				<tr>
					<th colspan="4">入库单</th>
				</tr>
				<tr>
					<td width="100" align="center">入库单编号：</td>
					<td width="250">&nbsp;${model.stockNo}</td>
					<td width="100" align="center">物资：</td>
					<td width="250">&nbsp;${model.asset.name}</td>
				</tr> 
				<tr>
					<td align="center">单价：</td>
					<td>&nbsp;${model.price}</td>
					<td align="center">入库数量：</td>
					<td>&nbsp;${model.inCounts}</td>
				</tr>
				<tr>
					<td align="center">金额：</td>
					<td>&nbsp;${model.amount}</td>
					<td align="center">入库日期：</td>
					<td>&nbsp;<s:date name="model.inDate" format="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td align="center">经手人：</td>
					<td>
						${model.buyer}
					</td>
					<td align="center">供应商：</td>
					<td>
						${model.provider}
					</td>
				</tr>
				<tr>
					<td align="center">经手人：</td>
					<td>
						<s:date name="model.shelflife" format="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td align="center" valign="top" >备注：</td>
					<td colspan="3">
						${model.notes}
					</td>
				</tr>
			</table>
			<div align="center">
				<input type="button" value="关闭" onclick="window.close();" class="button" />
			</div>
		</div>
	</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>

<title>办公用品信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">办公用品信息</div>
		<div class="x-panel-body">
				<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
					<tr>
						<th colspan="4">
							办公用品信息
						</th>
					</tr>
					<tr>
						<td width="100" align="center">物品编号：</td>
						<td width="250">&nbsp;${model.goodsNo}</td>
						<td width=100 align="center">物品名称：</td>
						<td width="250">&nbsp;${model.name}</td>
					</tr>
					<tr>
						<td align="center">规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：</td>
						<td>&nbsp;${model.specifications}</td>
						<td align="center">物品类别：</td>
						<td>&nbsp;${model.goodsType.name}</td>
					</tr>
					<tr>
						<td align="center">计量单位：</td>
						<td>&nbsp;${model.unit}</td>
						<td align="center">库&nbsp;&nbsp;存&nbsp;&nbsp;量：</td>
						<td>&nbsp;${model.stockCounts}</td>
					</tr>
					<tr>
						<td align="center">最低库存量：</td>
						<td>&nbsp;${model.maxCount}</td>
						<td align="center">最低库存量：</td>
						<td>&nbsp;${model.minCount}</td>
					</tr>
					<tr>
						<td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td colspan="3">&nbsp;${model.notes}</td>
					</tr>
				</table>
			<div align="center">
				<input type="button" value="关闭" onclick="window.close();" class="button" />
			</div>
		</div>
	</div>
	</body>
</html>
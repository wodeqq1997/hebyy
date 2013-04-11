<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
	<%@include file="/common/meta.jsp"%>
	<title>办公用品领用登记信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header">办公用品领用登记信息</div>
		<div class="x-panel-body">
			<fieldset>
				<legend>办公用品领用信息</legend>
				<table width="850" border="0" align="center"
					style="line-height: 30px;">
					<tr>
						<td width="100"  align="right"></td>
						<td width="400"></td>
					</tr>
					<tr>
						<td align="right">物&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;品：</td>
						<td>${model.goods.name}</td>
					</tr>
					<tr>
						<td align="right">使用数量：</td>
						<td>${model.useCount}</td>
					</tr>
					<tr>
						<td align="right">领用日期：</td>
						<td><s:date name="model.applyDate" format="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<td align="right">领&nbsp;&nbsp;用&nbsp;&nbsp;人：</td>
						<td>${model.proposer.name}</td>
					</tr>
					<tr>
						<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td>${model.notes}</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<input type="button" value="关闭" onclick="window.close();" class="button" />
			</div>
		</div>
	</div>
	</body>
</html>
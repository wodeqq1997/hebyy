<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>职位详情</title>
<%@include file="/common/meta.jsp"%>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header">
	<div style="float: left;">岗位职责</div>
</div>
	<div align="center" style="width: 100%">
		<div style="margin: 10px;">
			<table id="fineTable" width="900" align="center">
				<tr>
					<th colspan="2" align="left">&nbsp;职位详情</th>
				</tr>
				<tr>
					<td align="right" width="100">用户名称：</td>
					<td>${userName}</td>
				</tr>
				<tr>
					<td align="right" width="100">所属部门：</td>
					<td>${model.dept.name}</td>
				</tr>
				<tr>
					<td align="right" width="100">岗位名称：</td>
					<td>${model.name}</td>
				</tr>
				<tr>
					<td align="right">岗位描述：</td>
					<td>${model.descn}</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>通讯录类别编辑</title>
</head>
<body>
<div class="x-panel">
<div class="x-header">添加通类别讯录</div>
<div class="x-panel-body" style="padding-top: 10px;">
<table width="800" border="0" align="center" style="line-height: 30px;"
	cellpadding="0" cellspacing="0">
	<tr>
		<td width="90" align="right">名称：</td>
		<td width="710">${model.name }</td>
	</tr>
	<tr>
		<td align="right" valign="top">备注：</td>
		<td>${model.descn }</td>
	</tr>
</table>

</div>
</div>
</body>
</html>
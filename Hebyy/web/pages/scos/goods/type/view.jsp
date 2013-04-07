<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>

<title>类别信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header">类别信息</div>
		<div class="x-panel-body">
			<fieldset>
				<legend>类别信息</legend>
				<table width="850" border="0" align="center"
					style="line-height: 30px;">
					<tr>
						<td width="100"  align="right"></td>
						<td width="400"></td>
					</tr>
					<tr>
						<td align="right">类别名称:</td>
						<td>${model.name}</td>
					</tr>
					<tr>
						<td align="right">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述:</td>
						<td>${model.descn}</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<input type="button" value="返回" onclick="history.go(-1)" class="button" />
			</div>
		</div>
	</div>
	</body>
</html>
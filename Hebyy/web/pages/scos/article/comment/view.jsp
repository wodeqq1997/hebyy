<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css'
	rel='stylesheet'>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>文章评论信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" align="left">文章评论信息</div>
		<div class="x-panel-body">
			<fieldset>
				<legend>文章评论信息</legend>
				<table width="100%" border="0" align="center" style="line-height: 20px;">
					<tr>
						<td width="100" align="right">标&nbsp;&nbsp;&nbsp;&nbsp;题：</td>
						<td width="750">${model.article.title}
					</td>
					<tr>
						<td align="right">作&nbsp;&nbsp;&nbsp;&nbsp;者：</td>
						<td>
						${model.author}
						</td>
					</tr>
					<tr>
						<td align="right">发表时间：</td>
						<td><s:date name="model.createTime" format="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
					<tr>
						<td align="right">内&nbsp;&nbsp;&nbsp;&nbsp;容：</td>
						<td>${model.content}</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<input type="button" value="返回" onclick="history.go(-1)"
					class="button" />
			</div>
		</div>
	</div>
</body>
</html>
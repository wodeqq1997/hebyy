<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<link href="${ctx}/styles/fix.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.row{
	/*height: 30px;*/
	line-height:30px;
	border-bottom:1px solid #99BBE8; 
	font-family: sans-serif;
}
.title {
	font-size: 14px;
	font-weight: bold;
	background-image:
		url("${ctx}/scripts/extjs/resources/images/default/toolbar/bg.gif");
	text-align: center;
}
</style>
<title>通知公告查看</title>
</head>
<body style="background-color: #DFE8F6;">
<div style="width: 980px;margin: 0 auto;">
	<div style="margin: 10px; color: red; font-weight: bold; font-size: 14px; text-align: left;">通知公告查看</div>
	<div class="viewPanel">
		<div class="row title">${model.title}</div>
		<div class="row" align="right">
			&nbsp;<b>${model.creator.name}</b> &nbsp;发布于[
			<s:date name="model.createTime" format="yyyy-MM-dd HH:mm" />
			]
			&nbsp;&nbsp;
		</div>
		<div class="row">
			<div style="margin: 5px; line-height: 25px;">
				${model.content}</div>
		</div>
		<div class="row" style="padding: 5px;">
			&nbsp;附件列表：
			<div id="systop_file_list"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
	viewFileAttchList("${model.fileAttchIds}", false);
</script>
</body>
</html>
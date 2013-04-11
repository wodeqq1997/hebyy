<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattc/fileattch.css" type='text/css'
	rel='stylesheet'>
<title>规章制度查看页面</title>
</head>
<body>

<s:form id="save" method="post" validate="true">
	<div class="x-panel">
	<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">规章制度查看页面</div>
	<div class="x-panel-body">
	<table width="700" border="0" align="center"
		style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;"
		id="fineTable">
		<tr>
			<th colspan="2">规章制度查看</th>
		</tr>

		<tr>
			<td align="right" width="180">类别名称：</td>
			<td>${model.zcxx.zcMc } <s:hidden name="model.id" /></td>
		</tr>
		<tr>
			<td align="right">文 件 号：</td>
			<td>${model.wjh }</td>
		</tr>
		<tr>
			<td align="right">文件内容：</td>
			<td>${model.zdContent }</td>
		</tr>
		<tr>
			<td align="right">文件附件：</td>
			<td>
			<div id="systop_file_list"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border: 0px;" align="center"><br>
			<input type="button" value="返回" onclick="history.go(-1)"
				class="button" /></td>

		</tr>
	</table>
	</div>
	</div>

</s:form>
<script type="text/javascript">
	viewFileAttchList("${model.fileAttachIds}", false);
</script>
</body>
</html>
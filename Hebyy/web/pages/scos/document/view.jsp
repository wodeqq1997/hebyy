<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattc/fileattch.css" type='text/css' rel='stylesheet'>
<title>文档信息查看</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" style="border: 1px solid #99bbe8;">
		  <img src="${ctx}/images/icons/file.png"> 文档信息查看</div>
		<div class="x-panel-body"><br>
			<table width="850" id="fineTable" align="center">
				<tr>
					<td align="right" width="100">文档标题：</td>
					<td width="750" colspan="3">${model.title}</td>
				</tr>
				<tr>
					<td align="right" width="100">上传者：</td>
					<td width="200">
						<s:if test="model.owner == null">公共文档</s:if>
						<s:else>${model.owner.name}</s:else>
					</td>
					<td align="right" width="100">上传时间：</td>
					<td width="350"><s:date name="model.createTime"
							format="yyyy年MM月dd日" /></td>
				</tr>
				<tr>
					<td align="right">文档附件：</td>
					<td colspan="3">
						<div id="systop_file_list"></div></td>
				</tr>
				<tr>
					<td align="right">文档介绍：</td>
					<td colspan="3" style="height: 250px;">${model.descn}
					</td>
				</tr>


			</table>
		</div>
	</div>
	<script type="text/javascript">
		viewFileAttchList("${model.fileattchIds}", false);
	</script>
</body>
</html>
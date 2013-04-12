<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattc/fileattch.css" type='text/css' rel='stylesheet'>
<title>会议查看页面</title>
</head>
<body>
<s:form id="save" method="post" validate="true">	
<div class="x-panel">
		<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">会议查看页面</div>
		<div class="x-panel-body">
				<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
					<tr>
						<th colspan="4">会议查看</th>
					</tr>	
		<tr>
			<td align="right"  width="180">会议文件名称：</td>
			<td> ${model.hyMc }
			<s:hidden name="model.id" /></td>
			<td align="right">会议纪要类别：</td>
			<td>${model.hytype }</td>
		</tr>
		<tr>
			<td align="right">会议文件号：</td>
			<td>${model.wjh }</td>
			<td align="right">文件页/份数：</td>
			<td>${model.pageNum }</td>
		</tr>
		<tr>
			<td align="right">会议参与人：</td>
			<td>${model.hycyr }</td>
			<td align="right">会 议 时 间：</td>
			<td><s:date name="model.hyTime" format="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td align="right" >会 议 备 注：</td>
			<td colspan="3">${model.hyContent }</td>
		</tr>
		<tr>
			<td align="right">上传会议文件：</td>
			<td colspan="3"><div id="systop_file_list"></div></td>
		</tr>
		<tr>
			<td colspan="4" style="border: 0px;" align="center"><br> 
			<input type="button" value="返回" onclick="history.go(-1)" class="button" />
			</td>
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
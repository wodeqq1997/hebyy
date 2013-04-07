<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>案卷类型信息</title>
<%@include file="/common/meta.jsp"%>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<style>
    .income-div,.payment-div{
        padding-top: 7px;
    }
</style>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">案卷类型信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
	<s:hidden name="model.id" />
	<table width="700" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<th colspan="4">文件信息</th>
		</tr>
		<tr>
			<td width="100" align="center">文&nbsp;&nbsp;件&nbsp;&nbsp;号：</td>
			<td width="250">
				&nbsp;${model.fileNO}
			</td>
			<td width="100" align="center">文件名称：</td>
			<td width="250">
				&nbsp;${model.name}
			</td>
		</tr>
		<tr>
			<td width="100" align="center">所属案卷：</td>
			<td width="250">
				&nbsp;${archive.name}
			</td>
			<td width="100" align="center">发文单位：</td>
			<td width="250">
				&nbsp;${model.sendUnit}
			</td>
		</tr>
		<tr>
			<td width="100" align="center">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;级：</td>
			<td width="250">
				&nbsp;${model.dense}
			</td>
			<td width="100" align="center">发文日期：</td>
			<td width="250">
				&nbsp;<fmt:formatDate value="${model.sendDate}" pattern="yyyy-MM-dd"/>
			</td>
		</tr>
		<tr>
			<td width="100" align="center">文件页数：</td>
			<td width="250">
				&nbsp;${model.filePage}
			</td>
			<td width="100" align="center">打印页数：</td>
			<td width="250">
				&nbsp;${model.printPage}
			</td>
		</tr>
		<tr>
			<td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
			<td colspan="3"> 
				&nbsp;${model.remark}
			</td>
		</tr>
		<s:if test="#attr.sign != null && #attr.sign == 'viewFile'">
			<tr>
				<td align="center">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
				<td colspan="3"> 
					<div style="margin-left: 5px;" id="systop_file_list"></div>
				</td>
			</tr>		
		</s:if>
	</table>


    <table width="700px" style="margin-bottom: 10px;margin-top: 20px;" align="center">
		<tr>
			<td style="text-align: center;">
			  <input type="button" value="关闭" onclick="javascript:window.close()" class="button"/> 
			</td>
		</tr>
	</table>
</div>
<s:if test="model.id != null">
	<script type="text/javascript">
	viewFileAttchList('${model.attachIds}', false);
	</script>
</s:if>
</body>
</html>
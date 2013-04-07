<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>设备检测记录</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" align="left">设备检测记录</div>
		<div class="x-panel-body">
			<table width="500" id="fineTable" align="center" style="margin-top: 20px;margin-bottom: 10px;">
				<tr>
					<td width="100" align="center">设备物资</td>
					<td width="400">
						&nbsp;<s:property value="model.asset.name"/>
					</td>
				</tr>
				<tr>
					<td align="center" >送检日期</td>
					<td class="simple">
						&nbsp;<s:date name='model.checkDate' format='yyyy-MM-dd'/>
					</td>
				</tr>
				<tr>
					<td align="center" >校检日期</td>
					<td class="simple">
						&nbsp;<s:date name='model.correctDate' format='yyyy-MM-dd'/>
					</td>
				</tr>
				
				<tr>
					<td align="center">送&nbsp;&nbsp;检&nbsp;&nbsp;人</td>
					<td >
						&nbsp;${model.executant }
					</td>
				</tr>
				<tr>
					<td align="center" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
					<td>
						&nbsp;${model.notes}
					</td>
				</tr>
				<tr>
		        	<td align="center">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件</td>
					<td>
						<div id="systop_file_list"></div>
					</td>
		        </tr>
			</table>
			<div align="center">
				<input type="button" value="返回" onclick="history.go(-1)" class="button" />
			</div>
		</div>
	</div>
	<s:if test="model.id != null">
		<script type="text/javascript">
			viewFileAttchList('${model.attachIds}', true);
		</script>
	</s:if>
</body>
</html>
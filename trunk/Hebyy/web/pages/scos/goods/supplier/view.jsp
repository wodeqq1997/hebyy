<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>供应商信息</title>
<%@include file="/common/meta.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header">供应商信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
	<s:hidden name="model.id" />
	<table width="700" id="fineTable" align="center" style="margin-top: 10px;margin-bottom: 10px;">
		<tr>
			<th colspan="4">供应商信息</th>
		</tr>
		<tr>
			<td align="center" width="70">名&nbsp;&nbsp;&nbsp;&nbsp;称</td>
			<td align="left" >${model.name}</td>
			<td align="center" width="70" >联&nbsp;系&nbsp;人</td>
			<td class="simple">${model.linkman}</td>
		</tr>
		<tr>
			<td align="center">电&nbsp;&nbsp;&nbsp;&nbsp;话</td>
			<td align="left" >${model.phone}</td>
			<td align="center">电子邮件</td>
			<td align="left" >${model.email}</td>
		</tr>
		<tr>
			<td align="center">开&nbsp;户&nbsp;行</td>
			<td align="left" >${model.openBank}</td>
			<td align="center">银行账号</td>
			<td align="left" >${model.bankAccount}</td>
		</tr>
        <tr>
			<td align="center">传&nbsp;&nbsp;&nbsp;&nbsp;真</td>
			<td align="left" >${model.fax}</td>
			<td align="center">邮&nbsp;&nbsp;&nbsp;&nbsp;编</td>
			<td align="left" >${model.zip}</td>
		</tr>
        <tr>
           <td align="center">地&nbsp;&nbsp;&nbsp;&nbsp;址</td>
           <td align="left" colspan="3">${model.address}</td>
        </tr>
        <tr>
           <td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
           <td align="left" colspan="3">${model.notes}</td>
        </tr>		
	</table>
	<table width="700px" style="margin-bottom: 10px;">
		<tr>
			<td style="text-align: center;">
			  <input type="button" value="关闭" onclick="javascript:window.close();" class="button"/> 
			</td>
		</tr>
	</table>
</div>
</div>
</body>
</html>
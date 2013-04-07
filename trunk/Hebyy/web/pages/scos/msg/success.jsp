<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>发送短消息</title>
<%@include file="/common/meta.jsp"%>
</head>
<body>
	<div class="x-panel-header">短信发送成功</div>
	<fieldset style="margin: 10px;">
		<table width="400" align="center" style="margin: 25px auto;">
			<tr>
				<td width="80" valign="top"><img src="${ctx}/images/icons/ok.png">
				</td>
				<td width="320">
					<div style="color: green; font-size: 18px; font-weight: bold; line-height: 25px;">短信发送成功!</div>
					<div style="color: green; line-height: 25px;">
						<a style="color: green;" href="${ctx}/msg/newMsg.do">1.我要继续发送短信</a><br>
						<a style="color: green;" href="${ctx}/msg/receiveIndex.do">2.返回已经接收信息</a>
					</div>
				</td>
			</tr>
		</table>
	</fieldset>
</body>
</html>
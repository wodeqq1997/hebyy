<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/kindeditor.jsp"%>

    <%@include file="/common/uploadify.jsp"%>
    <script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
    <link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<title>日志信息编辑</title>
</head>
<body >
	<div class="x-panel">
		<div class="x-header">添加日志</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div class="x-panel-body">
			<form action="save.do" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>日志信息编辑</legend>
				<table border="0" align="center" style="line-height: 30px;width:100%">
					<tr>
						<td width="100" align="right">标题：</td>
						<td>
							<s:textfield name="model.title" id="title" maxlength="255" cssStyle="width:650"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">办理中工作事务：</td>
						<td>
							<s:textarea name="model.doing" id="content"  cssStyle="margin:3px 2px; width: 596px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">已完成工作事务：</td>
						<td>
							<s:textarea name="model.complate" id="content"  cssStyle="margin:3px 2px; width: 596px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">待办理工作事务：</td>
						<td>
							<s:textarea name="model.todo" id="content"  cssStyle="margin:3px 2px; width: 596px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">备注：</td>
						<td>
							<s:textarea name="model.content" id="content"  cssStyle="margin:3px 2px; width: 596px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>
</body>
</html>
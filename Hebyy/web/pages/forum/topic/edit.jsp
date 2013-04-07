<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<title>发表帖子</title>
<style type="text/css">
.board {
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #99BBE8;
	font-family: sans-serif;
	background-color: #d0def0;
	font-weight: bold;
}
</style>
</head>
<body style="background-color: #DFE8F6;">
	<div style="margin: 10px 100px;font-weight: bold; font-size: 14px;">
		<a href="${ctx}/forum/board/index.do" style="color: red; " title="论坛首页">河北演艺集团员工讨论区</a>
	</div>
	<div class="viewPanel" style="margin: 0px 100px;">
		<div class="board">
			<div style="float: left; padding-left: 20px;">编辑新帖</div>
		</div>

		<form action="save.do" id="save" method="post" style="margin: auto;">
			<s:hidden name="model.id" />
			<table width="730" align="center">
				<tr>
					<td width="80" align="right">版&nbsp;&nbsp;块：</td>
					<td width="650">
						<span style="color: green;font-weight: bold;">${model.board.name}</span>
						<s:hidden name="model.board.id" />
					</td>
				</tr>
				<tr>
					<td align="right">主&nbsp;&nbsp;题：</td>
					<td>
						<s:textfield name="model.title" id="title" maxlength="255" cssStyle="width:600px;" cssClass="required" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td align="right">内&nbsp;&nbsp;容：</td>
					<td>
						<s:textarea name="model.content" id="content"/>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="reset" value="重置" class="button">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('#content', {
				resizeType :1,
				allowFileManager : true,
				uploadJson : '${ctx}/fileManager/upload_json.jsp',
				fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
				width:600,
				height:350
			});
		});
		
	</script>
</body>
</html>
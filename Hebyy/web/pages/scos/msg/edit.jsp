<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>发送短消息</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>
<script type="text/javascript"
	src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link
	href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css"
	rel="stylesheet" />
<style type="text/css">
.msgInput {
	width: 600px;
}
</style>
</head>
<body onload="kind();">
<div class="x-panel">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">发送短消息</div>
<div class="x-panel-body">
<form id="sendMsg" action="sendMsg.do" method="post"
	style="margin: auto;">
<fieldset><legend>短消息编辑</legend>

<table width="100%" align="center" style="line-height: 30px;"
	cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" height="10"></td>
	</tr>
	<tr>
		<td width="65" align="right">发送人：</td>
		<td width="635"><input type="text" name="senderName"
			value="${model.sender.name}" class="msgInput" readonly="readonly" />
		<s:hidden name="model.sender.id" id="senderId" /></td>
	</tr>
	<tr>
		<td align="right" onclick="" style="cursor: pointer;">接收人：</td>
		<td><s:textfield name="receiverNames" id="receiverNames"
			cssClass="msgInput required" readonly="true"
			onclick="openSelector(this)" style="cursor: pointer;" /> <s:hidden
			name="receiverIds" id="receiverIds" /></td>
	</tr>
	<tr>
		<td align="right" valign="top">简要标题：</td>
		<td style="padding-top: 5px;"><textarea name="model.title"
			id="content"  style="width: 600px; height: 200px;"></textarea>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">内 容：</td>
		<td style="padding-top: 5px;"><textarea name="model.content"
			id="content" class="required" style="width: 600px; height: 200px;"></textarea>
		</td>
	</tr>
	<tr>
		<td align="right">附件：</td>
		<td>
		<table>
			<tr>
				<td><input type="file" id="systop_upload" />&nbsp;</td>
				<td><span style="color: #EB2A03">附件大小在30M以内!</span></td>
			</tr>
		</table>
		<div id="custom">
		<div id="systop-file-queue"></div>
		</div>
		<div id="systop-uploaded-files"
			style="width: 740px; border-bottom: 1px solid #C3C3C3;"><s:hidden
			id="fileAttchIds" name="model.fileAttchIds" /></div>
		<div id="systop_file_list"></div>
		</td>
	</tr>
</table>
<br>
</fieldset>
<div align="center"><input type="submit" value="立即发送"
	class="button">&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset"
	value="重置" class="button"></div>
</form>
</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#sendMsg").validate();
	});
	renderUploader(true, fileType, fileDesc, 30240000);
	function kind(){
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('#content', {
			resizeType :1,
			allowFileManager : true,
			uploadJson : '${ctx}/fileManager/upload_json.jsp',
			fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
			width:600,
			height:350,
			 items : [  'undo', 'redo', '|', 'template', 'cut', 'copy', 'paste',
			   		'plainpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
					'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
					'superscript', 'quickformat', 'selectall', '|', 'fullscreen', '/',
					'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
					'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
					'table', 'hr', 'emoticons', 'map']
		});
	});
	}
	viewFileAttchList('${model.fileAttchIds}', true);

	function openSelector(obj) {
		openSel(function(users) {
			var selectNames = "";
			var selectIds = "";
			if (users != null) {
				for ( var i = 0; i < users.length; i++) {
					selectNames = selectNames + users[i].name + ",";
					selectIds = selectIds + users[i].id + ",";
				}
			}
			obj.value = selectNames;
			var ids = document.getElementById("receiverIds");
			ids.value = selectIds;

		});
	}
</script>
</body>
</html>
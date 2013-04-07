<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>文件发送</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/pages/admin/fileattc/fileattch.css" type='text/css' rel='stylesheet'>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.msgInput{
	width: 600px;
}
</style>
</head>
<body>
<div class="x-panel-header" style="border-bottom:1px solid #99BBE8; ">
  <img src="${ctx}/images/icons/mail_3.gif ">&nbsp;编辑发送文件
</div>
<form id="sendMail" action="sendMail.do" method="post" style="margin: auto;">
  <input type="hidden" name="senderName" value="${model.sender.name}" style="color:#2966B0;" class="msgInput"/>
  <div style="margin: 5px 10px;">
  	<input type="button" class="button" value="立即发送" onclick="sendMail()">
  	<input type="button" class="button" value="存 草 稿" onclick="saveDraft()">
  </div>
  	<input type="hidden" name="model.id" value="${model.id}">
	<table width="700" align="center" border="0">
	  <tr>
	    <td width="80"  align="right">收件人：</td>
	    <td width="620" colspan="2">
	    	<s:textfield name="model.recipientNames" id="recipientNames" cssClass="msgInput" readonly="true" 
	    	  onclick="openSelector(this)" style="cursor: pointer;"/>  	
	    	  
	    	<s:hidden name="model.recipientIDs" id="recipientIDs"/>
	    </td>
	  </tr>
	  <!-- 
	  <tr>
	    <td align="right" style="cursor: pointer;" onclick="showCopyWin()">抄　送：</td>
	    <td colspan="2">
	    	<s:textfield name="model.copyToNames" id="copyToNames" cssClass="msgInput" readonly="true" 
	    	  onclick="showRecipientWin()" style="cursor: pointer;"/>
	    	<s:hidden name="model.copyToIDs" id="copyToIDs"/>
	    </td>
	  </tr>
	   -->
	  <tr>
	    <td align="right">主　题：</td>
	    <td colspan="2">
	    	<s:textfield name="model.subject" id="subject" cssClass="msgInput"/>
	    </td>
	  </tr>
	  <tr>
	    <td align="right" width="80">附　件：</td>
	    <td valign="top" width="70">
	  		<input type="file" id="systop_upload"/>
	  	<td width="550">
	  	  &nbsp;注：<span style="color:#EB2A03; font-family: sans-serif;">附加大小在100M以内!</span>
	  	</td>
	  </tr>  
	  <tr>
	    <td></td>
	  	<td colspan="2">
	   	    <div id="custom"><div id="systop-file-queue"></div></div>
	   	    <div id="systop-uploaded-files" style="width:600px;">
	   	      <input type="hidden" id="fileAttchIds" name="fileattchids"/>
	 	    </div>
	    </td>
	  </tr>
	  <tr>
	    <td style="padding-top: 5px;" colspan="3" align="center">
	      <s:textarea id="content" name="model.content"></s:textarea>
	    </td>
	  </tr>
	</table><br>
  </form>
<script type="text/javascript">

	//渲染上传组件
	renderUploader(true, fileType, fileDesc, 30240000);
	
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('#content', {
			resizeType :1,
			allowFileManager : true,
			uploadJson : '${ctx}/fileManager/upload_json.jsp',
			fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
			width:670,
			height:350
		});
	});
	//发送邮件
	function sendMail() {
		var receiverIds = $("#recipientIDs").val();
		if (receiverIds == null || receiverIds.length == 0) {
			alert("必须选择收信人!");
			return;
		}
		editor.sync();
		document.getElementById("sendMail").submit();
	}
	//保存草稿
	function saveDraft() {
		document.getElementById("sendMail").action = "saveDraft.do";
		editor.sync();
		document.getElementById("sendMail").submit();
	}
	
	function openSelector(obj) {
        openSel(function (users) {
            var selectNames = "";
            var selectIds = "";
            if (users != null) {
                for (var i = 0; i < users.length; i++) {
                    selectNames = selectNames + users[i].name + ",";
                    selectIds = selectIds + users[i].id + ",";
                }
            }
            obj.value = selectNames;
            var ids = document.getElementById("recipientIDs");
            ids.value = selectIds;
        })
	}
</script>

<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
</body>
</html>
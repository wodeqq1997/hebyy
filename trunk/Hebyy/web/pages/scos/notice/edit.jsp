<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<title>通知公告编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加通知公告</div>
		<div class="x-panel-body">
			<form action="save.do" id="save" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>通知公告编辑</legend>
				<table border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">标&nbsp;题：</td>
						<td>
							<s:textfield name="model.title" id="title" maxlength="255" cssStyle="width: 90%" cssClass="checkTitle"/>
							<span id="checkTitleDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">内&nbsp;容：</td>
						<td>
							<s:textarea name="model.content" id="content"/>
						</td>
					</tr>
					<tr>
						<td align="right" style="vertical-align: top;">附&nbsp;件：</td>
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
							<div id="systop-uploaded-files" style="width:740px; border-bottom: 1px solid #C3C3C3;">
								<s:hidden id="fileAttchIds" name="model.fileAttchIds" />
							</div>
							<div id="systop_file_list"></div>
						</td>
					</tr>
					
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="发布" class="button">&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		
		$(function() {
			$.validator.addMethod("checkTitle", function(value, element) {
		        var res = "";
		        if(value.length == 0){
		        	$("#checkTitleDescn").html("<font color='red'>必填</font>");
					res = "err";
		        }else{
		        	$("#checkTitleDescn").html("");
		        	return true;
		        }
		        return res != "err";
		    },"");
		});
		
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('#content', {
				resizeType :1,
				allowFileManager : true,
				uploadJson : '${ctx}/fileManager/upload_json.jsp',
				fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
				width:"99%",
				height:350
			});
		});
		//渲染上传组件
		renderUploader(true, fileType, fileDesc, 30240000);
		viewFileAttchList('${model.fileAttchIds}', true);
	</script>
</body>
</html>
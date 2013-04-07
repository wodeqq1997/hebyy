<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<title>文章信息编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加文章</div>
		<div class="x-panel-body" style="padding-top: 10px;">
			<form action="save.do" id="save" method="post" style="margin: 0px;" enctype="multipart/form-data">
			  <s:hidden name="model.id"/>
				<table width="800" border="0" align="center" style="line-height: 30px;" cellpadding="0" cellspacing="0">
					<tr>
						<td width="90" align="right">标题：</td>
						<td width="710">
							<s:textfield name="model.title" id="title" maxlength="255" cssStyle="width:670px;" cssClass="required"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">来源：</td>
						<td> 
							<s:textfield name="model.source" id="source" maxlength="255" cssStyle="width:670px;"/>
						</td>
					</tr>
					<tr>
						<td align="right">类型：</td>
						<td> 
							<s:select list="articleTypeMap" name="articleTypeId" value="model.articleType.id" headerKey="" id="articleTypeId" headerValue="全部" cssStyle="width:200px;" cssClass="articleType"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">照片：</td>
						<td>
							<s:hidden value="model.articlePhoto"/>
							<s:file name="photo" label="File" cssClass="checkPhoto" cssStyle="width:230px;"/>
							<span id="photoDescn" style="color: red;">首页显示照片（默认：无）</span>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">内容：</td>
						<td>
							<s:textarea name="model.content" id="content"  cssStyle="margin:3px 0px; width: 635px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
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
							<div id="systop-uploaded-files" style="width: 740px; border-bottom: 1px solid #C3C3C3;">
								<s:hidden id="fileAttchIds" name="model.fileAttchIds" />
							</div>
							<div id="systop_file_list"></div>
						</td>
					</tr>
				</table>
			
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
			$.validator.addMethod("articleType", function(value, element) {
				if (value == null || value.length == 0) {
					return false;
				} 
				return true;
			}, "必选");
			$.validator.addMethod("checkPhoto", function(value, element) {
				if (value != null && value.length > 0) {
					var pos = value.lastIndexOf(".");
					//此处文件后缀名也可用数组方式获得str.split(".")
					var lastname = value.substring(pos, value.length);  
					//alert(lastname);
					if (lastname.toLowerCase()!=".jpg" 
								&& lastname.toLowerCase()!=".gif" 
								&& lastname.toLowerCase()!=".png"
								&& lastname.toLowerCase()!=".jpeg"	
								&& lastname.toLowerCase()!=".bmp"){
						$('#photoDescn').html('图片类型错误');
						return false;
					}
				} 
				$('#photoDescn').html('首页显示照片（默认：无）');
				return true;
			}, "");
		});
		
		//渲染上传组件
		renderUploader(true, fileType, fileDesc, 30240000);
		
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('#content', {
				resizeType :1,
				allowFileManager : true,
				uploadJson : '${ctx}/fileManager/upload_json.jsp',
				fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
				width:720,
				height:350
			});
		});
		
		viewFileAttchList('${model.fileAttchIds}', true);
	</script>
</body>
</html>
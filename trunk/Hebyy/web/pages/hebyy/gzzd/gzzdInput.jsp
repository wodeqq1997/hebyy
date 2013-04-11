<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css'
	rel='stylesheet'>
<title>规章制度编辑页面</title>
</head>
<body>
<div class="x-panel-header">
			<div style="float: left;">规章制度条例</div>
	    </div>
<div id="content">
	<br>
	<table id="fineTable" width="750" align="center" style="margin-top: 20px;margin-bottom: 10px;">
	<s:form id="save" method="post"
	validate="true">
	    <tr>
			<th colspan="2">规章制度信息：</th>
		</tr>
		<tr>
			<td align="right"  width="160">类别名称：</td>
			<td ><s:select name="model.zcml" list='names'
				cssStyle="width:360px;height=22;" headerKey="" headerValue="请选择" cssClass="typeCheck" />
				<span id="typeDescn"></span>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td align="right" >文 件 号：</td>
			<td ><s:textfield  name="model.wjh"
				cssStyle="width:360px;" cssClass="required"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td align="right">文件内容：</td>
			<td><s:textfield  name="model.zdContent"
				cssStyle="width:360px" cssClass="required"/>
				<font color="red">*</font>
				 <s:hidden name="model.id" />
			</td>
		</tr>
		<tr height="36">
			<td align="right">文件上传：</td>
			<td>
		
				<input type="file" id="systop_upload" />
					<font style="color: #EB2A03">附件大小在30M以内!</font>
			<div id="custom">
			<div id="systop-file-queue"></div>
			</div>
			<div id="systop-uploaded-files"
				style="width: 410px; border-bottom: 1px solid #C3C3C3;"><s:hidden
				id="fileAttchIds" name="model.fileAttachIds" /></div>
			<div id="systop_file_list"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border: 0px;" align="center"><%@include
				file="/pages/common/messages.jsp"%> <input
				type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;<input type="button"
				onclick="javascript:window.location.href='${ctx}/gzzd/queryxx.do';"
				class="button" value=" 返 回 "></td>
		</tr>
		</s:form>
	</table>

</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	
	$(function() {
		$.validator.addMethod("typeCheck", function(value, element) {
			if (value == null || value.length == 0) {
				return false;
			} else {
				$("#typeDescn").html("");
				return true;
			}
		}, "必填");
	});

	function jkjsSave() {
		$('#save').attr("action", "${ctx}/gzzd/jkjsSave.do");
		$('#save').submit();
	}
</script>
<script type="text/javascript">
	//渲染上传组件
	renderUploader(true, fileType, fileDesc, 30240000);
	viewFileAttchList('${model.fileAttachIds}', true);
	function isChangeVisaBox() {
		if ($('#isChangeVisaBox').attr("checked")) {
			$('#isChangeVisa').val('1');
			$('#isChangeVisaTr').show();
		} else {
			$('#isChangeVisa').val('');
			$('#isChangeVisaTr').hide();
		}
	}
</script>
</body>
</html>
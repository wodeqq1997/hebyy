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
<title>会议编辑页面</title>
</head>
<body>
<div class="x-header">会议编辑页面</div>
<s:form id="save" method="post" validate="true">
	<fieldset><legend>基本信息</legend>
	<table width="720" border="0" style="line-height: 30px;">
		<tr>
			<td align="right"  width="280">会议文件名称：</td>
			<td width="440"> 
				<s:textfield name="model.hyMc"  style="width: 260px;"  cssClass="required"  maxlength="255"/>
						<font color="red">*</font>
			<s:hidden name="model.id" /></td>
		</tr>
		<tr>
			<td align="right">会议纪要类别：</td>
			<td><s:select name="model.meetingType.id" list='typeMap' cssClass="typeCheck" cssStyle="width:100px;" headerKey="" headerValue="请选择" />
				<span id="typeDescn"></span>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td align="right">文    件   号：</td>
			<td>
				<s:textfield name="model.wjh"   style="width: 260px;"  cssClass="required"  maxlength="255"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td align="right">文件页/份数：</td>
			<td>
				<s:textfield name="model.pageNum"   style="width: 260px;"  cssClass="required number"  maxlength="255"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td align="right">会议参与人：</td>
			<td>
			<s:textfield name="model.hycyr"   style="width: 260px;"    maxlength="255"/>
			</td>
		</tr>
		<tr>
			<td align="right"> 会 议 时 间：</td>
			<td><input id="hytime" type="text" name="model.hyTime" style="width: 260px;" readonly="readonly" value='<s:date name="model.hyTime" format="yyyy-MM-dd"/>' onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
				<span id="dateDescn"></span>
				<font color="red">*</font>
				</td>
		</tr>
		<tr>
			<td align="right">会 议 备 注：</td>
			<td><s:textarea id="content" name="model.hyContent"	cssStyle="width:260px;height: 45px;" /></td>
		</tr>
		<tr>
			<td align="right">上传会议记录：</td>
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
			<div id="systop-uploaded-files" style="width: 400px; border-bottom: 1px solid #C3C3C3;">
			<s:hidden id="fileAttchIds" name="model.fileAttachIds" /></div>
			<div id="systop_file_list"></div>
			</td>
		</tr>
		<tr>
			<td colspan="6" style="border: 0px;" align="center"><%@include file="/pages/common/messages.jsp"%>
			<input type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="javascript:window.location.href='${ctx}/meeting/queryxx.do';" class="button" value=" 返 回 "></td>
		</tr>
	</table>
	</fieldset>
</s:form>

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
		
		$.validator.addMethod("Wdate", function(value, element) {
			var res = "";
			if (value == null || value.length == 0) {
				res = "err";
				$("#dateDescn").html("<font color='red'>日期不允许为空</font>");
			}else {
				$("#dateDescn").html("");
				var d = new Date();   // 获得当前日期
				var vYear = d.getFullYear();
				var vMon = d.getMonth() + 1;
				var vDay = d.getDate();
				var dd = vYear+"-"+vMon+"-"+vDay;
				
				var stdt=new Date(value.replace("-","/"));
				var etdt=new Date(dd.replace("-","/"));
				if(stdt > etdt){
					res = "err";
					$("#dateDescn").html("<font color='red'>日期不允许大于当前日期</font>");
				}else{
					$("#dateDescn").html("");			
				}
			}
			return res != "err";
		}, "");
	});
	
	function jkjsSave() {
		$('#save').attr("action", "${ctx}/meeting/save.do");
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
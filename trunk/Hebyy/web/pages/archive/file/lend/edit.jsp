<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>案卷借阅记录</title>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/showUser.js"></script>
<script type="text/javascript">
/**
 * 选择案卷
 */
function showArchives() {
	url = "/pages/zjimis/archives/selector.jsp";
	if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
		var archives = window.showModalDialog(
				URL_PREFIX + url, null,
				"dialogWidth=800px;resizable: Yes;");
		if (archives != null) {
			var tab = $('#archivesName');
			tab.val(archives.name);
			var tab1 = $('#archivesId');			
			tab1.val(archives.id);
		}
	} else {
		window.open(URL_PREFIX + url,
					"",
					"width=800px,height=520,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
		this.returnAction = function(project) {
			if (archives != null) {
				var tab = $('#archivesName');
				tab.val(project.name);
				var tab1 = $('#archivesId');			
				tab1.val(archives.id);
			}
			return;
		};
	}
}
</script>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header">案卷借阅记录</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
<s:form action="save.do" id="save" method="post">
	<s:hidden name="model.id" id="id"/>
	<fieldset style="width: 75%; padding:10px 10px 10px 10px;">
	<legend>案卷借阅记录</legend>
	<table width="100%" align="left">
		<tr>
			<td align="right" width="100" >案卷名称：</td>
			<td class="simple">
				<s:textfield id="archiveName" name="model.archive.name" style="width:197px;background-image: url(${ctx}/images/grid/accessories-magnifier.png); background-repeat: no-repeat; background-position: 176px 3px; " cssClass="required" onclick="showArchives()" readonly="true"/><s:hidden id="archivesId" name="model.archives.id"/>
				<span id="archivesNameDescn"></span>
				<font color="red">*</font> 
			</td>
		</tr>
		<tr>
			<td align="right">审&nbsp;批&nbsp;人：</td>
			<td align="left">
				<input type="hidden" name="auditor" id="auditor" value="${model.flow.nodes[0].auditor.id}">
				<input type="text" id="auditorName" name="auditorName" value="${model.flow.nodes[0].auditor.name}" onclick="showAuditUser(this)" class="required" readonly="readonly" 
				  	style="width:197px;background-image: url(${ctx}/images/grid/accessories-magnifier.png); background-repeat: no-repeat; background-position: 175px 3px; " />
				<span id="auditorDescn"></span>
				<font color="red">*</font>
				<br>
				<font color="red">该项不允许为空，必须选择第一审核人</font>
			</td>
		</tr>
        <tr>
           <td align="right">
           	备&nbsp;&nbsp;&nbsp;&nbsp;注：
           </td>
           <td align="left" colspan="3">
           		<s:textarea id="" name="model.remark" cols="55" rows="4" cssStyle="margin:3px 0px; width: 635px; height: 150px; overflow: auto; border: 1px solid #C3c3c3;"></s:textarea>
			</td>
        </tr>		
	</table>
	</fieldset>
	<table width="600px" style="margin-bottom: 10px;">
		<tr>
			<td style="text-align: center;">
			  <s:submit value="保存" cssClass="button" /> 
			  &nbsp;&nbsp;
			  <s:reset value="重置" cssClass="button" />
			  &nbsp;&nbsp;
			  <input type="button" value="返回" onclick="history.go(-1)" class="button"/> 
			</td>
		</tr>
	</table>
</s:form>
</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	$(function() {
		$.validator.addMethod("Wdate", function(value, element) {
			var res;
			if (value == null || value.length == 0) {
				res = "err";
				$("#createTimeDescn").html("<font color='red'>案卷借阅记录签订日期不允许为空</font>");
			}else {
				$("#createTimeDescn").html("");
			}
			return res != "err";
		}, "");
	});
</script>
</body>
</html>
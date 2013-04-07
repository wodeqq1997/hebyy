<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>文件信息</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>

</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header">文件信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<s:form action="save.do" id="save" method="post">
	<s:hidden name="model.id" id="customerId"/>
	<s:hidden name="model.payment.id" id="paymentId"/>
	<s:hidden name="model.income.id" id="incomeId"/>
	<table width="700" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<th colspan="4">文件信息</th>
		</tr>
		<tr>
			<td width="100" align="center">文&nbsp;&nbsp;件&nbsp;&nbsp;号：</td>
			<td width="250">
				<s:textfield name="model.fileNO" id="fileNO" maxlength="255" cssStyle="width:200px;" cssClass="required"/>
				<font color="red">*</font>
			</td>
			<td width="100" align="center">文件名称：</td>
			<td width="250">
				<s:textfield name="model.name" id="name" maxlength="255" cssStyle="width:200px;" cssClass="required" />
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td width="100" align="center">所属案卷：</td>
			<td width="250">
				<s:hidden id="archiveId" name="model.archive.id"/>
				<s:textfield id="archiveName" name="model.archive.name" cssStyle="width:200px;" cssClass="required" onclick="showArchive()" readonly="true"/>
				<font color="red">*</font>
            </td>
			<td width="100" align="center">发文单位：</td>
			<td width="250">
				<s:textfield name="model.sendUnit" id="sendUnit" maxlength="255" cssStyle="width:200px;"/>
			</td>
		</tr>
		<tr>
			<td width="100" align="center">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;级：</td>
			<td width="250">
				<s:select list="#{'保密':'保密','绝密':'绝密'}" id="dense" name="model.dense" headerKey="" headerValue=""/>
			</td>
			<td width="100" align="center">发文日期：</td>
			<td width="250">
				<s:if test="model.sendDate != null">
					<input id="sendDate" name="model.sendDate"  style="height:25px;width:200px;" value='<fmt:formatDate value="${model.sendDate}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</s:if>
				<s:else>
					<input id="sendDate" name="model.sendDate"  style="height:25px;width:200px;" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</s:else>
			</td>
		</tr>
		<tr>
			<td width="100" align="center">文件页数：</td>
			<td width="250">
				<s:textfield id="filePage" name="model.filePage" cssClass="digits" style="width:200px;"/>
			</td>
			<td width="100" align="center">打印页数：</td>
			<td width="250">
				<s:textfield name="model.printPage" id="printPage" cssClass="digits" cssStyle="width:200px;"/>
			</td>
		</tr>
		<tr>
			<td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
			<td colspan="3"> 
				<s:textfield name="model.remark" id="remark" cssStyle="width:570px;"/>
			</td>
		</tr>
		<tr>
			<td align="center">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
			<td colspan="3"> 
				<table style="border: 0px;">
				  <tr style="border: 0px;">
				    <td style="border: 0px;"><input type="file" id="systop_upload" />&nbsp;</td>
				    <td style="border: 0px;"><span style="color: #EB2A03">附件大小在30M以内!</span></td>
				  </tr>
				</table>
				<div id="custom">
					<div id="systop-file-queue"></div>
				</div>
				<div id="systop-uploaded-files" style="width: 635px; border-bottom: 1px solid #C3C3C3;">
					<s:hidden id="fileAttchIds" name="model.attachIds"/>
				</div>
				<div id="systop_file_list"></div>
			</td>
		</tr>
	</table>


	<table width="700px" style="margin-bottom: 10px;margin-top: 20px;" align="center">
		<tr>
			<td style="text-align: center;">
			  <s:submit value="保存" cssClass="button" /> 
			  &nbsp;&nbsp;
			  <s:reset value="重置" cssClass="button" />
			</td>
		</tr>
	</table>
</s:form>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#save").validate();
    //没有付款,就清除input,否则会出错.
    $("#save").submit(function(){
        if($("#paymentId").val()==""){
            $("#paymentId").removeAttr("name");
        }
        if($("#incomeId").val()==""){
            $("#incomeId").removeAttr("name");
        }
    })
});
//渲染上传组件
renderUploader(true, fileType, fileDesc, 30240000);
</script>
<s:if test="model.id != null">
	<script type="text/javascript">
	viewFileAttchList('${model.attachIds}', true);
	</script>
</s:if>
</body>
</html>
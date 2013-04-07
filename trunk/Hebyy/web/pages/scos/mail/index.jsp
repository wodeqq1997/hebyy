<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件信息列表</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<style type="text/css">
.22 {
	height: 22px;
}
</style>
</head>
<body>
<div class="x-panel-header">
<div style="float: left;"><s:if
	test="#attr.mailIndexType == 'send'">
	  	&nbsp;<font color="blue">已经发送的文件</font>
</s:if> <s:elseif test="#attr.mailIndexType == 'receive'">
	  	&nbsp;<font color="green">已经接收的文件</font>
</s:elseif></div>
<div style="float: right; font-weight: normal;"><a
	href="newMail.do"> <img src="${ctx}/images/icons/mail.gif">&nbsp;发送文件
</a> <a href="#" onclick="remove()"> <img
	src="${ctx}/images/icons/delete.gif">&nbsp;删除 </a><s:if test="#attr.mailIndexType == 'receive'"> <a
	href="javascript:;" onclick="readAllMailBoxs()"> <img
	src="${ctx}/images/icons/modify.gif">&nbsp;全部已读 </a></s:if></div>
</div>
<div class="x-toolbar" style="height: 25px; padding: 3px 5px;">
<form id="pageQueryForm" action="index.do" method="post">
<table width="99%">
	<tr>
		<td>&nbsp;主题：<s:textfield name="model.subject" cssClass="22" />&nbsp;
		&nbsp;从：<input type="text" name="startDate" readonly="readonly"
			style="width: 100px"
			value='<s:date name="startDate" format="yyyy-MM-dd"/>'
			onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
			class="Wdate 22" /> &nbsp;至：<input type="text" name="endDate"
			readonly="readonly" style="width: 100px"
			value='<s:date name="endDate" format="yyyy-MM-dd"/>'
			onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
			class="Wdate 22" /> <s:if test="#attr.mailIndexType == 'receive'">
			<input type="hidden" name="mailIndexType" value="receive">
		</s:if> <input type="submit" value="查询" class="button"><s:hidden
			name="ec_p" id="ec_p" /></td>
	</tr>
</table>
</form>
</div>
<div class="x-panel-body">
<form id="ec">
<table id="fineTable" width="800" style="margin-left: 0px;margin-top: 0px">
	<tr>
		<th>选择</th>
		<th>状态</th>
		<s:if test="#attr.mailIndexType == 'send'">
			<th>发送人</th>
		</s:if>
		<s:elseif test="#attr.mailIndexType == 'receive'">
			<th>接收人</th>
		</s:elseif>
		<th>主题</th>
		<th>附件</th>
		<th>发送时间</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td width="40px" align="center"><input type="checkbox" name="selectedItems"
				id="selectedItems" value="${item.id}" class="checkbox" /></td>
			<td width="60px"align="center"><s:if test="#attr.item.isRead == 0">
				<font color="red">未读</font>
			</s:if>
			<s:else><font color="green">已读</font></s:else></td>
			<td align="center"><s:if test="#attr.mailIndexType == 'send'">
                   ${item.mail.recipientNames}
                    </s:if> <s:elseif test="#attr.mailIndexType == 'receive'">
                     ${item.mail.senderName}
                     </s:elseif></td>
			<td width="360px"><a href="view.do?mailId=${item.id}"><font color="bule"><span
				style="font-weight: ${item.isRead ne 0 ? 'normal':'bold'}">${empty
			item.mail.subject ? "无标题":item.mail.subject}</span> </font> </a></td>
			<td align="center"><s:if test="#attr.item.fileIds != null">
				<img src="${ctx}/images/icons/attachment.gif" title="有附件信息">
			</s:if></td>
			<td align="center"><fmt:formatDate value="${item.sendTime}"
				pattern="yyyy-MM-dd" /></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</form>
</div>
<script type="text/javascript">
	// 设置全部已读
	function readAllMailBoxs() {
		$('#pageQueryForm').attr('action', 'readAllMailBoxs.do');
		$('#pageQueryForm').submit();
	}

	function remove() {
		var sels = document.getElementsByName("selectedItems");
		var checked = false;
		;
		for ( var i = 0; i < sels.length; i++) {
			if (sels[i].checked) {
				checked = true;
				break;
			}
		}
		if (!checked) {
			alert("请选择要删除的邮件!");
			return;
		}
		if (confirm("确定要删除所选择的文件吗？删除后不能恢复!")) {
			var from = document.getElementById("ec");
			from.action = "removeMailBox.do";
			from.submit();
		}
	}

	function view(id) {
		window.location.href = "view.do?mailId=" + id;
	}
</script>
</body>
</html>
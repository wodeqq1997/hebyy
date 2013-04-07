<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>已收信息列表</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<style>
.select-all {
	height: auto !important;
}
</style>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="color: green; float: left;">已经接收的短消息</div>
<div style="float: right; font-weight: normal;"><a
	href="newMsg.do"><img src="${ctx}/images/icons/add.gif">&nbsp;新建消息</a>
<a href="#" onclick="readAllMsgs()"><img
	src="${ctx}/images/icons/modify.gif">&nbsp;全部标记为已读</a> <a href="#"
	onclick="onRemove()"> <img src="${ctx}/images/icons/delete.gif">&nbsp;删除
</a></div>
</div>
<div class="x-toolbar">
<form id="pageQueryForm" action="receiveIndex.do" method="post">
<s:hidden name="model.msgType" />
<table width="99%">
	<tr>
		<td>&nbsp;发送人：<s:textfield name="model.sender.name" /> &nbsp;从：<input
			type="text" name="startDate" readonly="readonly"
			value='<s:date name="startDate" format="yyyy-MM-dd"/>'
			onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
			class="Wdate" /> &nbsp;至：<input type="text" name="endDate"
			readonly="readonly"
			value='<s:date name="endDate" format="yyyy-MM-dd"/>'
			onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
			class="Wdate" /> &nbsp; <input type="submit" value="查询"
			class="button"><s:hidden name="ec_p" id="ec_p" /></td>
	</tr>
</table>
</form>
</div>
<div class="x-panel-body">
<form id="ec">
<table id="fineTable" width="800"
	style="margin-left: 0px; margin-top: 0px">
	<tr>
		<th>选择</th>
		<th>发送人</th>
		<th>标题</th>
		<th>发送时间</th>
		<th>状态</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td width="40px"align="center"><input type="checkbox" name="selectedItems"
				id="selectedItems" value="${item.id}" class="checkbox" /></td>
			<td width="60px"align="center"><s:if test="#attr.item.sender != null">
	${item.sender.name}
</s:if> <s:elseif
				test="#attr.item.msgType == @com.systop.scos.communicate.smsg.MsgConstants@IS_SYS">
	系统消息
</s:elseif></td>
			<td ><a href="javascript:view(${item.id });"><font color="blue">${item.title}</font></a></td>
			<td width="80px"align="center"><fmt:formatDate value="${item.createTime}"
				pattern="yyyy-MM-dd" /></td>
			<td width="80px" align="center"><s:if test="#attr.item.isRead == 1">
				<div style="color: #339933; font-weight: bold;">已读</div>
			</s:if> <s:else>
				<div style="color: red; font-weight: bold;">未读</div>
			</s:else></td>
			<td align="center" width="80px"><a
				href="edit.do?model.id=${item.id}" title=""> 修改</a>&nbsp;|&nbsp; <a
				href="#" onclick="remove('${item.id}')" title="">删除 </a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</form>
</div>
</div>
<script type="text/javascript">
	function remove(id) {
		if (confirm('确认要删除这条信息吗？删除后不能恢复！')) {
			window.location.href = "${ctx}/msg/receiveDel.do?model.id=" + id;
		}
	}
	function readAllMsgs() {
		$('#pageQueryForm').attr("action", "${ctx}/msg/readAllMsgs.do");
		$('#pageQueryForm').submit();
	}
	function onRemove() {
		var sels = document.getElementsByName("selectedItems");
		var checked = false;
		for ( var i = 0; i < sels.length; i++) {
			if (sels[i].checked) {
				checked = true;
				break;
			}
		}
		if (!checked) {
			alert("请选择要删除的消息!");
			return;
		}
		if (confirm("确定要删除所选择的消息吗？删除后不能恢复!")) {
			var from = document.getElementById("ec");
			from.action = "receiveRemove.do";
			from.submit();
		}
	}
	function view(id) {
		var url = "${ctx}/msg/view.do?model.id="
				+ id
				+ "&updateState=Y"
				+ "&currtime="
				+
<%=com.systop.core.util.DateUtil.getDateTime(
					"yyyyMMddHHmmss", new java.util.Date())%>
	;
		location.href = url;

		//var conf = "dialogWidth=608px;dialogHeight=438px;status=no;help=no;scrollbars=no";
		//window.showModalDialog(url, null, conf);
		//ECSideUtil.reload('ec');
	}

	//issue 864
	$(function() {
		$("#ec_table_head .headerTitle:first").after(
				"<input type='checkbox' class='select-all'/>")
		$(".select-all").live(
				"change",
				function() {
					$(".selected-items").attr("checked",
							$(this).attr("checked") == "checked");
				})
	})
</script>
</body>
</html>
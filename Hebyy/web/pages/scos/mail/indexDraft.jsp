<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>草稿文件</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
</head>
<body>
<div class="x-panel-header">草稿</div>
<div class="x-toolbar" style="height: 25px; padding: 3px 5px;">
<form action="indexDraft.do" method="post" id="pageQueryForm"><s:hidden
	name="ec_p" id="ec_p" />
<table width="99%">
	<tr>
		<td><span> <img src="${ctx}/images/icons/folder_edit.gif">
		&nbsp;<font color="#909090"><b>草稿文件</b></font> </span></td>
		<td align="right"><a href="newMail.do"> <img
			src="${ctx}/images/icons/mail.gif">&nbsp;发送文件 </a></td>
	</tr>
</table>
</form>
</div>
<div class="x-panel-body">
<table id="fineTable" width="800" style="margin-left: 0px;margin-top: 0px">
	<tr>
		<th>序号</th>
		<th>接收人</th>
		<th>主题</th>
		<th>附件</th>
		<th>创建时间</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td width="40px" align="center">${(page.pageNo-1)*20 + st.index+1}</td>
			<td width="300px"> ${item.recipientNames}</td>
			<td width="340px"><a href="view.do?mailId=${item.id}"><font color="blue">${empty
			item.subject ? "无标题":item.subject}</font>  </a></td>
			<td width="40px"align="center" valign="middle"><s:if test="#attr.item.fileIds != null">
				<img src="${ctx}/images/icons/attachment.gif" title="有附件信息">
			</s:if></td>
			<td width="80px" align="center"><fmt:formatDate value="${item.sendTime}"
				pattern="yyyy-MM-dd" /></td>

			<td width="80px"><a href="javascript:edit('${item.id}');" title="">编辑</a> &nbsp;|&nbsp; <a
				href="javascript:remove('${item.id}');" title="">删除</a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>

</div>
<script type="text/javascript">
	function edit(id) {
		window.location.href = "edit.do?model.id=" + id;
	}

	function remove(id) {
		if (confirm("确定要删除该草稿邮件吗？删除后不能恢复!")) {
			window.location.href = "remove.do?model.id=" + id;
		}
	}
</script>
</body>
</html>
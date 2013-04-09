<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<html>
<head>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>日志管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该日志？")) {
			window.location.href = URL_PREFIX + "/diary/remove.do?model.id="
					+ id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">${empty items ?
'下属':items[0].user.name}的日志</div>
</div>
<div class="x-toolbar">
<table width="100%" style="margin: 4px 0px;" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="70%">
		<s:form action="indexByUser.do" method="post"id="pageQueryForm">
                        &nbsp;&nbsp;标题：<s:textfield id="title"
				name="model.title" maxlength="40" />&nbsp;&nbsp;
                        创建时间：<input id="queryDate" name="queryDate"
				value="<s:date name='queryDate' format='yyyy-MM-dd'/>"
				onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" />&nbsp;&nbsp;
                        <input type="hidden"
				value="${empty items ?'':items[0].user.id}" name="model.user.id" />
			<input type="submit" value="查询" class="button" />
			<s:hidden name="ec_p" id="ec_p" />
		</s:form></td>
		<td width="30%" align="right"></td>
	</tr>
</table>
</div>
<div class="x-panel-body">

<table id="fineTable" width="800"
	style="margin-left: 0px; margin-top: 0px">
	<tr>
		<th>序号</th>
		<th>标题</th>
		<th>创建日期</th>
		<th>最后修改时间</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${(page.pageNo-1)*20 + st.index+1 }</td>
			<td align="center"><a
				href="view.do?model.id=${item.id}" title="${item.title}"
				target="_blank"><font color="bule">${item.title}</font></a></td>
			<td width="" align="center"><fmt:formatDate
				value="${item.createTime}" pattern="yyyy-MM-dd" /></td>
			<td width="" align="center"><fmt:formatDate
				value="${item.updateTime}" pattern="yyyy-MM-dd" /></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>
</body>
</html>
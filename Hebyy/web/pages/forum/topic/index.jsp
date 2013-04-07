<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	function remove(id) {
		if(confirm("删除主题，会同时删除相关的回复记录，确定要删除吗？")) {
			window.location.href = URL_PREFIX+"/forum/topic/remove.do?model.id=" + id;
		}
	}
</script>
<title>发帖管理</title>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	&nbsp;发帖管理&nbsp;.${model.board.name}
</div>
<div class="x-toolbar">
	<s:form action="index.do"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	<table width="100%">
	 <tr>
			<td>
				&nbsp;标题：<s:textfield id="title" name="model.title" />
				&nbsp;开始日期：<input id="startDate" name="startDate"  value='${startDate}' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" /> 
				&nbsp;截止日期：<input id="endDate" name="endDate"  value='${endDate}' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
				&nbsp;<s:hidden name="boardId"/>
				<input type="submit" value="查询" class="button" /></td>
		</tr>
	</table>
	</s:form>
</div>
<div class="x-panel-body">
<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>标题</th>
        <th>发帖者</th>
        <th>创建时间</th>
        <th>模块</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
			<td><a href="${ctx}/forum/topic/view.do?model.id=${item.id}" target="_blank">${item.title }</a></td>
			<td>${item.sender.name }</td>
			<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
			
			<td>${item.board.name }</td>
			<td>
				<a href="edit.do?model.id=${item.id}" title="修改"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;&nbsp;
			<a href="#" onclick="remove('${item.id}')" title="删除">	<img src="${ctx}/images/icons/remove.gif"></a>
			</td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;"
			align="right"><%@include file="/pages/common/page.jsp"%>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
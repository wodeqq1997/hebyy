<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>论坛板块.${model.board.name}</title>
    <link href="${ctx}/styles/fix.css" type='text/css' rel='stylesheet'>

<script type="text/javascript">
function changeBgColoe(obj, className){
	obj.className = className;
}
</script>
<style type="text/css">
.board {
	border-bottom: 1px solid #99BBE8;
	background-color: #d0def0;
	height: 35px;
	text-align: right;
	padding: 5px 20px 0px 0px;
}
.table{
	font-size: 14px;
	line-height: 30px; 
	font-weight: bold;
}
.left{
	padding-left: 10px;
}
.right{
	text-align:right;
	padding-right: 10px;
}
</style>
</head>
<body style="background-color: #DFE8F6;">
<div style="width: 980px;margin: 0 auto;">
<s:form action="index.do"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	</s:form>
<div style="margin: 20px 0;font-weight: bold; font-size: 14px;">
	<a href="${ctx}/forum/board/index.do" style="color: red; " title="论坛首页">河北演艺集团员工讨论区</a>&nbsp;&gt;&gt;
	<a href="${ctx}/forum/topic/topicIndex.do?boardId=${model.board.id}" style="color: red; ">${model.board.name }</a>
</div>
<div class="viewPanel" style="margin: 10px 0">
	<div class="board">
		<a href="${ctx}/forum/topic/edit.do?boardId=${model.board.id}"><img src="${ctx}/images/icons/add.gif"> 发新帖</a>
	</div>
	
	
	<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>创建时间</th>
        <th>话题</th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
			<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
			
			<td><a href="view.do?model.id=${item.id}" title="${item.title}">
		    		<img src="${ctx}/images/icons/postnote.gif" />&nbsp;${item.title}</a></td>
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
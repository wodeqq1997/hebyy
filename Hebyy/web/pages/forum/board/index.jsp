<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>论坛版块管理</title>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该版块吗?版块下的所有话题会被一同删除!")) {
			window.location.href = "remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<s:form action="index.do" method="post"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	  </s:form>
	<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
		<div style="float: left;">&nbsp;论坛版块管理</div>
		<div style="float: right;">
			<a href="${ctx}/forum/board/edit.do"><img src="${ctx}/images/icons/add.gif">&nbsp;添加版块</a>
			&nbsp;&nbsp;
		</div>
	</div>
	<div class="x-panel-body">
		<div><%@ include file="/common/messages.jsp"%></div>
		
		
		<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>模块名称</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
			<td><a href="${ctx}/forum/topic/index.do?boardId=${item.id}">${item.name}</a></td>
			<td>
				<a href="edit.do?model.id=${item.id}" title="修改">
				 	 <img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除">
				 	 <img src="${ctx}/images/icons/remove.gif"></a>
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
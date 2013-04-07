<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>文章类型管理</title>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除该文章类型？")) {
			window.location.href = URL_PREFIX + "/article/type/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">&nbsp;新闻类型管理</div>
	<div class="x-toolbar">
	<table width="100%">
		<tr>
			<td>
			<s:form action="index.do"  id="pageQueryForm">
		 		&nbsp;类型名称：
		 		<s:textfield id="name" name="model.name" ></s:textfield>
				<input type="submit" value="查询" class="button" /><s:hidden name="ec_p" id="ec_p"/>
			</s:form>
			</td>
			<td align="right" style="padding-right: 20px;">
				<img src="${ctx}/images/icons/add.gif">
				<a href="${ctx}/article/type/edit.do">添加类型</a>
				&nbsp;&nbsp;
				<img src="${ctx}/images/icons/rem-all.gif">
				<a href="${ctx}/article/index.do">新闻管理</a>
			</td>
		</tr>
	</table>
	</div>
	<div>
		<%@ include file="/common/messages.jsp"%>
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
         <th>名称</th>
		<th>描述</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
            <td align="center"><a href="view.do?model.id=${item.id}" title="${item.name}" target="_blank">${item.name}</a></td>
			<td align="center">${item.descn}</td>
			<td>
				<a href="edit.do?model.id=${item.id}" title="修改类型">
						<img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除类型">
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
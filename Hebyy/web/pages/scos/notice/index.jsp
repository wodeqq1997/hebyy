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
	if(confirm("确认要删除该通知公告？")) {
		window.location.href = URL_PREFIX+"/notice/remove.do?model.id=" + id;
	}
}
</script>
<title>通知公告</title>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">通知公告</div>
	<div style="float: right"></div>
</div>
<div class="x-toolbar">
	<table width="99%">
	   <tr>
	     <td width="75%">
			<s:form action="index.do" id="pageQueryForm">
			  &nbsp;&nbsp;标题：<s:textfield id="title" name="model.title" />&nbsp;
			  &nbsp;&nbsp;开始日期：<input id="startDate" name="startDate"  value='<s:date name="startDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
			  &nbsp;&nbsp;截至日期：<input id="endDate" name="endDate"  value='<s:date name="endDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
			  &nbsp;&nbsp;<input type="submit" value="查询" class="button" /><s:hidden name="ec_p" id="ec_p"/>
			</s:form>
		  </td>
		  <td width="24%" align="right">
		  		<a href="${ctx}/notice/edit.do"><img src="${ctx}/images/icons/add.gif">&nbsp;添加通知公告</a>
		  	&nbsp;
		  </td>
		</tr>
	</table>
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
		<th>发布人</th>
		<th>发布时间 </th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
                  <td align="center"><a href="view.do?model.id=${item.id}" title="${item.title}" target="_blank">${item.title}</a></td>
			<td align="center">${item.creator.name}</td>
			<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
			<td>
			<a href="edit.do?model.id=${item.id}" title="修改"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
				<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a>
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
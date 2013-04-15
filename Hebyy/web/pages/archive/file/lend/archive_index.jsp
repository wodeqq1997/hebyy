<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>案卷借阅管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">案卷借阅</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
	<s:form action="archiveIndex.do"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
	<table width="100%">
	  <tr>
			<td>
				案卷名称：<s:textfield id="name" name="model.name" />
		   		案卷类型：<s:select list="archiveTypeMap" name="model.archiveType.id" headerKey="" id="archiveTypeId" headerValue="全部" cssStyle="width:110px;" />
		   		<input type="submit" value="查询" class="button" />
			</td>
			<td align="right">
				<a href="${ctx}/archive/archiveIndex.do"><img src="${ctx}/images/icons/rem-all.gif">案卷查阅管理</a>
				&nbsp;
			</td>
		</tr>
	</table>
	</s:form>
</div>
<div class="x-panel-body">
<table id="fineTable" width="800" align="left">
	<tr>
		<th>序号</th>
        <th>编号</th>
		<th>名称</th>
		<th>案卷类别</th>
		<th>存放位置</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="50">${(page.pageNo - 1) * 20 + st.index + 1}</td>
            <td><a href="javascript:" onclick="openArchive('${item.id}')" title="查看案卷信息"><font color="blue">${item.archiveNO}</font></a></td>
			 <td>${item.name}</td>
			<td>${item.archiveType.name}</td>
			<td>${item.archiveCabinet.name }</td>
			<td align="center" width="100">
			<c:if test="${!empty item.archiveFiles}">
				<a href="${ctx}/archive/file/fileIndex.do?model.archive.id=${item.id}">查看可借阅文件</a>
				</c:if>
				<c:if test="${empty item.archiveFiles}">
				无可借阅文件
			 </c:if>
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
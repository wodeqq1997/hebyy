<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>案卷管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/project/selector.js"></script>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该案卷(同时删除案卷内的文件)？")) {
			window.location.href = URL_PREFIX+"/archive/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">案卷管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
	<s:form action="index.do"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
	<table width="100%">
	  <tr>
			<td>
				案卷名称：<s:textfield id="name" name="model.name" />
		   		案卷类型：<s:select list="archiveTypeMap" name="model.archiveType.id" headerKey="" id="archiveTypeId" headerValue="全部" cssStyle="width:110px;" />
		   		<input type="submit" value="查询" class="button" />
			</td>
			<td width="20%" align="right">
				<a href="${ctx}/archive/edit.do?model.archiveType.id=${model.archiveType.id}">
				<img src="${ctx}/images/icons/add.gif">&nbsp;添加案卷</a>
				<a href="${ctx}/archive/type/index.do">
				<img src="${ctx}/images/icons/folder.gif" class="icon"/>&nbsp;案卷类别管理</a>
				<a href="${ctx}/archive/cabinet/index.do">
				<img src="${ctx}/images/icons/folder.gif" class="icon"/>&nbsp;档案柜管理</a>
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
		<th>归档</th>
		<th>案卷类别</th>
		<th>存放位置</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="50">${(page.pageNo - 1) * 20 + st.index + 1}</td>
            <td align="left"><a href="javascript:" onclick="openArchive('${item.id}')" title="查看案卷信息"><font color="blue">${item.archiveNO}</font></a></td>
			 <td>${item.name}</td>
			<td align="center"> <c:catch>
                ${item.submit?"<span style='color:red'>是</span>":"否"}
            </c:catch></td>
			<td>${item.archiveType.name }</td>
			<td>${item.archiveCabinet.name }</td>
			<td align="center" width="125"><a href="allView.do?model.id=${item.id}" title="查看详情（包括文件）" target="_blank">查看</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="edit.do?model.id=${item.id}" title="修改案卷信息">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="#" onclick="remove('${item.id}')" title="删除案卷信息">删除</a>
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
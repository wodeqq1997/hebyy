<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<title>文件管理</title>
<script type="text/javascript">
function remove(id){
	if (confirm("确认要删除该文件吗?")){
		window.location.href=URL_PREFIX+"/archive/file/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >
	<div style="float: left;">文件管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
        <s:form action="index" theme="simple"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
			<table width="99%">
				<tr>
					<td width="70%">
						文件名称：<s:textfield id="name" name="model.name" style="" />
						案卷名称：<s:textfield id="archiveName" name="model.archive.name" cssStyle="width:140px;"/>
						&nbsp;
						<input type="submit" value="查询" class="button" />
					</td>
					<td width="30%" align="right" >
						<img src="${ctx}/images/icons/add.gif"><a href="${ctx}/archive/file/edit.do">添加文件</a>
					</td>
				</tr>
			</table>
		</s:form>
</div>  
<div class="x-panel-body">
<table id="fineTable" width="800" align="left">
	<tr>
		<th>序号</th>
        <th>文件号</th>
		<th>文件名称</th>
		<th>所属案卷</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="50">${(page.pageNo - 1) * 20 + st.index + 1}</td>
            <td><a href="javascript:" onclick="openArchiveFile('${item.id}','viewFile')" title="查看文件信息"><font color="blue">${item.fileNO}</font></a></td>
			 <td>${item.name}</td>
			<td><a href="javascript:" onclick="openArchive('${item.archive.id}')" title="查看案卷信息"><font color="blue">${item.archive.name}</font></a></td>
			<td width="125" align="center">
			<a  href="javascript:" onclick="openArchiveFile('${item.id}','viewFile')" title="查看文件信息">查看</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="edit.do?model.id=${item.id}">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="#" onclick="remove('${item.id}')" title="删除">删除</a>
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
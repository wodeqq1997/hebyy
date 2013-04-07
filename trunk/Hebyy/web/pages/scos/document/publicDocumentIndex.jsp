<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>文档管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除？")) {
			window.location.href = URL_PREFIX + "/document/remove.do?model.id="
					+ id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-toolbar" style="padding: 3px 0px;">
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td width="70%"><s:form action="publicDocumentIndex.do"
			method="post" id="pageQueryForm">
			<s:hidden id="ec_p" name="ec_p"/>
			<s:hidden name="model.docType.id" />
	        &nbsp;标题：<s:textfield id="title" name="model.title"
				maxlength="40" cssStyle="width: 150px;" />
	        &nbsp;关键字：<s:textfield id="keyWord" name="model.keyWord"
				maxlength="20" />
	        &nbsp;<input type="submit" value="查询" class="button" />
			<s:hidden name="model.msgType" />
		</s:form></td>
		<td width="10%" align="right" style="padding-right: 4px;"><img
			src="${ctx}/images/icons/add.gif"> <a
			href="${ctx}/document/edit.do?model.isPublic=1">公共文档</a></td>
	</tr>
</table>
</div>
<div class="x-panel-body">
<table id="fineTable" width="100%"
	style="margin-left: 0px; margin-top: 0px;border-top: 0px">
	<tr>
		<th>序号</th>
		<th>标题</th>
		<th>上传者</th>
		<th>关键字</th>
		<th>类别</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${(page.pageNo-1)*20 + st.index+1}</td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				title="${item.title}" target="_blank"><font color="bule">${item.title}</font></a></td>
			<td>${item.owner.name }</td>
			<td align="center">${item.keyWord}</td>
			<td align="center">${item.docType.name}</td>
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
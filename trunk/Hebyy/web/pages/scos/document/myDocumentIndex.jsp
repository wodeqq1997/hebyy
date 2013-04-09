<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>文档管理</title>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="x-panel">
<div class="x-toolbar" style="padding: 3px 0px;">
<table width="90%" cellpadding="0" cellspacing="0">
	<tr>
		<td width="70%"><s:form action="myDocumentIndex.do" method="post"
			id="pageQueryForm">
			<s:hidden id="ec_p" name="ec_p"/>
			<s:hidden name="model.docType.id" />
	        &nbsp;标题：<s:textfield id="title" name="model.title"
				cssStyle="width: 150px;" />
	        &nbsp;关键字：<s:textfield id="keyWord" name="model.keyWord"
				maxlength="20" />
	        &nbsp;<input type="submit" value="查询" class="button" />
			<s:hidden name="model.msgType" />
		</s:form></td>
		<td width="30%" align="right"><img
			src="${ctx}/images/icons/add.gif"> <a
			href="${ctx}/document/edit.do">个人文档</a>&nbsp;&nbsp;</td>
	</tr>
</table>
</div>
<div class="x-panel-body">

<table id="fineTable" width="100%" style="margin-left: 0px;margin-top: 0px">
	<tr>
		<th>序号</th>
		<th>标题</th>
		<th>关键字</th>
		<th>类别</th>
		<th>上传日期</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td width="8%">${(page.pageNo-1)*20 + st.index+1}</td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				title="${item.title}" target="_blank"><font color="blue">${item.title}</font></a></td>
			<td>${item.keyWord}</td>
			<td>${item.docType.name}</td>
			<td><fmt:formatDate value="${item.createTime}"
				pattern="yyyy-MM-dd" /></td>
			<td><a href="edit.do?model.id=${item.id}" title="">修改&nbsp;|</a>&nbsp; <a href="remove.do?model.id=${item.id}"
				title=""> 删除&nbsp;|</a>  
				<a href="toShare.do?model.id=${item.id}" title="">&nbsp;分享</a>
			<s:if
				test='#attr.item.status != null'>
				|<a href="desShare.do?model.id=${item.id}" title="">&nbsp;取消分享</a>
			</s:if></td>
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
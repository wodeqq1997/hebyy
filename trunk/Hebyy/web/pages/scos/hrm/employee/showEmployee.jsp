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
<title>员工信息详情</title>
<script type="text/javascript">
function importSupplier(){
	window.location.href = "${ctx}/employee/importIndex.do";
}

</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">员工信息详情</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
<s:form action="showUsers" theme="simple" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table width="100%">
		<tr>
			<td width="95%">&nbsp;姓 名:&nbsp;
			<s:textfield id="userName" name="model.name" />&nbsp;&nbsp;
			&nbsp;部 门:&nbsp;
			<s:textfield id="dept" name="model.dept.name" />&nbsp;&nbsp; &nbsp;
			<s:submit value="查询" cssClass="button" />
			<input type="button" value="重  置" class="button" onclick="location.replace(location.href);"/>
</td>
			<td style="text-align: right; padding-right: 1em;" width="5%">
			<a href="${ctx}/employee/editNew.do?from=hr">
			<img src="${ctx}/images/icons/add.gif">新建员工信息</a></td>
			<td><input type="button" class="button" onclick="importSupplier()"
									value="导入员工信息" /></td>
		</tr>
	</table>
</s:form>

</div>
<div class="x-panel-body">
<table width="100%" align="left" id="fineTable">
<tr>
<th>序号</th>
<th>员工姓名</th>
<th>性别</th>
<th>部门</th>
<th>操作</th>
</tr>
<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="40">${(page.pageNo - 1) * 20 + st.index + 1}</td>
			<td width="100" style="text-align:center;ellipsis:true">${item.name}</td>
      		<td width="40" style="text-align:center">
            <c:if test="${item.sex eq 'M'}">男</c:if>
            <c:if test="${item.sex eq 'F'}">女</c:if>
            </td>
			<td width="100" style="ellipsis:true">${item.dept.name}</td>
            <td width="80"><a href="${ctx}/employee/edit.do?model.id=${item.id}">编辑</a>|
            <a href="${ctx}/employee/view.do?model.id=${item.id}" title="查看">查看</a> 
            </td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="4" style="border: 0px; padding-top: 10px;"
			align="right"><%@include file="/pages/common/page.jsp"%>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
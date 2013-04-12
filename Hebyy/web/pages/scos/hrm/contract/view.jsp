<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/pages/common/taglibs.jsp"%>
<html>
<head>
<title>员工合同信息</title>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.title {
	border-bottom: 1px solid #99BBE8;
	font-size: 13px;
	font-weight: bold;
	color: #15428b;
}
</style>
<script type="text/javascript">
function remove(id){
	if (confirm("确认要删除合同信息?")){
		window.location.href=URL_PREFIX+"/empcontract/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<s:form action="view" theme="simple" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
</s:form>
<div class="x-panel-header">
	<div style="float: left;">员工合同信息</div>	<div style="float: right">
				<a href="${ctx}/empcontract/edit.do?model.employee.id=${model.employee.id}">
				<img src="${ctx}/images/icons/add_2.gif">&nbsp;添加员工合同</a>
				</div>
</div>
<div>

<div class="x-panel-body">
<table width="100%" align="left" id="fineTable">
<tr>
<th>序号</th>
<th>员工姓名</th>
<th>部门名称</th>
<th>职务</th>
<th>合同起始时间</th>
<th>合同截止时间</th>
<th>操作</th>
</tr>
<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="40">${(page.pageNo - 1) * 20 + st.index + 1}</td>
			<td width="100" >${item.employee.name}</td>
      		<td width="100">${item.employee.dept.name}</td>
			<td width="40" >${item.employee.position.name}</td>
			<td width="120" align="center"><fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd"/></td>
			<td width="120" align="center"><fmt:formatDate value="${item.endTime}" pattern="yyyy-MM-dd"/></td>
			<td width="100" style="text-align:center;sortable:false">
			<a href="${ctx }/empcontract/edit.do?model.id=${item.id}" title="修改合同信息">编辑</a> |
			<a href="#" onclick="remove('${item.id}')" title="删除合同信息">删除</a>
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
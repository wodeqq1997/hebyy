<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>员工合同管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">员工合同管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
<s:form action="showUsers" theme="simple" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
 <table width="100%">  
      <tr>
        <td> 
          &nbsp;姓　名:&nbsp;<s:textfield id="userName" name="model.user.name" />&nbsp;&nbsp;
          &nbsp;部　门:&nbsp;<s:textfield id="dept" name="model.user.dept.name" />&nbsp;&nbsp;
          &nbsp;<s:submit value="查询" cssClass="button" />
        </td>
    </tr>
</table>
</s:form>
</div>
<div class="x-panel-body">
<table width="100%" align="left" id="fineTable">
<tr>
<th>序号</th>
<th>员工姓名</th>
<th>部门名称</th>
<th>学历</th>
<th>入职时间</th>
<th>最近合同开始时间</th>
<th>最近合同截止时间</th>
<th>状态</th>
<th>操作</th>
</tr>
<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="40">${(page.pageNo - 1) * 20 + st.index + 1}</td>
			<td width="100" ellipsis="true">${item.name}</td>
      		<td width="100"ellipsis="true">${item.dept.name}</td>
			<td width="40" ellipsis="true">${item.degree}</td>
			<td width="120" align="center"><fmt:formatDate value="${item.joinTime}" pattern="yyyy-MM-dd"/></td>
			<td width="120" align="center"><fmt:formatDate value="${item.lastContractBegin}" pattern="yyyy-MM-dd"/></td>
			<td width="120" align="center"><fmt:formatDate value="${item.lastContractEnd}" pattern="yyyy-MM-dd"/></td>
			<td width="55" style="text-align:center">
			${item.contractStatus eq 1?"正常":item.contractStatus eq 0?"<span style='color:red'>过期</span>":"—"}
			</td>
			<td width="100" style="text-align:center" sortable="false">
			<a href="${ctx }/empcontract/userContractView.do?model.user.id=${item.id}" title="查看员工合同">查看员工合同</a>
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
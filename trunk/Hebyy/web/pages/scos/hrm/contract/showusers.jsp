<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec2.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>员工合同管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">员工合同管理</div>
</div>
<div class="x-toolbar">
 <table width="100%" style="line-height: 25px;">  
      <tr>
        <td> 
          <form id="queryForm" action="showUsers.do">
          &nbsp;姓　名:&nbsp;<s:textfield id="userName" name="model.user.name"  cssStyle="height:20px;"/>&nbsp;&nbsp;
          &nbsp;部　门:&nbsp;<s:textfield id="dept" name="model.user.dept.name"  cssStyle="height:20px;"/>&nbsp;&nbsp;
          &nbsp;<s:submit value="查询" cssClass="button" />
          </form>
        </td>
    </tr>
</table>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="showUsers.do" 
		useAjax="false"
		doPreload="false" 
		pageSizeList="20,50" 
		editable="false"
		sortable="false" 
		rowsDisplayed="20"
		generateScript="true" 
		resizeColWidth="true" 
		classic="true" 
		width="100%"
		height="460px"
		minHeight="460"
		toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
	<ec:row>
	    <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
	    <ec:column width="100" property="name" title="员工姓名" style="text-align:center" ellipsis="true"/>
		<ec:column width="100" property="dept.name" title="部门名称" style="text-align:center" ellipsis="true"/>
		<ec:column width="100" property="degree"  title="学历"  style="text-align:center" ellipsis="true"/>
		<ec:column width="100" property="joinTime" title="入职时间" cell="date" ellipsis="true"/>
		<ec:column width="150" property="lastContractBegin"  title="最近合同开始时间"   cell="date" ellipsis="true"/>
		<ec:column width="150" property="lastContractEnd"  title="最近合同截止时间"  cell="date" ellipsis="true"/>
        <ec:column width="55" property="_1" title="状态" style="text-align:center">
            ${item.contractStatus eq 1?"正常":item.contractStatus eq 0?"<span style='color:red'>过期</span>":"—"}
        </ec:column>
		<ec:column width="170" property="_0" title="操作" style="text-align:center" sortable="false">
			<a href="${ctx }/empcontract/userContractView.do?model.user.id=${item.id}" title="查看员工合同">查看员工合同</a>
		</ec:column>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
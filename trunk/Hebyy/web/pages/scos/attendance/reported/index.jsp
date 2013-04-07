<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp" %>
<%@include file="/common/extjs.jsp" %>
<%@include file="/common/meta.jsp" %>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>考勤管理</title>
<style type="text/css">
.button {
	height: 20px;
	padding: 2px 0px 2px 0px;
	background-color: #D2E0F1;
	border: 1px solid #99BBE8;
	background-image: url("../images/grid/footerBg.gif");
}
</style>
</head>
<body>
<div class="x-panel">
  <div class="x-panel-header">上报考勤信息</div>
    <div class="x-toolbar">
		<s:form action="index.do" method="post">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td width="40px" align="right">
					员工：
				</td>
				<td width="130px">
					<input id="userName" name="userName" />
				</td>
				<td width="40px" align="right">日期：</td>
				<td>
					<input id="date" name="date" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" style="height: 20px;"/>
				</td>
				<td width="30%" align="right">
			        	<s:submit value="查  询" cssClass="button"></s:submit>&nbsp;&nbsp;
			        	<input type="button" value="重  置" class="button" onclick="location.replace(location.href);"/>
				</td>
				<td align="right">
					<a href="${ctx}/reportedAtte/edit.do"><img src="${ctx}/images/icons/add.gif" />上报考勤</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</s:form> 
	</div>   
    <div class="x-panel-body">
    <div>
	<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="index.do"
		useAjax="true" doPreload="false"
		maxRowsExported="10000000" 
		pageSizeList="20,50" 
		editable="false" 
		sortable="false"	
		rowsDisplayed="20"	
		generateScript="true"	
		resizeColWidth="false"	
		classic="false"	
		width="100%" 	
		height="460px"	
		minHeight="460"
		toolbarContent="navigation|pagejump|pagesize|refresh|extend|status"
	>
	<ec:row>
	   <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
	    <ec:column width="100" property="user.name" title="员工姓名" style="text-align:center" />
	    <ec:column width="100" property="leaveDay" title="事假" style="text-align:center" />
	    <ec:column width="100" property="diseaseDay" title="病假" style="text-align:center" />
	    <ec:column width="100" property="lateCount" title="迟到" style="text-align:center" />
	    <ec:column width="100" property="absentCount" title="旷工" style="text-align:center" />
	    <ec:column width="250" property="mark" title="备注" style="text-align:center" />
		<ec:column width="120" property="date" title="创建日期" cell="date" format="yyyy-MM-dd" style="text-align:center"/>
		<ec:column width="100" property="status" title="状态" style="text-align:center" >
			<s:if test='#attr.item.status == "0"'>
				未上报
			</s:if>
			<s:else>
				已上报
			</s:else>
		</ec:column>
		<ec:column width="60" property="_2" title="操作" style="text-align:center"  sortable="false">
		  <s:if test='#attr.item.status == "0"'> 
		    <a href="report.do?model.id=${item.id}" title="上报"><img src="${ctx}/images/exticons/arrow-up.gif"></a>
		  	<a href="editAtte.do?model.id=${item.id}" title="编辑"><img src="${ctx}/images/icons/modify.gif"></a>
		   </s:if>
		</ec:column>
	</ec:row>
	</ec:table>
	</div>
	</div>
</div>
<div id='load-mask'></div>
</body>
</html>
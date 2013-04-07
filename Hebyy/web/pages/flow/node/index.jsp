<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec2.jsp"%>
<script>
    tableHeightMod = 106
</script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>项目信息管理</title>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >&nbsp;我的待办事项</div>
<div class="x-toolbar" style="padding: 2px;">
	<s:form action="myIndex.do" cssStyle="margin:auto;">
		&nbsp;待办事项：<s:textfield name="flowTitle" cssStyle="width:100px;"/>
		&nbsp;事项类型：<s:select list="flowTitleMap" name="flowType" headerKey="" headerValue="全部" cssStyle="width:100px;"/>
		&nbsp;开始日期：<input id="startDate" name="startDate" style="height:20px;width: 100px;" value='<s:date name="startDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" /> 
		&nbsp;结束日期：<input id="endDate" name="endDate" style="height:20px;width: 100px;" value='<s:date name="endDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
		&nbsp;<input type="submit" value="查询" class="button" />
		&nbsp;<input type="button" value="重置" class="button" onclick="location.replace(location.href);"/>
	</s:form>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="myIndex.do" 
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
	    <ec:column width="50" property="_s" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
		<ec:column width="450" property="flow.title" title="待办事项" />
		<ec:column width="100" property="flow.createDate" title="申请日期" cell="date" format="yyyy-MM-dd" style="text-align:center"/>
		<ec:column width="80" property="status" title="状态" style="text-align:center;" mappingItem="@com.systop.zjimis.flow.FlowConstants@STATUS_MAP"/>
		<ec:column width="100" property="_0" title="操作" viewsAllowed="html" style="text-align:center">
			<a href="view.do?model.id=${item.id}">查看具体信息</a>
		</ec:column>
	</ec:row>
	<s:if test="#attr.items.size()==0">
		<ec:extendrow>
			<tr style="background-color: #ffe3ee">
				<td colspan="9" align="center" id="No1"
					style="font-weight: bold; border-top: 0px; border-bottom: 0px; border-left: 0px">无审批信息</td>
			</tr>
		</ec:extendrow>
	</s:if>
</ec:table>
</div>
</div>
</body>
</html>
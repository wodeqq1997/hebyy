<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<title>案卷</title>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >
	<div style="float: left;">案卷审核</div>
	<input type="button" class="button" value="待审核记录" onclick="openAuditSelectByInfo('1')">
</div>
<div class="x-toolbar">
	<s:form action="historyAuditIndex" theme="simple">
		<table width="99%">
			<tr>
				<td>
					开始日期：<input id="startDate" name="startDate"  style="height:20px;" value='${startDate}' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					结束日期：<input id="endDate" name="endDate"  style="height:20px;" value='${endDate}' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
					审核状态：<s:select name="flowStatus" list="#{'pass':'批准','noPass':'未批准'}" headerKey="" headerValue="全部" cssStyle="width:100px;" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value="查询" class="button" />
				</td>
			</tr>
		</table>
	</s:form>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="historyAuditIndex.do" 
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
	    <ec:column width="100" property="_fileNO" title="文件编号" style="text-align:center">
	    	<a href="javascript:" onclick="openArchiveFile('${item.flow.archiveFileLend.archiveFile.id}')" title="查看文件信息">
	    		${item.flow.archiveFileLend.archiveFile.fileNO}
	    	</a>
	    </ec:column>
		<ec:column width="140" property="flow.archiveFileLend.lendUser.name" title="借阅人" style="text-align:center"/>
		<ec:column width="130" property="flow.archiveFileLend.createTime" cell="date" style="text-align:center" title="借阅日期" format="yyyy-MM-dd HH:mm:ss"/>
		<ec:column width="130" property="audDate" cell="date" style="text-align:center" title="审批日期" format="yyyy-MM-dd HH:mm:ss"/>
		<ec:column width="60" property="_status" title="状态" style="text-align:center;">
		 	<s:if test='#attr.item.status == "noPass"'>
				<span style="color: red;">未批准</span>
			</s:if>
			<s:elseif test='#attr.item.status == "pass"'>
				<span style="color: green;">批准</span>
			</s:elseif>
		</ec:column>
	</ec:row>
	<s:if test="#attr.items.size()==0">
		<ec:extendrow>
			<tr style="background-color: #ffe3ee">
				<td colspan="9" align="center" id="No1"
					style="font-weight: bold; border-top: 0px; border-bottom: 0px; border-left: 0px">无审核信息</td>
			</tr>
		</ec:extendrow>
	</s:if>
</ec:table>
</div>
</div>
</body>
</html>
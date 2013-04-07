<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<title>案卷</title>
<script type="text/javascript">
//审核相关JS

/**
* 提交审核
* @param url 提交成功跳转的URL
*/
function submitAudit(nodeId,status){
	$.ajax({
		url : URL_PREFIX+"/flow/node/auditFlowNode.do",
		type : "POST",
		data : {
			"model.id" : nodeId,
			"model.status" : status,
			"auditorId" : '',		
			"model.descn" : '',
			"field" : 'archiveFileLend'
		},
		dataType : "json",
		success : function(result) {
			//如果执行成功
			if(result.success){
				alert('审核完成');
				window.location.href = URL_PREFIX + '/archive/file/lend/auditIndex.do';
			}else{
				alert('审核失败');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(XMLHttpRequest + "@@" + textStatus + "@@@" + errorThrown);//"发生异常，请与管理员联系！",
			return false;
		}
	});
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >
	<div style="float: left;">案卷审核</div>
	<s:form action="archiveIndex.do"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
        </s:form>
</div>
<div class="x-toolbar">
</div>
<div class="x-panel-body">
<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>文件编号</th>
		<th>借阅人</th>
		<th>借阅日期</th>
		<th>审批日期</th>
		<th>状态</th>
		<th>审批日期</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
            <td align="center"><a href="javascript:" onclick="openArchiveFile('${item.flow.archiveFileLend.archiveFile.id}')" title="查看文件信息">
	    		${item.flow.archiveFileLend.archiveFile.fileNO}
	    	</a></td>
			 <td>${item.flow.archiveFileLend.lendUser.name}</td>
			<td><fmt:formatDate value="${item.flow.archiveFileLend.createTime}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${item.audDate}" pattern="yyyy-MM-dd"/></td>
			<td><s:if test='#attr.item.flow.status == "stop"'>
				<span style="color: red;">未通过</span>
			</s:if>
			<s:elseif test='#attr.item.flow.status == "end"'>
				<span style="color: green;">通过</span>
			</s:elseif>
			<s:elseif test='#attr.item.flow.status == "start"'>
				<span style="color: green;">审核中</span>
			</s:elseif>
			<s:else>
				<span style="color: black;">待审核</span>
			</s:else></td>
			<td>
				<a href="javascript:" onclick="submitAudit('${item.id}','pass')" title="审核案卷借阅">批准</a> | 
			<a href="javascript:" onclick="submitAudit('${item.id}','noPass')" title="审核案卷借阅">不批准</a>
		</td>
		</tr>
	</s:iterator>
	<s:if test="#attr.items.size()==0">
			<tr style="background-color: #ffe3ee">
				<td colspan="9" align="center" id="No1"
					style="font-weight: bold; border-top: 0px; border-bottom: 0px; border-left: 0px">无待审核信息</td>
			</tr>
	</s:if>
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
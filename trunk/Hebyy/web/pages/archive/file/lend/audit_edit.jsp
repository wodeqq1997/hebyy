<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<%@ page import="com.systop.common.modules.security.user.UserUtil,com.systop.common.modules.security.user.model.User;" %>
<html>
<head>
<title>档案借阅审批</title>
<%
	User u = UserUtil.getLoginUser(request);
	pageContext.setAttribute("loginUserId", u.getId());
%>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/audit.js"></script>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/showUser.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">档案文件借阅审批</div>
<div class="x-panel-body">
<div><%@ include file="/common/messages.jsp"%></div>
	<s:hidden name="model.id" />
	<table width="800" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<th colspan="4">案卷信息</th>
		</tr>
		<tr>
			<td width="100" align="center">案卷编号：</td>
			<td width="300">
				&nbsp;<s:property value="model.archiveFile.archive.archiveNO"/>
			</td>
			<td width="100" align="center">案卷名称：</td>
			<td width="300">
				&nbsp;<s:property value="model.archiveFile.archive.name"/>
			</td>
		</tr>
		<tr>
			<td align="center">案卷类别：</td>
			<td> 
				&nbsp;<s:property value="model.archiveFile.archive.archiveType.name"/>
			</td>
		</tr>
		<tr>
			<th colspan="4">文件信息</th>
		</tr>
		<tr>
			<td width="100" align="center">文&nbsp;&nbsp;件&nbsp;&nbsp;号：</td>
			<td width="300">
				&nbsp;${model.archiveFile.fileNO}
			</td>
			<td width="100" align="center">文件名称：</td>
			<td width="300">
				&nbsp;${model.archiveFile.name}
			</td>
		</tr>
		<tr>
			<td width="100" align="center">借&nbsp;&nbsp;阅&nbsp;&nbsp;人：</td>
			<td width="250">
				&nbsp;${model.lendUser.name}
			</td>
			<td width="100" align="center">借阅日期：</td>
			<td width="250">
				&nbsp;<s:date name="model.createTime" format="yyyy-MM-dd"/>
			</td>
		</tr>
	</table>
	<table id="fineTable" align="center" width="800" style="margin-top: -1px;">
		<tr>
			<th colspan="6" >项目审批状态</th>
		</tr>
		<tr>
			<td width="50" align="center">No.</td>
			<td width="150" align="center">审批部门</td>
			<td width="100" align="center">审批人</td>
			<td width="100" align="center">审批日期</td>
			<td width="100" align="center">审批状态</td>
			<td width="300" align="center">审批意见</td>
		</tr>
		<s:iterator value="model.lastFlow.nodes" var="node">
			<tr>
				<td align="center">${node.orderId}</td>
				<td>&nbsp;
					<s:if test="#attr.node.auditor.dept != null">
		        		${node.auditor.dept.name}
					</s:if>
				</td>
				<td>
					&nbsp;${node.auditor.name}
				</td>
				<td>
					&nbsp;<s:date name="#attr.node.audDate" format="yyyy/MM/dd HH:mm" />
				</td>
				<td align="center">
					<s:if test='#attr.node.status == @com.systop.zjimis.flow.FlowConstants@STATUS_NOPASS'>
						<span style="color: red;">未通过</span>
					</s:if>
					<s:elseif test='#attr.node.status == @com.systop.zjimis.flow.FlowConstants@STATUS_PASS'>
						<span style="color: green;">通过</span>
					</s:elseif>
					<s:else>
						<span style="color: black;">未审批</span>
					</s:else>&nbsp;
				</td>
				<td>&nbsp;${node.descn}</td>
			</tr>
		</s:iterator>
	</table>
	<br>
	<s:if test="model.status == 0">
	<s:hidden id="nodeId" name="#attr.node.id"/>
	<input type="hidden" id="auditor">
	<table id="fineTable" align="center" width="800" style="margin-top: -1px;">
		<tr>
			<th colspan="6">本次审批操作</th>
		</tr>
		<tr>
			<td width="100" align="right" >审批人</td>
			<td width="150">${node.auditor.name}&nbsp;</td>
			<td width="100" align="right" >所属部门</td>
			<td width="150">${node.auditor.dept.name}&nbsp;</td>
			<td width="100" align="right" >审批状态</td>
			<td width="200">
				<input type="radio" name="status" style="border:0;"  value="pass">通过&nbsp;&nbsp;&nbsp;
				<input type="radio" name="status" style="border:0;"  value="noPass">未通过
			</td>
		</tr>
		<tr>
			<td width="100"  align="right">审批意见</td>
			<td colspan="5" width="700">
				<textarea id="descn" style="width: 690px; height: 50px;"></textarea>
			</td>
		</tr>
		<tr>
			<td width="100"  align="right">下一审批人</td>
			<td colspan="5" width="700">
				<div id="auditorDiv">
					<input type="hidden" id="auditor">
					<input type="text" id="auditorName" onclick="showAuditUser(this,true)" readonly="readonly"/>
					<span style="color: red;" >如果没有下一审批人，当前审批人为最终审批</span>
				</div>
			</td>
		</tr>
	</table>
	</s:if>
	<br>
	<div align="center">
		<s:if test="model.status == 0">
			<input type="button" value="提交审批意见" onclick="submitPage()" class="button"/>
            <script type="text/javascript">
                function submitPage()
                {

                    //submitAudit('${ctx}/pages/success.jsp?url='+encodeURIComponent(document.location.href),'archiveFileLend');
                    submitAudit('${ctx}/pages/success.jsp','archiveFileLend');
                }
            </script>
		</s:if>
	</div>
</div>
</div>
</body>
</html>
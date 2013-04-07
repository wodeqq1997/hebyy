<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>案卷借阅</title>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<%@include file="/common/meta.jsp"%>
<style type="text/css">
.table {
	margin: auto;
	border-top: 1px solid #000000;
	border-left: 1px solid #000000;
	border-bottom: -1px solid #000000;
	border-right: -1px solid #000000;
	margin-top: 5px;
}

.table tr td {
	height:25px;
	border-bottom: 1px solid #000000;
	border-right: 1px solid #000000;
	font-family: sans-serif;
}

.table tr th {
	background-color: #ECECEC;
	height:30px;
 	font-weight: bold;
 	font-size:13px;
 	text-align: center;
	border-bottom: 1px solid #000000;
	border-right: 1px solid #000000;
	font-family: sans-serif;
}
</style>
</head>
<body>
<div class="x-panel" style="width: 100%">
	<div class="x-panel-header">
		<div style="float: left;">案卷借阅信息</div>
		<div style="float: right;"><a href="javascript:" onclick="history.go(-1);">返回</a>&nbsp;&nbsp;</div>
	</div>
	<div><%@ include file="/common/messages.jsp"%></div>
	<div align="center" style="width: 100%">
		<s:hidden name="model.id" />
		<table width="700" class="table" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<th colspan="6" class="title">案卷借阅信息</th>
			</tr>
			<tr>
				<td align="right" width="80">案卷编号：</td>
				<td align="left" colspan="3">
				    &nbsp;${model.archives.archivesNO}
				</td>
			</tr>
			<tr>
				<td align="right" >案卷名称：</td>
				<td align="left" colspan="3">
				    &nbsp;${model.archives.name}
				</td>
			</tr>
			<tr>
				<td align="right">申请日期：</td>
				<td align="left" colspan="3">
					&nbsp;<s:date name="model.createTime" format="yyyy-MM-dd"/>
				</td>
			</tr>
			<tr>
				<td align="right">归还日期：</td>
				<td align="left" colspan="3">
					&nbsp;
					<s:if test="model.alsoDate == null">
						<font color="red">未归还</font>
					</s:if>
					<s:date name="model.alsoDate" format="yyyy-MM-dd"/>
				</td>
			</tr>
	        <tr>
	           <td align="right">
	           	备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：
	           </td>
	           <td align="left" colspan="3">
	           		&nbsp;${model.remark}
				</td>
	        </tr>		
		</table>
		<table class="table" width="700" cellpadding="0" cellspacing="0">
			<tr>
				<th colspan="6" class="title">工程案卷借阅审核状态</th>
			</tr>
			<tr align="center">
				<th width="40">No.</th>
				<th width="80">审核部门</th>
				<th width="80">审核人</th>
				<th width="80">审核日期</th>
				<th width="80">审核状态</th>
				<th width="284">审核意见</th>
			</tr>
			<s:iterator value="model.flow.nodes" var="node">
				<tr>
					<td align="center">${node.orderId}</td>
					<td>&nbsp;
						<s:if test="#attr.node.auditor.dept.name!= null">
			        		${node.auditor.dept.name}
						</s:if>
					</td>
					<td>
						&nbsp;${node.auditor.name}
					</td>
					<td align="center">
						&nbsp;<s:date name="#attr.node.audDate" format="yyyy-MM-dd" />
					</td>
					<td align="center">
						<s:if test='#attr.node.status == "noPass"'>
							<span style="color: red;">未通过</span>
						</s:if>
						<s:elseif test='#attr.node.status == "pass"'>
							<span style="color: green;">通过</span>
						</s:elseif>
						<s:else>
							<span style="color: black;">未审核</span>
						</s:else>&nbsp;
					</td>
					<td>&nbsp;${node.descn}</td>
				</tr>
			</s:iterator>
		</table>
	</div>
</div>
</body>
</html>
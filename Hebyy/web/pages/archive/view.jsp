<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>案卷信息</title>
<%@include file="/common/meta.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
</head>
<body>
	<div class="x-panel" style="width: 100%">
		<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">案卷信息</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div align="center" style="width: 100%">
			<s:hidden name="model.id" />
			<table width="700" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<th colspan="4">档案信息</th>
				</tr>
				<tr>
					<td width="100" align="center">案卷编号：</td>
					<td width="250">
						&nbsp;${model.archiveNO}
					</td>
					<td width="100" align="center">案卷名称：</td>
					<td width="250">
						&nbsp;${model.name}
					</td>
				</tr>
				<tr>
					<td align="center">案卷类别：</td>
					<td> 
						&nbsp;${model.archiveType.name}
					</td>
				</tr>
				<tr>
					<td align="center">所属部门：</td>
					<td> 
						&nbsp;${model.dept.name}
					</td>
					<td align="center">归档年代：</td>
					<td> 
						&nbsp;<fmt:formatDate value="${model.archiveYear}" pattern="yyyy年"/>
					</td>
				</tr>
				<tr>
					<td align="center">起始日期：</td>
					<td>
						&nbsp;<fmt:formatDate value="${model.beginDate}" pattern="yyyy-MM-dd"/>
					</td>
					<td align="center">终止日期：</td>
					<td>
						&nbsp;<fmt:formatDate value="${model.endDate}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td align="center">保管期限：</td>
					<td> 
						&nbsp;${model.deadline}							
					</td>
					<td align="center">案卷密级：</td>
					<td> 
						&nbsp;${model.dense}
					</td>
				</tr>
				<tr>
					<td align="center">全&nbsp;&nbsp;宗&nbsp;&nbsp;号：</td>
					<td> 
						&nbsp;${model.categoryNO}
					</td>
					<td align="center">目&nbsp;&nbsp;录&nbsp;&nbsp;号：</td>
					<td> 
						&nbsp;${model.catalogNO}
					</td>
				</tr>
				<tr>
					<td align="center">档案保管位置：</td>
					<td> 
						&nbsp;<s:property value="model.archiveCabinet.name"/>
					</td>
					<td align="center">微&nbsp;&nbsp;缩&nbsp;&nbsp;号：</td>
					<td> 
						&nbsp;${model.microNO}
					</td>
				</tr>
				<tr>
					<td align="center">页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数：</td>
					<td> 
						&nbsp;${model.archivePage}
					</td>
					<td align="center">编制机构：</td>
					<td> 
						&nbsp;${model.editDept}
					</td>
				</tr>
				<tr>
					<td align="center">案卷内容：</td>
					<td colspan="3"> 
						&nbsp;${model.content}
					</td>
				</tr>				<tr>
					<td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					<td colspan="3">
						&nbsp;${model.remark}
					</td>
				</tr>
			</table>
			<table width="600px" style="margin-bottom: 10px;margin-top: 20px;">
				<tr>
					<td style="text-align: center;">
					  <input type="button" value="关闭" onclick="javascript:window.close();" class="button"/> 
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
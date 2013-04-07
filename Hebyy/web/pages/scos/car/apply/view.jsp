<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css'
	rel='stylesheet'>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>车辆申请信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" align="left" style="border-bottom: 1px solid #99bbe8;">车辆申请详单</div>
		<div class="x-panel-body">
			<s:hidden name="model.id"/>
			<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
				<tr>
					<th colspan="4">
						汽车使用申请
					</th>
				</tr>
				<tr>
					<td align="center" width="100">申&nbsp;&nbsp;请&nbsp;&nbsp;人：</td>
					<td width="250">
						&nbsp;${model.proposer.name}
					</td>
					<td align="center" width="100">申请人数：</td>
					<td width="250">
						&nbsp;${model.personCount}
					</td>
				</tr>
				<tr>
					<td align="center">车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;辆：</td>
					<td >
						&nbsp;${model.car.carNo}
					</td>
				</tr>
				<tr>
					<td align="center">开始时间：</td>
					<td>
						&nbsp;<s:date name="model.startTime" format="yyyy-MM-dd hh:mm:ss" />
					</td>
					<td align="center">结束时间：</td>
					<td>
						&nbsp;<s:date name="model.endTime" format="yyyy-MM-dd hh:mm:ss" />
					</td>
				</tr>
				<tr>
					<td align="center">开始里程：</td>
					<td>
						&nbsp;${model.startMileage}
					</td>
					<td align="center">结束里程：</td>
					<td>
						&nbsp;${model.endMileage}
					</td>
				</tr>
				<tr>
					<td align="center">申请日期：</td>
					<td>
						&nbsp;<s:date name="model.applyDate" format="yyyy-MM-dd" />
					</td>
					<td align="center">油&nbsp;&nbsp;耗&nbsp;&nbsp;量：</td>
					<td>
						&nbsp;${model.oilUse}
					</td>
				</tr>
				<tr>
					<td align="center">申请原因：</td>
					<td>
						&nbsp;${model.reason}
					</td>
					<td align="center">司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
					<td>
						&nbsp;<s:property value="model.chauffeur.name"/>
					</td>
				</tr>
				<tr>
					<td align="center">审&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;核：</td>
					<td colspan="3">&nbsp;
						<s:if test="model.status == 0">
							未审核
						</s:if>
						<s:elseif test="model.status == 1">
							<font color="green">通过</font>
						</s:elseif>
						<s:else>
							<font color="red">未通过</font>
						</s:else>
						
					</td>
				</tr>
				<tr>
					<td align="center" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					<td colspan="3">
						&nbsp;${model.notes}
					</td>
				</tr>
			</table>
		<div align="center">
			<input type="button" value="返回" onclick="history.go(-1)" class="button" />
		</div>
		</div>
	</div>
</body>
</html>
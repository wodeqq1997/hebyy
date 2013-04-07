<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>汽车交接记录</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
			<div style="float: left;">汽车交接记录</div>
		</div>
		<div class="x-panel-body" style="text-align: center;">
			<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px; margin-bottom: 20px;"	id="fineTable">
				<tr>
					<th colspan="4">汽车交接记录</th>
				</tr>
				<tr>
					<td width="80" align="center">交&nbsp;&nbsp;付&nbsp;&nbsp;人：</td>
					<td width="270">${model.delivery}</td>
					<td width="80" align="center">接&nbsp;&nbsp;收&nbsp;&nbsp;人：</td>
					<td width="270">${model.recipient}</td>
				</tr>
				<tr>
					<td align="center">交接车辆：</td>
					<td width="550">${model.car.carNo}</td>
					<td align="center">交接时间：</td>
					<td><s:date name="date" format="yyyy-MM-dd" />
					</td>
				</tr>
				<tr>
					<td align="center">车辆状态：</td>
					<td width="550" colspan="3">
						<s:if test="model.status == 1">
								可用
							</s:if>
							<s:elseif test="model.status == 0">
								报废
							</s:elseif>
							<s:else>
								维修中
							</s:else>
					</td>
				</tr>
				<tr>
					<td align="center" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					<td colspan="3">${model.descn}</td>
				</tr>
			</table>
			<center>
				<input type="button" class="button" value="返回" onclick="history.back(-1)">
			</center>
		</div>
	</div>
</body>
</html>
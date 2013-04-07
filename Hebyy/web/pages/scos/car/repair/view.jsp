<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>车辆维修记录</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" align="left">车辆维修记录详单</div>
		<div class="x-panel-body">
			<fieldset>
				<legend>车辆维修记录信息</legend>
				<table width="750" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="300" align="right">车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</td>
						<td width="450">
							${model.car.carNo}
						</td>
					</tr>
					<tr>
						<td align="right">维修日期：</td>
						<td>
							<s:date name="model.repairDate" format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<td align="right">维修类型：</td>
						<td>
							${model.repairType}
						</td>
					</tr>
					<tr>
						<td align="right">经&nbsp;&nbsp;办&nbsp;&nbsp;人：</td>
						<td >
							${model.executant}
						</td>
					</tr>
					<tr>
						<td align="right">费&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用：</td>
						<td >
							${model.fee}
						</td>
					</tr>
					<tr>
						<td align="right">车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;况：</td>
						<td >
							${model.conditions}
						</td>
					</tr>
					<tr>
						<td align="right">维修原因：</td>
						<td >
							${model.reason}
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td >
							${model.notes}
						</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<input type="button" value="返回" onclick="history.go(-1)" class="button" />
			</div>
		</div>
	</div>
</body>
</html>
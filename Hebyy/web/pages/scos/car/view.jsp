<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>车辆信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" align="left">车辆信息</div>
		<div class="x-panel-body">
			<fieldset>
				<legend>车辆信息</legend>
				<table width="750" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</td>
						<td width="350">
							${model.carNo}
						</td>
						<td width="300" rowspan="8" align="center">
							<div style="border:1px solid #ccc;width: 250px;height: 270px;">
								<s:if test="model.id != null && model.carPhoto != null && model.carPhoto != ''">
									<img  id="photo" src="${ctx}${model.fileAttch.path}" width="250px" height="270px"/>
								</s:if>
								<s:else>
									<img  id="photo" src="${ctx}/images/scos/defaultcarpic.gif" width="250px" height="270px"/>
								</s:else>						
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">车辆类型：</td>
						<td>
							${model.carType}
						</td>
					</tr>
					<tr>
						<td align="right">发动机号：</td>
						<td>
							${model.engineNo}
						</td>
					</tr>
					<tr>
						<td align="right">厂&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
						<td >
							${model.factory}
						</td>
					</tr>
					<tr>
						<td align="right">保险购买日期：</td>
						<td class="simple">
							<s:date name="model.buyInsureTime" format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<td align="right">年审日期：</td>
						<td class="simple">
							<s:date name="model.auditTime" format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<td align="right" >购置日期：</td>
						<td class="simple">
							<s:date name="model.buyDate" format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<td align="right">车辆状态：</td>
						<td>
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
						<td width="100" align="right">服务电话：</td>
						<td width="650" colspan="2">
							${model.servicePhone}
						</td>
					</tr>
					<tr>
						<td width="100" align="right">多少公里保养：</td>
						<td width="650" colspan="2">
							${model.maintenance}
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：</td>
						<td colspan="2">
							${model.descn}
						</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<input type="button" value="返回" onclick="history.go(-1)"
					class="button" />
			</div>
		</div>
	</div>
</body>
</html>
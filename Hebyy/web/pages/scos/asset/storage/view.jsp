<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>物资信息</title>
<%@include file="/common/meta.jsp"%>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">物资出入库信息</div>
		<div class="x-panel-body">
				<table width="750" border="0" style="line-height: 30px;">
					<tr>
						<td align="right">
						出库经办人：</td>
						<td >
							<s:textfield name="model.takeOperator.name" id="bringPerson"  cssClass="required" disabled="true"/>
						</td>
					</tr>
					<tr>
						<td align="right">领&nbsp;&nbsp;取&nbsp;&nbsp;人：</td>
						<td >
							<s:textfield name="model.takePerson" id="takePerson"  cssClass="required" disabled="true" />
						</td>
					</tr>
					<tr>
						<td align="right">出库时间：</td>
						<td >
							<s:date name='model.takeTime' format='yyyy-MM-dd'/>
						</td>
					</tr>
					<tr>
						<td align="right">出库明细：</td>
						<td>
							<s:textarea value="%{#attr.model.takeDetail}" 
							id="takeDetail" cssStyle="margin:3px 0px; width: 450px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;resize: none;"  disabled="true"/>
						</td>
					</tr>
					<tr>
						<td align="right">
						归还经办人：</td>
						<td >
							<s:textfield name="model.bringOperator.name" id="bringPerson" disabled="true"  cssClass="required" />
						</td>
					</tr>
					<tr>
						<td align="right">
						归&nbsp;&nbsp;还&nbsp;&nbsp;人：</td>
						<td >
							<s:textfield name="model.bringPerson" id="bringPerson" disabled="true"  cssClass="required" />
						</td>
					</tr>
					<tr>
						<td align="right">
						方&nbsp;&nbsp;量：</td>
						<td >
							<s:textfield name="model.square" id="square"  disabled="true" cssClass="required" maxLength="8"/>
						</td>
					</tr>
					<tr>
						<td align="right">归还时间：</td>
						<td >
							<s:date name='model.bringTime' format='yyyy-MM-dd'/>
						</td>
					</tr>
					<tr>
						<td align="right">归还明细：</td>
						<td>
							<s:textarea name="model.bringDetail" id="takeDetail" disabled="true"
							cssStyle="margin:3px 0px; width: 450px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;resize: none;"/>
						</td>
					</tr>
				</table>
		</div>
	</div>
</body>
</html>
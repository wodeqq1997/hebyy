<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/scos/car/selector.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>添加汽车交接记录</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
			<div style="float: left;">添加汽车交接记录</div>
			<div style="float: right;display: inline;"></div>
		</div>
		<div class="x-panel-body">
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px; margin-bottom: 20px;" id="fineTable">
					<tr>
						<th colspan="4">
							添加汽车交接记录
						</th>
					</tr>
					<tr>
						<td width="80" align="center">交&nbsp;&nbsp;付&nbsp;&nbsp;人：</td>
						<td width="270">
							<s:textfield name="delivery" id="proposer"  cssClass="required" maxlength="255"/>
							<font color="red">*</font>
						</td>
						<td width="80" align="center">接&nbsp;&nbsp;收&nbsp;&nbsp;人：</td>
						<td width="270">
							<s:textfield name="recipient" id="recipient"  cssClass="required" maxlength="255" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td width="200" align="center">选择车辆：</td>
						<td width="550">
							<s:textfield id="carNo" name="model.car.carNo" onclick="showCar()"  readonly="true" cssClass="required"/><s:hidden name="model.car.id" id="carId" /><!--							<input name="button2" id="carButton" type="button" class="button" onclick="" value="选择" />-->
							<span id="carNoDescn"></span>
							<font color="red">*</font>
						</td>
						<td align="center">交接时间：</td>
						<td>
							<s:if test="model.date != null">
								<input id="inDate" name="model.date"  value='<fmt:formatDate value="${model.date}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							</s:if>
							<s:else>
								<input id="inDate" name="model.date"  value='' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							</s:else>	
						</td>
					</tr>
					<tr>
						<td width="80" align="center">交接状态：</td>
						<td width="270"  colspan="3">
							<s:select list="statusMap" name="status" headerKey="" id="status" headerValue="全部" cssStyle="width:147px;" cssClass="statusCheck"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td colspan="3">
							<s:textarea name="descn" id="notes"  cssStyle="margin:3px 0px; width: 560px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  <div align="center" id="test">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		
		$(function() {
			$.validator.addMethod("Wdate", function(value, element) {
				if (value == null || value.length == 0){
					return false;					
				}else {
					return true;			
				}
			}, "必填");
		});

	</script>
	</body>
</html>
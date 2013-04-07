<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/scos/car/selector.js"></script>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/showUser.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<title>添加汽车使用</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
			<div style="float: left;">添加汽车使用</div>
			<div style="float: right;display: inline;"><a href="${ctx}/car/record/index.do">返回</a></div>
		</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div class="x-panel-body">
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px; margin-bottom: 20px;" id="fineTable">
					<tr>
						<th colspan="4">
							添加汽车使用
						</th>
					</tr>
					<tr>
						<td width="80" align="center">申&nbsp;请&nbsp;人：</td>
						<td width="270">
							<s:hidden name="model.proposer.id" id="userId"/>
							<s:textfield name="model.proposer.name" id="proposer"  cssClass="required" maxlength="255" onclick="showPresideUser(this)" readonly="true"/>
							<font color="red">*</font>
						</td>
						<td width="80" align="center">申请人数：</td>
						<td width="270">
							<s:textfield name="model.personCount" id="personCount"  cssClass="required digits" maxlength="255" />
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
					</tr>
					<tr>
						<td align="center" >开始时间：</td>
						<td class="simple">
							<input id="startTime" name="model.startTime"  value="<s:date name='model.startTime' format='yyyy-MM-dd HH:mm:ss'/>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\',{s:-1})}',skin:'blueFresh',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly" />
							<span id="startTimeDescn"></span>
							<font color="red">*</font>
						</td>
						<td align="center" >结束时间：</td>
						<td class="simple">
							<input id="endTime" name="model.endTime"  value="<s:date name='model.endTime' format='yyyy-MM-dd HH:mm:ss'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\',{s:1})}',skin:'blueFresh',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly" />
							<span id="endTimeDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center">开始里程：</td>
						<td>
							<s:textfield name="model.startMileage" id="startMileage"  cssClass="number"/>
							<span id="startMileageDescn"></span>
						</td>
						<td align="center">结束里程：</td>
						<td>
							<s:textfield name="model.endMileage" id="endMileage"  cssClass="number"/>
							<span id="endMileageDescn"></span>
						</td>
					</tr>
					<tr>
						<td align="center" >申请日期：</td>
						<td class="simple">
							<input id="applyDate" name="model.applyDate"  value="<s:date name='model.applyDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							<span id="applyDateDescn"></span>
							<font color="red">*</font>
						</td>
						<td align="center">油&nbsp;耗&nbsp;量：</td>
						<td>
							<s:textfield name="model.oilUse" cssClass="required number" id="oilUse"  />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center">申请原因：</td>
						<td>
							<s:textfield name="model.reason" id="reason" cssClass="required" cssStyle="width: 300px;"/>
 							<span id="reasonDescn"></span>
							<font color="red">*</font>
						</td>
						<td align="center">司&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
						<td>
							<s:hidden name="model.chauffeur.id" id="chauffeurId"/>
							<s:textfield name="model.chauffeur.name" cssClass="required" id="chauffeurName" cssStyle="width: 152px;" readonly="true" onclick="showChauffeur()"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td colspan="3">
							<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 0px; width: 600px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
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

		/**
		 * 选择司机 
		 */
		function showChauffeur() {
		    openSel(function (users) {
		        var selectNames = "";
		        var selectIds = "";
		        if (users.length > 0) {
		            if (users.length > 1) {
		                alert("只能选择一个，默认为第一个选项！");
		            }
		            selectNames = users[0].name;
		            selectIds = users[0].id;
		        }
		        $('#chauffeurId').val(selectIds);
		        $('#chauffeurName').val(selectNames);
		    },true);
		}
	</script>

    <script type="text/javascript" src="${ctx}/scripts/select.project.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
    <link href="${ctx}/styles/select.project.css" rel="stylesheet"/>
    <link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
	</body>
</html>
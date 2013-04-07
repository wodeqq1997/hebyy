<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/pages/scos/car/selector.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<%@include file="/common/validator.jsp"%>
<title>车辆维修记录编辑</title>
    <style>
        .textfield
        {
            width: 450px;
        }
    </style>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加车辆维修记录</div>
		<div class="x-panel-body">
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset style="width: 75%;  padding:10px 10px 10px 10px;">
			    <legend>车辆维修记录编辑</legend>
				<table width="750" border="0" style="line-height: 30px;">
					<tr>
						<td width="200" align="right">选择车辆：</td>
						<td width="550">
							<s:textfield id="carNo" name="model.car.carNo" onclick="showCar()"  readonly="true" cssClass="required"/>
							<s:hidden name="model.car.id" id="carId" />
<!--							<input name="button2" id="carButton" type="button" class="button" onclick="" value="选择" />-->
							<span id="carNoDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" >维修日期：</td>
						<td class="simple">
							<input id="repairDate" name="model.repairDate"  value="<s:date name='model.repairDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							<span id="repairDateDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">维修类型：</td>
						<td>
							<s:select list="#{'维修':'维修','保养':'保养'}" name="model.repairType" cssClass="repairTypeCheck" headerKey="" id="repairType" headerValue="全部" cssStyle="width:110px;" />
							<span id="repairTypeDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">经&nbsp;&nbsp;办&nbsp;&nbsp;人：</td>
						<td >
							<s:textfield name="model.executant" id="executant"  />
						</td>
					</tr>
					<tr>
						<td align="right">费&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用：</td>
						<td>
							<s:textfield name="model.fee" cssClass="required number" id="fee"  />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right">车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;况：</td>
						<td>
							<s:textfield name="model.conditions" id="conditions" cssClass="textfield"/>
						</td>
					</tr>
					<tr>
						<td align="right">维修原因：</td>
						<td>
							<s:textfield name="model.reason" id="reason"  cssClass="required textfield" maxlength="255"/>
							<span id="reasonDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td>
							<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 0px; width: 450px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center" id="test" style="margin-top: 10px;">
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
		$.validator.addMethod("repairTypeCheck", function(value, element) {
			if (value == null || value.length == 0) {
				return false;
			} else {
				$("#repairTypeDescn").html("");
				return true;
			}
		}, "必填");
		$.validator.addMethod("Wdate", function(value, element) {
			var res = "";
			if (value == null || value.length == 0) {
				res = "err";
				$("#repairDateDescn").html("<font color='red'>维修日期不允许为空</font>");
			}else {
				$("#repairDateDescn").html("");
				var d = new Date();   // 获得当前日期
				var vYear = d.getFullYear();
				var vMon = d.getMonth() + 1;
				var vDay = d.getDate();
				var dd = vYear+"-"+vMon+"-"+vDay;
				
				var stdt=new Date(value.replace("-","/"));
				var etdt=new Date(dd.replace("-","/"));
				if(stdt > etdt){
					res = "err";
					$("#repairDateDescn").html("<font color='red'>维修日期不允许大于当前日期</font>");
				}else{
					$("#repairDateDescn").html("");			
				}
			}
			return res != "err";
		}, "");
	});
</script>
</body>
</html>
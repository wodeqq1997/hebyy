<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />

<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/select.project.js"></script>
    <link href="${ctx}/styles/select.project.css" rel="stylesheet"/>
    <link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/showUser.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>
<title>申购物资信息</title>
</head>
<body onload="CurentTime()">
	<div class="x-panel">
		<div class="x-header">申购物资</div>
		<div class="x-panel-body">
			<form id="save" action="save.do" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="700" id="fineTable" align="center" style="margin-top: 20px;margin-bottom: 10px;">
					<tr>
						<th colspan="4">申购物资信息</th>
					</tr>
					<tr>
						<td width="100" align="right">物资名称：</td>
						<td width="200">
							<s:textfield name="model.name" id="name"  maxlength="255" cssClass="required" style="width:210px; "/>
							<font color="red">*</font>
						</td>
						<td width="100" align="right">物资编号：</td>
						<td width="200">
							<s:textfield name="model.assetNo" id="assetNo"  maxlength="255" style="width:210px; "/>
						</td>
					</tr>
					<tr>
						<td align="right">规格类型：</td>
						<td>
							<s:textfield name="model.stardard" id="stardard"  maxlength="255" style="width:210px; "/>
						</td>
						<td align="right">物资类别：</td>
						<td> 
							<s:select list="assetTypeMap" name="model.assetType.id" headerKey="" id="assetTypeId" headerValue="全部" cssStyle="width:208px;" cssClass="assetTypeCheck"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						
						<td align="right" >配套物品：</td>
						<td class="simple" >
							<s:textfield name="model.matchItems" id="matchItems"  maxlength="255" style="width:210px; "/>
						</td>
						<td align="right">审&nbsp;核&nbsp;人：</td>
					<td ><input id="csrMc" name="model.depter.name" onclick="openSupplier(this)"  
						 style="width:210px;"  class="required" readonly="readonly" >
				       <font color="red">*</font>
						 <input type="hidden" id="csrId" name="model.depter.id" />
						 </td>
						
					</tr>
					<tr>
						<td align="right" >申购个数：</td>
						<td class="simple" >
							<s:textfield name="model.stockCounts"   maxlength="255" cssClass="required" style="width:210px; "/>
							<font color="red">*</font>
						</td>
						<td align="right">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</td>
						<td> 
							<s:textfield name="model.unit"   maxlength="255" cssClass="required" style="width:210px; "/>
							<font color="red">*</font>
						</td>
						
					</tr>
					<tr>
						<td align="right" >申购日期：</td>
						<td class="simple">
						   <input type="text" id="jytime"  name="model.buyDate" style="width:210px; " readonly="readonly" 
							value=""   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" / >
						<font color="red">*</font>
						</td>
						<td align="right">申&nbsp;购&nbsp;人：</td>
						<td> 
						    <s:hidden name="model.proposer.id" id="userId"/>
							<s:textfield name="model.proposer.name" id="proposer"  cssClass="required" maxlength="255" readonly="true" style="width:210px; "/>
							<s:hidden name="model.dept.id" id="deptId"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">申购备注：</td>
						<td colspan="3">
							<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 0px; width: 600px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		$(function(){
			$.validator.addMethod("assetTypeCheck", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必选项");
		});
		$(function(){
			$.validator.addMethod("statusCheck", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必选项");
		});
		function CurentTime()
	    { 
	        var now = new Date();
	        var year = now.getFullYear();       //年
	        var month = now.getMonth() + 1;     //月
	        var day = now.getDate();            //日
	        var clock=year + "-";
	        if(month < 10){
	            clock += "0";
	        }
	        clock += month + "-";
	        if(day < 10){
	            clock += "0";
	        }
	        clock += day ;
	        
	       // alert(clock);
	    	var jytime = $("#jytime").val();
	        $("#jytime").val(clock);
	        
	        
	    } 
	
	    /**
		 * 显示审核人
		 */
		function openSupplier(obj) {
			var ids = document.getElementById("csrId");//初审人id
			var partId = document.getElementById("deptId");
			//alert(partId.value);
			if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
				var conf = "dialogWidth=508px;dialogHeight=338px;status=no;help=no;scrollbars=no";
				var csr = window.showModalDialog("${ctx}/pages/scos/asset/selectorCs.jsp?deptId="+partId.value, null, conf);
				if (csr != null){
					obj.value = csr.name;
					ids.value = csr.id;
				}
			} else {
				window.open("${ctx}/pages/scos/asset/selectorCs.jsp?deptId="+partId.value,
							"",
							"width=608px,height=438,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
				this.returnAction = function(csr) {
					if (csr != null){
						obj.value = csr.name;
						ids.value = csr.id;
					}
					return;
				};
			}
		}

	</script>
</body>
</html>
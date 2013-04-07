<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<style type="text/css">
.warn {
	color: red;
}
.title {
	border-bottom: 1px solid #99BBE8;
	font-size: 14px;
	font-weight: bold;
	color: #15428b;
}
</style>
<title>编辑档案</title>
</head>
<body>
<div class="x-panel">
<div class="x-toolbar" style="padding: 5px; font-weight: bold;">档案信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<s:form action="save" id="save" validate="true" method="post">
<s:hidden name="model.id" id="id"/>
<s:hidden id="uid" name="model.user.id" />
	<table width="800" align="center"style="margin: 10px; border-bottom: 1px solid #99BBE8;">
		<tr>
			<td colspan="2" class="title"><span>员工档案信息</span></td>
		</tr>
		<tr>
			<td>
			<table width="800" border="0" style="line-height: 25px;"  align="center">
				<tr>
					<td align="right" width="200">员工姓名：</td>
					<td align="left" colspan="3">${model.user.name}</td>
				</tr>
				<tr >
					<td align="right">员工薪酬：</td>
					<td><s:textfield name="model.salary" cssStyle="width:200px" />&nbsp;&nbsp;&nbsp;企业工龄：
					<s:textfield name="model.workYear" cssStyle="width:200px" /></td>
				</tr>
				
				<tr>
					<td align="right">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
					<td><s:textfield name="model.technical" cssStyle="width:200px"maxLength="255" />&nbsp;&nbsp;&nbsp;转正日期：  <input type="text" name="model.formalDate" style="width: 200px;" readonly="readonly" 
							   value='<s:date name="model.formalDate" format="yyyy-MM-dd"/>'
							    onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" /></td>
				</tr>
				<tr>
					<td align="right">缴纳保险：</td>
					<td>
						<s:hidden name="model.insurance" id="insurance"/>
						<input type="checkbox" name="insurancePram" value='<s:property value="@com.systop.scos.hrm.extinfo.ExtinfoConstants@EXTINFO_INSURANCE_PENSION"/>' style="border: 0xp;">养老保险&nbsp;
						<input type="checkbox" name="insurancePram" value='<s:property value="@com.systop.scos.hrm.extinfo.ExtinfoConstants@EXTINFO_INSURANCE_MEDICAL"/>' style="border: 0xp;">医疗保险&nbsp; 
						<input type="checkbox" name="insurancePram" value='<s:property value="@com.systop.scos.hrm.extinfo.ExtinfoConstants@EXTINFO_INSURANCE_UNEMPLOYMENT"/>' style="border: 0xp;">失业保险&nbsp;
						<input type="checkbox" name="insurancePram" value='<s:property value="@com.systop.scos.hrm.extinfo.ExtinfoConstants@EXTINFO_INSURANCE_INJURIES"/>' style="border: 0xp;">工伤保险&nbsp;
						<input type="checkbox" name="insurancePram" value='<s:property value="@com.systop.scos.hrm.extinfo.ExtinfoConstants@EXTINFO_INSURANCE_FERTILITY"/>' style="border: 0xp;">生育保险&nbsp;
						<input type="checkbox" name="insurancePram" value='<s:property value="@com.systop.scos.hrm.extinfo.ExtinfoConstants@EXTINFO_INSURANCE_HOUSING_FUND"/>' style="border: 0xp;">住房公积金	
					</td>
				</tr>
				<tr>
					<td align="right">个人爱好：</td>
					<td><s:textarea name="model.hobby"cssStyle="width:472px;height:40px;" rows="2"/></td>
				</tr>
				<tr>
					<td align="right">奖罚情况：</td>
					<td><s:textarea name="model.awardPunish"cssStyle="width:472px;height:40px;" rows="2"/></td>
				</tr>
				<tr>
					<td align="right" >工作经历：</td>
					<td><s:textarea name="model.workExp" cssStyle="width:472px;height:60px;" rows="3" /></td>
				</tr>
				<tr>
					<td align="right" >培训经历：</td>
					<td><s:textarea name="model.trainExp" cssStyle="width:472px;height:60px;" rows="3" /></td>
				</tr>
				<tr>
					<td align="right" >再教经历：</td>
					<td><s:textarea name="model.reEducationExp"
						cssStyle="width:472px;height:60px;" rows="3" /></td>
				</tr>
				<tr>
					<td align="right" >企业表现：</td>
					<td><s:textarea name="model.companyRep" cssStyle="width:472px;height:60px;" rows="3" /></td>
				</tr>
				<tr>
					<td align="right">所获证书：</td>
					<td>
						<table>
						  <tr>
						    <td><input type="file" id="systop_upload" />&nbsp;</td>
						    <td><span style="color: #EB2A03">附件大小在30M以内!</span></td>
						  </tr>
						</table>
						<div id="custom">
						</div>
						<div id="systop-uploaded-files" style="width: 800px; border-bottom: 1px solid #C3C3C3;">
							<s:hidden id="fileAttchIds" name="model.fileAttchIds" />
						</div>
						<div id="systop_file_list"></div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<span style="color: green;">附件中请上传毕业证、身份证、职称等相关证件。</span>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		 <tr>
			<td>
				<div align="left" style="margin-top: 5px;padding-left:270px;"><input type="submit"
				value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp; <input
				type="reset" value="重置" class="button"></div><br>
			</td>
		</tr>
	</table>
	<br>
</s:form></div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
		initInsurance();
		$.each($('input[name="insurancePram"]'), function(i) {
			this.onchange=function(){
				insurancePramChange(this);
			};
		});
	});
	// 保险复选框 onchange事件
	function insurancePramChange(insurancePram){
		var pram = insurancePram.value;
		// 保险
		var insurance = $('#insurance');
		insurance.val(insurance.val().replace(pram + "," , ""));
		
		if(insurancePram.checked){
			insurance.val(insurance.val() + pram + ",");
		}
	}
	/**
	 * 初始化标签
	 */
	function initInsurance(){
		var insurance = $('#insurance').val().split(",");
		$.each(insurance, function(i, n) {
			$.each($('input[name="insurancePram"]'), function(i) {
				if(n == this.value){
					$(this).attr("checked", true);
				}
			});
		});
	}
	//渲染上传组件
	renderUploader(true, fileType, fileDesc, 30240000);
</script>
<s:if test="model.id != null">
	<script type="text/javascript">
		viewFileAttchList('${model.fileAttchIds}', true);
	</script>
</s:if>
</body>
</html>
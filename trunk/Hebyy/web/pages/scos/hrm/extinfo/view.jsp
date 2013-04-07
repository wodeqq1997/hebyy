<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>员工企业档案信息</title>
<%@include file="/common/meta.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<style type="text/css">
.title {
	border-bottom: 1px solid #99BBE8;
	font-size: 13px;
	font-weight: bold;
	color: #15428b;
}
</style>
</head>
<body>
<div class="x-panel" >
<div class="x-panel-header">员工企业档案信息</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center">
	<s:hidden name="model.id" />
	<fieldset style="width: 50%; padding:10px 10px 10px 10px;">
	<legend>员工企业档案信息</legend>
	<table width="100%" align="left">
		<tr>
			<td align="left" width="150">员工姓名：
			    ${model.user.name}
			</td>
		</tr>
		<tr>
			<td align="left" width="150" >所属部门：
			    ${model.user.dept.name}
			</td>
			</tr>
		<tr>
			<td align="left" width="150">员工性别：
			    <s:if test='#attr.model.user.sex =="F"'>女</s:if>
			    <s:if test='#attr.model.user.sex =="M"'>男</s:if>
			</td>
		</tr>
		 <tr>
			<td align="left" width="150">个人职称：
				${model.technical}
			</td>
		</tr>
		  <tr>
				<td align="left"  width="150">获得证书：
				${model.certificate}
			</td>
        </tr>
		 <tr>
			<td align="left" width="400">个人爱好：
				${model.hobby}
			</td>
		</tr>
        <tr>
           <td align="left" width="400" colspan="2">
           	奖罚情况：${model.awardPunish} 
			</td>
        </tr>
          <tr>
           <td align="left" width="400" colspan="2">
           	工作经历：${model.workExp} 
			</td>
        </tr>	
       <tr>
           <td align="left" width="400" colspan="2">
           	培训经历：${model.trainExp} 
			</td>
        </tr>	
          <tr>
           <td align="left" width="400" colspan="2">
           	再教育经历：${model.reEducationExp} 
			</td>
        </tr>
            <tr>
           <td align="left" width="400" colspan="2">
           	企业表现：${model.companyRep} 
			</td>
        </tr>
	</table>
	</fieldset>
	<table width="600px" style="margin-bottom: 10px;">
		<tr>
			<td style="text-align: center;">
			  <input type="button" value="返回" onclick="history.go(-1)" class="button"/> 
			</td>
		</tr>
	</table>
</div>
</div>
</body>
</html>
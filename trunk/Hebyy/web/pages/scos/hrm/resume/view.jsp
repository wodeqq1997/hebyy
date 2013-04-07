<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>简历查看</title>
</head>
<body>
<div class="x-panel">
<div class="x-toolbar" style="padding: 5px; font-weight: bold;">查看简历信息</div>
<br>
<table width="800" id="fineTable" align="center">
	<tr>
		<th colspan="4" class="title" align="center">简历基本信息</th>
	</tr>
	<tr>
		<td align="right" width="80">姓名</td>
		<td width="320">${model.name}</td>
		<td align="right" width="80">性别</td>
		<td width="320">
		  ${empty model.sex ? '' : model.sex eq 'M' ? '男':'女'}</td>
	</tr>
	<tr>
		<td align="right">学历</td>
		<td>${model.degree }</td>
		<td align="right">专业</td>
		<td>${model.major }</td>
	</tr>
	<tr>
		<td align="right">籍贯</td>
		<td>${model.jiguan }</td>
		<td align="right">出生年月</td>
		<td><s:date name="model.birthday" format="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<td align="right">毕业院校</td>
		<td>${model.graduatCollege }</td>
		<td align="right">毕业时间</td>
		<td><s:date name="model.graduationTime" format="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<td align="right">户口所在</td>
		<td>${model.hukou }</td>
		<td align="right">档案存放</td>
		<td>${model.archivesAdd }</td>
	</tr>
	<tr>
		<td align="right">联系方式</td>
		<td>${model.mobile }</td>
		<td align="right">邮箱</td>
		<td>${model.email}</td>
	</tr>
	<tr>
		<td align="right">身份证号</td>
		<td>${model.personalId }</td>
		<td align="right">个人爱好</td>
		<td>${model.hobby }</td>
	</tr>
	<tr>
		<td align="right">联系地址</td>
		<td colspan="3">${model.address }</td>
	</tr>
</table>
<table width="800" id="fineTable" align="center">
	<tr>
		<th align="center">简历其他信息&nbsp;</th>
	</tr>
	<tr>
		<td align="center">
			${model.otherExp}
		</td>
	</tr>
</table>
<div align="center" style="margin-top: 5px;">
<input type="button" value="返回管理页" onclick="history.go(-1)" class="button"/> </div>
</div>
</body>
</html>
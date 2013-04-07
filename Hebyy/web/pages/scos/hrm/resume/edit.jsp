<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<%@include file="/common/kindeditor.jsp"%>
<style type="text/css">
	.red{
		color: red;
	}
</style>
<title>编辑简历</title>
</head>
<body>
<div class="x-panel">
	<div class="x-toolbar" style="padding: 5px; font-weight: bold;">编辑简历信息</div>
	<div><%@ include file="/common/messages.jsp"%></div>
	<s:form action="save" id="save" validate="true" method="post" cssStyle="margin:5px auto;">
		<s:hidden name="model.id" id="id" />
		<table width="800" id="fineTable" align="center">
			<tr>
				<th colspan="4" class="title" align="center">简历基本信息</th>
			</tr>
			<tr>
				<td align="right" width="80">姓名</td>
				<td width="320"><s:textfield name="model.name"  cssClass="required"/><span class="red">*</span></td>
				<td align="right" width="80">性别</td>
				<td width="320">
					<s:radio list="%{@com.systop.common.modules.security.user.UserConstants@SEX_MAP}" name="model.sex" cssStyle="border:0px;"/></td>
			</tr>
			<tr>
				<td align="right">学历</td>
				<td><s:textfield name="model.degree"  /></td>
				<td align="right">专业</td>
				<td><s:textfield name="model.major"  /></td>
			</tr>
			<tr>
				<td align="right">籍贯</td>
				<td><s:textfield name="model.jiguan"  /></td>
				<td align="right">出生年月</td>
				<td>
					<input type="text" name="model.birthday" style="width: 242px;" readonly="readonly"
					value='<s:date name="model.birthday" format="yyyy-MM-dd"/>'
					onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate 22" />
				</td>
			</tr>
			<tr>
				<td align="right">毕业院校</td>
				<td><s:textfield name="model.graduatCollege"  /></td>
				<td align="right">毕业时间</td>
				<td><input type="text" name="model.graduationTime" style="width: 242px;"
					readonly="readonly" value='<s:date name="model.graduationTime" format="yyyy-MM-dd"/>'
					onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate 22" />
				</td>
			</tr>
			<tr>
				<td align="right">户口所在</td>
				<td><s:textfield name="model.hukou"  /></td>
				<td align="right">档案存放</td>
				<td><s:textfield name="model.archivesAdd"  /></td>
			</tr>
			<tr>
				<td align="right">联系方式</td>
				<td><s:textfield name="model.mobile"  cssClass="required"/><span class="red">*</span></td>
				<td align="right">邮箱</td>
				<td><s:textfield name="model.email"  /></td>
			</tr>
			<tr>
				<td align="right">身份证号</td>
				<td><s:textfield name="model.personalId"  /></td>
				<td align="right">个人爱好</td>
				<td><s:textfield name="model.hobby"  /></td>
			</tr>
			<tr>
				<td align="right">联系地址</td>
				<td colspan="3"><s:textfield name="model.address" cssStyle="width:600px" /></td>
			</tr>
	</table>
	<table width="800" id="fineTable" align="center">
		<tr>
			<th align="center">简历其他信息&nbsp;</th>
		</tr>
		<tr>
			<td align="center">
				<s:textarea name="model.otherExp" id="otherExp"
				cssStyle="width: 790px; height: 300px; overflow: auto; border: 1px solid #C3c3c3;" />
			</td>
		</tr>
	</table>
	<br />
	<table style="line-height: 25px;" cellpadding="2" cellspacing="0"
		align="center">
		<tr>
			<td>
			<div align="center" style="margin-top: 2px;"><input
				type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" value="重置" class="button"></div>
			</td>
		</tr>
	</table>
	<br />
</s:form></div>
<script type="text/javascript">
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('textarea[name="model.otherExp"]');
		});
		
		$(document).ready(function() {
			$("#save").validate();
		});
</script>
</body>
</html>
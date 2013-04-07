<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<script src="/scripts/jquery/jquery-1.3.2.js"></script>
<script>
	$(function(){
		$('#form1').submit(function(){
			if($.trim($('#title').val()).length==0){
				alert('调查项目不能为空!');
				return false;
			}
            return true;
	});});
</script>
<title>问卷调查项目</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">问卷调查项目</div>
		<div class="x-panel-body">
			<s:form action="save.do" method="post" id="form1" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <s:hidden name="model.survey.id"/>
			  <fieldset>
			    <legend>问卷调查项目</legend>
				<table width="850" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">调查项目：</td>
						<td width="700">
							<s:textfield name="model.title" id="title" maxlength="100" cssStyle="width:500px;"/><span style="color: red">*</span>
							
						</td>
					</tr>
					<tr>
						<td width="100" align="right">调查项目类型：</td>
						<td width="700">
						<s:select list="#{'1':'多选'}" name="model.multiple" headerKey="0" headerValue="单选" />
					</tr>
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="完成" class="button">&nbsp;&nbsp;
				<input type="button" value="取消" class="button" onclick="history.back(-1)">
			  </div>
			</s:form>
		</div>
	</div>
</body>
</html>
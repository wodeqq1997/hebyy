<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>问卷调查项目选项</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">问卷调查项目选项</div>
		<div class="x-panel-body">
			<form action="save.do?surveyId=${surveyId}" method="post" style="margin: 0px;">
			  <s:hidden name="model.surveyItem.id"></s:hidden>
			  <s:hidden name="model.id"></s:hidden>
			  <fieldset>
			    <legend>问卷调查项目选项</legend>
				<table width="850" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">调查项目选项：</td>
						<td width="700">
							<s:textfield name="model.title" id="title" maxlength="100" cssStyle="width:500px;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="完成" class="button">&nbsp;&nbsp;
				<input type="button" value="取消" class="button" onclick="history.back(-1)">
			  </div>
			</form>
		</div>
	</div>
</body>
</html>
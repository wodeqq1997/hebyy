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
				alert('主题不能为空!');
				return false;
			}
			if($.trim($('#title').val()).length==0){
				alert('主题长度不能超过100!');
				return false;
			}
            if($.trim($('#descn').val()).length==0){
				alert('主题介绍不能为空!');
				return false;
			}
            return true;
	});});
</script>
<title>问卷主题</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">问卷主题</div>
		<div class="x-panel-body">
			<form id="form1" action="save.do" method="post" style="margin: 0px;">
			  <fieldset>
			    <legend>问卷主题</legend>
			    <s:hidden name="model.id" />
			    <s:hidden type="hidden" name="model.releaseStatus" />
			    <s:hidden type="hidden" name="model.createDate" />
				<table width="850" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">主&nbsp;题：</td>
						<td width="700">
							<s:textfield name="model.title" id="title" maxlength="100" cssStyle="width:500px;"/>&nbsp;<span style="color: red">*</span>
						</td>
					</tr>
					<tr>
						<td width="100" align="right">主题介绍：</td>
						<td width="700">
							<s:textfield name="model.descn" id="descn" cssStyle="width:500px;"/>&nbsp;<span style="color: red">*</span>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="完成" class="button">&nbsp;&nbsp;
				<input type="button" value="取消" class="button" onclick="location.href='index.do?showTimeOut=2'">
			  </div>
			</form>
		</div>
	</div>
</body>
</html>
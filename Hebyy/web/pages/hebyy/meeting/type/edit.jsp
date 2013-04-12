<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<title>会议类别编辑页面</title>
</head>
<body>
	<div class="x-header">会议类别编辑页面</div>
		<s:form id="save" method="post" validate="true" action="save.do">
 <fieldset>
			    <legend>基本信息</legend>
				<table border="0" align="center" style="line-height: 30px;width:100%">
					<tr>
						<td align="right">会议类别名称：</td>
						<td width="575"><s:textfield name="model.hyLbMc"   style="width: 280px;"  cssClass="required"  maxlength="255"/>
						<font color="red">*</font>
						 <s:hidden name="model.id" /></td>
				</tr>
				<tr>
					<td align="right">会议类别备注：</td>
					<td><s:textarea name="model.remark"   cssStyle="margin:3px 0px; width: 450px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/></td>
				</tr>
				<tr><td colspan="6" style="border: 0px;" align="center"><%@include file="/pages/common/messages.jsp"%> <input type="submit" class="button" value=" 保 存 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" onclick="javascript:window.location.href='${ctx}/meetingType/index.do';" class="button" value=" 返 回 "></td>
				</tr>
			</table>
 </fieldset>
		</s:form>
	<script type="text/javascript">
	   $(document).ready(function(){
		$("#save").validate();
	    });
	</script>
</body>
</html>
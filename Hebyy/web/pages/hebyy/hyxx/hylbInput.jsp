<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	var URL_CTX = '${ctx}';
</script>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/pages/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<style type="text/css">
td {
	padding: 4px 2px 2px 3px;
}

select {
	border: 1px solid #CCC;
}

textarea {
	padding: 5px;
	width: 520px;
	height: 70px;
}

.td1 {
	text-align: right;
}
</style>
<title>会议类别编辑页面</title>
</head>
<body>
	<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
		当前位置： <span class="r_nav_item">会议类别信息记录</span> <span
			class="r_nav_item">会议类别编辑页面</span>
	</div>
		<s:form id="bmxxForm" method="post" validate="true">
 <fieldset>
			    <legend>基本信息</legend>
				<table border="0" align="center" style="line-height: 30px;width:100%">
		


				<tr>
					<th colspan="6" align="left">基本信息</th>
				</tr>
				
				<tr>

					<td width="125" align="right"><span class="warn">*</span>会议类别名称:</td>
					<td width="575"><input id="pnanme" name="model.hyLbMc"
						value="${model.hyLbMc}" maxlength="255"  style="width: 260px;" > <s:hidden name="model.id" /></td>
						
				</tr>
				<tr>
					<td  align="right">备注:</td>
					<td>
					<s:textarea id="content"  name="model.remark"  cssStyle="width:260px;height: 45px;"/>
					</td>
				</tr>
				<tr>
					<td colspan="6" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/hylb/index.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>
 </fieldset>
		</s:form>


	<script type="text/javascript">
		function jkjsSave() {
			$('#bmxxForm').attr("action", "${ctx}/hylb/jkjsSave.do");
			$('#bmxxForm').submit();
		}
	</script>



</body>
</html>
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
<title>规章制度编辑页面</title>
</head>
<body>
	<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
		当前位置： <span class="r_nav_item">规章制度条例</span> <span
			class="r_nav_item">规章制度编辑页面</span>
	</div>

	<div id="content">
		<s:form id="bmxxForm" method="post" validate="true">

			<table id="fineTable" width="780">


				<tr>
					<th colspan="6" align="left">基本信息</th>
				</tr>
				
				<tr>
					<td class="td1"><span class="warn">*</span> 章程目录</td>
					<td><s:select name="model.zcml" list='names'
							cssStyle="width:660px;" headerKey="" headerValue="请选择" /></td>

				</tr>
				
				
				<tr>
					<td class="td1"><span class="warn">*</span> 规章制度内容</td>
					<td>
					<s:textarea id="hynr" name="model.zdContent"  cssStyle="width:660px;height: 185px;"/>
					<s:hidden name="model.id" />
					</td>
				</tr>

				<tr>
					<td colspan="6" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/gzzd/queryxx.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>

		</s:form>

	</div>
	<script type="text/javascript">
		function jkjsSave() {
			
			var strNr = $("#hynr").val();

			if (strNr == null || strNr.length == 0) {
				alert("请填写规章制度内容！");
				return;
			}
			
			
		
			
			
			$('#bmxxForm').attr("action", "${ctx}/gzzd/jkjsSave.do");
			$('#bmxxForm').submit();
		}
	</script>
</body>
</html>
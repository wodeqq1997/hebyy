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
<title>图书类别编辑页面</title>
</head>
<body>
	<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
		当前位置： <span class="r_nav_item">图书类别</span> <span
			class="r_nav_item">图书类别编辑页面</span>
	</div>

	<div id="content">
		<s:form id="bmxxForm" method="post" validate="true">

			<table id="fineTable" width="780">


				<tr>
					<th colspan="6" align="left">基本信息</th>
				</tr>
				
				
				<tr>
					<td class="td1"><span class="warn">*</span> 图书类别名称</td>
					<td><s:hidden name="model.id" />
					
					 <input id="tslb" name="model.lbMc" value="${model.lbMc}" style="width:380px;height:22px;"> &nbsp;&nbsp;&nbsp;&nbsp;  
				
					</td>

				</tr>
				<tr>
					<td class="td1" > 图书类别备注</td>  
					<td>
					
					<input style="width:650px; height:22px;" name="model.descn" value="${model.descn}">
					</td>

				</tr>

				<tr>
					<td colspan="6" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/lbxx/queryxx.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>

		</s:form>

	</div>
	<script type="text/javascript">
		function jkjsSave() {
			
			var strNr = $("#tslb").val();

			if (strNr == null || strNr.length == 0) {
				alert("请填写图书类别名称！");
				return;
			}
		
			
			
			$('#bmxxForm').attr("action", "${ctx}/lbxx/lbsave.do");
			$('#bmxxForm').submit();
		}
	</script>
</body>
</html>
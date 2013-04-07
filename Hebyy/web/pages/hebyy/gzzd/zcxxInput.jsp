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
<title>章程目录编辑页面</title>
</head>
<body>
	<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
		当前位置： <span class="r_nav_item">章程目录</span> <span
			class="r_nav_item">章程目录编辑页面</span>
	</div>

	<div id="content">
		<s:form id="bmxxForm" method="post" validate="true">

			<table id="fineTable" width="780">


				<tr>
					<th colspan="6" align="left">基本信息</th>
				</tr>
				
				
				
				
				<tr>
					<td class="td1"><span class="warn">*</span> 章程目录序号</td>
					<td><s:hidden name="model.id" />
					<s:if test='#attr.model.id == 0 || #attr.model.id == null'>
					
					第&nbsp;  <input id="hynr" name="model.zcxh" value="${model.zcxh}" style="width:20px; height:18px;"> &nbsp;章&nbsp;&nbsp;&nbsp;&nbsp;  
					</s:if>
					<s:if test='#attr.model.id != 0 &&#attr.model.id != null'>
					
					&nbsp;  <input id="hynr" name="model.zcxh" value="${model.zcxh}" style="width:125px; height:18px;"> &nbsp;&nbsp;&nbsp;&nbsp;  
					</s:if>
					</td>

				</tr>
				<tr>
					<td class="td1" ><span class="warn">*</span> 章程目录名称</td>  
					<td>
					
					<input id="hynr1" style="width:650px; height:18px;" name="model.zcMc" value="${model.zcMc}">
					</td>

				</tr>

				<tr>
					<td colspan="6" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/zcxx/queryxx.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>

		</s:form>

	</div>
	<script type="text/javascript">
		function jkjsSave() {
			
			var strNr = $("#hynr").val();

			if (strNr == null || strNr.length == 0) {
				alert("请填写章程目录编号！");
				return;
			}
			var strNr1 = $("#hynr1").val();

			if (strNr1 == null || strNr1.length == 0) {
				alert("请填写章程目录名称！");
				return;
			}
			
			
			$('#bmxxForm').attr("action", "${ctx}/zcxx/zcsave.do");
			$('#bmxxForm').submit();
		}
	</script>
</body>
</html>
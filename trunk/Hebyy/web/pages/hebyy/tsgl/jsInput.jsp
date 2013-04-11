<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>

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
<title>借书信息页面</title>
</head>
<body onload="CurentTime()">
<div class="x-panel-header">
	<div style="float: left;">借书信息页面</div>
	</div>
	<div id="content">
		<s:form id="save" method="post" validate="true">
 <fieldset>
 <legend>基本信息</legend>
		<table border="0" align="center" style="line-height: 30px;width:100%">

		<tr>
					<td align="right"> 图书名称：</td>
					<td width="575"><input id="sm" name="model.tsMc" disabled
						value="${model.tsMc}" style="width:280px; "> </td>

				</tr>
				<tr>
					<td align="right"> 图书作者：</td>
					<td ><input id="zz" name="model.author" disabled
						value="${model.author}" style="width:280px;"> </td>
				</tr>
				<tr>
					<td align="right">借 书 人：</td>
					<td ><input id="jsr" name="jsr" onclick="showAuditUser();" 
						 style="width:280px;"  class="required" readonly="readonly" >
				       <font color="red">*</font>
						 <input type="hidden" id="jsrId" name="jsrId" />
						 </td>
				</tr>		
				<tr>
					<td align="right">借阅时间：</td>
					<td ><input type="text" id="jytime"  name="jytime" style="width:280px; " readonly="readonly" 
							value=""   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" / > </td>

				</tr>
				<tr>
					<td align="right">备注信息：</td>
					<td>
					<s:textarea id="bzxx" name="bzxx"  cssStyle="width:280px;height: 45px;"/>
					<s:hidden name="model.id" />
					</td>
				</tr>

				<tr>
					<td colspan="6" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/tsgl/queryxx1.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>
			 </fieldset>

		</s:form>

	</div>
	<script type="text/javascript">
	
	$(document).ready(function() {
		$("#save").validate();
	});
	/**
	 * 选择显示用户 
	 */
	function showAuditUser() {
      openSel(returnAction);
	}

    function returnAction(users)
    {
    	// alert(users[0].id);
    	 $("#jsr").val(users[0].name);
    	 $("#jsrId").val(users[0].id);
    }
	
		function jkjsSave() {
			$('#save').attr("action", "${ctx}/tsgl/js.do");
			$('#save').submit();
		}
		
		function CurentTime()
	    { 
	        var now = new Date();
	        var year = now.getFullYear();       //年
	        var month = now.getMonth() + 1;     //月
	        var day = now.getDate();            //日
	        var clock=year + "-";
	        if(month < 10){
	            clock += "0";
	        }
	        clock += month + "-";
	        if(day < 10){
	            clock += "0";
	        }
	        clock += day ;
	        
	       // alert(clock);
	    	var jytime = $("#jytime").val();
	        $("#jytime").val(clock);
	        
	        
	    } 

	</script>
</body>
</html>
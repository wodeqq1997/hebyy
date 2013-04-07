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
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
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
<title>还书信息页面</title>
</head>
<body onload="CurentTime()">
<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
当前位置： <span class="r_nav_item">借书还书管理</span> <span class="r_nav_item">还书信息页面</span>
</div>

<div id="content">

<fieldset><legend>基本信息</legend>
<table border="0" align="center" style="line-height: 30px; width: 100%">
	<s:form id="bmxxForm" method="post" validate="true">
		<tr>
			<td width="125" align="right"><span class="warn">*</span> 图书名称:</td>
			<td width="575"><input name="model.bookMc" value="${model.bookMc}"
				style="width: 280px;" disabled></td>
		</tr>
		<tr>
			<td align="right"><span class="warn">*</span> 图书作者:</td>
			<td><input name="zz" value="${zz}" style="width: 280px;" disabled>
			</td>
		</tr>
		<tr>
			<td align="right"><span class="warn">*</span> 还 书 人:</td>
			<td><input id="hsr" name="model.hsr"  style="width: 280px;">
		
			<input
				type="hidden" value="${model.jsr}" name="model.jsr"  id="jsr" />
			</td>
		</tr>
		<tr>
			<td align="right"><span class="warn">*</span> 还书时间：</td>
			<td><input type="text" id="hstime" name="model.hsTime" style="width: 280px;"
				readonly="readonly" onClick="WdatePicker({skin:'blueFresh'})"
				class="Wdate" /></td>

		</tr>
		<tr>
			<td align="right">备注信息：</td>
			<td><s:textarea name="model.hsbz"
				cssStyle="width:280px;height: 45px;" /> <input type="hidden"
				value="${bookid}" name="model.bookId" id="bookid" /> <input
				type="hidden" value="${model.id}" name="model.id" id="ids" /></td>
		</tr>

		<tr>
			<td colspan="6" style="border: 0px;" align="center"><%@include
				file="/pages/common/messages.jsp"%> <input
				type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;<input type="button"
				onclick="javascript:window.location.href='${ctx}/jhs/queryxx.do';"
				class="button" value=" 返 回 "></td>

		</tr>
	</s:form>
</table>
</fieldset>



</div>
<script type="text/javascript">
	function jkjsSave() {

		var hsr = $("#hsr").val();
		if (hsr == null || hsr.length == 0) {
			alert("请填写还书人姓名！");
			return;
		}
	
		var hstime = $("#hstime").val();
		if (hstime == null || hstime.length == 0) {
			alert("请填写还书时间！");
			return;
		}
		
		$('#bmxxForm').attr("action", "${ctx}/jhs/hs.do");
		$('#bmxxForm').submit();
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
        
     
        $("#hstime").val(clock);//默认还书时间为当前日期
        var jyr = $("#jsr").val();
        $("#hsr").val(jyr);//默认还书人为借书人
        
    } 


</script>
</body>
</html>
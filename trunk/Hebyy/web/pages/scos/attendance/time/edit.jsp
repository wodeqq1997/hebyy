<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>考勤时间设置</title>
<script type="text/javascript">
</script>
    <style>
        input {
        	width : 30px;
        }
        td{
        	text-align: center;
        }
    </style>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
	<div style="float: left;">考勤时间设置</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
<s:form action="save" id="save" validate="true" method="POST">
<s:hidden name="#attr.time.id" id="id"/>
	<table id="fineTable" width="300" style="margin-left: 0px;margin-top: 0px">
		<tr>
			<th>上午上班</th>
			<th>上午下班</th>
			<th>下午上班</th>
			<th>下午下班</th>
		</tr>
		<tr>
			<td><input type="text" name="morWorkH" id="morWorkH" class="number required">:<input type="text" name="morWorkM" id="morWorkM"class="number required"></td>
			<td><input type="text" name="morOverH" id="morOverH"class="number required">:<input type="text" name="morOverM" id="morOverM"class="number required"></td>
			<td><input type="text" name="aftWorkH" id="aftWorkH"class="number required">:<input type="text" name="aftWorkM" id="aftWorkM"class="number required"></td>
			<td><input type="text" name="aftOverH" id="aftOverH"class="number required">:<input type="text" name="aftOverM" id="aftOverM"class="number required"></td>
		</tr>
	</table>
	<input type="button" class="button" value="保存" onclick="sub()">
</s:form>
</div>
</div>
</body>
<script type="text/javascript">
function sub(){
	var morWork = $("#morWorkH").val() +":" +$("#morWorkM").val();
	var morOver = $("#morOverH").val() +":" +$("#morOverM").val();
	var aftWork = $("#aftWorkH").val() +":" +$("#aftWorkM").val();
	var aftOver = $("#aftOverH").val() +":" +$("#aftOverM").val();
	window.location.href="${ctx}/time/save.do?id="+$("#id").val()+"&morWork="+morWork+"&morOver="+morOver+"&afWork="+aftWork+"&afOver="+aftOver;
}
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#save").validate();
});
window.onload=setVal;
	function setVal(){
		var morWork = "${time.morWork}";
		var morOver = "${time.morOver}";
		var aftWork = "${time.afWork}";
		var aftOver = "${time.afOver}";
		var morW = morWork.split(":");
		var morO = morOver.split(":");
		var aftW = aftWork.split(":");
		var aftO = aftOver.split(":");
		$("#morWorkH").val(morW[0]);
		$("#morWorkM").val(morW[1]);
		$("#morOverH").val(morO[0]);
		$("#morOverM").val(morO[1]);
		$("#aftWorkH").val(aftW[0]);
		$("#aftWorkM").val(aftW[1]);
		$("#aftOverH").val(aftO[0]);
		$("#aftOverM").val(aftO[1]);
	}

</script>
</html>
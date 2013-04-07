<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/jquery/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
<title>考勤管理</title>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
	<div style="float: left;">考勤管理</div>
</div>
<div align="center" style="width: 100%">
<s:form action="save.do" id="save" validate="true" method="POST">
	<s:hidden name="model.id" />
	<table width="1100" id="fineTable" cellpadding="0" cellspacing="0" align="center" style="margin-bottom:10px;table-layout: fixed;">
		<tr>
			<th colspan="7" style="margin:0 auto;font-weight:700;height: 22px;">员工考勤 （只需要上报本部门当天的请假，迟到及旷工员工。）</th>
			<th>
				<input id="date" name="model.date" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" style="height: 20px;" value="<fmt:formatDate value="<%=new Date()%>" pattern="yyyy-MM-dd"/>"/>
				<span id="attendanceDateDescn"></span>
			</th>
		</tr>
		<tr class="title">
			<th width="90" align="center">No.</th>
			<th width="110" align="center">姓名</th>
			<th width="100" align="center">病假天数</th>
			<th width="100" align="center">事假天数</th>
			<th width="100" align="center">迟到次数</th>
			<th width="100" align="center">旷工次数</th>
			<th width="250" align="center">备注</th>
			<th style="text-align: left">　<input type="button" class="button" value="添加员工" onclick="addRow()"></th>
		</tr>
		<tbody id="tbody">
		<tr class="title" style="display: none">
			<td width="90" align="center">1</td>
			<td width="110" align="center">
				<input type="text" id="auditorName" onclick="showUser(this)" readonly="readonly"/>
				<input type="hidden" id="auditor" name="auditor">
			</td>
			<td width="100" align="center"><input type="text" name="diseaseDays" value="0" class="required number"/></td>
			<td width="100" align="center"><input type="text" name="leaveDays" value="0" class="required number"/></td>
			<td width="100" align="center"><input type="text" name="lateCounts" value="0" class="required digits"/></td>
			<td width="100" align="center"><input type="text" name="absentCounts" value="0" class="required digits"/></td>
			<td width="250" align="center"><input type="text" name="marks" style="size: 190"></td>
			<td width="100" align="center">
				<input type="button" class="button" value="删除科目" onclick="removeRow(this,'')"/>
			</td>
		</tr>
		</tbody>
	</table>
	<table width="100%" style="margin-bottom: 10px;">
		<tr>
			<td align="center" class="font_white">
				<input type="submit" value="保存" class="button" />&nbsp;&nbsp;
			</td>
		</tr>
	</table>
</s:form>
</div>
</div>
<script type="text/javascript">
	/** ready */
	$(document).ready(function() {
		$("#save").validate();
	});

	
	$(function(){
		$.validator.addMethod("Wdate", function(value, element) {
			var res = "";
			if (value == null || value.length == 0) {
				res = "err";
				$("#attendanceDateDescn").html("<font color='red'>考勤月份不能为空</font>");
			}else {
				$("#attendanceDateDescn").html("");
			}
			return res != "err";
		}, "");
	});
	
	/**
	 * 增加一行
	 */
	 function addRow(){
	 	var root = document.getElementById("tbody");
	 	var allRows = root.getElementsByTagName('tr');
	 	var cRow = allRows[0].cloneNode(true);
	 	cRow.style.display="";
	 	root.appendChild(cRow);
	 	var rows = root.rows.length ;
	 	var cTd = cRow.getElementsByTagName('td');
	 	cTd[0].childNodes[0].nodeValue = rows - 1; 
	 }
	/**
	 * 删除一行
	 */
	function removeRow(delInput,id)
	{
		var r = delInput.parentNode.parentNode;
		
		var root = document.getElementById("tbody");
		var allRows = root.getElementsByTagName('tr');
		if (!confirm("确认要删除该员工考勤吗?")){
			return;
		}
		if(!id){
			var root = r.parentNode;
			root.removeChild(r);
			for(var i = 0; i < root.childNodes.length; i++){
				var cTd =  root.childNodes[i].getElementsByTagName('td');
				cTd[0].childNodes[0].nodeValue = i;
			}
		}else{
			window.location.href=URL_PREFIX+"/workload/kc/detail/remove.do?model.id=" + id;
		}
	}
	
	/**
	 * 选择用户 
	 */
	function showUser(obj) {
	    openSel(function (users) {
	        var selectNames = "";
	        var selectIds = "";
	        if (users.length > 0) {
	            if (users.length > 1) {
	                alert("只能选择一个，默认为第一个选项！");
	            }
	            selectNames = users[0].name;
	            selectIds = users[0].id;
	        }
	        $(obj).val(selectNames);
	        $(obj).next().val(selectIds);
	    },true);
	}
</script>
</body>
</html>
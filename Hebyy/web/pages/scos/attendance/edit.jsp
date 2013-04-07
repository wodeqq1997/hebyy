<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/extjs.jsp" %>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/jquery/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>考勤管理</title>
<script type="text/javascript">
//<s:if test="model.id == null">
var rootName = '河北演艺集团';
var dtree;
Ext.onReady(function() {
	//var deptId = $('#deptId').val();
	var initValue = '${model.dept.name}';
	if (initValue.length == 0) {
		initValue = rootName;
	}
	dtree = new DeptTree({
		url : '${ctx}/admin/dept/deptTree.do',
		rootName : rootName,
		initValue : initValue ,
		el : 'comboxWithTree',
		innerTree : 'inner-tree',
		onclick : function(nodeId) {
			Ext.get('deptId').dom.value = nodeId;
		}
	});
	dtree.init();
});
//</s:if>
</script>
    <style>
        .label-th{
            text-align: center;
            width: 55px;
        }
        .item-tr input{
            width: 98%;
        }
    </style>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
	<div style="float: left;">考勤管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
<s:form action="save" id="save" validate="true" method="POST">
	<s:hidden name="model.id" />
	<table width="700" id="fineTable" cellpadding="0" cellspacing="0" align="center" style="margin-top: 20px;">
		<tr>
			<th colspan="2" style="margin:0 auto;text-align:center;font-weight:700;height: 22px;" >考勤信息</th>
		</tr>
		<tr height="30">
			<td width="200" align="right">
				部门：
			</td>
			<td width="500" class="simple" align="left" valign="bottom">
				<input type="hidden" id="deptId" name="model.dept.id" class="dept" value="${model.dept.id}" />
				<s:if test="model.id != null">
					&nbsp;${model.dept.name}
				</s:if>
				<s:else>
					<table cellpadding="0" cellspacing="0" style="border: 0px;">
						<tr style="border: 0px;">
							<td style="border: 0px;">
								<div id='comboxWithTree'></div>
							</td>
							<td style="border: 0px;">
								<span id="deptmsg" class="warn"></span>
								<span id="deptIdDescn"></span><font color="red">&nbsp;*</font>
							</td>
						</tr>
					</table>
				</s:else>
		    </td>
		</tr>
		<tr>
			<td align="right">
				月份：
			</td>
			<td align="left">
				<input id="attendanceDate" name="model.attendanceDate" style="width:197px;" onfocus="WdatePicker({maxDate:'%y-%M',skin:'blueFresh',dateFmt:'yyyy-MM'})" value='<s:date name="model.attendanceDate" format="yyyy-MM"/>' class="Wdate" readonly="readonly" />
				<span id="attendanceDateDescn"></span>
				<font color="red">*</font>
		    </td>
		</tr>
		<tr>
			<td align="right">应出勤天数：</td>
			<td align="left">
				<s:textfield id="shouldDays" name="model.shouldDays" cssStyle="width:197px;" cssClass="{required:true,number:true,min:0,max:31}"/>
				<font color="red">*</font>
			</td>
		</tr>
	</table>
	<s:if test="model.id == null">
	<table align="center" width="700">
		<tr>
			<td>
				<div align="right">
						<input name="button" class="button" type="button" value="添加员工" onclick="addPerson()">
				</div>
			</td>
		</tr>
	</table>
	</s:if>
	<table id="fineTable" cellpadding="0" cellspacing="0" style="margin-bottom:10px;width: 700px;">
		<tr>
			<th colspan="10" style="margin:0 auto;font-weight:700;height: 22px;">员工考勤</th>
		</tr>
		<tr class="title">
			<th class="label-th" style="width: 25px">No.</th>
			<th class="label-th" style="width: 75px;">姓名</th>
			<th class="label-th" style="width: 75px;">实际出勤天数</th>
            <th class="label-th">外业天数</th>
            <th class="label-th">内业天数</th>
			<th class="label-th" >病假天数</th>
			<th  class="label-th">事假天数</th>
			<th  class="label-th">迟到次数</th>
			<th  class="label-th">旷工次数</th>
            <th>备注</th>
		</tr>
		<s:iterator value="model.items" var="item">
			<input type="hidden" name="itemIds" value="${item.id}"/>
		<tr class="item-tr">
			<td align="center">${item.person.id}<input type="hidden" name="personIds" value="${item.person.id}"/></td>
			<td align="center">${item.person.name}</td>
			<td><input name="actualDays" value="${item.actualDays}" type="text" style="" class="required number"/></td>
			<td><input name="outDays" value="${item.outDays}" type="text" style="" class="number"/></td>
			<td><input name="inDays" value="${item.inDays}" type="text" style="" class="number"/></td>
			<td><input name="diseaseDays" value="${item.diseaseDays}" type="text" style="" class="required number"/></td>
			<td><input name="leaveDays" value="${item.leaveDays}" type="text" style="" class="required number"/></td>
			<td><input name="lateCounts" value="${item.lateCount}" type="text" style="" class="required digits"/></td>
			<td><input name="absentCounts" value="${item.absentCount}" type="text" style="" class="required digits"/></td>
            <td>
                <input type="text" name="remark" value="${item.remark}"/>
            </td>
		</tr>
		</s:iterator>
		<s:if test="model.items.size == 0">
			<tr>
				<td align="center" colspan="10" bgcolor="#ffe3ee">无员工信息</td>
			</tr>
		</s:if>
	</table>
	<table width="100%" style="margin-bottom: 10px;">
		<tr>
			<td align="center" class="font_white">
				<s:if test="model.items.size == 0">
					<input type="button" value="保存" class="button" onclick="alert('该部门下没有员工，无法保存');"/>&nbsp;&nbsp;
				</s:if>
				<s:else>
					<input type="button" value="保存" class="button" onclick="saveyz()"/>&nbsp;&nbsp;
				</s:else>
<input type="button"
				onclick="javascript:window.location.href='${ctx}/attendance/index.do';"
				class="button" value="返回 ">			
&nbsp;&nbsp;
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
		$.validator.addMethod("dept", function(value, element) {
			var res = "";
			if (value == null || value.length == 0) {
				res = "err";
				$("#deptIdDescn").html("<font color='red'>请选择部门</font>");
			}else {
				$("#deptIdDescn").html("");
			}
			return res != "err";
		}, "");
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
	* 添加员工
	*/
	function addPerson(){
		var deptId = $('#deptId').val();
		var attendanceDate = $('#attendanceDate').val();
		if(!deptId){
			alert('部门不允许为空');
			return;
		}
		if(!attendanceDate){
			alert('月份不允许为空');
			return;
		}
		$.ajax({
			url : URL_PREFIX+"/attendance/isAttendance.do",
			type : "POST",
			data : {
				"model.attendanceDate" : attendanceDate,
				"model.dept.id" :  deptId
			},
			dataType : "json",
			success : function(result) {
				//如果执行成功，得到合同额
				if (result.success) {
					formReset();
					alert('该部门'+attendanceDate+'月份考勤已存在');
				}else{
					showPerson();
				}
				if(result.error){
					alert('发生异常');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest + "@@" + textStatus + "@@@" + errorThrown);//"发生异常，请与管理员联系！",
				return false;
			}
		});
	}
	/**
	 * 显示部门下的员工
	 */
	function showPerson(){
		$('#save').attr('action', '${ctx}/attendance/showPerson.do');
		$('#save').submit();
	}
	/**
	* 保存提交
	*/
	function saveyz(){
		$("input[name='actualDays']").each(function(i){
			if(!$(this).val()){
				alert('实际出勤天数不允许为空！');
				$(this).focus();
				return false;
			}
		});
		
		$('#save').attr('action', '${ctx}/attendance/save.do');
		$('#save').submit();
	}
	/**
	* 重置
	*/
	function formReset(){
		$("#save")[0].reset();
		var initValue = '${model.dept.name}';
		if (initValue.length == 0) {
			initValue = rootName;
		}
		dtree.comboxWithTree.setValue(initValue);
	}
</script>
</body>
</html>
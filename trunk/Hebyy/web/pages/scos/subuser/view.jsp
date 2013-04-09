<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>添加下属</title>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/ec.jsp"%>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">下属关系</div>
	<div><%@ include file="/common/messages.jsp"%></div>
	<div class="x-panel-body" align="center">
		<br><br>
        <c:if test="${model.status ne '2'}">
            <div style="text-align: center">已经完成操作</div>
        </c:if>
        <c:if test="${model.status eq '2'}">
		<table width="500" id="finetable" style="line-height: 30px; margin: 50px auto;">
		  <tr>
		  	<th colspan="2">
		  		<s:property value="model.owner.name"/>
		  		【所属部门:<s:property value="model.owner.dept.name"/>】
		  		【职位:<s:property value="model.owner.position.name"/>】将你添加为下属<br>
		  	</th>
		  </tr>
		  <tr>
		  	<td width="200" align="right">如果你同意请点击</td>
		  	<td width="300"> <input type="button" class="button" value="确认" onclick="submitForm('1')"></td>
		  </tr>
		  <tr>
		  	<td align="right">如果你不同意请点击</td>
		  	<td><input type="button" class="button" value="拒绝" onclick="submitForm('0')"></td>
		  </tr>
		</table>
        </c:if>
    </div>
	<form id="confirmFrom" action="subUserConfirm.do" method="post">
		<s:hidden name="model.id"/>
		<s:hidden name="model.status" id="status"/>
	</form>
	
	<script type="text/javascript">
		function submitForm(status){
			document.getElementById("status").value = status;
			document.getElementById("confirmFrom").submit();
		}
	</script>
</div>
</body>
</html>
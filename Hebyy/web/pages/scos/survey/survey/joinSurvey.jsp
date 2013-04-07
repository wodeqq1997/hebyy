<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>问卷调查</title>
<style>
.noborder {
	border: 0px;
}
</style>
<script>
	$(function() {
		$('#form1').submit(function() {
			var number = 0;
			var stop;
			$("table").each(function() {
				var checkbox = false;
				var radio = false;
				stop = false;
				$(this).find("input[type=radio]").each(function() {
					if ($(this).attr("checked")) {
						radio = true;
						return false;
					}
				});
				if (!radio) {
					$(this).find("input[type=checkbox]").each(function() {
						if ($(this).attr("checked")) {
							checkbox = true;
							return false;
						}
					});
				}
				number = number + 1;
				if (!(checkbox || radio)) {
					stop = true;
					alert('请完成第' + number + '道题目!');
					return false;
				}
				i++;
			});
			if (stop == true) {
				return false;
			}
			i++;
		});
	});
	function getValue(){
		var s = document.getElementsByTagName("input");
		var options=new Array();
		for(i=0;i<s.length;i++){
			if(s[i].checked) {
				options.push(s[i].value);
			}
		}
		var values=options.join(",");
		$('#selectedSubitemId').val(values);
	}	
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">&nbsp;问卷调查</div>
<div class="x-panel-body">
	<s:iterator value="model.surveyItems" var="item" status="st">
		<table width="800" align="center">
			<tr>
				<td style="border-bottom: 1px dotted #99bbe8; padding-left: 10px;">
				${st.index + 1}.${item.title}</td>
			</tr>
			<tr>
				<td style="padding-left: 20px;">
  					<s:iterator value="#attr.item.subitems" id="subitem">
						<s:if test='#attr.item.multiple=="0"'>
							<input type="radio" value="${subitem.id}" name="${item.id}" class="noborder">
							${subitem.title}<br>
						</s:if>
						<s:else>
							<input type="checkbox" value="${subitem.id}" class="noborder">
							${subitem.title}<br>
						</s:else>
					</s:iterator>
				</td>
			</tr>
		</table>
	</s:iterator>
	<br>
	<div align="center">
		<form action="${ctx}/survey/subitem/vote.do" method="post" id = "form1">
			<input type="submit" value="提交问卷" class="button" onclick="getValue();">&nbsp;&nbsp; 
			<input type="hidden" name="selectedSubitemId" id="selectedSubitemId">
			<input type="hidden" value="${model.id}" name="surveyId" id="surveyId">
		</form>
	</div>
</div>
</div>
</body>
</html>
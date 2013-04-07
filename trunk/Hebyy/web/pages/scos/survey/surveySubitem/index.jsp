<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript">
function remove(id) {
		if(confirm("确认要删除该选项?")) {
			var surveyId = document.getElementById("surveyId").value;
			window.location.href = URL_PREFIX+"/survey/subitem/remove.do?model.id=" + id + "&&surveyId=" + surveyId;
		}
}
</script>
<title>问卷调查</title>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">
		<div style="float: left;">问卷调查</div>
		<div style="float: right"></div>
	</div>
	<s:form action="index.do" id="pageQueryForm">
			 <s:hidden name="ec_p" id="ec_p"/>
	</s:form>
	<div class="x-toolbar">
		<table width="99%">
	  	 <tr>
		    <td width="24%" align="right">
		    	<input type="hidden" name="surveyId" id="surveyId" value="${surveyId}">
		    	<a href="edit.do?model.surveyItem.id=${model.surveyItem.id}&&surveyId=${surveyId}"><img src="${ctx}/images/icons/add.gif">&nbsp;新增调查项目选项</a>
		    	<a href="${ctx}/survey/item/index.do?model.survey.id=${surveyId}"><img src="${ctx}/images/icons/add.gif">&nbsp;调查项目页</a>
		    	<a href="${ctx}/survey/index.do"><img src="${ctx}/images/icons/accept.gif">&nbsp;主题页</a>
		    </td>
		 </tr>
	</table>
	</div>
	<div class="x-panel-body">
	
	<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>调查项目选项</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${GLOBALROWCOUNT}</td>
            <td align="center">${item.title}</td>
			<td>
<a href="edit.do?model.id=${item.id}&&surveyId=${surveyId}" title="修改"><img src="${ctx}/images/icons/modify.gif">修改</a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif">删除</a></td></tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;"
			align="right"><%@include file="/pages/common/page.jsp"%>
		</td>
	</tr>
</table>
	</div>
</div>
</body>
</html>
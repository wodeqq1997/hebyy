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
	if(confirm("确认要删除该调查项目以及项目下的选项?")) {
		window.location.href = URL_PREFIX+"/survey/item/remove.do?model.id=" + id ;
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
	<div class="x-toolbar">
	<s:form action="index.do" id="pageQueryForm">
			 <s:hidden name="ec_p" id="ec_p"/>
	</s:form>
		<table width="99%">
	  	 <tr>
		    <td width="24%" align="right">
		    	<a href="edit.do?model.survey.id=${model.survey.id}"><img src="${ctx}/images/icons/add.gif">&nbsp;新增调查项目</a>
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
        <th>调查项目</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${GLOBALROWCOUNT}</td>
            <td align="center">${item.title}</td>
			<td>
<a href="../subitem/index.do?model.surveyItem.id=${item.id}&&surveyId=${model.survey.id}" target="_self"><img src="${ctx}/images/icons/add.gif">&nbsp;</a>
					<a href="edit.do?model.id=${item.id}" title="修改"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a>		</td>
		</tr>
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
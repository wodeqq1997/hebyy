<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>问卷调查</title>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">
		<div style="float: left;">问卷调查</div>
		<div style="float: right"></div>
	</div>
	<div class="x-toolbar">
		<table width="99%">
	  	 <tr>
	       <td width="75%">
			 <s:form action="view.do" id="pageQueryForm">
			 <s:hidden name="ec_p" id="ec_p"/>
			   &nbsp;&nbsp;问卷标题: <s:textfield name="model.title" cssStyle="width:110px;" />
			   &nbsp;&nbsp;<input type="submit" value="查询" class="button" />
			 </s:form>
		    </td>
		 </tr>
	</table>
	</div>
	
	
	
	<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>问卷主题</th>
		<th>问卷描述</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
            <td align="center">${item.title}</td>
			<td>${item.descn}</td>
			<td>
				<a href="joinSurvey.do?model.id=${item.id}">参加调查</a>
				<a href="showResult.do?model.id=${item.id}" target="_blank">查看结果</a>
		</td>
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
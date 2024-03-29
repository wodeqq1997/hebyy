<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>借书还书管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

<div id="r_main">
<div class="x-panel-header">
<div style="float: left;">借书还书记录查询</div>
</div>
<div class="x-toolbar">
<table width="100%" style="margin: 4px 0px;" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="70%"><s:form id="pageQueryForm" action="queryxx1.do"
			cssStyle="margin:auto;" method="post">&nbsp;
				
					书名：<s:textfield name="model.bookMc" maxLength="12" cssStyle="width:100px; height:16px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					借书人：<s:textfield name="model.jsr" maxLength="12" cssStyle="width:100px; height:16px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;						
				          是否归还：<s:select name="model.isgh"  list="{'已归还','未归还'}" headerKey="" headerValue="不限--" />

					<input type="submit" class="button" value=" 查询" style="width: 50px; height: 18px;">&nbsp;&nbsp;
				    <input type="button" onclick="jkjsSave()" class="button" value=" 查询全部" style="width: 70px; height: 18px;">
					<s:hidden name="ec_p" id="ec_p" />
		</s:form></td>
		<td width="80%" align="right">
		<a href="${ctx}/tsgl/queryxx2.do" title="返回"> <img src="${ctx}/images/icons/go.gif">&nbsp;返回</a>
		</td>
	</tr>
</table>
</div>
<div class="x-panel-body">
<div align="right">
<table>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;" align="right"><%@include file="/pages/common/messages.jsp"%></td>
	</tr>
</table>
</div>
<table id="fineTable" width="800">

	<tr>
		<th>序号</th>
		<th width="95">书名</th>
		<th width="60">借阅人</th>
		<th width="78">借阅时间</th>
		<th width="165">借阅备注</th>
		<th width="60">还书人</th>
		<th width="78">还书时间</th>
		<th width="165">还书备注</th>

	</tr>
	<s:iterator value="jhList" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td width="95" align="center">${item.bookMc}</td>
			<td width="60" align="center">${item.jsr}</td>
			<td width="78" align="center"><fmt:formatDate value="${item.jsTime}" pattern="yyyy-MM-dd" /></td>
			<td width="155" align="center">${item.jsbz}</td>
			<td width="60" align="center"><s:if test='#attr.item.hsr == null'>- -</s:if>${item.hsr}</td>
			<td width="78" align="center"><s:if test='#attr.item.hsTime == null'>- -</s:if> <fmt:formatDate value="${item.hsTime}" pattern="yyyy-MM-dd" /></td>
			<td width="165" align="center"><s:if test='#attr.item.hsbz == null'>- -</s:if> ${item.hsbz}</td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>

<script type="text/javascript">
	function jkjsSave() {
		$('#pageQueryForm').attr("action", "${ctx}/jhs/getAllKd1.do");
		$('#pageQueryForm').submit();
	}
</script>

</body>
</html>
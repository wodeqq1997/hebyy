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
<div style="float: left;">借书还书信息查询</div>
</div>
<div class="x-toolbar">
<table width="100%" style="margin: 4px 0px;" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="70%">
		<s:form id="pageQueryForm" action="queryxx1.do" cssStyle="margin:auto;" method="post">&nbsp;
					图书类别：<s:select name="model.lbxx.id" list='typeMap' cssStyle="width:180px;" headerKey="" headerValue="请选择" />	&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;
					书名：<s:textfield name="model.tsMc" maxLength="12" cssStyle="width:100px; height:16px;" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					作者：<s:textfield name="model.author" maxLength="12" cssStyle="width:100px; height:16px;" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;					
						<input type="submit" class="button" value=" 查询" style="width: 50px; height: 18px;">&nbsp; &nbsp;
				   		 <input type="button" onclick="jkjsSave()" class="button" value=" 查询全部" style="width: 70px; height: 18px;">
						<s:hidden name="ec_p" id="ec_p" />
		</s:form>
		</td>
	</tr>
	<tr>
		<td width="80%" align="right"><a href="${ctx}/jhs/queryxx.do" title="归还图书"> <img src="${ctx}/images/icons/down.gif">&nbsp;归还图书</a>&nbsp;&nbsp;</td>
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
		<th width="110">书名</th>
		<th width="75">作者</th>
		<th width="95">图书类别</th>
		<th width="60">总数量</th>
		<th width="65">剩余数量</th>
		<th width="78">入库日期</th>
		<th>图书备注</th>


		<th>操作</th>
	</tr>
	<s:iterator value="items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">

			<td align="center">${st.index + 1}</td>
			<td width="110" align="center"><a href="view.do?model.id=${item.id}" title="查看详情"><font color="blue">${item.tsMc}</font></a></td>
			<td width="75" align="center">${item.author}</td>
			<td width="95" align="center">${item.lbxx.lbMc}</td>
			<td width="60" align="center">${item.totalNum}</td>
			<td width="65" align="center"> <s:if test="#attr.item.syNum == 0"> <font color="red">${item.syNum}</font> </s:if>
			<s:if test="#attr.item.syNum != 0"> ${item.syNum} </s:if> </td>
			<td width="78" align="center"><fmt:formatDate value="${item.rkTime}" pattern="yyyy-MM-dd" /></td>
			<td>${item.descn} <input type="hidden" name="item.lbxx.lbMc" value="${item.lbxx.lbMc}" /></td>
			<td align="center" valign="middle"><s:if test='#attr.item.syNum != 0'> <a href="toJs.do?model.id=${item.id}&&zx=1" title="借阅">借阅</a></s:if>
			 <s:if test='#attr.item.syNum == 0'>
			<a href="javascript:;" title="借阅"><font color="#D4D0C8">借阅</font></a>
			</s:if></td>
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
		$('#pageQueryForm').attr("action", "${ctx}/tsgl/toAll1.do");
		$('#pageQueryForm').submit();
	}
</script>

</body>
</html>
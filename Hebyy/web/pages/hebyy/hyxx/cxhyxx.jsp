<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>会议信息历史记录</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

<div id="r_main">
<div class="x-header" style="border-bottom: 1px solid #99bbe8;"><span
	class="r_nav_item">会议信息历史记录查询</span></div>


<div class="x-toolbar">
<table width="100%" style="margin: 4px 0px;" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="70%"><s:form id="pageQueryForm" action="queryxx1.do"
			cssStyle="margin:auto;" method="post">
					
					会议文件名称：<s:textfield name="model.hyMc" maxLength="12"
				cssStyle="width:100px; height:16px;" />
					&nbsp;会议纪要类别：
					<s:select name="model.hytype" list='names'
							cssStyle="width:100px;" headerKey="" headerValue="请选择" />&nbsp;起止时间：
						<input type="text" name="model.startTime"
				style="width: 90px; height: 16px;" readonly="readonly"
				value='<s:date name="model.startTime" format="yyyy-MM-dd"/>'
				onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
						截止时间：
						<input type="text" name="model.endTime"
				style="width: 90px; height: 16px;" readonly="readonly"
				value='<s:date name="model.endTime" format="yyyy-MM-dd"/>'
				onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
			<s:hidden name="ec_p" id="ec_p" />
			<input type="submit" value="查询" class="button" />
			<input type="button" onclick="jkjsSave()" class="button" style="width: 60px;"  value="查询全部" >
		</s:form></td>
	</tr>

</table>
</div>
<div class="x-panel-body">

<div align="right">
		<table>
		<tr>
					<td colspan="13" style="border: 0px; padding-top: 4px;"
						align="right"><%@include file="/pages/common/messages.jsp"%>
					</td>
				</tr>
		</table>
	</div>	
<table id="fineTable" width="800">
	
	<tr>

		<th>序号</th>
		<th>会议文件名称</th>
		<th>文件号</th>
		<th>文件页/份数</th>
		<th>会议纪要类别</th>
		<th>会议参与人</th>
		<th>会议时间</th>
		<th>备注</th>


	</tr>
	<s:iterator value="items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">

			<td align="center">${st.index + 1}</td>
			<td align="center">${item.hyMc}</td>
			<td align="center">${item.wjh}</td>
			<td align="center">${item.pageNum}</td>
			<td align="center">${item.hytype}</td>
			<td align="center">${item.hycyr}</td>
			<td align="center"><fmt:formatDate value="${item.hyTime}"
				pattern="yyyy-MM-dd" /></td>
			<td align="center">${item.hyContent}</td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>

<script type="text/javascript">
	function jkjsSave() {
		$('#pageQueryForm').attr("action", "${ctx}/hybl/toAll1.do");
		$('#pageQueryForm').submit();
	}
</script>

</body>
</html>
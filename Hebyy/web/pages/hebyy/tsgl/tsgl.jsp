<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>图书管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

<div id="r_main">
<div class="x-header" style="border-bottom: 1px solid #99bbe8;">
<span class="r_nav_item">图书管理查询</span></div>

<div class="x-toolbar">
<table width="100%" style="margin: 4px 0px;" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="70%"><s:form id="pageQueryForm" action="queryxx.do"
			cssStyle="margin:auto;" method="post">&nbsp;
					图书类别：<s:select name="model.lbmc" list='names'
				cssStyle="width:180px;" headerKey="" headerValue="请选择" />	&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;
					书名：<s:textfield name="model.tsMc" maxLength="12"
				cssStyle="width:100px; height:16px;" />
						
						
						
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					作者：<s:textfield name="model.author" maxLength="12"
				cssStyle="width:100px; height:16px;" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;					
						<input type="submit" class="button" value=" 查询"
				style="width: 50px; height: 18px;">&nbsp;
				    &nbsp;
				    <input type="button" onclick="jkjsSave()" class="button"
				value=" 查询全部" style="width: 70px; height: 18px;">

			<s:hidden name="ec_p" id="ec_p" />
		</s:form></td>
	</tr>
	<tr>
		<td width="80%" align="right"><a href="${ctx}/lbxx/queryxx.do"
			title="图书类别管理"> <img src="${ctx}/images/icons/add.gif">&nbsp;图书类别管理</a>
		&nbsp;&nbsp; <a href="toEdit.do?&&zx=0" title="添加图书信息"> <img
			src="${ctx}/images/icons/add.gif">&nbsp;新建</a> &nbsp;&nbsp; <a
			href="javascript:changeUser('pageQueryForm','确认要删除信息吗?');"
			title="删除规章制度条例"> <img
			src="${ctx}/images/icons/delete.gif">删除</a></td>

	</tr>
</table>
</div>
<div class="x-panel-body">
<div align="right">
<table>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;" align="right"><%@include
			file="/pages/common/messages.jsp"%></td>
	</tr>
</table>
</div>
<table id="fineTable" width="800">


	<tr>
		<th width="33">选择</th>
		<th width="100">书名</th>
		<th width="75">作者</th>
		<th width="85">图书类别</th>
		<th width="65">总数量</th>
		<th width="70">剩余数量</th>
		<th width="80">入库日期</th>
		<th width="150">图书备注</th>


		<th>操作</th>
	</tr>
	<s:iterator value="items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td width="33" align="center"><input type="checkbox"
				name="selectedItems" id="selectedItems" value="${item.id}"
				class="checkbox" /></td>
			<td width="100" align="center"><a
				href="view.do?model.id=${item.id}" title="查看详情"><font
				color="blue">${item.tsMc}</font></a></td>
			<td width="75" align="center">${item.author}</td>
			<td width="85" align="center">${item.lbxx.lbMc}
			<td width="65" align="center">${item.totalNum}</td>
			<td width="70" align="center">${item.syNum}</td>
			<td width="80" align="center"><fmt:formatDate
				value="${item.rkTime}" pattern="yyyy-MM-dd" /></td>
			<td width="150" align="center">${item.descn} <input
				type="hidden" name="item.lbxx.lbMc" value="${item.lbxx.lbMc}" /></td>



			<td align="center" valign="middle"><a
				href="toEdit.do?model.id=${item.id}&&zx=1" title="修改图书信息"> <img
				src="${ctx}/images/icons/edit.png"> </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
	function changeUser(formid, msg) {
		var checked = false;
		$('input').each(function(i, item) {
			if (item.checked && item.id == 'selectedItems') {
				checked = true;
			}
		});
		if (!checked) {
			alert('请至少选择一条要删除信息');
			return;
		}

		if (confirm(msg)) {
			var s = null;
			$('input').each(function(i, item) {//循环每一个表单里的input元素
				if (item.checked && item.id == 'selectedItems') {//确定选中的是复选框
					if (s != null) {
						s = s + item.value + ",";
						//	alert(item.value);
					} else {//第一次
						s = item.value + ",";
					}
				}
			});

			// alert(s);
			window.location.href = "delete.do?ids=" + s;
		}
	}

	function jkjsSave() {
		$('#pageQueryForm').attr("action", "${ctx}/tsgl/toAll.do");
		$('#pageQueryForm').submit();
	}
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>规章制度条例</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

<div id="r_main">
      <div class="x-panel-header">
			<div style="float: left;">规章制度条例查询</div>
	    </div>
<div class="x-toolbar">
<table width="100%" style="margin: 4px 0px;" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="70%"><s:form id="pageQueryForm" action="queryxx.do"
			cssStyle="margin:auto;" method="post">&nbsp;
					类别名称：<s:select name="model.zcml" list='names'
				cssStyle="width:280px;" headerKey="" headerValue="请选择" />	&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;
					文件号：<s:textfield name="model.wjh" maxLength="12"
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
		<td width="80%" align="right"><a href="${ctx}/zcxx/queryxx.do"
			title="类别管理"> <img src="${ctx}/images/icons/add.gif">&nbsp;类别管理</a>
		&nbsp;&nbsp; <a href="toEdit.do?&&zx=0" title="添加规章制度条例"> <img
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
		<th width="35">选择</th>
		<th width="150">类别名称</th>
		<th width="120">文件号</th>
		<th width="300">文件名</th>
		<th>操作</th>
	</tr>
	<s:iterator value="items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td width="35" align="center"><input type="checkbox"
				name="selectedItems" id="selectedItems" value="${item.id}"
				class="checkbox" /></td>
			<td width="150" align="center">${item.zcxx.zcMc}</td>
			<td width="120" align="center"><a href="view.do?model.id=${item.id}" title="查看详情"> <font color="blue">${item.wjh}</font></a></td>
			<td width="300" align="left">${item.zdContent} <input
				type="hidden" name="item.zcxx.zcMc" value="${item.zcxx.zcMc}" /></td>
			<td align="center" valign="middle"><a
				href="toEdit.do?model.id=${item.id}&&zx=1" title="修改规章制度条例"> <img
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
			window.location.href = "remove.do?ids=" + s;
		}
	}
</script>
<script type="text/javascript">
	function jkjsSave() {
		$('#pageQueryForm').attr("action", "${ctx}/gzzd/toAll.do");
		$('#pageQueryForm').submit();
	}
</script>

</body>
</html>
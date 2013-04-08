<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>物品管理</title>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除？")) {
			window.location.href = URL_PREFIX + "/goods/remove.do?model.id="
					+ id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">物品</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td style="padding-left: 5px;" width="60%"><s:form
			action="index.do" method="post" id="pageQueryForm">
			<s:hidden name="ec_p" id="ec_p" />
	        	物品名称：<s:textfield id="name" name="model.name" maxlength="40" />
	        	物品类别：<s:select list="goodsTypeMap" name="model.goodsType.id"
				headerKey="" id="goodsTypeId" headerValue="全部"
				cssStyle="width:100px;" />
			<input type="submit" value="查询" class="button" />
		</s:form></td>
		<td width="40%" align="right"><img
			src="${ctx}/images/icons/add.gif"> <a
			href="${ctx}/goods/edit.do">添加物品</a> &nbsp; <img
			src="${ctx}/images/icons/folder.gif" class="icon"> <a
			href="${ctx}/goods/type/index.do">物品类别管理</a> &nbsp; <img
			src="${ctx}/images/icons/folder.gif" class="icon"> <a
			href="${ctx}/goods/instock/index.do">入库单管理</a> &nbsp;</td>
	</tr>
</table>
</div>
<div style="margin: 10px;">
<div>
<table>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;" align="right"><%@include
			file="/pages/common/messages.jsp"%></td>
	</tr>
</table>
</div>
<table id="fineTable" width="800">

	<tr>
		<th>序号</th>
		<th>物品名称</th>
		<th>物品编号</th>
		<th>规格</th>
		<th>计量单位</th>
		<th>库存量</th>
		<th>上限库存量</th>
		<th>下限库存量</th>
		<th>物品类别</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center"><a href="view.do?model.id=${item.id}"
				title="${item.name}" target="_blank"><font color="blue">${item.name}</font></a></td>
			<td align="center">${item.goodsNo }</td>
			<td>${item.specifications}</td>
			<td>${item.unit}</td>
			<td>${item.stockCounts}</td>
			<td>${item.maxCount}</td>
			<td>${item.minCount}</td>
			<td>${item.goodsType.name}</td>
			<td align="center"><a href="edit.do?model.id=${item.id}"
				title="修改"> <img src="${ctx}/images/icons/modify.gif"></a>&nbsp;&nbsp;
			<a href="#" onclick="remove('${item.id}')" title="删除"> <img
				src="${ctx}/images/icons/remove.gif"></a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="10" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>
</body>
</html>
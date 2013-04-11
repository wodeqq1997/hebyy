<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>办公用品领取</title>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除?")) {
			window.location.href = URL_PREFIX
					+ "/goods/instock/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">办公用品领取</div>
</div>
<div class="x-toolbar">
<table width="100%">
	<tr>
		<td width="70%"><s:form action="index.do" method="post"
			id="pageQueryForm">
			<s:hidden name="ec_p" id="ec_p" />
	 	&nbsp; 入库单编号：<s:textfield id="stockNo" name="model.stockNo"></s:textfield>
	 	&nbsp;入库物品名称：<s:textfield id="goods.name" name="model.goods.name"></s:textfield>
	 	&nbsp;入库单日期：<input id="cDate" name="cDate" value='${cDate}'
				onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" />
			<input type="submit" value="查询" class="button" />
			<td width="30%" align="right"></td>
		</s:form>
	</tr>
</table>
</div>
<div class="x-panel-body">

<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;" align="right"><%@include
			file="/pages/common/messages.jsp"%></td>
	</tr>
	<tr>
		<th>序号</th>
		<th>入库单编号</th>
		<th>物品</th>
		<th>供应商</th>
		<th>单价</th>
		<th>总数量</th>
		<th>现有数量</th>
		<th>入库日期</th>
		<th>经手人</th>

		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center"><a
				href="${ctx}/goods/instock/view.do?model.id=${item.id}"
				title="${item.stockNo}" target="_blank"><font color="blue">${item.stockNo}</font></a></td>
			<td><a href="${ctx}/goods/view.do?model.id=${item.goods.id}"
				title="${item.goods.name}" target="_blank"><font color="blue">${item.goods.name}</font></a></td>
			<td>${item.goodsSupplier.name }</td>
			<td align="center">${item.price }</td>
			<td align="center">${item.inCounts }</td>
			<td align="center">${item.nowCounts }</td>
			<td align="center"><fmt:formatDate value="${item.inDate }" pattern="yyyy-MM-dd" /></td>
			<td align="center">${item.buyer }</td>
			<td align="center"><a href="toDraw.do?model.id=${item.id}">领取</a></td>
		</tr>
	</s:iterator>

	<tr>
		<td colspan="11" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
</div>
</div>
</body>
</html>
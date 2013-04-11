<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>办公用品登记</title>
<script type="text/javascript">
	function remove(id) {
		if (confirm("确认要删除?")) {
			window.location.href = URL_PREFIX
					+ "/goods/apply/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
<div style="float: left;">办公用品登记</div>
</div>
<div class="x-toolbar">

<table width="99%">
	<tr>
		<s:form action="index.do" method="post" id="pageQueryForm">

			<td>登记编号:<s:textfield id="stockNo" name="model.applyNo" />
			物品名称：<s:textfield id="goodsName" name="model.goods.name" /> 日期：<input
				id="startDate" name="startDate"
				value='<s:date name="startDate" format="yyyy-MM-dd"/>'
				onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" />&nbsp; ~&nbsp;<input
				id="endDate" name="endDate"
				value='<s:date name="endDate" format="yyyy-MM-dd"/>'
				onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
				class="Wdate" readonly="readonly" /><input type="submit" value="查询"
				class="button" />
				&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/goods/instock/indexDraw.do';"
						class="button" value="返回"></td>
				
				 <s:hidden name="ec_p" id="ec_p" /></td>
		</s:form>
	</tr>
</table>

</div>
<div class="x-panel-body">
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
		<th>物品</th>
		<th>使用数量</th>
		<th>领用物品总价格</th>
		
		<th>领用日期</th>
		<th>领用人</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
		
			<td align="center"><a
				href="${ctx}/goods/view.do?model.id=${item.goods.id}"
				title="${item.goods.name}" target="_blank"><font color="blue">${item.goods.name}</font></a></td>
			<td>${item.useCount}</td>
			<td>${item.totalPrice}</td>
			
			<td>${item.applyDate}</td>
			<td>${item.proposer.name}</td>
			<td align="center"><a
				href="${ctx}/goods/apply/view.do?model.id=${item.id}"
				title="${item.applyNo}" target="_blank"><font color="blue">查看明细</font></a></td>
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
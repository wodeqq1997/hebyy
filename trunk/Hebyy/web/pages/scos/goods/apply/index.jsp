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
	if(confirm("确认要删除?")) {
		window.location.href = URL_PREFIX+"/goods/apply/remove.do?model.id=" + id;
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
	<s:form action="index.do" method="post"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
		<table width="99%">
			<tr>
				<td width="70%">
					登记编号：<s:textfield id="stockNo" name="model.applyNo"  />
					物品名称：<s:textfield id="goodsName"  name="model.goods.name" />
					日期：<input id="startDate" name="startDate"  value='<s:date name="startDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
					~&nbsp;<input id="endDate" name="endDate"  value='<s:date name="endDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</td>
				<td width="30%" align="left">
					<input type="submit" value="查询" class="button" />
				</td>
			</tr>
		</table>
	</s:form>
</div>
<div class="x-panel-body">
<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>序号</th>
        <th>登记单编号</th>
		<th>物品</th>
		<th>使用数量</th>
		<th>申请物品总价格</th>
		<th>库存数量</th>
		<th>申购日期</th>
		<th>申请人</th>
		<th>状态</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			 <td align="center">${st.index + 1}</td>
            <td align="center"><a href="${ctx}/goods/apply/view.do?model.id=${item.id}" title="${item.applyNo}" target="_blank">${item.applyNo}</a></td>
			<td align="center"><a href="${ctx}/goods/view.do?model.id=${item.goods.id}" title="${item.goods.name}" target="_blank"><font color="blue">${item.goods.name}</font></a></td>
			 <td>${item.useCount}</td>
			<td>${item.totalPrice}</td>
			<td>${item.goods.stockCounts }</td>
			<td>${item.applyDate}</td>
			<td>${item.proposer.name}</td>
			<td>
			<s:if test='#attr.item.status == 0'>
			<font color="red">未审核</font>
			</s:if>
			<s:if test="#attr.item.status == 1">
			审核通过
			</s:if>
			<s:if test="#attr.item.status == 2">
			审核未通过
			</s:if>
			
			</td>
			<td align="center">
				<s:if test="#attr.item.status == 0">
				<a href="passCarApply.do?model.id=${item.id}" title="查看">批准</a> |  
				<a href="noPassCarApply.do?model.id=${item.id}" title="查看">不批准</a> 
			</s:if>
			<s:else>
				<a href="#" title="查看"><font color="#D4D0C8">批准</font></a> | 
				<a href="#" title="查看"><font color="#D4D0C8">不批准</font></a> 
			</s:else>
			</td>
		</tr>
	</s:iterator>
	<s:if test="#attr.items.size()!=0">
			<tr style="background-color: #ffe3ee">
				<td colspan="2" align="center" id="No1"
					style="font-weight: bold; border-top: 0px; border-bottom: 0px; border-left: 0px">合计(全部)</td>
				<td style="font-weight: bold; word-wrap: break-word; word-break: break-all; text-align: right">${totalUseCount}</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td >&nbsp;</td>	
				<td >&nbsp;</td>
				<td >&nbsp;</td>
			</tr>
	</s:if>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>入库单管理</title>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除?")) {
		window.location.href = URL_PREFIX+"/asset/instock/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">物资入库单管理</div>
</div>
<div class="x-toolbar">
	<table width="100%">
	  <tr>
	  <td width="70%">
	  <s:form action="index.do" method="post"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	 	&nbsp; 入库单编号：<s:textfield id="stockNo" name="model.stockNo" ></s:textfield>
	 	&nbsp;入库物资名称：<s:textfield id="asset.name" name="model.asset.name" ></s:textfield>
	 	&nbsp;入库单日期：<input id="cDate" name="cDate"  value='${cDate}' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
	 	<input type="submit" value="查询" class="button"/>
	  <td width="30%" align="right"><a href="${ctx}/asset/instock/edit.do">
		<img src="${ctx}/images/icons/add.gif">&nbsp;添加物资入库单</a>
		&nbsp;&nbsp;
		<a href="${ctx}/asset/index.do" >
			<img src="${ctx}/images/icons/rem-all.gif">&nbsp;物资管理</a>
	  </td>
	  </s:form>
	  </tr>
	</table>
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
        <th>入库单编号</th>
		<th>物资</th>
		<th>供应商</th>
		<th>单价</th>
		<th>入库数量</th>
		<th>现有数量</th>
		<th>金额</th>
		<th>入库日期</th>
		<th>经手人</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			 <td align="center">${st.index + 1}</td>
            <td align="center"><a href="${ctx}/asset/instock/view.do?model.id=${item.id}" title="${item.stockNo}" target="_blank">${item.stockNo}</a></td>
			<td align="center"><a href="${ctx}/asset/view.do?model.id=${item.asset.id}" title="${item.asset.name}" target="_blank">${item.asset.name}</a></td>
			 <td>${item.provider}</td>
			<td>${item.price}</td>
			<td>${item.inCounts}</td>
			<td>${item.nowCounts}</td>
			<td>${item.amount}</td>
			<td><fmt:formatDate value="${item.inDate}" pattern="yyyy-MM-dd"/></td>
			<td>${item.buyer}</td>
			
			<td align="center">
				<a href="edit.do?model.id=${item.id}">
				<img src="${ctx}/images/icons/modify.gif"></a> 
			<a href="#" onclick="remove('${item.id}')" title="删除">
				<img src="${ctx}/images/icons/remove.gif"></a>
			</td>
		</tr>
	</s:iterator>
	<s:if test="#attr.items.size()!=0">
			<tr style="background-color: #ffe3ee">
				<td colspan="5" align="center" id="No1"
					style="font-weight: bold; border-top: 0px; border-bottom: 0px; border-left: 0px">合计(全部)</td>
				<td style="font-weight: bold; word-wrap: break-word; word-break: break-all; text-align: right">${totalInCounts}</td>
				<td>&nbsp;</td>
				<td style="font-weight: bold; word-wrap: break-word; word-break: break-all; text-align: right">${totalAmount}</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>		
				<td>&nbsp;</td>
			
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
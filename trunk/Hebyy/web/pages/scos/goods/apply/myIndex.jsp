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
	<s:form action="myIndex.do" method="post" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
		<table width="99%">
			<tr>
				<td width="70%">
					登记编号：<s:textfield id="stockNo" name="model.applyNo"  />
					物品名称：<s:textfield id="goodsName"  name="model.goods.name" />
					日期：<input id="startDate" name="startDate"  value='<s:date name="startDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					~&nbsp;<input id="endDate" name="endDate"  value='<s:date name="endDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				</td>
				<td>
					<input type="submit" value="查询" class="button" />
				</td>
				<td width="20%" align="right">
					<a href="${ctx}/goods/apply/edit.do">
						<img src="${ctx}/images/icons/add.gif">申请办公用品
					</a> &nbsp;&nbsp;
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
		<th>办公用品</th>
		<th>使用数量</th>
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
			<td align="center"><a href="${ctx}/goods/view.do?model.id=${item.goods.id}" title="${item.goods.name}" target="_blank">${item.goods.name}</a></td>
			 <td align="center">${item.useCount }</td>
			<td align="center"><fmt:formatDate value="${item.applyDate}" pattern="yyyy-MM-dd"/></td>
			<td align="center">${item.proposer.name}</td>
			<td align="center">
			<s:if test='#attr.item.status == 0'>
			未审核
			</s:if>
			<s:if test="#attr.item.status == 1">
			审核通过
			</s:if>
			<s:if test="#attr.item.status == 2">
			审核未通过
			</s:if>
			
			</td>
			<td align="center">
				<a href="view.do?model.id=${item.id}" target="_blank" title="查看"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
			<s:if test="#attr.item.status == 0">
				<a href="edit.do?model.id=${item.id}" title="修改"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
				<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a>
			</s:if>
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
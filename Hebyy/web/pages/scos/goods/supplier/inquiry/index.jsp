<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>供应商询价管理</title>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除该条询价记录?")) {
		window.location.href = URL_PREFIX+"/goods/inquiry/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">供应商询价管理</div>
</div>
<div class="x-toolbar">
	<s:form action="index" method="post"id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
		<table width="100%">
			<tr>
				<td width="70%">
					&nbsp;供应商名称：<s:textfield id="name" name="model.goodsSupplier.name"/>
					询价科目：<s:select name="model.goods.id" id="goods" cssClass="required" list="goodsMap" headerKey="" headerValue="选择询价科目" cssStyle="width:132px;"/>
					开始日期：<input id="startDate" name="startDate"  style="height: 20px;" value='${startDate}' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					结束日期：<input id="endDate" name="endDate"  style="height: 20px;" value='${endDate}' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
					<input type="submit" value="查询" class="button" />
				<td width="30%" align="right">
					<a href="${ctx}/goods/inquiry/edit.do">
						<img src="${ctx}/images/icons/add.gif">&nbsp;添加询价记录
					</a>
					&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</s:form>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-panel-body">
<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>序号</th>
        <th>询价日期</th>
        <th>询价科目</th>
        <th>供应商名称</th>
        <th>报价</th>
        <td>备注</td>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
		     <td align="center">${st.index + 1}</td>
            <td align="center"><fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd"/></td>
            <td>${item.goods.name }</td>
            <td><a href="${ctx}/goods/supplier/view.do?model.id=${item.goodsSupplier.id}" target="_blank">${item.goodsSupplier.name}</a></td>
            <td>${item.price }</td>
            <td>${item.notes }</td>
			<td>
				<a href="view.do?model.id=${item.id}"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
			<a href="edit.do?model.id=${item.id}"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp; 
			<a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a>
			</td>
		</tr>
	</s:iterator>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>

<title>供应商询价记录</title>
<style>
    .spacing-span{
        letter-spacing: 0.5em;
        margin-left: 0.5em;
    }
</style>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">供应商询价信息</div>
		<div class="x-panel-body">
			<table width="700"id="fineTable" align="center" style="margin-top: 20px;">
				<tr>
					<th colspan="4">供应商询价记录</th>
				</tr>
				<tr>
					<td width="80" align="center">询价日期</td>
					<td width="270">
						<s:date name="model.createTime"/>
					</td>
					<td width="80" align="center">询价科目</td>
					<td width="270">${model.goods.name}</td>
				</tr>
				<tr>
					<td align="center"><span class="spacing-span">供应商</span></td>
					<td>${model.goodsSupplier.name}</td>
					<td align="center"><span class="spacing-span">联系人</span></td>
					<td>${model.goodsSupplier.linkman}</td>
				</tr>
				<tr>
					<td align="center">电　　话</td>
					<td>${model.goodsSupplier.phone}</td>
					<td align="center">报　　价</td>
					<td>${model.price}</td>
				</tr>
				<tr>
					<td align="center">描　　述</td>
					<td colspan="3">${model.notes}</td>
				</tr>
			</table>
			<div align="center" style="margin-top: 20px;">
				<input type="button" value="返回" onclick="history.go(-1)" class="button" />
			</div>
		</div>
	</div>
	</body>
</html>
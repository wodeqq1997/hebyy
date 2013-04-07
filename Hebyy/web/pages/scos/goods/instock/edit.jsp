<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/goods/selector.js"></script>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/showUser.js"></script>
<%@include file="/common/validator.jsp"%>
<title>物品入库单编辑</title>
</head>
<body>
<div class="x-panel">
<div class="x-header" style="border-bottom: 1px solid #99bbe8;">添加入库单</div>
<div align="center" style="width: 100%">
	<form action="save.do" method="post" id="save" style="margin: 0px;">
		<s:hidden name="model.id" />
		<table width="700" border="0" align="center" style="line-height: 20px; margin-top: 20px; margin-bottom: 20px;" id="fineTable">
			<tr>
				<th colspan="4">入库单</th>
			</tr>
			<tr>
				<td width="100" align="center">入库单编号：</td>
				<td width="250"><s:textfield name="model.stockNo" id="stockNo" readonly="true"  maxlength="20" /></td>
				<td width="100" align="center">物品：</td>
				<td width="250">
					<s:textfield id="goodsName"  name="model.goods.name" onclick="showGoods()" cssClass="required"/><s:hidden id="goodsId" name="model.goods.id"/><span id="nameDescn"></span><font color="red">*</font>
				</td>
			</tr> 
			<tr>
				<td align="center">单价：</td>
				<td>
					<s:textfield name="model.price" id="price"  maxlength="20" onblur="calAmount()" cssClass="required number"/>
					<font color="red">*</font>
				</td>
				<td align="center">入库数量：</td>
				<td>
					<s:textfield name="model.inCounts" id="inCounts" onblur="calAmount()"  maxlength="20" cssClass="required digits"/>
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td align="center">金额：</td>
				<td>
					<s:textfield name="model.amount" cssClass="number" id="amount" onfocus="calAmount()"  maxlength="20" />
					<span id="amountCheckDescn"></span>		
				</td>
				<td   align="center">入库日期：</td>
				<td>
					<s:if test="model.inDate != null">
						<input id="inDate" name="model.inDate"  value='<fmt:formatDate value="${model.inDate}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					</s:if>
					<s:else>
						<input id="inDate" name="model.inDate"  value='' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					</s:else>	
				</td>
			</tr>
			<tr>
				<td align="center">经手人：</td>
				<td>
					<s:textfield name="model.buyer" id="buyer"  maxlength="20"/>
				</td>
				<td align="center">供应商：</td>
				<td>
					<s:hidden name="model.goodsSupplier.id" id="supplierId"/>
						<s:textfield name="model.goodsSupplier.name" id="supplierName" cssClass="required"  onclick="openSupplier(this)" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td align="center">保质期：</td>
				<td>
					<s:if test="model.shelflife != null">
						<input id="inDate" name="model.shelflife"  value='<fmt:formatDate value="${model.shelflife}" pattern="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					</s:if>
					<s:else>
						<input id="inDate" name="model.shelflife"  value='' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
					</s:else>	
				</td>
			</tr>
			<tr>
				<td align="center" valign="top" >备注：</td>
				<td colspan="3">
					<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 2px; width: 532px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" value="重置" class="button">
		</div>
	</form>
	</div>
</div>
<script type="text/javascript">
	/** ready */
	$(document).ready(function() {
		$("#save").validate();
	});
	
	function calAmount(){
		var price = $('#price').val();
		var inCounts = $('#inCounts').val();
		if(isNumber(price) && isNumber(inCounts)){
			$('#amount').val(parseFloat(price) * parseInt(inCounts));
		}
	}
	
	/**
	* 判断数字
	*/
	function isNumber(oNum) {
		if (!oNum)
			return false;
		var strP = /^\d+(\.\d+)?$/;
		if (!strP.test(oNum))
			return false;
		try {
			if (parseFloat(oNum) != oNum)
				return false;
		} catch (ex) {
			return false;
		}
		return true;
	}
	/**
	 * 选择供应商（乙方）
	 */
	function openSupplier(obj) {
		var ids = document.getElementById("supplierId");

		if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
			var conf = "dialogWidth=508px;dialogHeight=338px;status=no;help=no;scrollbars=no";
			var suppliers = window.showModalDialog("${ctx}/pages/scos/goods/supplier/selector/selector.jsp", null, conf);
			if (suppliers != null){
				obj.value = suppliers.name;
				ids.value = suppliers.id;
			}
		} else {
			window.open("${ctx}/pages/scos/goods/supplier/selector/selector.jsp",
						"",
						"width=608px,height=438,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
			this.returnAction = function(suppliers) {
				if (suppliers != null){
					obj.value = suppliers.name;
					ids.value = suppliers.id;
				}
				return;
			};
		}
	}
</script>
</body>
</html>
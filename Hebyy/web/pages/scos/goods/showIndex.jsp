<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>物品管理</title>
<style type="text/css">

.green{
	color: green;
	font-weight: bold;
}

.red{
	color: red;
	font-weight: bold;
}
</style>
<script type="text/javascript">
	//物品信息
	function goods(){
		// 主键
		this.id;
		// 物品名称
		this.name;
		// 物品编号
		this.goodsNo;
		// 规格
		this.specifications;
		// 计量单位
		this.unit;
		// 备注
		this.notes;
		// 库存量
		this.stockCounts;
		// 上限数量
		this.maxCount;
		// 报警数量 （下限数量）
		this.minCount;
		//物品类别
		this.goodsType;
	}
	function closeWindow(id,name,stockCounts){
		var g = new goods();
		g.id = id;
		g.name = name;
		g.stockCounts = stockCounts;
		if (navigator.userAgent.indexOf("MSIE")>0){//IE判断
			window.returnValue = g;
			window.close();
		}else{
		    window.parent.close();
			window.parent.opener.returnAction(g);
		}
	}
	/**
	 * 选择物品
	 */
	function selectGoods(){
		var items = $("input[name='selectitems']:checked");
		if(items.length != 1){
			alert('请选择【一个】分包商（供应商）进行操作');
			return;
		}
		closeWindow(items.val(), $('#'+items.val()+'Name').val(), $('#'+items.val()+'StockCounts').val());
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">车辆信息管理</div>
</div>
<div class="x-toolbar">
	<s:form action="showIndex.do">
		<table width="99%" cellpadding="0" cellspacing="0">
		  <tr>
		    <td style="padding-left: 5px;">
	        	物品名称：<s:textfield id="name" name="model.name"  maxlength="40"/>
	        	物品类别：<s:select list="goodsTypeMap" name="model.goodsType.id" headerKey="" id="goodsTypeId" headerValue="全部" cssStyle="width:100px;" />
	       		<input type="submit" value="查询" class="button"/>
		    </td>
    	  	<td align="right">
		  		<input type="button" class="button green" value="取消选择" onclick="javascript:window.close();">&nbsp;
				<input type="button" class="button red" value="确认选择" onclick="selectGoods()">
		 	</td>
		  </tr>
		</table>
	</s:form>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="showIndex.do" 
		useAjax="false"
		doPreload="false" 
		pageSizeList="10,20,40" 
		editable="false"
		sortable="false" 
		rowsDisplayed="10"
		generateScript="true" 
		resizeColWidth="true" 
		classic="true" 
		width="100%"
		height="220px"
		minHeight="220"
		toolbarContent="navigation|pagejump|pagesize|refresh|export|extend|status">
	<ec:row ondblclick="closeWindow('${item.id}','${item.name}','${item.stockCounts}')">
		<ec:column width="40" property="_s" title="选择" style="text-align:center">
			<input type="hidden" id="${item.id}Name" value="${item.name}">
			<input type="hidden" id="${item.id}StockCounts" value="${item.stockCounts}">
	    	<input type="radio" id="${item.id}" name="selectitems" value="${item.id}" style="border: 0px;"/>
	    </ec:column>	    <ec:column width="100" property="name" title="物品名称"/>
		<ec:column width="100" property="goodsNo" title="物品编号" />
		<ec:column width="100" property="specifications" title="规格" />
		<ec:column width="60" property="unit" style="text-align: center;"  title="计量单位" />
		<ec:column width="80" property="stockCounts" style="text-align: right;" title="库存量" />
		<ec:column width="80" property="maxCount" style="text-align: right;" title="上限库存量" />
		<ec:column width="80" property="minCount" style="text-align: right;" title="下限库存量" />
		<ec:column width="120" property="goodsType.name" title="物品类别" />
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
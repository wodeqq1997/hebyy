<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<title>车辆信息管理</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
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
	//车辆信息
	function asset(){
		// 主键
		this.id;
		// 物资名称
		this.name;
		// 资产编号
		this.assetNo;
		// 规格型号
		this.stardard;
		// 厂家
		this.manufacturer;
		// 出厂日期
		this.exFactoryDate;
		// 购置日期
		this.buyDate;
		// 保管人
		this.custodian;
		// 资产值
		this.assetValue;
		// 备注
		this.notes;
		// 物资类别
		this.assetType;
		// 数量
		this.stockCounts
		// 部门
		this.dept
	}
	function dbclickRow(id,name){
		var a = new asset();
		a.id = id;
		a.name = name;
		
		if (navigator.userAgent.indexOf("MSIE")>0){//IE判断
			window.returnValue = a;
			window.close();
		}else{
		    window.parent.close();
			window.parent.opener.returnAction(a);
		}
	}
	/**
	 * 选择物资
	 */
	function selectAsset(){
		var items = $("input[name='selectitems']:checked");
		if(items.length != 1){
			alert('请选择【一个】物资进行操作');
			return;
		}
		dbclickRow(items.val(), $('#'+items.val()+'name').val());
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<table width="100%">
	  <tr>
	  	<td width="50%" style="color: #15428b; font-weight: bold;">车辆信息管理&nbsp;</td>
	  	<td width="50%" align="right">
	  		<input type="button" class="button green" value="取消选择" onclick="javascript:window.close();">&nbsp;
			<input type="button" class="button red" value="确认选择" onclick="selectAsset()">
			&nbsp;
	  	</td>
	  </tr>
	</table>
</div>
<div class="x-toolbar">
	<s:form action="showIndex.do">
	<table width="100%">
	  <tr>
			<td>
				物资名称：<s:textfield id="title" name="model.name" />
				物资状态：<s:select list="#{'好':'好','损坏':'损坏','报废':'报废'}" name="model.status" headerKey="" id="status" headerValue="全部" cssStyle="width:80px;" cssClass="statusCheck"/>
		   		物资类型：<s:select list="assetTypeMap" name="model.assetType.id" headerKey="" id="assetTypeId" headerValue="全部" cssStyle="width:110px;" />
		   		<input type="submit" value="查询" class="button" />
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
		pageSizeList="10,20" 
		editable="false"
		sortable="false" 
		rowsDisplayed="10"
		generateScript="true" 
		resizeColWidth="true" 
		classic="true" 
		width="100%"
		height="220px"
		minHeight="220"
		toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
	<ec:row>
		<ec:column width="40" property="_s" title="选择" style="text-align:center">
			<input type="hidden" id="${item.id}name" value="${item.name}">
	    	<input type="radio" id="${item.id}" name="selectitems" value="${item.id}" style="border: 0px;"/>
	    </ec:column>
	    <ec:column width="40" property="_d" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
	    <ec:column width="100" property="name" title="名称" ellipsis="true"/>
	    <ec:column width="100" property="assetNo" title="编号" ellipsis="true"/>
	    <ec:column width="100" property="stardard" title="规格" ellipsis="true"/>
	    <ec:column width="100" property="assetType.name" title="物资类别" ellipsis="true"/>
	    <ec:column width="80" property="buyDate" cell="date" title="购买日期 " style="text-align:center" format="yyyy-MM-dd"/>
		<ec:column width="80" property="custodian" title="保管人" ellipsis="true"/>
		<ec:column width="80" property="assetValue" title="物资值" style="text-align:right" format="###,##0.00" cell="number" ellipsis="true"/>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/ec.jsp" %>
<title>选择供应商</title>
<style type="text/css">

.green{
	color: green;
	font-weight: bold;
}

.red{
	color: red;
	font-weight: bold;
}

#ec_bodyZone .tableRegion input
{
    height: auto !important;
}
</style>
<script type="text/javascript">
	//供应商信息
	function supplier(){
		// 主键
		this.id;
		/** 供应商名称 */
		this.name;
		/** 供应商描述 */
		this.descn;
	}
	function dbclickRow(id, name){
		var s = new supplier();
		s.id = id;
		s.name = name;
		
		if (navigator.userAgent.indexOf("MSIE")>0){//IE判断
			window.returnValue = s;
			window.close();
		}else{
		    window.parent.close();
			window.parent.opener.returnAction(s);
		}
	}
	/**
	 * 选择供应商
	 */
	function selectSupplier(){
		var items = $("input[name='selectitems']:checked");
		if(items.length != 1){
			alert('请选择【一个】供应商进行操作');
			return;
		}
		dbclickRow(items.val(), $('#'+items.val()+'Name').val(), $('#'+items.val()+'Titles').val());
	}
</script>
</head>
<body>
<div class="x-toolbar" style="padding: 5px;">
	<form action="${ctx}/goods/supplier/selectSupplier.do" method="post">
	<table width="99%">
	  <tr>
	  	<td>
	  		<s:hidden name="model.supplierType.id"/>
	  		供应商名称：<s:textfield name="model.name" cssStyle="width:120px;"/>
	  		<s:submit cssClass="button" value="查询"/>
	  	</td>
	  	<td align="right">
	  		<input type="button" class="button green" value="取消选择" onclick="javascript:window.close();">&nbsp;
			<input type="button" class="button red" value="确认选择" onclick="selectSupplier()">
			&nbsp;
	  	</td>
	  </tr>
	</table>
	</form>
</div>
<ec:table style="" items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="selectSupplier.do"
		useAjax="true" doPreload="false"
		maxRowsExported="10000000" 
		pageSizeList="15,50,100" 
		editable="false" 
		sortable="false"	
		rowsDisplayed="15"	
		generateScript="true"	
		resizeColWidth="true"
		classic="false"
		width="99.7%"
		height="310px"
		minHeight="310"
		toolbarContent="navigation|pagesize|refresh|status"   
	>
	<ec:row>
		<ec:column width="40" property="_s" title="选择" style="text-align:center">
			<input type="hidden" id="${item.id}Name" value="${item.name}">
	    	<input type="radio" id="${item.id}" name="selectitems" value="${item.id}" style="border: 0px;"/>
	    </ec:column>
		<ec:column width="180" property="name" title="供应商名称" ellipsis="true"/>
		<ec:column width="80" property="linkman" title="联系人" ellipsis="true"/>
		<ec:column width="40" property="_0" title="操作" style="text-align:center" sortable="false">
			<a href="view.do?model.id=${item.id}" target="_blank" title="查看详情"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;
		</ec:column>
	</ec:row>
</ec:table>
</body>
</html>
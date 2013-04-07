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
	function car(){
		// 主键
		this.id;
		// 车牌
		this.carNo;
		// 汽车类型:轿车、货车、商务车
		this.carType;
		// 发动机号
		this.engineNo;
		// 厂家
		this.factory;
		// 保险购买日期
		this.buyInsureTime;
		// 年审时间
		this.auditTime;
		// 购置日期
		this.buyDate;
		// 汽车照片
		this.carPhoto;
		// 车辆状态: 1=可用、2=维修中、0=报废
		this.status;
		// 服务电话 4s店
		this.servicePhone;
		// 描述
		this.descn;
	}
	function dbclickRow(id,carNo){
		var c = new car();
		c.id = id;
		c.carNo = carNo;
		
		if (navigator.userAgent.indexOf("MSIE")>0){//IE判断
			window.returnValue = c;
			window.close();
		}else{
		    window.parent.close();
			window.parent.opener.returnAction(c);
		}
	}
	/**
	 * 选择选择车辆
	 */
	function selectCar(){
		var items = $("input[name='selectitems']:checked");
		if(items.length != 1){
			alert('请选择【一个】车辆进行操作');
			return;
		}
		dbclickRow(items.val(), $('#'+items.val()+'CarNo').val());
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
			<input type="button" class="button red" value="确认选择" onclick="selectCar()">
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
				车牌：<s:textfield id="carNo" name="model.carNo" />
				汽车类型：<s:select list="#{'轿车':'轿车','货车':'货车','商务车':'商务车'}" name="model.carType" headerKey="" id="carType" headerValue="全部" cssStyle="width:60px;" />
				发动机号：<s:textfield id="engineNo" name="model.engineNo" />
				购买日期：<input id="startDate" name="startDate"  value="<s:date name='startDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				~&nbsp;<input id="endDate" name="endDate"  value="<s:date name='endDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
			</td>
			<td>
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
		pageSizeList="10,20,40" 
		editable="false"
		sortable="false" 
		rowsDisplayed="10"
		generateScript="true" 
		resizeColWidth="true" 
		classic="true" 
		width="100%"
		height="215px"
		minHeight="215"
		toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
	<ec:row>
	    <ec:column width="40" property="_s" title="选择" style="text-align:center">
			<input type="hidden" id="${item.id}CarNo" value="${item.carNo}">
	    	<input type="radio" id="${item.id}" name="selectitems" value="${item.id}" style="border: 0px;"/>
	    </ec:column>
	    <ec:column width="60" property="carNo" title="车牌" style="text-align:center" ellipsis="true"/>
	    <ec:column width="60" property="carType" title="车辆类型" style="text-align:center" ellipsis="true"/>
		<ec:column width="80" property="engineNo" title="发动机号" ellipsis="true"/>
		<ec:column width="100" property="buyInsureTime" cell="date" title="保险购买日期 " style="text-align:center" format="yyyy-MM-dd"/>
		<ec:column width="70" property="auditTime" cell="date" title="年审时间 " style="text-align:center" format="yyyy-MM-dd"/>
		<ec:column width="70" property="buyDate" cell="date" title="购置日期 " style="text-align:center" format="yyyy-MM-dd"/>
		<ec:column width="40" property="_status" title="状态" style="text-align:center;">
			<s:if test="#attr.item.status == 1">
				可用
			</s:if>
			<s:elseif test="#attr.item.status == 0">
				报废
			</s:elseif>
			<s:else>
				维修中
			</s:else>
		</ec:column>
		<ec:column width="100" property="servicePhone" title="服务电话" ellipsis="true"/>
 		<ec:column width="100" property="descn" title="描述" ellipsis="true"/>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
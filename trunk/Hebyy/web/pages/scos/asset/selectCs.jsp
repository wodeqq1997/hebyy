<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/ec.jsp" %>
<title>选择审核人</title>
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
	 * 选择审核人
	 */
	function selectSupplier(){
		var items = $("input[name='selectitems']:checked");
		if(items.length != 1){
			alert('请选择【一个】审核人进行操作');
			return;
		}
		dbclickRow(items.val(), $('#'+items.val()+'Name').val(), $('#'+items.val()+'Titles').val());
	}
</script>
</head>
<body>
<div class="x-toolbar" style="padding: 5px;">
	<form action="${ctx}/userselector/selUser.do" method="post">
	<table width="99%">
	  <tr>
	  	<td align="right">
	  		<input type="button" class="button green" value="取消选择" onclick="javascript:window.close();">&nbsp;
			<input type="button" class="button red" value="确认选择" onclick="selectSupplier()">
	  	</td>
	  </tr>
	</table>
	</form>
</div>
<div align="left"">
<table id="fineTable" width="400">
	<tr>
		<th>选择</th>
		<th>名称</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center"><input type="radio" id="${item.id}" name="selectitems" value="${item.id}" style="border: 0px;"/></td>
			<td align="center">${item.name}
			<input type="hidden" id="${item.id}Name" value="${item.name}">
			</td>
			
	</s:iterator>

	</table>
	</div>
</body>
</html>
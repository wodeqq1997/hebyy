<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/pages/zjimis/project/project/selector.js"></script>
<title>案卷信息管理</title>
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
	//案卷信息
	function archive(){
		// 主键
		this.id;
		/** 案卷名称 */
		this.name;
		/** 案卷编号 */
		this.archiveNO;
	}
	function closeWindow(id, name, archiveNO){
		var a = new archive();
		a.id = id;
		a.name = name;
		a.archiveNO = archiveNO;
		if (navigator.userAgent.indexOf("MSIE")>0){//IE判断
			window.returnValue = a;
			window.close();
		}else{
			window.parent.opener.returnAction(a);
		    window.parent.close();
		}
	}
	/**
	 * 选择案卷
	 */
	function selectCar(){
		var items = $("input[name='selectitems']:checked");
		if(items.length != 1){
			alert('请选择【一个】项目进行操作');
			return;
		}
		closeWindow(items.val(), $('#'+items.val()+'Name').val(),$('#'+items.val()+'ArchiveNO').val());
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<table width="100%">
	  <tr>
	  	<td width="50%" style="color: #15428b; font-weight: bold;">案卷信息&nbsp;</td>
	  	<td width="50%" align="right">
	  		<input type="button" class="button green" value="取消选择" onclick="javascript:window.close();">&nbsp;
			<input type="button" class="button red" value="确认选择" onclick="selectCar()">
			&nbsp;
	  	</td>
	  </tr>
	</table>
</div>
<div class="x-toolbar"><s:form action="showIndex.do">
	<s:form action="index" theme="simple"> 
      <table width="99%">
      	<tr>
			<td>
		      	案卷名称：<s:textfield id="name" name="model.name"  cssStyle="height:20px;" />
		      	案卷名称：<s:textfield id="archivesNO" name="model.archivesNO"  cssStyle="height:20px;" />
				案卷类型：<s:select list="archiveTypeMap" name="model.archiveType.id" headerKey="" id="archiveTypeId" headerValue="全部" cssStyle="width:110px;" />
				<input type="submit" value="查询" class="button" />
			</td>
     	</tr>
     </table>
	</s:form>
</s:form>
</div>
<div class="x-panel-body">
<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
		action="showIndex.do" 
		useAjax="false"
		doPreload="false" 
		pageSizeList="10,20,50" 
		editable="false"
		sortable="false" 
		rowsDisplayed="10"
		generateScript="true" 
		resizeColWidth="true" 
		classic="true" 
		width="100%"
		height="300px"
		minHeight="300"
		toolbarContent="navigation|pagejump|pagesize|refresh|export|extend|status">
	<ec:row>
	    <ec:column width="40" property="_s" title="选择" style="text-align:center">
			<input type="hidden" id="${item.id}ArchiveNO" value="${item.archiveNO}">
			<input type="hidden" id="${item.id}Name" value="${item.name}">
	    	<input type="radio" id="${item.id}" name="selectitems" value="${item.id}" style="border: 0px;"/>
	    </ec:column>
	    <ec:column width="100" property="archiveNO" title="编号" ellipsis="true"/>
	    <ec:column width="200" property="name" title="名称" style="text-align:center"/>
	    <ec:column width="140" property="archiveType.name" title="案卷类别" style="text-align:center"/>
	    <ec:column width="80" property="categoryNO" title="全宗号" style="text-align:center"/>
		<ec:column width="100" property="archiveCabinet.name" title="存放位置" style="text-align:center"/>
		<ec:column width="80" property="dense" title="案卷密级" style="text-align:center"/>
	</ec:row>
</ec:table>
</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<%@include file="/common/extjs.jsp" %>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>

<title>编辑文档类别</title>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header">文档类别信息</div>
<div class="x-toolbar">
<table width="100%">
	<tr>
		<td align="right">
		<table>
			<tr>
				<td><a href="${ctx}/pages/amol/base/prosort/index.jsp"><img src="${ctx}/images/grid/filterArrow.gif" style="width: 12px; height: 12px;"/>&nbsp;返回&nbsp;&nbsp;</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div align="center" style="width: 100%">
<s:form action="save" id="save" validate="true" method="POST">
	<s:hidden name="model.id" id="uId" />
	<fieldset style="width: 60%; padding:10px 10px 10px 10px;">
	<legend>文档类别信息</legend>
	<table width="100%" align="center">
		<tr>
			<td align="right" width="300px">所属类别：</td>
			<td class="simple" align="left">
			    <span id='comboxWithTree' style="width: 120px;"></span>	        
			    <s:hidden id="parentProsortId" name="model.parentProsort.id" cssClass="parentProsortIdCheck"/>
				<span id="parentProsortIdTip"></span>
				<font color="red">*(不选择为根目录)</font>				  
			</td>
		</tr>	
		<tr>
			<td align="right">名称：</td>
			<td class="simple" align="left" colspan="3">
				<s:textfield  id="" name="model.name" cssClass="required" cssStyle="width:140px;"></s:textfield >
				<font color="red">*</font>
			</td>
			<td class="simple" align="left">
			</td>
		</tr>
		<tr>
			<td align="right" >状态：</td>
			<td class="simple" align="left" colspan="3">
				<s:select name="model.status" id="prosortStatus"
						list='#{"1":"可用","0":"禁用"}' headerKey=""
						headerValue="请选择状态" cssStyle="width:140px;" cssClass="prosortStatusCheck"/>
				<span id="prosortStatusTip"></span>
				<font color="red">*</font>
			</td>
		</tr>	
		<tr>
			<td align="right">描&nbsp;&nbsp;&nbsp;&nbsp;述：</td>		
			<td align="left" colspan="1">
				<s:textarea id="remark" name="model.descn" cols="50" rows="4" />
			</td>
		</tr>				
	</table>
	</fieldset>
	<table width="100%" style="margin-bottom: 10px;">
		<tr>
			<td align="center" class="font_white">
				<s:submit value="保存" cssClass="button"/>&nbsp;&nbsp; 
				<s:reset value="重置" cssClass="button"/>&nbsp;&nbsp;
				<input type="button" value="返回" onclick="history.go(-1)" class="button"/>
			</td>
		</tr>
	</table>
</s:form>
</div>
</div>
<script type="text/javascript">
 	/** ready */
	$(document).ready(function() {
		$("#save").validate();
	});
</script>
<script type="text/javascript"
	src="${ctx}/pages/amol/base/product/prosortCombox.js"></script>
<script type="text/javascript">
	Ext.onReady(function() {
		var pstree = new ProsortTree({
			el : 'comboxWithTree',
			target : 'parentProsortId',
			//emptyText : '选择文档类别',
			url : '${ctx}/base/prosort/prosortTree.do?status=1'
		});
		pstree.init();
	});
</script>
<script type="text/javascript">
$.validator.addMethod("prosortStatusCheck", function(value, element) {
    var res;
    var costsort = document.getElementById('prosortStatus').value;
	if(costsort == '') {
		res = "err";
		document.getElementById('prosortStatusTip').innerHTML = '&nbsp;<font color="red">'+'未选择状态'+'</font>';
	}else{
		res = "od";
		document.getElementById('prosortStatusTip').innerHTML = '';
	}
    return res != "err";
},"");

</script>
</body>
</html>
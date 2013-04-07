<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>编辑部门</title>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/extjs.jsp" %>
<%@include file="/common/validator.jsp"%>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<style type="text/css">
	body {
		margin:0px;
		padding:0px;
		border :0px none #ffffff;
		font-size: 12px;
		overflow:auto;
	
	}
  .select{
    width: 30px;
    font-weight: bold;
  }
</style>
</head>
<body>
<div class="x-toolbar" style="padding: 5px;">&nbsp;</div>
<div class="x-panel" style="margin: 5px;">
  <%@ include file="/common/messages.jsp"%>
  <s:form id="saveDeptForm" action="save" theme="simple" validate="true" method="post" onsubmit="disable1001()">
  <fieldset >
  <legend>部门信息编辑</legend>
  <s:hidden name="model.id"/>
  <s:hidden name="model.serialNo"/><br>
  <table width="500" style="line-height:25px;" align="center">
     <tr>
       <td width="80" align="right">上级部门：</td>
       <td width="320">
         <div id="comboxWithTree"></div>
         <input type="hidden" id="parentId" name="parentId" value="${model.parentDept.id}"/>
       </td>
    </tr>
    <tr>
       <td width="80" align="right">部门名称：</td>
       <td width="320">
         <s:textfield name="model.name" id="deptName" maxlength="25" cssStyle="width:200px;" cssClass="required"/>
         &nbsp;<font color="red">*</font>
       </td>
    </tr>
    <tr>
       <td width="80" align="right">部门编号：</td>
       <td width="320">
         <s:if test="model.id == null">保存后自动生成部门编号</s:if>
         <s:else>${model.serialNo }</s:else>
       </td>
     </tr>
	  <tr>
	    <td colspan="2" align="center" height="40">
	   	 <input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
	   	 <input type="reset" value="重置" class="button">
	    </td>
	  </tr>
  </table>
  </fieldset>
  </s:form>
</div>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<script type="text/javascript">
var rootName = '河北演艺集团';
var initValue = '${model.parentDept.name}';
if (initValue.length == 0){
	initValue = rootName;
}
Ext.onReady(function() {
	var dtree = new DeptTree({
		url : '/admin/dept/deptTree.do',
		rootName: rootName,
		initValue : initValue,
		el : 'comboxWithTree',
		innerTree :'inner-tree',
		onclick : function(nodeId) {
		  Ext.get('parentId').dom.value = nodeId;
		}
	});
	dtree.init();	
});

//添加jquery验证
$(document).ready(function() {
	$("#saveDeptForm").validate();
});


</script>

</body>
</html>
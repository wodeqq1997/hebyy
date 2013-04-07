<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	var rootName = '河北演艺集团';
	var initValue = '${model.dept.name}';
	if (initValue.length == 0) {
		initValue = rootName;
	}
	Ext.onReady(function() {
		var dtree = new DeptTree({
			url : '/admin/dept/deptTree.do',
			rootName : rootName,
			initValue : initValue,
			el : 'comboxWithTree',
			innerTree : 'inner-tree',
			onclick : function(nodeId) {
				Ext.get('deptId').dom.value = nodeId;
			}
		});
		dtree.init();
	});
</script>

<style type="text/css">
.warn {
	color: red;
}

.title {
	border-bottom: 0px solid #99BBE8;
	font-size: 14px;
	font-weight: bold;
	color: #15428b;
}
.noBorder{
 	border:0px;
 }
</style>
<script type="text/javascript">
var editor;
KindEditor.ready(function(K) {
	editor = K.create('#descn', {
		resizeType : 1,
		allowFileManager : true,
		uploadJson : '${ctx}/fileManager/upload_json.jsp',
		fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
		width : 700,
		height : 350
	});
});
</script>
<title>编辑职位</title>
</head>
<body>
<div class="x-panel">
<s:form action="save.do" id="save" validate="true" method="post">
	<fieldset>
		<legend style="margin-top: 5px;">职位编辑</legend>
			<table width="850" border="0" align="center" style="line-height: 30px;" >
				<tr>
					<td>
						职位名称：
					</td>
					<td>
						<s:textfield name="model.name" id="model.name" cssClass="required"></s:textfield>
					</td>
					<td width="100" >所属部门：</td>
					<td width="350">
						<s:hidden name="model.id" id="uid"/>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<div id='comboxWithTree'></div>
									<input type="hidden" id="deptId" name="model.dept.id" class="dept" value="${model.dept.id}" />
								</td>
								<td>
									<span id="deptmsg" class="warn"></span>&nbsp; 
									<span class="warn">*</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td >
						职位权限：
					</td>
					<td colspan="4">
						<s:hidden name="model.authority" id="authority"/>
						<input type="checkbox" id="authorityBox" style="border: 0px;">审批
					</td>
				</tr>
				<tr>
					<td >
						职位描述：
					</td>
					<td colspan="4">
						<s:textarea name="model.descn" id="descn"  cssStyle="margin:3px 0px; width: 535px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
					</td>
				</tr>
			</table>
		</fieldset>
	<div align="center" style="margin-top: 5px;">
		<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp; 
		<input type="reset" value="重置" class="button">
	</div>
</s:form>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
		$('#authorityBox').change(changeAuthority);
		<s:if test="model.authority == 0">
			$('#authorityBox').attr('checked','checked');
		</s:if>
	});
	$(function() {
		$.validator.addMethod("dept", function(value, element) {
			if (value == null || value.length == 0 || value == 0) {
				$("#deptmsg").html("选择部门");
				return false;
			} else {
				$("#deptmsg").html("");
				return true;
			}
	}, "");});
	function changeAuthority(){
		if($('#authorityBox').attr('checked')){
			$('#authority').val('0');
		}else{
			$('#authority').val('');
		}
	}
</script>
</body>
 
</html>
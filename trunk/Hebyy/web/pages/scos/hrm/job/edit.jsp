<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
<%@include file="/common/kindeditor.jsp"%>
<title>部门职位编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">编辑职位</div>
		<div class="x-panel-body">
			<form action="save.do" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>职位信息编辑</legend>
				<table width="850" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">所属部门：</td>
						<td width="750">
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
						<td width="100" align="right">职位名称：</td>
						<td width="750">
							<s:textfield name="model.jobName" id="jobName" maxlength="255" cssStyle="width:740px;"/>
						</td>
					</tr>
					<tr>
						<td width="100" align="right">排序编号：</td>
						<td width="750">
							<s:textfield name="model.orderId" id="orderId" maxlength="2" cssStyle="width:20px;"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">岗位职责：</td>
						<td>
							<s:textarea name="model.descn" id="descn"  cssStyle="margin:3px 0px; width: 635px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
					
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('#descn', {
				resizeType :1,
				allowFileManager : true,
				uploadJson : '${ctx}/fileManager/upload_json.jsp',
				fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
				width:740,
				height:350
			});
		});
		
		var rootName = '中佳勘察设计有限公司';
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
</body>
</html>
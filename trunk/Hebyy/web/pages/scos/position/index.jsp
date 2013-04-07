<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.systop.common.modules.dept.DeptConstants" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/extjs.jsp" %>
<link href="${ctx}/scripts/extjs/resources/css/column-tree.css" type='text/css' rel='stylesheet'>
<script type="text/javascript" src="${ctx}/scripts/extjs/diy/ColumnNodeUI.js"></script>
<script type="text/javascript" src="${ctx}/scripts/extjs/diy/ColumnTreeLoader.js"></script>
<title></title>
<style type="text/css">
.task {
    background-image:url(${ctx}/images/icons/file.png) !important;
}
.task-folder {
    background-image:url(${ctx}/images/icons/foldericon.png) !important;
}
.x-tree-node-cb {
    border:0;
    height:14px;
}
.x-tree-col-text {
   padding:0px;
   margin:0px;
   font-size:12px;
   font-family: sans-serif;
}
.x-tree-hd-text {
   font-size:12px;
   font-family: sans-serif;
}
#tree-dept {
	border-right:1px #99bbe8 solid;
	height:500px;
}
</style>
<script type="text/javascript">
var tree;
var rootName = '河北演艺集团';
Ext.onReady(function() {
	Ext.isBorderBox = true;
	tree = new Ext.tree.ColumnTree({
		el : 'tree-dept',
		width : 205,
		height:510,
		animate : false,
		rootVisible : true,
		autoScroll : true,
		lines : true,
		title : '',
		useArrows : false,

		columns : [{
			header : '部门选择',
			width : 200,
			dataIndex : 'text'
		}],

		loader : new Ext.tree.ColumnTreeLoader({
			dataUrl : '/admin/dept/deptTree.do',
			uiProviders : {
				'col' : Ext.tree.ColumnNodeUI
			},
			listeners : {
				"beforeCreateNode" : function(l, attr) {
					attr.uiProvider = "col";
					attr.iconCls = (attr.leaf) ? "task" : "task-folder";					
				}
			}
		}),

		root : new Ext.tree.AsyncTreeNode({
			 text: rootName,
		     id:'0'
		})
	});
	tree.on('click', function(node) {
		document.getElementById('showPositionPage').src="${ctx}/position/showPosition.do?deptId=" + node.id ;
	});
	tree.render();
	tree.expandAll();
});

</script>
</head>
<body>
<div class="x-panel">
  <div class="x-toolbar" style="padding: 5px;" align="right">
	    <img src="${ctx}/images/icons/folder_go.gif"/><a href="${ctx}/position/edit.do" target="showAndEdit"> 新建职位</a>
	    &nbsp;&nbsp;&nbsp;&nbsp;
  </div>
  <div class="x-panel-body">
	  <table width="100%" cellpadding="0" cellspacing="0" style="border-bottom:1px #99bbe8 solid;">
	    <tr>
	      <td width="180" valign="top">
	          <div id="tree-dept"></div>
	      </td>
	      <td valign="top">
	   		  <iframe src="${ctx}/position/showPosition.do" width="100%" height="510" id="showPositionPage" name="showAndEdit" style="border:none;overflow-y: hidden;"></iframe>
	      </td>
	    </tr>
	  </table>
  </div>
</div>
</body>
</html>
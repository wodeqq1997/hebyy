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

.x-panel-body{
    border: none!important;
}
</style>
<script type="text/javascript">
var tree;
var rootName = '文件类别';
Ext.onReady(function() {
	Ext.isBorderBox = true;
	tree = new Ext.tree.ColumnTree({
		el : 'tree-dept',
		width : 135,
		height:540,
		animate : false,
		rootVisible : true,
		autoScroll : true,
		lines : true,
		title : '',
		useArrows : false,

		columns : [{
			header : '文件类别选择',
			width : 135,
			dataIndex : 'text'
		}],

		loader : new Ext.tree.ColumnTreeLoader({
			dataUrl : '${ctx}/document/type/docTypeTree.do?model.isPublic=${isPublic}',
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
		<s:if test="model.isPublic == 1">
	    	document.getElementById('showDocumentPage').src="${ctx}/document/publicDocumentIndex.do?model.docType.id=" + node.id ;
    	</s:if>
    	<s:else>
	    	document.getElementById('showDocumentPage').src="${ctx}/document/myDocumentIndex.do?model.docType.id=" + node.id ;
	    </s:else>
	});
	tree.render();
	tree.expandAll();
});

</script>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">
		<div style="float: left;width:945;">
			<s:if test="model.isPublic == 1">
				&nbsp;文档列表.<span style="color: green;">(公共)</span>
			</s:if>
			<s:else>
				&nbsp;我的文档.<span style="color: blue;">(个人)</span>
			</s:else>
		</div>
		<div style="float: right;">
			<s:if test="model.isPublic == 1">
				<img src="${ctx}/images/icons/folder.gif" class="icon">
	    			<a href="${ctx}/document/type/index.do?model.isPublic=1">文档类别</a>
			</s:if>
			<s:else>
				<img src="${ctx}/images/icons/folder.gif" class="icon">
	    			<a href="${ctx}/document/type/index.do">文档类别</a>
			</s:else>
		</div>
	</div>
  </div>
  <div class="x-panel-body">
	  <table width="100%" cellpadding="0" cellspacing="0" style="border-bottom:1px #99bbe8 solid;">
	    <tr>
	      <td width="135" valign="top">
	          <div id="tree-dept"></div>
	      </td>
	      <td valign="top">
	      	<s:if test="model.isPublic == 1">
	   		  	<iframe src="${ctx}/document/publicDocumentIndex.do" width="800" height="510"   id="showDocumentPage" name="showAndEdit" style="border:0px;overflow-y: hidden;" ></iframe>	    		
	    	</s:if>
	    	<s:else>
	    		<iframe src="${ctx}/document/myDocumentIndex.do" width="800" height="510"  id="showDocumentPage" name="showAndEdit" style="border:none;overflow-y: hidden;" ></iframe>
		    </s:else>
	      </td>
	    </tr>
	  </table>
  </div>
</body>
</html>
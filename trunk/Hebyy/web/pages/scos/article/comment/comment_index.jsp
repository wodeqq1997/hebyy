<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/ec.jsp"%>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>文章评论信息</title>
</head>
<body>
	<s:hidden name="articleId"/>
	<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit" 
			action="commentIndex.do" 
			useAjax="false"
			doPreload="false" 
			pageSizeList="20,50" 
			editable="false"
			sortable="false" 
			rowsDisplayed="20"
			generateScript="true" 
			resizeColWidth="false" 
			classic="true" 
			width="100%"
			height="460px"
			minHeight="460"
			toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
		<ec:row>
		    <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" sortable="false" style="text-align:center"/>
			<ec:column width="100" property="author" title="作者" ellipsis="true"/>
			<ec:column width="100" property="createTime" cell="date" title="创建时间 " style="text-align:center" format="yyyy-MM-dd"/>
			<ec:column width="430" property="content" viewsAllowed="html" title="内容" ellipsis="true"/>
			<ec:column width="68" property="_0" title="操作" style="text-align:center" sortable="false">
				<a href="${ctx}/article/comment/view.do?model.id=${item.id}" title="查看文章信息">详情</a> 
			</ec:column>
		</ec:row>
		<s:if test="#attr.items.size()==0">
		<ec:extendrow>
			<tr style="background-color: #ffe3ee">
				<td colspan="9" align="center" id="No1"
					style="font-weight: bold; border-top: 0px; border-bottom: 0px; border-left: 0px">无评论信息</td>
			</tr>
		</ec:extendrow>
		</s:if>
	</ec:table>
</body>
</html>
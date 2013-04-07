<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>新闻管理</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该条新闻（及该新闻下所有评论）？")) {
			window.location.href = URL_PREFIX+"/article/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel-view">
	<div class="x-panel-header">
		&nbsp;新闻管理
	</div>
	<div class="x-toolbar">
		<s:form action="index.do" id="pageQueryForm">
		<s:hidden name="isArticlePhotos"/>
		<s:hidden name="ec_p" id="ec_p"/>
		<table width="100%">
		  <tr>
		  	<td width="75%">
				&nbsp;标题：<s:textfield id="title" name="model.title" />
				开始日期：<input id="startDate" name="startDate"  value="<s:date name='startDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				截至日期：<input id="endDate" name="endDate"  value="<s:date name='endDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
			   	类型：<s:select list="articleTypeMap" name="model.articleType.id" headerKey="" id="articleTypeId" headerValue="全部" cssStyle="width:100px;" />
				<input type="submit" value="查询" class="button" /><s:hidden name="ec_p" id="ec_p"/>
			</td>
			<td width="25%" align="right">
				  <a href="${ctx}/article/edit.do"><img src="${ctx}/images/icons/add.gif">&nbsp;添加新闻</a>&nbsp;&nbsp;
				  <a href="${ctx}/article/type/index.do" target="main"><img src="${ctx}/images/icons/articles.gif" class="icon">新闻类别</a>
				&nbsp;
			</td>
		</tr>
		</table>
		</s:form>
	</div>
	<div class="x-panel-body">
	
		<table id="fineTable" width="800">
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 4px;"
			align="right"><%@include file="/pages/common/messages.jsp"%>
		</td>
	</tr>
	<tr>
		<th>选择</th>
        <th>标题</th>
		<th>图片新闻</th>
		<th>作者</th>
		<th>创建时间</th>
		<th>类型</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
            <td align="center"><a href="${ctx}/article/view.do?model.id=${item.id}" target="_blank">${item.title}</a></td>
			<td align="center"><s:if test="#attr.item.articlePhoto != null">是</s:if>
			    	<s:else>否 </s:else></td>
			 <td>${item.creator.name }</td>
			<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
			<td>${item.articleType.name}</td>
			<td>
				<a href="edit.do?model.id=${item.id}" title="修改类型">
						<img src="${ctx}/images/icons/modify.gif"></a>&nbsp;
					<a href="#" onclick="remove('${item.id}')" title="删除类型">
						<img src="${ctx}/images/icons/remove.gif"></a>
		</td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;"
			align="right"><%@include file="/pages/common/page.jsp"%>
		</td>
	</tr>
</table>
	</div>
</div>
</body>
</html>
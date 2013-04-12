<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>通讯录类别管理</title>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该条通讯录类别？")) {
			window.location.href = URL_PREFIX+"/addressBook/type/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel-view">
	<div class="x-panel-header">
		&nbsp;通讯录类别管理
	</div>
	<div class="x-toolbar">
		<s:form action="index.do" id="pageQueryForm">
		<s:hidden name="ec_p" id="ec_p"/>
		<table width="100%">
		  <tr>
		  	<td width="75%">
				&nbsp;名称：<s:textfield id="title" name="model.name" />
				<input type="submit" value="查询" class="button" /><s:hidden name="ec_p" id="ec_p"/>
			</td>
			<td width="25%" align="right">
				  <a href="${ctx}/addressBook/type/edit.do"><img src="${ctx}/images/icons/add.gif">&nbsp;添加通讯录类别</a>&nbsp;&nbsp;
				  <a href="${ctx}/addressBook/index.do"><img src="${ctx }/images/icons/rem-all.gif">&nbsp;个人通讯录</a>
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
		<th>序号</th>
        <th>名称</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${(page.pageNo-1)*20 +st.index+1 }</td>
			<td>${item.name}</td>
			<td>
				<a href="edit.do?model.id=${item.id}" title="">
						修改</a>&nbsp;|
				<a href="#" onclick="remove('${item.id}')" title="">
						删除</a>
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
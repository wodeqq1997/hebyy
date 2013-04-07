<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>类别管理</title>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除该类别?")) {
		window.location.href = URL_PREFIX+"/goods/type/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>

<div class="x-panel-header">
	<div style="float: left;">物品类别管理</div>
</div>
<div class="x-toolbar">
	<table width="100%">
	  <tr>
	  <td width="70%">
	  <s:form action="index.do" method="post" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p"/>
	 	&nbsp;&nbsp; 类别名称：<s:textfield id="name" name="model.name" ></s:textfield>
	 	<input type="submit" value="查询" class="button"/>
	  <td width="30%" align="right"><a href="${ctx}/goods/type/edit.do">
		<img src="${ctx}/images/icons/add.gif">&nbsp;添加物品类别</a>
		&nbsp;&nbsp;
		<a href="${ctx}/goods/index.do" >
			<img src="${ctx}/images/icons/rem-all.gif">&nbsp;物品管理</a>
	  </td>
	  </s:form>
	  </tr>
	</table>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
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
			 <td align="center">${st.index + 1}</td>
            <td align="center"><a href="view.do?model.id=${item.id}" title="${item.name}" target="_blank"><font color="blue">${item.name}</font></a></td>
			<td align="center">
				<a href="edit.do?model.id=${item.id}">
				<img src="${ctx}/images/icons/modify.gif"></a> 
			<a href="#" onclick="remove('${item.id}')" title="删除">
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
</body>
</html>
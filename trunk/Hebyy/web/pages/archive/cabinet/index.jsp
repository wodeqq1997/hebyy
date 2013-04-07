<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>档案柜管理</title>
<script type="text/javascript">
function remove(id){
	if (confirm("确认要删除该档案柜吗?")){
		window.location.href=URL_PREFIX+"/archive/cabinet/remove.do?model.id=" + id;
	}
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >
	<div style="float: left;">档案柜管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
        <s:form action="index" theme="simple"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
			<table width="99%">
				<tr>
					<td width="70%">
						档案柜名称：<s:textfield id="name" name="model.name"  cssStyle="height:19px;" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" class="button" />
					</td>
					<td width="30%" align="right" >
						<a href="${ctx}/archive/cabinet/edit.do"><img src="${ctx}/images/icons/add.gif">添加档案柜</a>
						&nbsp;
						<a href="${ctx}/archive/index.do"><img src="${ctx}/images/icons/rem-all.gif">案卷管理</a>
					</td>
				</tr>
			</table>
		</s:form>
</div>  

<div class="x-panel-body">

	<table id="fineTable" width="800" align="left">
	<tr>
		<th>序号</th>
        <th>档案柜名称</th>
		<th>保管位置</th>
		<th>备注</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="50">${(page.pageNo - 1) * 20 + st.index + 1}</td>
            <td>${item.name }</td>
			 <td>${item.location}</td>
			<td>${item.remark}</td>
			<td align="center" width="125">
				<a href="view.do?model.id=${item.id}">查看</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="edit.do?model.id=${item.id}">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="#" onclick="remove('${item.id}')" title="删除">删除</a>
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
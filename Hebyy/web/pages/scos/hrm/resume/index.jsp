<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>简历管理</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<script type="text/javascript">
	function remove(id) {
		if(confirm("确认要删除该简历？")) {
			window.location.href = URL_PREFIX+"/resume/remove.do?model.id=" + id;
		}
	}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">简历管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar" >
	<s:form action="index" theme="simple" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table width="100%">
	  <tr>
	  	<td>
	  		&nbsp;毕业时间：<input type="text" name="model.graduationTime" readonly="readonly" 
							   value='<s:date name="model.graduationTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />&nbsp;
	  		&nbsp;姓名：<s:textfield id="name"  name="model.name" />&nbsp;
	  		&nbsp; 学历：<s:textfield id="degree" name="model.degree" />&nbsp;
	  		<input type="submit" value="查询" class="button" />
	  	</td> 
	  	<td align="right">
			<a href="${ctx}/resume/edit.do">
			<img src="${ctx}/images/icons/add.gif">&nbsp;添加简历</a>&nbsp;&nbsp;
		</td>
	</tr>
	</table>
	</s:form>
</div>
<div class="x-panel-body">
<table width="100%" align="left" id="fineTable">
<tr>
<th>序号</th>
<th>员工姓名</th>
<th>专业</th>
<th>毕业院校</th>
<th>操作</th>
</tr>
<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="40">${(page.pageNo - 1) * 20 + st.index + 1}</td>
			<td width="100" ellipsis="true">${item.name}</td>
      		<td width="150"ellipsis="true">${item.major}</td>
			<td width="150" ellipsis="true">${item.graduatCollege}</td>
			<td width="170" style="text-align:center" sortable="false">
			<a href="view.do?model.id=${item.id}" title="查看档案信息">详情</a> | 
			<a href="edit.do?model.id=${item.id}" title="修改档案信息">编辑</a> |
			<a href="#" onclick="remove('${item.id}')" title="删除档案信息">删除</a>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<title>员工信息详情</title>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" style="width: 1210px">
	<div style="float: left;">员工信息详情</div>
</div>
<div style="width: 1210px"><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar" style="width: 1210px">
<s:form action="showUsers" theme="simple" id="pageQueryForm">
	<s:hidden name="ec_p" id="ec_p" />
	<table>
		<tr>
			<td width="95%">&nbsp;姓 名:&nbsp;
			<s:textfield id="userName" name="model.user.name" />&nbsp;&nbsp;
			&nbsp;部 门:&nbsp;
			<s:textfield id="dept" name="model.user.dept.name" />&nbsp;&nbsp; &nbsp;
			<s:submit value="查询" cssClass="button" /></td>
			<td style="text-align: right; padding-right: 1em;" width="5%">
			<a href="${ctx}/security/user/editNew.do?from=hr">
			<img src="${ctx}/images/icons/add.gif">新建员工信息</a></td>
		</tr>
	</table>
</s:form>
</div>
<div class="x-panel-body" style="width: 1210px; ">
<table width="100%" align="left" id="fineTable">
<tr>
<th>序号</th>
<th>员工姓名</th>
<th>所属部门</th>
<th>性别</th>
<th>籍贯</th>
<th>身份证号</th>
<th>学历</th>
<th>毕业院校及专业</th>
<th>毕业时间</th>
<th>入职时间</th>
<th>职称</th>
<th>联系方式</th>
<th>操作</th>
</tr>
<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="40">${(page.pageNo - 1) * 20 + st.index + 1}</td>
			<td width="100" style="text-align:center" ellipsis="true">${item.name}</td>
      		<td width="100" style="text-align:center" ellipsis="true">${item.dept.name}</td>
      		<td width="40" style="text-align:center">
            <c:if test="${item.sex eq 'M'}">男</c:if>
            <c:if test="${item.sex eq 'F'}">女</c:if>
            </td>
            <td width="60" style="text-align:center">${item.hometown}</td>
			<td width="135" style="text-align:center">${item.idCard}</td>
			<td width="40" ellipsis="true">${item.degree}</td>
			<td width="150" ellipsis="true" title="${item.college}&nbsp;${item.major}">
			<div style="width:145px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis">
			${item.college}&nbsp;${item.major}
			</div></td>
			<td width="70"><fmt:formatDate value="${item.graduationTime}" pattern="yyyy-MM-dd"/></td>
			<td width="70"><fmt:formatDate value="${item.joinTime}" pattern="yyyy-MM-dd"/></td>
			<td  width="80" ellipsis="true">${item.enterpriseExt.technical}</td>
			<td width="80" style="text-align:center"  ellipsis="true">${item.mobile}</td>
			<td width="200" style="text-align:center" sortable="false">
			<a href="${ctx }/security/user/edit.do?model.id=${item.id}&from=1" title="员工基本信息">基本信息</a>|
			<a href="${ctx}/enterpriseext/edit.do?model.user.id=${item.id}" title="员工档案信息">企业档案</a>|
			<a href="javascript:disableUser(${item.id})" title="标记离职" style="color:red">离职</a>
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
<script>
    function disableUser(id){
        if (confirm("确认选定用户要离职吗?")) {
            var url = "${ctx}/security/user/remove.do";
            $.post(url, {selectedItems:id}, function () {
                $('#ec').submit();
            })
        }
    }
</script>
</body>
</html>
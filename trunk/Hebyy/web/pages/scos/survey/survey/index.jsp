<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript">
function remove(id) {
	if(confirm("确认要删除该主题以及下属的项目和选项？")) {
		window.location.href = URL_PREFIX+"/survey/remove.do?model.id=" + id;
	}
}
</script>
<title>问卷调查</title>
</head>
<body>
<div class="x-panel">
	<div class="x-panel-header">
		<div style="float: left;">问卷调查</div>
		<div style="float: right"></div>
	</div>
	<div class="x-toolbar">
		<table width="99%">
	  	 <tr>
	       <td width="75%">
			 <s:form action="index.do" id="pageQueryForm">
			 <s:hidden name="ec_p" id="ec_p"/>
			   &nbsp;&nbsp;问卷状态: <s:select list="#{'0':'正在进行','1':'已过期','2':'未发布'}" name="model.releaseStatus" headerKey="" id="surveyStatus" headerValue="全部" cssStyle="width:110px;margin:0;" />
			   &nbsp;&nbsp;<input type="submit" value="查询" class="button" />
			 </s:form>
		    </td>
		    <td width="24%" align="right">
		    	<a href="edit.do"><img src="${ctx}/images/icons/add.gif">&nbsp;新增主题</a>
		    </td>
		 </tr>
	</table>
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
        <th>问卷主题</th>
		<th>问卷状态</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${GLOBALROWCOUNT}</td>
            <td align="center">${item.title}</td>
			<td><s:if test="#attr.item.releaseStatus==0">未发布</s:if>
					<s:if test="#attr.item.releaseStatus==1">正在进行</s:if>
					<s:if test="#attr.item.releaseStatus==2">已过期</s:if></td>
			<td>
				<s:if test="#attr.item.releaseStatus==0"><a href="${ctx}/survey/item/index.do?model.survey.id=${item.id}" title="添加问卷"><img src="${ctx}/images/icons/add.gif"></a>&nbsp;</s:if>
					<s:if test="#attr.item.releaseStatus==0"><a href="edit.do?model.id=${item.id}" title="修改"><img src="${ctx}/images/icons/modify.gif"></a>&nbsp;</s:if>
					<s:if test="#attr.item.releaseStatus==0"><a href="release.do?model.id=${item.id}" title="发布"><img src="${ctx}/images/icons/signIn.gif"></a>&nbsp;</s:if>
					<s:if test="#attr.item.releaseStatus==1"><a href="rollback.do?model.id=${item.id}" title="结束调查"><img src="${ctx}/images/icons/signOff.gif"></a>&nbsp;</s:if>
					<s:if test="#attr.item.releaseStatus==2"><a href="${ctx}/survey/showResult.do?model.id=${item.id}&&isExpiration=${item.releaseStatus}"  target="_blank" title="查看结果"><img src="${ctx}/images/icons/attendance.gif"></a>&nbsp;</s:if>
					<s:if test="#attr.item.releaseStatus==0"><a href="#" onclick="remove('${item.id}')" title="删除"><img src="${ctx}/images/icons/remove.gif"></a></s:if>
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
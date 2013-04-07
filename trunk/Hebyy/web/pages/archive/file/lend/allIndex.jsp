<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
<title>案卷借阅记录管理</title>
<script type="text/javascript">
/**
 * 根据案卷ID打开案卷详细信息
 */
function open_archives(id)
{
	URL=URL_PREFIX+"/pro/archives/view.do?model.id=" + id;
	myleft=(screen.availWidth-700)/2;
	mytop=200;
	mywidth=700;
	myheight=300;
	window.open(URL,null,"height="+myheight+",width="+mywidth+",status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,top="+mytop+",left="+myleft+",resizable=yes");
}
</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >
	<div style="float: left;">案卷借阅管理</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
	  <s:form action="allIndex" theme="simple"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
		<s:hidden name="flowStatus"/>
      <table width="99%">
       <tr>
			<td>
				文件名称：<s:textfield id="archiveFile"  name="model.archiveFile.name"  cssStyle="height:19px;"/>
	     		归还状态：<s:select name="alsoStatus" list="#{'notNull':'已归还','null':'未归还'}" headerKey="" headerValue="全部" cssStyle="width:80px;" />
				日期：<input id="startDate" name="startDate"  value="<s:date name="startDate" format="yyyy-MM-dd"/>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				~&nbsp;<input id="endDate" name="endDate"  value="<s:date name="endDate" format="yyyy-MM-dd"/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
			</td>
			<td align="left">
				<input type="submit" value="查询" class="button" />
				<input type="button" value="重置" class="button" onclick="location.replace(location.href);"/>
			</td>
		</tr>
     </table>
     </s:form>
</div>
<div class="x-panel-body">

<table id="fineTable" width="800" align="left">
	<tr>
		<th>序号</th>
        <th>文件号</th>
		<th>文件名称</th>
		<th>所属案卷</th>
		<th>申请日期</th>
		<th>归还日期</th>
		<th>审核状态</th>
		<th>申请人</th>
		<th>归还状态</th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
	<input type="hidden" value="${item.archiveFile.id}">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${(page.pageNo - 1) * 20 + st.index + 1}</td>
            <td align="center">
            <s:if test="#attr.item.alsoDate == null && #attr.item.lastFlow.status == 'end'">
	    		<a href="#" onclick="openArchiveFile('${item.archiveFile.id}','viewFile')" title="${item.archiveFile.fileNO}"><font color="blue">${item.archiveFile.fileNO}</font></a>
			</s:if>
			<s:else>
	    		<a href="#" onclick="openArchiveFile('${item.archiveFile.id}','')" title="${item.archiveFile.fileNO}"><font color="blue">${item.archiveFile.fileNO}</font></a>
	    	</s:else></td>
			 <td>${item.archiveFile.name}</td>
			<td>${item.archiveFile.archive.name}</td>
			<td align="center"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
			<td align="center" width="85"><s:if test="#attr.item.alsoDate == null">
				&nbsp;
			</s:if>
			<font color="green"><s:date name="#attr.item.alsoDate" format="yyyy-MM-dd"/></font></td>
			<td align="center"><s:if test='#attr.item.lastFlow.status == "stop"'>
				<span style="color: red;">未通过</span>
			</s:if>
			<s:elseif test='#attr.item.lastFlow.status == "end"'>
				<span style="color: green;">通过</span>
			</s:elseif>
			<s:elseif test='#attr.item.lastFlow.status == "start"'>
				<span style="color: green;">审核中</span>
			</s:elseif>
			<s:else>
				<span style="color: black;">待审核</span>
			</s:else></td>
			<td>${item.lendUser.name}</td>
			<td align="center"><s:if test='#attr.item.lastFlow.status == null || #attr.item.lastFlow.status != "end"'>
				<s:if test='#attr.item.lastFlow.status == "stop"'>
					未通过
				</s:if>
				<s:else>
					审核中
				</s:else>
			</s:if>
			<s:else>
				<s:if test="#attr.item.alsoDate != null">
					<font color="green">已归还</font>
				</s:if>
				<s:else>
					<font color="red">未归还</font>
				</s:else>
			</s:else></td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>个人考勤</title>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header">
	<div style="float: left;">我的考勤</div>
</div>
<div class="x-toolbar">
	<table width="100%" style="margin: 4px 0px;" cellpadding="0" cellspacing="0">
	  <tr>
	    <td width="70%">
	      <s:form action="index.do" method="post" id="pageQueryForm">
	      	开始日期：<input id="startDate" name="startDate"  value="<s:date name='startDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
				结束日期&nbsp;<input id="endDate" name="endDate"  value="<s:date name='endDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;
	        <input type="submit" value="查询" class="button"/><s:hidden name="ec_p" id="ec_p"/>
	      </s:form>
	    </td>
	  </tr>
	</table>
</div>
<div class="x-panel-body">

<table id="fineTable" width="800" style="margin-left: 0px;margin-top: 0px">
				<tr>
                    <th>日期</th>
					<th>上午上班</th>
					<th>上午下班</th>
					<th>下午上班</th>
					<th>下午下班</th>
					<th>操作</th>
				</tr>
				<s:iterator value="#attr.items"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">
	                    <td width="120px" align="center"><fmt:formatDate value="${item.date}" pattern="yyyy-MM-dd"/></td>
						<td width="120px"align="center"><fmt:formatDate value="${item.morWorkPunch }" pattern="hh:mm"/>-<s:if test="#attr.item.morWorkStatus == 'later'">迟到</s:if><s:elseif test="#attr.item.morWorkStatus == 'normal'" >正常</s:elseif><s:else>未签到</s:else></td>
						<td width="120px"align="center"><fmt:formatDate value="${item.morOverPunch }" pattern="hh:mm"/>-<s:if test="#attr.item.morOverStatus == 'early'">早退</s:if><s:elseif test="#attr.item.morOverStatus == 'normal'" >正常</s:elseif><s:else>未签到</s:else></td>
						<td width="120px"align="center"><fmt:formatDate value="${item.aftWorkPunch }" pattern="hh:mm"/>-<s:if test="#attr.item.aftWorkStatus == 'later'">迟到</s:if><s:elseif test="#attr.item.aftWorkStatus == 'normal'" >正常</s:elseif><s:else>未签到</s:else></td>
						<td width="120px"align="center"><fmt:formatDate value="${item.aftOverPunch }" pattern="hh:mm"/>-<s:if test="#attr.item.aftOverStatus == 'early'">早退</s:if><s:elseif test="#attr.item.aftOverStatus == 'normal'" >正常</s:elseif><s:else>未签到</s:else></td>
						<td><a href="edit.do?model.id=${item.id}">打卡</a></td>
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
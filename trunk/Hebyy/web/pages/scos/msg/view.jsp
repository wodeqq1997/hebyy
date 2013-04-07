<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>短信查看</title>
<base target="_self">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<style type="text/css">
	.msghead{
		background-color: #F6F9FC;
		border-bottom: 1px solid #D0D0D0;
		padding-left:20px;
		line-height: 20px;
	}
	.subject{
		color: gray;
		font-size: 12px; 
		font-weight: normal;
		padding: 5px 0px;
	}
	.msgbody{
        padding: 20px;
	}
</style>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" style="border: 1px solid #99bbe8;">
  <div style="float: left;">短信查看</div>
</div>
<div class="x-panel-body">
	<div class="msghead">
      <c:if test="${not empty model.sender}">
	  <div class="subject">发送人：${model.sender.name}</div>
      </c:if>
      <div class="subject">时　间：<s:date name="model.createTime" format="yyyy/MM/dd  HH:mm:ss"/></div>
      <div class="subject">标题：${model.title}</div>
      <div class="subject">接收人：${model.receiver.name}</div>
	</div>
	<div class="msgbody">
    <pre>${model.content}</pre>
    </div>
</div>
</div>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
    <link href="${ctx}/styles/fix.css" type='text/css' rel='stylesheet'>

<style type="text/css">
.board {
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #99BBE8;
	font-family: sans-serif;
	background-color: #d0def0;
	font-weight: bold;
}

.forumTable{
	border-collapse:collapse;
	font-family: sans-serif;
	height: 150px;
	border-bottom:1px solid #99bbe8; 
}
.forumTable td{
	height: 30px;
	line-height: 30px;
}
.onMSover{
	background-color: #EEE;
}

.onMSout{
	background-color: #FFFFFF;
}
</style>

<script type="text/javascript">
function changeBgColoe(obj, className){
	obj.className = className;
}
</script>
<title>河北演艺集团员工论坛</title>
</head>
<body style="background-color: #DFE8F6;">
<div style="width:980px;margin: 0 auto;">
	<div class="viewPanel" style="margin: 10px auto;">
		<s:iterator value="#attr.items" var="board">
			<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="50%" class="board">
						&nbsp;&nbsp;
						<a href="${ctx}/forum/topic/topicIndex.do?boardId=${board.id}" title="${board.name}">${board.name}</a>
						&nbsp;(${board.topicCount})</td>
					<td width="50%" align="right" class="board">
						<a href="${ctx}/forum/topic/edit.do?boardId=${board.id}"><img src="${ctx}/images/icons/add.gif"> 发新帖</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding: 5px; border-bottom: 1px dotted #CECECE;">
						${board.descn}
					</td>
				</tr>
			</table>
			<table class="forumTable" width="100%" align="center">
				<s:if test="#attr.board.latestTopics.size() != 0 ">
					<s:iterator value="#attr.board.latestTopics" var="topic">
					<tr onmousemove="changeBgColoe(this, 'onMSover')" onmouseout="changeBgColoe(this, 'onMSout')" >
						<td width="65%" style="padding-left: 50px;">	
							<img src="${ctx}/images/icons/postnote.gif" />
							<a href="${ctx}/forum/topic/view.do?model.id=${topic.id}" >&nbsp;${topic.title}</a>
						</td>
						<td width="15%" align="center">
								回复：${topic.reCount}
						</td>
						<td width="20%" align="center">
							<s:date name="#attr.topic.createTime" format="yyyy-MM-dd"/>
						</td>
					</tr>
					</s:iterator>
				</s:if>
				<s:else>
					<tr>
						<td colspan="3" align="center"><font style="color: green">该板块无发帖信息</font>
						</td>
					</tr>
				</s:else>
			</table>
		</s:iterator>
	</div>
</div>
</body>
</html>
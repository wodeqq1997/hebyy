<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>

<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
<title>论坛主题查看.${model.title }</title>
<link href="${ctx}/styles/fix.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.pg{
	padding:0px;
	height: 22px;
	line-height: 22px;
	width: 35px;
}

.viewPanel{
	/*width: 100%;*/
	border: 2px solid #99bbe8;
}

.topic {
	height: 30px;
	line-height: 30px;
	border-bottom: 1px solid #99BBE8;
	font-family: sans-serif;
	background-color: #d0def0;
	font-weight: bold;
	padding-left: 10px;
	color: green;
}
.title{
	height: 30px;
	line-height: 30px;
	background-color: #EEE;
	font-weight: bold;
	color: orange;
}
.rBorder{
	border-right: 1px solid #99BBE8;
	padding-left: 10px;
}
.tBorder{
	border-top: 1px solid #99BBE8;
}
.content{
	padding: 5px;
}
.time{
	border-bottom: 1px dotted #99BBE8; margin: 0px 5px;
}

</style>
</head>
<body style="background-color: #DFE8F6;">
<div style="width: 980px;margin: 0 auto;">
	<div style="margin:20px 0;font-weight: bold; font-size: 14px;">
		<a href="${ctx}/forum/board/index.do" style="color: red; " title="论坛首页">河北演艺集团员工讨论区</a>&nbsp;&gt;&gt;
		<a href="${ctx}/forum/topic/topicIndex.do?boardId=${model.board.id}" style="color: red; ">${model.board.name }</a>
	</div>
	<div class="viewPanel" style="background-color: #FFF;">
		<div class="topic">
			&nbsp;主题：${model.title}
			&nbsp;&nbsp;
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" style="line-height: 25px;">
		  <tr>
		  	<td width="15%" class="title rBorder">作者</td>
		  	<td width="85%" class="title">&nbsp;正文</td>
		  </tr>
		  <s:iterator value="#attr.page.data" var="topic">
		  <tr>
		  	<td class="rBorder tBorder" valign="top">
		  		<div>${topic.sender.name}</div>
		  		<div>部门：${topic.sender.dept.name}</div>
		  		<%--<div>性别：${topic.sender.sex}</div>--%>
		  	</td>
		  	<td class="tBorder" height="50" valign="top">
		  		<div class="time">
		  			<s:if test="#attr.topic.title != null">
			  			&nbsp;${topic.title}<br>
		  			</s:if>
		  			&nbsp;发布时间：<s:date name="#attr.topic.createTime" format="yyyy-MM-dd HH:mm"/>
		  		</div>
		  		<div class="content">
		  		  ${topic.content}
		  		</div>
		  	</td>
		  </tr>
		  </s:iterator>
		</table>
	</div>
	<div class="viewPanel" style="border-width: 0px; text-align: right;">
		<form id="pageQuery" action="view.do" method="post" style="margin: 5px auto;">
			<s:hidden name="model.id"></s:hidden>
			<img alt="" src="${ctx}/images/grid/firstPage.gif" style="cursor: pointer;" onclick="submitQuery(1)">&nbsp;
			<img alt="" src="${ctx}/images/grid/prevPage.gif" style="cursor: pointer;" onclick="submitQuery('${page.pageNo - 1}')">&nbsp;&nbsp;
			<img alt="" src="${ctx}/images/grid/nextPage.gif" style="cursor: pointer;" onclick="submitQuery('${page.pageNo + 1}')">&nbsp;
			<img alt="" src="${ctx}/images/grid/lastPage.gif" style="cursor: pointer;" onclick="submitQuery('${page.pages}')">&nbsp;&nbsp;
			第<input type="text" id="selfPageNo" name="selfPageNo" class="pg" value="${selfPageNo}">页
			<input type="button" value="前往" class="button"  onclick="submitQuery(null)">&nbsp;&nbsp;
			第${page.pageNo}页&nbsp;/&nbsp;共${page.pages}页&nbsp;
		</form>
	</div>
	<div class="viewPanel">
		<div class="topic">
			&nbsp;主题回复
		</div>
		<form action="saveReTopic.do" style="margin: auto;" method="post">
		<table width="100%">
			<tr>
			  <td width="70%" align="center">
		    	<textarea name="model.content" id="content" style="margin: 5px;"></textarea>
			  </td>
			  <td width="30%" valign="bottom">
				<s:if test="#attr.model.id != null">
					<input type="hidden" name="model.parent.id" value="${model.id}" />
					回复人:${loginUserName}&nbsp;&nbsp;
			    	<input type="submit" class="button" value="提交">
				</s:if>
			  </td>
			</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('#content', {
				resizeType :1,
				allowFileManager : true,
				items:[ 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
				        'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
				        'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons','link', 'unlink'
				],
				uploadJson : '${ctx}/fileManager/upload_json.jsp',
				fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp',
				width:550,
				height:150
			});
		});
		
		function submitQuery(pageNo){
			var pageCount = ${page.pages};
			pageQueryFrom = document.getElementById("pageQuery");
			selfPageNo = document.getElementById("selfPageNo");
			if (pageNo != null){
				selfPageNo.value = pageNo;
			}
			if (isNaN(selfPageNo.value)){
				selfPageNo.value = 1;
			}
			if (selfPageNo.value <= 0){
				selfPageNo.value = 1;
			}else if (selfPageNo.value > pageCount){
				selfPageNo.value = pageCount;
			}
			pageQueryFrom.submit();
		}
	</script>
</div></body>
</html>
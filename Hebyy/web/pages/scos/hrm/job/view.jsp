<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.row{
	height: 30px;
	line-height:30px;
	border-bottom:1px solid #99BBE8; 
	font-family: sans-serif;
}
.title {
	font-size: 14px;
	font-weight: bold;
	background-image:
		url("${ctx}/scripts/extjs/resources/images/default/toolbar/bg.gif");
	text-align: center;
}
</style>
<title>新闻查看</title>
</head>
<body style="background-color: #DFE8F6;">
	<div style="margin: 10 10 0 20; color: red; font-weight: bold; font-size: 14px;">新闻查看</div>
	<div class="viewPanel">
	  <div class="row title"> ${model.title} </div>
	  <div class="row" align="right">
	  	&nbsp;<b>${model.creator.name}</b>
		&nbsp;发布于[<s:date name="model.createTime" format="yyyy-MM-dd HH:mm" />]
		&nbsp;点击[${model.hits}]次&nbsp;&nbsp;
	  </div>
	  <div class="row">
	  	<div style="margin: 5px; height: 250px; line-height: 25px;">
		  	${model.content}
	  	</div>
	  </div>
	  <div class="row">
	  	&nbsp;附件列表：
		<div id="systop_file_list"></div>
	  </div>
	  <div class="row title" style="font-size: 12px;"> 相关评论 </div>
	  <div>
	  	<iframe src="${ctx}/article/comment/commentIndex.do?articleId=${model.id}" width="100%" height="170" frameborder="0" name="commentIndex"></iframe>
		<form id="commentSave" method="post" action="${ctx}/article/comment/save.do" target="commentIndex">
			<input type="hidden" name="articleId" value="${model.id}"/>
			<fieldset><legend>发表评论</legend>
			<table width="100%" border="0" align="center" style="line-height: 30px;">
				<tr>
					<td align="right">内容：</td>
					<td>
						<textarea name="model.content" id="content" style="margin: 3px 0px; width: 535px; height: 70px; overflow: auto; border: 1px solid #C3c3c3;"></textarea>
					</td>
				</tr>
				<tr>
					<td align="right">署名：</td>
					<td>
						<input id="author" name="model.author" value='${author}' type="radio" checked="checked" />${author}
						<input id="author" name="model.author" value='匿名' type="radio" />匿名
					</td>
				</tr>
			</table>
			</fieldset>
			<div align="center">
				<input type="submit" value="发表" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<input type="button" value="关闭" onClick="javascript:window.close();" class="button" />
			</div>
		</form>
	  </div>
	</div>
	<s:if test="model.id != null">
	<script type="text/javascript">
	viewFileAttchList('${model.fileAttchIds}', false);
	</script>
</s:if>
</body>
</html>
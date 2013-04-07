<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<link href="${ctx}/styles/fix.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.row{
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

.rBorder{
	border-right: 1px solid #99BBE8;
	padding-left: 10px;
}
.tBorder{
	border-top: 1px solid #99BBE8;
}
.content{
	padding: 5px;
	border-bottom: 1px solid #99BBE8;
}
.time{
	border-bottom: 1px dotted #99BBE8; margin: 0px 5px;
}

.photo-div{
    text-align: center;
    padding: 7px;
    border-bottom: 1px solid #99BBE8;
}
.photo-div img{
    max-width: 940px;
}

</style>
<title>新闻查看</title>
</head>
<body style="background-color: #DFE8F6;">
<div style="width:980px;margin: 0 auto">
	<div style="margin: 10px; color: red; font-weight: bold; font-size: 14px; text-align: left;">新闻查看</div>
	<div class="viewPanel">
	  <div class="row title"> ${model.title} </div>
	  <div class="row" align="right">
	  	&nbsp;<b>${model.creator.name}</b>
		&nbsp;发布于[<s:date name="model.createTime" format="yyyy-MM-dd HH:mm" />]
		&nbsp;点击[${model.hits}]次&nbsp;&nbsp;
	  </div>
	  <div class="row">
          <c:if test="${not empty model.articlePhoto}">
              <div class="photo-div">
                  <img src="${ctx}${model.articlePhoto}">
              </div>
          </c:if>
          <div style="margin: 5px; line-height: 25px;">
	  		<table border="0" width="99%">
	  			<tr>
	  				<td>${model.content}</td>
	  			</tr>
	  		</table>
	  	</div>
	  </div>
	  <div class="row">
	  	<table border="0" width="99%">
  			<tr>
  				<td width="70">&nbsp;附件列表：</td>
  				<td>
					<div id="systop_file_list"></div>
  				</td>
  			</tr>
  		</table>
	  </div>
	  <div class="row title" style="font-size: 12px;"> 相关评论 </div>
	  <div>
	  	<table width="100%" cellpadding="0" cellspacing="0" style="line-height: 25px;">
		  <s:iterator value="#attr.page.data" var="comment">
		  <tr>
		  	<td class="tBorder" height="50" valign="top">
		  		<div class="time">
		  			${comment.author}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  			发表时间：<s:date name="#attr.comment.createTime" format="yyyy-MM-dd HH:mm"/>
		  		</div>
		  		<div class="content">
		  		   <s:property value="#comment.content"/>&nbsp;
		  		</div>
		  	</td>
		  </tr>
		  </s:iterator>
		  <s:if test="#attr.page.data.size == 0">
		  	<tr>
		  		<td class="content">暂无评论</td>
		  	</tr>		
		  </s:if>
		</table>
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
		<form id="commentSave" method="post" action="${ctx}/article/comment/save.do">
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
						<input id="author" name="model.author" value='${author}' type="radio" checked="checked" style="border: 0;"/>${author}
						<input id="author" name="model.author" value='匿名' type="radio" style="border: 0;"/>匿名
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
</div>
	<s:if test="model.id != null">
	<script type="text/javascript">
		viewFileAttchList('${model.fileAttchIds}', false);
	</script>
	</s:if>
	<script type="text/javascript">
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
</body>
</html>
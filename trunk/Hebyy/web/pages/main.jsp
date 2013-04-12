<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>
<link href="${ctx}/styles/welcome.css" type='text/css' rel='stylesheet'>

<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
<style type="text/css">
.noBorder {
	margin: -1px;
}
.ui-tabs-nav{
    background: url("${ctx}/images/default/tabs/tab-strip-bg.gif") repeat-x scroll center bottom #CEDFF5 !important;
    /*border-bottom: 1px solid #8DB2E3;*/
    /*padding-top: 1px;*/
}
.ui-tabs .ui-tabs-nav li a {
    padding: 0.2em 1em !important;
}
.ui-tabs .ui-tabs-panel {
    padding: 0.9em 0.9em !important;
}

.left-div{
    width: 60%;
    float: left;

}
.right-div{
    overflow: hidden;

}

</style>
<script>
    $(function(){
        $(".tabs-div").tabs({

        });
    })
</script>
<title></title>
</head>
<body style="overflow-x: hidden;">
	<div id="main" style="height: 100%;">

		<div id="base">
            <div class="blockm left-div">
                <div class="block-title">
                    <a href="${ctx}/notice/index.do">通知公告</a>
                </div>
                <div class="block-body list" id="notices"></div>
            </div>

            <div class="blockm right-div">
                <div class="block-title">
                    <a href="${ctx}/flow/node/myIndex.do">待办事项</a>
                </div>
                <div class="block-body list" id="myNodes"></div>
            </div>

            <div class="blockm left-div">
                <div class="block-title">
                    <a href="${ctx}/article/index.do">公司新闻</a>
                </div>
                <div class="block-subTitle" id="articleTypes"></div>
                <div class="block-subBody list" id="articles"></div>
            </div>

            <div class="blockm right-div">
            <div class="block-title">
                    <a href="${ctx}/pages/scos/mail/mailLayout.jsp">内部邮件</a>
                </div>
                <div class="block-body list" id="mail"></div>
            </div>

            <div class="blockm left-div">
                <div class="block-title">
                    <a href="${ctx}/msg/receiveIndex.do">短消息</a>
                </div>
                <div class="block-body" id="msg"></div>
            </div>

            <div class="blockm right-div">
                <div class="block-title">
                    <a>规章制度</a>
                </div>
                <div class="block-body list" id="gzzd"></div>
            </div>

            <div class="blockm left-div" style="clear: both;">
                <div class="block-title">
                    <a href="${ctx}/article/index.do?isArticlePhotos=1">图片新闻</a>
                </div>
                <div class="block-body" id="articlePhotos"></div>
            </div>
             <div class="blockm right-div">
                <div class="block-title">
                    <a href="${ctx}/forum/board/index.do" target="_blank">内部讨论区</a>
                </div>
                <div class="block-body" id="topics"></div>
            </div>
		</div>
        </div>
	<script type="text/javascript" src="main.js"></script>
	<script type="text/javascript" language="javascript">
		var URL_PREFIX = '${ctx}';
		//加载通知公告
		loadNotices("notices");
		//加载待办事项
		loadMyNodes("myNodes");
		//加载文章类别
		loadArticleTypes("articleTypes", "articles");
		//加载文章列表
		loadArticles("", "articles");
		//加载内部论坛
		loadTopics("topics");
		//加载内部邮件
		loadMails("mail");
		//加载常用网址
		loadUsefulLink("gzzd");
		//加载图片新闻
		loadArticlePhotos("articlePhotos");
		//加载短消息
		loadMsg("msg");
	</script>
</body>
</html>
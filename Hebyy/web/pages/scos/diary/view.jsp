<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
    <script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
    <link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>

    <style>
        .close-window-button
        {
            display: none;
        }
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
    </style>
<title>文档信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-body">
				<table width="850" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td align="center" style="font-size: 20px; font-weight: bold; color: red;">${model.title}</td>
					<tr>
						<td align="center" style="border-bottom: 1px solid #a9bfd3;">
							上传者：${model.user.name}&nbsp;&nbsp;&nbsp;&nbsp;
							上传时间：<s:date name="model.createTime" format="yyyy-MM-dd HH:mm" />
						</td>
					</tr>
					<tr>
						<td>
							<div style="padding: 10px;">
								${model.content}
							</div>
                            <c:if test="${not empty model.fileAttachIds}">
                            <div style="border-top: 1px solid #ccc">附件列表：</div>
							<div id="systop_file_list"></div>
                            </c:if>
						</td>
					</tr>
				</table>
		</div>

        <div style="margin: 0 auto;width: 850px;margin-top: 15px;">
        <div class="row title" style="font-size: 12px;"> 相关评论 </div>
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 25px;">
                <s:iterator value="model.diaryComments" var="comment">
                    <tr>
                        <td class="tBorder" height="50" valign="top">
                            <div class="time">
                                <s:property value="#comment.user.name"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                发表时间：<s:date name="#attr.comment.createTime" format="yyyy-MM-dd HH:mm"/>
                            </div>
                            <div class="content">
                                <s:property value="#comment.content"/>&nbsp;
                            </div>
                        </td>
                    </tr>
                </s:iterator>
                <s:if test="model.diaryComments.size == 0">
                    <tr>
                        <td class="content">暂无评论</td>
                    </tr>
                </s:if>
            </table>
            <form id="commentSave" method="post" action="${ctx}/diary/comment/save.do">
                <input type="hidden" name="model.diary.id" value="${model.id}"/>
                <fieldset><legend>发表评论</legend>
                    <table width="100%" border="0" align="center" style="line-height: 30px;">
                        <tr>
                            <td align="right">内容：</td>
                            <td>
                                <textarea name="model.content" id="content" style="margin: 3px 0px; width: 700px; height: 70px; overflow: auto; border: 1px solid #C3c3c3;"></textarea>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <div align="center" style="margin-bottom: 10px;">
                    <input type="submit" value="发表" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value="关闭" onClick="javascript:window.close();" class="button" />
                </div>
            </form>
        </div>
        </div>
	</div>
    <s:if test="model.id != null">
        <script type="text/javascript">
            viewFileAttchList('${model.fileAttachIds}', false);
        </script>
    </s:if>
</body>
</html>
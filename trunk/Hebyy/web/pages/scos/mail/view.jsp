<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/taglibs.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发送文件</title>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/pages/admin/fileattc/fileattch.css" type='text/css' rel='stylesheet'>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<style type="text/css">
	.mailhead{
		background-color: #F6F9FC;
		border-bottom: 1px solid #D0D0D0;
		padding-left:20px;
		height: 100px;
		line-height: 20px;
	}
	.fileattch{
		background-color: #F6F9FC;
		border-bottom: 1px solid #D0D0D0;
		padding: 5px 20px;
	}
	.subject{
		color: green;
		font-size: 14px; 
		font-weight: bold;
		padding: 5px 0px;
	}
	.mailbody{
		padding: 5px 20px;
	}
</style>
</head>
<body>
<div class="x-panel-header">文件系统-查看</div>
<table align="center" width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td class="x-toolbar" style="padding:5px 20px;">
    	<a href="newMail.do">新建</a>&nbsp;&nbsp;&nbsp;&nbsp;
    	<a href="javascript:reply()">回复</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <script type="text/javascript">
            function reply()
            {
                $('<form action="newMail.do" method="POST">' +
                  '<input type="hidden" name="model.recipientIDs" value="${mailbox.mail.sender.id}">' +
                  '<input type="hidden" name="model.recipientNames" value="${mailbox.mail.sender.name}">' +
                  '</form>').appendTo("body").submit();
            }
        </script>

    	<!--
    	<a href="#">转发</a>&nbsp;&nbsp;&nbsp;&nbsp;
    	<a href="#">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
    	-->
    </td>
  </tr>
  <tr>
    <td class="mailhead">
      <div class="subject">${mailbox.mail.subject}</div>
      <div>发件人：${mailbox.mail.senderName}</div>
      <div>时　间：${mailbox.sendTime}</div>
      <div>收件人：${mailbox.mail.recipientNames}</div>
<%--       <s:if test="#attr.mailbox.mail.copyToNames != ''"> --%>
<%--         <div>抄送人：${mailbox.mail.copyToNames}</div> --%>
<%--       </s:if> --%>
    </td>
  </tr>
  <s:if test="#attr.mailbox.mail.fileIds != null">
  <tr>
    <td class="fileattch">
      <div id="systop_file_list">&nbsp;附件：</div>
    </td>
  </tr>
   </s:if>
  <tr>
    <td>
	    <div class="mailbody">${mailbox.mail.content}</div>
    </td>
  </tr>
</table>
<br>
<script type="text/javascript">
	viewFileAttchList('${mailbox.mail.fileIds}');
</script>
</body>
</html>
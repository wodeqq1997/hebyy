<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>站内短信</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@include file="/common/extjs.jsp"%>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<LINK href="${ctx}/pages/layout.css" type='text/css' rel='stylesheet'>
<style type="text/css">
.title{
	font-weight: bold;
}
</style>
</head>
<body>

<script type="text/javascript">
	Ext.onReady(function() {

		Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

		new Ext.Viewport( {
			layout : 'border',
			items : [ {
				region : 'west',
				split : true,
				title: '我的短消息',
				width : 120,
				minSize : 120,
				maxSize : 120,
				collapsible : true,
				margins : '-1',
				layoutConfig : {
					animate : true
				},
				items : [ 
				{
					html :  document.getElementById('msg').innerHTML,
					border : false,
					iconCls : 'cms'
				}]
			},
			{
				region : 'center',
				contentEl : 'center',
				split : true,
				border : true,
				margins : '-1'
			}]
		});
	});
</script>
<div id="west"></div>
<div id="center">
	<iframe id="main" name="msgMain" src="${ctx}/msg/receiveIndex.do"
		style="width: 100%; height: 100%; border: 0px;" frameborder="0">
	</iframe>
</div>
<div id="menu" style="display:none">
	<div id="msg">
		<div style="padding-left:5px;"> 
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/modify.gif" class="icon">
				<a href="${ctx}/msg/newMsg.do" target="msgMain">发送短消息</a>
			</div>
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/message.png" class="icon">
				<a href="${ctx}/msg/receiveIndex.do" target="msgMain">我的短消息</a>
			</div>
			<div style="padding-top:5px; margin-left: 20px;">
				<img src="${ctx}/images/icons/user_go.gif" class="icon">
				<a href="${ctx}/msg/receiveIndex.do?model.msgType=personal" target="msgMain">个人消息</a>
			</div>
			<div style="padding-top:5px; margin-left: 20px;">
				<img src="${ctx}/images/icons/sms.gif" class="icon">
				<a href="${ctx}/msg/receiveIndex.do?model.msgType=sys" target="msgMain">系统消息</a>
			</div>
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/diary.png" class="icon">
				<a href="${ctx}/msg/sendIndex.do" target="msgMain">已发短信</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>

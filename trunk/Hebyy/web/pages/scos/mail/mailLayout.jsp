<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>站内邮件</title>
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

		new Ext.Viewport({
			layout : 'border',
			items : [ new Ext.BoxComponent({ // raw
				region : 'north',
				el : 'north',
				height : 25,
				margins : '0'
			}),
			{
				region : 'west',
				split : true,
				title : '&nbsp;',
				width : 120,
				minSize : 120,
				maxSize : 120,
				collapsible : true,
				margins : '-1',
				layoutConfig : {
					animate : true
				},
				items : [ {
					html : document.getElementById('mail').innerHTML,
					border : false,
					iconCls : 'cms'
				} ]
			}, {
				region : 'center',
				contentEl : 'center',
				split : true,
				border : true,
				margins : '-1'
			} ]
		});
	});
</script>
<div id="north" style="line-height: 25px;">
	<span style="font-weight: bold; color: #15428b; margin-left: 15px;">我的文件</span>
</div>
<div id="west"></div>
<div id="center">
	<iframe id="main" name="mailMain" src="${ctx}/mail/index.do?mailIndexType=receive" style="width: 100%; height: 100%; border: 0px;" frameborder="0">
	</iframe>
</div>
<div id="menu" style="display:none">
	<div id="mail">
		<div style="padding-left:10px;">
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/mail_3.gif">&nbsp;
				<a href="${ctx}/mail/newMail.do" target="mailMain">发送文件</a>
			</div>
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/folder-in.gif">&nbsp;
				<a href="${ctx}/mail/index.do?mailIndexType=receive" target="mailMain">已收文件</a>
			</div>
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/folder_go.gif">
				<a href="${ctx}/mail/index.do" target="mailMain">已发文件</a>
			</div>
			<div style="padding-top:5px">
				<img src="${ctx}/images/icons/folder_edit.gif">
				<a href="${ctx}/mail/indexDraft.do" target="mailMain">草稿箱</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>

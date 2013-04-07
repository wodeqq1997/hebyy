<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>项目信息管理</title>
</head>
<body>
	<div class="x-panel">
		<%
			String srcUrl = "/pages/zjimis/faultOperat.jsp";
		%>
		<s:if test="model.flow.archiveFileLend.id !=null"><%--档案--%>
			<%
				srcUrl = "/archive/file/lend/auditEdit.do?model.id=" + request.getAttribute("model.flow.archiveFileLend.id");
			%>
		</s:if>
		<s:else>
			<%
				session.setAttribute("FAULT_OPERAT_MSG_SESSION", "您查看的短消息已不存在");
			%>
		</s:else>
		<iframe width="100%" id="test" frameborder="0" scrolling="no" 
				src="${ctx}<%=srcUrl%>" onLoad="iFrameHeight()"></iframe>		
		
		<script type="text/javascript" language="javascript">
			function iFrameHeight() {
				var ifm = document.getElementById("test");
				var subWeb = document.frames ? document.frames["test"].document
						: ifm.contentDocument;
				if (ifm != null && subWeb != null) {
					ifm.height = subWeb.body.scrollHeight;
				}
			}
		</script>
	</div>
</body>
</html>
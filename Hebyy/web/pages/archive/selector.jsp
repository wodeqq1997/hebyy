<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/taglibs.jsp"%>
<title>选择案卷</title>
</head>
<body>
<div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div><iframe name="iframe_cars" id="iframe_cars"
			src="${ctx}/archive/showIndex.do" style="HEIGHT: 425px; WIDTH: 100%" 
			frameborder="0" scrolling="no">
			</iframe>
			</div>
		</td>
	</tr>
</table>
</div>
</body>
</html>
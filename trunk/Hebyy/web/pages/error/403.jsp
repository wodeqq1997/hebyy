<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<%@include file="/common/taglibs.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>403 错误</title>
    <LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
    <LINK href="${ctx}/styles/error.css" type='text/css' rel='stylesheet'>
</head>
<body>
<div>
    <div class="error-msg-div">您没有访问权限，请检查登录帐号！</div>
    <div class="error-link-div">
        <h3>
            <a href="javascript:history.back();">后退</a>
            <a href="${ctx}" target="_top">返回首页</a>
        </h3>
    </div>
</div>
<script type="text/javascript">
    (function () {
        //window.top.location.href = URL_PREFIX + "/main.do";
    })();
</script>
</body>
</html>

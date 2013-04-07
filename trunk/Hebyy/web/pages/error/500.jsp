<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="com.systop.core.ApplicationException" %>
<%@include file="/common/taglibs.jsp" %>
<%
    Exception ex = null;
    if (pageContext.getException() instanceof ApplicationException) {
        ex = pageContext.getException();
        pageContext.setAttribute("ex", ex);
        if(ex.getMessage().contains("未登录")){
            pageContext.setAttribute("notLogin",true);
        }
    } else if (pageContext.getException().getCause() instanceof ApplicationException) {
        ex = (Exception) pageContext.getException().getCause();
        pageContext.setAttribute("ex", ex);

    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${ctx}/scripts/jquery/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/cookie.js"></script>
    <LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
    <LINK href="${ctx}/styles/error.css" type='text/css' rel='stylesheet'>
    <title>500 Error</title>

</head>
<body>
<div class="main-div">
    <c:if test="${empty ex}">
        <div class="error-img">
            <img src="${ctx}/images/error/500.jpg" style="width: 450px;" alt="">
        </div>
        <div class="error-msg-div">对不起，服务器无法响应您的请求!</div>
        <div class="error-link-div">
            <a href="${ctx}/main.do" target="_top">返回首页</a>
        </div>
    </c:if>
    <c:if test="${not empty ex}">
        <c:if test="${notLogin}">
            <div class="error-img">
                <img src="${ctx}/images/error/500.jpg" style="width: 450px;" alt="">
            </div>
        </c:if>
        <div class="error-msg-div">${ex.message}</div>
        <div class="error-link-div">
            <c:if test="${notLogin}">
                <h3><a href="${ctx}" target="_top">重新登录</a></h3>
                <script>
                    (function () {
                        if (window.top ==window){
                            setTimeout(function () {
                                location.href = "${ctx}";
                            }, 3 * 1000);//5
                        }
                    })();
                </script>
            </c:if>
        </div>

        <script type="text/javascript">
            //因为没有登录导致的问题,可以在登录之后返回之前请求的页面,非首页,没有框架的前提下
            $(function(){
                if(location.href.indexOf("main.do")==-1 && window.top===window){
                    _setCookie("urlFrom",encodeURI(location.pathname+location.search),undefined,URL_PREFIX);
                }
            })
        </script>
    </c:if>
</div>



</body>
</html>

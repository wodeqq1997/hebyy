<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.systop.common.modules.dept.DeptConstants" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/extjs.jsp" %>
<%@include file="/common/meta.jsp" %>
<script type="text/javascript" src="${ctx}/scripts/extjs/diy/ColumnNodeUI.js"></script>
<script type="text/javascript" src="${ctx}/scripts/extjs/diy/ColumnTreeLoader.js"></script>
<style type="text/css">
    body
    {
        overflow-y: hidden;
        height: auto !important;
        width: auto !important;
    }
    #ext-gen8
    {
        width: 155px !important;
    }
</style>
<title>选择供应商</title>
</head>
<body>
	<div class="x-toolbar" style="padding: 5px;">
		<span style="color: #15428b; font-weight: bold; ">选择供应商</span>
	</div>
    <div style="overflow: hidden;">
        <iframe name="suppliers" width="100%" height="403" src="${ctx}/goods/supplier/selectSupplier.do" frameborder="0"
                scrolling="no" id="suppliers"></iframe>
    </div>

</body>
</html>
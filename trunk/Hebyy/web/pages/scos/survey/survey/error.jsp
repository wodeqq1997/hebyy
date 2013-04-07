<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
.greenfont { font-size: 20px; font-weight: bold; color: red; }
</style>
</head>

<body>
<table style="height: 200px; width: 500px;border: 5px solid #C6DEEC; background-color: #F6FBFF;margin-top: 100px;" align="center">
  <tr><td>
	  <table width="350" border="0" align="center" cellpadding="0" cellspacing="0" style="font-family: Verdana, Geneva, sans-serif; font-size: 12px;">
	    <tr>
	      <td width="66" height="80"><img src="${ctx}/images/icons/warning_2.jpg" width="80" height="80"/></td>
	      <td width="10">&nbsp;</td>
	      <td width="324" >
	      	<span class="greenfont">操作错误！</span>
	      	<br/><br/>提示：<s:actionerror />
	      </td>
	    </tr>
	  </table>
  </td></tr>
</table>
</body>
</html>
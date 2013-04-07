<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>查询规章制度条例</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

	<div id="r_main">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
			<span
				class="r_nav_item">规章制度条例查询</span>
		</div>

		
		
		
		
		<div class="x-toolbar">
	<table width="100%" style="margin: 4px 0px;" cellpadding="0" cellspacing="0">
	  <tr>
	    <td width="70%">
	     	<s:form id="pageQueryForm" action="queryxx.do" cssStyle="margin:auto;" method="post">&nbsp;
					&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;
					
				  
						
						  <s:hidden name="ec_p" id="ec_p"/>
						<input type="button" style="width:70px; height:18px;"
						onclick="javascript:window.location.href='${ctx}/pages/main.jsp';"
						class="button" value=" 返 回 ">
						  
				</s:form> </td>
	   </tr>
	  
	</table>
</div>
<div class="x-panel-body">
		
			<table id="fineTable" width="800">
				<tr>
					<td colspan="5" style="border: 0px; padding-top: 4px;"
						align="right"><%@include file="/pages/common/messages.jsp"%>
					</td>
				</tr>
				<tr>
                    <th  width="60">章程号</th>
                    <th  width="100">章程名称</th>
					<th  width="500">规章制度内容</th>
				</tr>
				<s:iterator value="items"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">		                  
	                    <td  width="60" align="center">${item.zcxx.zcxh}</td>
	                    <td width="100" align="center">${item.zcxx.zcMc}</td>
						<td  width="500" align="left">${item.zdContent}
						<input type="hidden" name="item.zcxx.zcMc" value="${item.zcxx.zcMc}"/>
						</td>
					</tr>
				</s:iterator>
				<tr>
					<td colspan="13" style="border: 0px; padding-top: 10px;"
						align="right"><%@include file="/pages/common/page.jsp"%>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		function jkjsSave() {
			$('#pageQueryForm').attr("action", "${ctx}/gzzd/toAll.do");
			$('#pageQueryForm').submit();
		}
	</script>

</body>
</html>
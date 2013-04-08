<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>图书信息查询</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

	<div id="r_main">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
			<span
				class="r_nav_item">图书查询</span>
		</div>

	<div class="x-toolbar">
	<table width="100%" style="margin: 4px 0px;" cellpadding="0" cellspacing="0">
	  <tr>
	    <td width="70%">
	      	<s:form id="pageQueryForm" action="queryxx2.do" cssStyle="margin:auto;" method="post">&nbsp;
					图书类别：<s:select name="model.lbmc" list='names'
							cssStyle="width:180px;" headerKey="" headerValue="请选择" />	&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;
					书名：<s:textfield name="model.tsMc"
						maxLength="12" cssStyle="width:100px; height:16px;" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					作者：<s:textfield name="model.author"
						maxLength="12" cssStyle="width:100px; height:16px;" />
					&nbsp;&nbsp;					
						<input type="submit"  class="button"
						 value=" 查询" style="width:50px; height:18px;">&nbsp;
				  
				    <input type="button" onclick="jkjsSave()"  class="button" 
						value=" 查询全部" style="width:70px; height:18px;">
						 <a href="${ctx}/jhs/queryxx1.do" title="查询图书借阅情况"> 
						<img src="${ctx}/images/icons/down.gif">&nbsp;查询图书借阅情况</a>
						&nbsp;&nbsp;
						  <s:hidden name="ec_p" id="ec_p"/>
				</s:form>
 </td>
	   </tr>
	  
	</table>
</div>
<div class="x-panel-body">

			<table id="fineTable" width="800">
				<tr>
					<td colspan="9" style="border: 0px; padding-top: 4px;"
						align="right"><%@include file="/pages/common/messages.jsp"%>
					</td>
				</tr>
				<tr>
				    <th> 序号 </th>
                    <th  width="110">书名</th>
                    <th  width="80">作者</th>
					<th  width="100">图书类别</th>
					<th  width="80">总数量</th>
					<th  width="70">剩余数量</th>
					<th  width="80">入库日期</th>
					<th  width="160">图书备注</th>
	 			    <th  width="30">操作</th>

				
				</tr>
				<s:iterator value="items"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">
					    <td align="center">${st.index + 1}</td>
	                    <td  width="110" align="center">${item.tsMc}</td>
	                    <td width="80" align="center">${item.author}</td>
						<td  width="100" align="center">${item.lbxx.lbMc}
						 <td  width="80" align="center">${item.totalNum}</td>
	                    <td width="70" align="center">${item.syNum}</td>
	                  
						<td  width="80" align="center">  <fmt:formatDate value="${item.rkTime}" pattern="yyyy-MM-dd"/></td>
						<td  width="180">${item.descn}
						
						
						</td>
					
          <td width="30"	align="center"> <a href="view.do?model.id=${item.id}" title="查看详情"><img src="${ctx}/images/icons/zoom.gif"></a>&nbsp;</td>

						
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
			$('#pageQueryForm').attr("action", "${ctx}/tsgl/toAll2.do");
			$('#pageQueryForm').submit();
		}
	</script>

</body>
</html>
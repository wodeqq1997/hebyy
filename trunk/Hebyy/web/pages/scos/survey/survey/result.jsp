<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
		<script type="text/javascript" src="${ctx}/scripts/jquery/jquery.progressbar/js/jquery.progressbar.min.js"></script>
<title>问卷调查</title>
</head>
<body>
<div class="x-panel-header">
<div style="float: left;">问卷调查</div>
<div style="float: right"></div>
</div>
<div class="x-panel-body b">
<table width="800" border="0" align="center">
<s:iterator value="model.surveyItems" var="item" status="st">
	<tr><td colspan="3" style="border-bottom: 1px dotted #99bbe8">${st.index+1}.${item.title}</td></tr>
		<s:iterator value="#attr.item.subitems" id="subitem" status="s">
	 		<s:if test='#attr.item.multiple=="0"'>
	 			<tr>	
	 				<td style="border:none;padding-left: 20px;float: right" width="100px">${subitem.title}:</td>
					<td style="border:none;" width="310px">
						 <div id="progressbar${st.index}${s.index}" style="height: 15px;"></div>
					</td>
					<td style="border:none;" width="390px">(${subitem.votesCount}人投票)</td>
				</tr>
	 		</s:if>
			<s:else>
	 			<tr>
		 			<td style="border:none;padding-left: 20px">${subitem.title}:</td>
					<td style="border:none;">
						<div id="progressbar${st.index}${s.index}"  style="height: 15px;"></div>
					</td>
					<td style="border:none;">(${subitem.votesCount}人投票)</td>
				</tr>
			</s:else>
		</s:iterator>
</s:iterator>
</table>
</div>
<script type="text/javascript">
$(document).ready(function() {
// 	<s:iterator value="model.surveyItems" var="item" status="st">
// 		<s:iterator value="#attr.item.subitems" id="subitem" status="s">
			var st = <s:property value="#attr.st.index"/>;
			var s = <s:property value="#attr.s.index"/>;
			var id = "progressbar"+st+s;
			var color = null;
			if((${subitem.percent/10}) <=20){
				color = '${ctx}/scripts/jquery/jquery.progressbar/images/progressbg_red.gif';
			}
			if (20<(${subitem.percent/10}) && (${subitem.percent/10})<=40){
				color = '${ctx}/scripts/jquery/jquery.progressbar/images/progressbg_orange.gif';
			}
			if (40<(${subitem.percent/10}) && (${subitem.percent/10})<=60){
				color = '${ctx}/scripts/jquery/jquery.progressbar/images/progressbg_yellow.gif';
			}
			if (60<(${subitem.percent/10}) && (${subitem.percent/10})<=100){
				color = '${ctx}/scripts/jquery/jquery.progressbar/images/progressbg_green.gif';
			}
			$('#'+id).progressBar(${subitem.percent/10}
					,{ showText: true, 
						barImage: color
					});
			 //$("#"+id).progressbar({
		     //       value: ${subitem.percent/10}
		      //  });
// 		</s:iterator>
// 	</s:iterator>
	});

</script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>


</body>
</html>
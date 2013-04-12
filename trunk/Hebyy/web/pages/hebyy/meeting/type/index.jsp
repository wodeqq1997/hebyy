<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>会议纪要类别</title>
</head>
<body>
	<div id="r_main">
	<div class="x-panel-header">
			<div style="float: left;">会议纪要类别管理</div>
	</div>
		<div id="r_tool">
			<div style="float:right">
				<s:form id="pageQueryForm" action="index.do" cssStyle="margin:auto;" method="post">&nbsp;
						<a href="edit.do" title="添加会议纪要类别"><img src="${ctx}/images/icons/add.gif">&nbsp;新建</a>&nbsp;&nbsp;
						<a href="javascript:changeUser('pageQueryForm','确认要删除信息吗?');" title="删除会议纪要类别"> <img src="${ctx}/images/icons/delete.gif">删除</a> 
						<a href="javascript:window.location.href='${ctx}/meeting/queryxx.do';" title="返回会议管理页面"> 
						<img src="${ctx}/images/icons/go.gif">&nbsp;返回</a>&nbsp;&nbsp;&nbsp;&nbsp;
						 <s:hidden name="ec_p" id="ec_p"/>
				</s:form>

			</div>
		</div>
		<div style="margin: 10px;">
		<div align="right">
		<table>
				<tr>
					<td colspan="13" style="border: 0px; padding-top: 4px;" align="right"><%@include file="/pages/common/messages.jsp"%></td>
				</tr>
		</table>
	</div>	
			<table id="fineTable" width="800">
				
				<tr>
				    <th>选择</th>
					<th>会议纪要类别名称</th>
					<th>备注</th>
					<th width="60">操作</th>
				</tr>
				<s:iterator value="items"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">
						<td align="center"><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
						<td align="left">${item.hyLbMc}</td>
						<td align="left">${item.remark}</td>
						<td align="center" valign="middle"><a href="edit.do?model.id=${item.id}" title="修改会议纪要类别"> <img 	src="${ctx}/images/icons/edit.png"></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</s:iterator>
				<tr>
					<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include file="/pages/common/page.jsp"%></td>
				</tr>
			</table>
		</div>
	</div>
<script type="text/javascript">
	

		function changeUser(formid, msg) {
			var checked = false;
			$('input').each(function(i, item) {
				if (item.checked && item.id == 'selectedItems') {
					checked = true;
				}
			});
			if (!checked) {
				alert('请至少选择一条要删除信息');
				return;
			}

			if (confirm(msg)) {
				var s = null;
				$('input').each(function(i, item) {//循环每一个表单里的input元素
					if (item.checked && item.id == 'selectedItems') {//确定选中的是复选框
						if(s!=null){
						s=s+item.value+",";
					//	alert(item.value);
						}else{//第一次
							s=item.value+",";
						}
					}
				});
				
				// alert(s);
				window.location.href = "remove.do?ids=" + s;
			}
		}
	</script>


</body>
</html>
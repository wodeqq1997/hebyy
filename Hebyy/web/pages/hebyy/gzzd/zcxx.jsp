<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>章程目录</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

	<div id="r_main">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
			<span
				class="r_nav_item">章程目录管理</span>
		</div>
		<div id="r_tool">
			<div>
				<s:form id="pageQueryForm" action="queryxx.do" cssStyle="margin:auto;" method="post">&nbsp;
					
					&nbsp;&nbsp;
						<a href="edit.do" title="添加章程目录"> 
						<img src="${ctx}/images/icons/add.gif">&nbsp;新建</a>
						&nbsp;&nbsp;
						<a href="javascript:changeUser('pageQueryForm','确认要删除信息吗?');" title="删除章程目录"
							> <img
								src="${ctx}/images/icons/delete.gif">删除</a> 
						<a href="javascript:window.location.href='${ctx}/gzzd/queryxx.do';" title="返回规章制度管理页面"> 
						<img src="${ctx}/images/icons/go.gif">&nbsp;返回</a>
					
						
						  <s:hidden name="ec_p" id="ec_p"/>
				</s:form>

			</div>
		</div>
		<div style="margin: 10px;">
			<table id="fineTable" width="800">
				<tr>
					<td colspan="13" style="border: 0px; padding-top: 4px;"
						align="right"><%@include file="/pages/common/messages.jsp"%>
					</td>
				</tr>
				<tr>
				    <th>选择</th>
                    <th>章程编号</th>
					<th>章程目录</th>
	 			

					<th width="60">操作</th>
				</tr>
				<s:iterator value="zcList"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">
						<td align="center"><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
	                   
	                    <td align="center">${item.zcxh}</td>
						<td align="left">${item.zcMc}</td>
					


						<td align="center" valign="middle"><a
							href="edit.do?model.id=${item.id}" title="修改章程目录"> <img
								src="${ctx}/images/icons/edit.png">
						</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
				window.location.href = "delete.do?ids=" + s;
			}
		}
	</script>
	<script type="text/javascript">
		function jkjsSave() {
			$('#pageQueryForm').attr("action", "${ctx}/zcxx/toAll.do");
			$('#pageQueryForm').submit();
		}
	</script>

</body>
</html>
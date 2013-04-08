<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>

<title>会议信息记录</title>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>

	<div id="r_main">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
			<span
				class="r_nav_item">会议信息记录查询</span>
		</div>

		
		<div class="x-toolbar">
	<table width="100%"  cellpadding="0" cellspacing="0" style="margin-left: 0px;margin-top: 0px">
	  <tr>
	    <td width="70%">
	      <s:form id="pageQueryForm" action="queryxx.do" cssStyle="margin:auto;" method="post">&nbsp;
					
					会议名称：<s:textfield name="model.hyMc"
						maxLength="12" cssStyle="width:100px; height:16px;" />
					&nbsp;会议纪要类别：
					<s:select name="model.hytype" list='names'
							cssStyle="width:100px;" headerKey="" headerValue="请选择" />
					&nbsp;&nbsp;&nbsp;起止时间：
						<input type="text" name="model.startTime" style="width:90px; height:16px;" readonly="readonly" 
							   value='<s:date name="model.startTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
							   &nbsp;截止时间：
						<input type="text" name="model.endTime" style="width:90px; height:16px;" readonly="readonly" 
							   value='<s:date name="model.endTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
						
						  <s:hidden name="ec_p" id="ec_p"/>
				
	      
	       <input type="submit" value="查询" class="button"/>
	    	<input type="button" onclick="jkjsSave()"  class="button" 
					style="width: 60px;"	value="查询全部" >
	   </s:form> </td>
	   </tr>
	   <tr>
	    <td align="right">
	   <a href="toEdit.do?zx=0" title="添加会议信息记录"> 
						<img src="${ctx}/images/icons/add.gif">&nbsp;新建</a>
						&nbsp;&nbsp;
						<a href="javascript:changeUser('pageQueryForm','确认要删除信息吗?');" title="删除会议信息记录"
							> <img
								src="${ctx}/images/icons/delete.gif">删除</a> 
							&nbsp;&nbsp;
							<a href="${ctx}/hylb/index.do"
			title="会议纪要类别管理"> <img src="${ctx}/images/icons/add.gif">&nbsp;会议纪要类别管理</a>
		&nbsp;&nbsp;
							
							&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	    
	  </tr>
	</table>
</div>
<div class="x-panel-body">
<div align="right">
		<table>
		<tr>
					<td colspan="13" style="border: 0px; padding-top: 4px;"
						align="right"><%@include file="/pages/common/messages.jsp"%>
					</td>
				</tr>
		</table>
	</div>	
			<table id="fineTable" width="800">
				
				<tr>
				    <th>选择</th>
                    <th>序号</th>
					<th>会议文件名称</th>
					<th>文件号</th>
					<th>文件页/份数</th>
				   <th>会议纪要类别</th>
					<th>会议参与人</th>
					<th>会议时间</th>
	 				<th>备注</th>

					<th width="60">操作</th>
				</tr>
				<s:iterator value="items"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">
						<td align="center"><input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox"/></td>
	                    <td align="center">${st.index + 1}</td>
						<td align="center">${item.hyMc}</td>
						<td align="center">${item.wjh}</td>
						<td align="center">${item.pageNum}</td>
						<td align="center">${item.hytype}</td>
						<td align="center">${item.hycyr}</td>
						<td align="center">
						<fmt:formatDate value="${item.hyTime}" pattern="yyyy-MM-dd"/>
						</td>
						<td align="center">${item.hyContent}</td>


						<td align="center" valign="middle"><a
							href="toEdit.do?model.id=${item.id}&zx=1" title="修改会议信息记录"> <img
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
			$('#pageQueryForm').attr("action", "${ctx}/hybl/toAll.do");
			$('#pageQueryForm').submit();
		}
	</script>

</body>
</html>
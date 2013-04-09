<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的下属</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
</head>
<body>

<div class="x-panel">
  <div class="x-panel-header">我的下属</div>
  <div><%@ include file="/common/messages.jsp"%></div>
  <div class="x-toolbar">
    <table width="100%" style="line-height: 25px;">  
      <tr>
        <td> 
          <form id="pageQueryForm" action="index.do" method="post">
          &nbsp;姓　名：<s:textfield name="model.user.name" />&nbsp;&nbsp;
          &nbsp;<s:submit value="查询" cssClass="button" /><s:hidden name="ec_p" id="ec_p"/>
          </form>
        </td>
        <td align="right" style="padding-right: 20px;">
          <form id="saveForm" action="save.do">
          	<a href="javascript:openSelector()">
          	<img src="${ctx}/images/icons/add.gif"/> 添加下属</a>
          	<input type="hidden" id="subUserIds" name="subUserIds">
          </form>
        </td>
      </tr>
    </table>
    </div>   
    <div class="x-panel-body">
    
    <table id="fineTable" width="800" style="margin-left: 0px;margin-top: 0px">
	<tr>
		<th>序号</th>
		<th>姓名</th>
		<th>部门</th>
		<th>手机</th>
		<th>入职时间</th>
		<th>职务</th>
		<th>是否确认</th>
		<th>操作</th>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td>${(page.pageNo -1)*20+st.index+1 }</td>
			<td width="80px" align="center">${item.user.name }</td>
			<td width="80px" align="center">${item.user.dept.name }</td>
			<td width="80px">${item.user.mobile}</td>
			<td><fmt:formatDate pattern="yyyy-mm-dd" value="${item.user.joinTime}"/></td>
			<td>${item.user.position.name }</td>
			<td><s:if test='#attr.item.status == "1"'>
				<span style="color: green;">已确认</span>
			</s:if>
			<s:else>
				<span style="color: red;">未确认</span>
			</s:else></td>
			<td width="80px" align="center" valign="middle"> <a href="javascript:remove('${item.id}');" title="删除">删除</a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>
	</div>
</div>

<script type="text/javascript">
	function openSelector() {
        openSel(function(users){
            var selectNames = "";
          		var selectIds = "";
          		if (users != null) {
          			for ( var i = 0; i < users.length; i++) {
          				selectNames = selectNames + users[i].name + ",";
          				selectIds = selectIds + users[i].id + ",";
          			}
          		}
                var subUserIds = document.getElementById("subUserIds");
          		subUserIds.value = selectIds;
          		if(subUserIds.value != null && subUserIds.value.length != 0){
          			document.getElementById("saveForm").submit();
          		}
        });

	}
	
	function remove(id){
		if (confirm("确定要删除下属吗?")){
			window.location.href = "remove.do?model.id=" +  id;
		}
	}
</script>
</body>
</html>
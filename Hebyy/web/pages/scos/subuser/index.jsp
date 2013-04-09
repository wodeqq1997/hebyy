<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>我的下属</title>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/ec.jsp" %>
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
          <form id="queryForm" action="index.do" method="post">
          &nbsp;姓　名：<s:textfield name="model.user.name" />&nbsp;&nbsp;
          &nbsp;<s:submit value="查询" cssClass="button" />
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
	<ec:table items="items" var="item" retrieveRowsCallback="process" sortRowsCallback="process" 
		action="index.do"
		useAjax="true" doPreload="false"
		maxRowsExported="10000000" 
		pageSizeList="20,50" 
		editable="false" 
		sortable="false"	
		rowsDisplayed="20"	
		generateScript="true"	
		resizeColWidth="false"	
		classic="false"	
		width="100%" 	
		height="460px"	
		minHeight="460"
		toolbarContent="navigation|pagejump|pagesize|refresh|extend|status"   
	>
	<ec:row>
	    <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" style="text-align:center" />
		<ec:column width="100" property="user.name" title="姓名" />
		<ec:column width="120" property="user.dept.name" title="部门" />
		<ec:column width="120" property="user.mobile" title="手机" />
		<ec:column width="100" property="user.joinTime" title="入职时间" cell="date" format="yyyy-MM-dd" style="text-align:center"/>
		<ec:column width="100" property="user.duty" title="职务" style="text-align:center"/>
		<ec:column width="100" property="status" title="对方确认" style="text-align:center">
			<s:if test='#attr.item.status == "1"'>
				<span style="color: green;">已确认</span>
			</s:if>
			<s:else>
				<span style="color: red;">未确认</span>
			</s:else>
		</ec:column>
		<ec:column width="40" property="_2" title="操作" style="text-align:center"  sortable="false">
		   <a href="javascript:remove('${item.id}');" title="删除">
		     <img src="${ctx}/images/icons/remove.gif"></a>
		</ec:column>
	</ec:row>
	</ec:table>
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
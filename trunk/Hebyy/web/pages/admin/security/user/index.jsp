<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/ec.jsp" %>
<%@include file="/common/extjs.jsp" %>
    <style type="text/css">
        #ec_toolbar
        {
            position: static !important;
        }
        #ec_bodyZone
        {
            overflow-x:hidden !important;
        }
        .detail-button
        {
            height: 14px;
        }
        
        .online{
        	color: green;
        	font-weight: bold;
        }
        .offline{
        	color:silver;
        }
    </style>
</head>
<body>
	<script type="text/javascript">
		/**
		 * 提交表单
		 */
		function submitForm() {
			$("#queryForm").submit();
		}

		function changeUser(formid, msg) {
			var checked = false;
			$('input').each(function(i, item) {
				if (item.checked && item.id == 'selectedItems') {
					checked = true;
				}
			});
			if (!checked) {
				alert('请至少选择一个用户');
				return;
			}

			if (confirm(msg)) {
				$('#ec').attr("action", $('#' + formid).attr("action"));
				//ec.from里面已经包含model.type项,不相信查看源代码
				$('#ec').submit();
			}
		}
	</script>
<s:form action="user/remove" id="removeForm"></s:form>
<s:form action="user/unsealUser" id="unsealForm"></s:form>
<div class="x-panel">
  <div class="x-toolbar" style="min-width: 916px;width: 100%">
    <table style="line-height: 25px;">
      <tr>
        <td> 
          <form id="queryForm" action="index.do" method="post">
          &nbsp;用户名：<s:textfield id="userLoginId" name="model.loginId"  cssStyle="height:20px;"/>&nbsp;&nbsp;
          &nbsp;姓　名：<s:textfield id="userName" name="model.name"  cssStyle="height:20px;"/>&nbsp;&nbsp;
          &nbsp;状　态：<s:select id="userStatus" name="model.status" list='#{"1":"可用","0":"禁用"}' onchange="submitForm()"/>&nbsp;
          &nbsp;<s:submit value="查询" cssClass="button" />
          </form>
        </td>
        <stc:role ifAnyGranted="ROLE_ADMIN">
        <td>
          <a href="${ctx}/security/user/editNew.do">
          <img src="${ctx}/images/icons/add.gif"/> 新建</a></td>
        <td><span class="ytb-sep"></span></td>
        <td>
        	
          <a href="javascript:changeUser('unsealForm','确认要启用所选用户吗?');">
          <img src="${ctx}/images/exticons/recommend.gif"/> 启用</a></td>
        <td><span class="ytb-sep"></span></td>
        <td>
          <a href="javascript:changeUser('removeForm','确认要禁用所选用户吗?');">
          <img src="${ctx}/images/icons/delete.gif"/> 禁用</a></td>
        <td>
        <span class="ytb-sep"></span></td>
        </stc:role>
        <td>
          <a href="${ctx}/security/user/index.do">
          <img src="${ctx}/images/exticons/refresh.gif"/> 刷新</a></td>
      </tr>
    </table>
    </div>   
    <div >
    <table cellpadding="0" cellspacing="0" style="border-bottom: 1px solid #99bbe8;width: 100%;">
    	<tr>
    		<td width="205" valign="top">
    			<iframe name="users" width="205" height="510" src="${ctx}/pages/admin/security/user/deptTree.jsp" frameborder="0" scrolling="no"></iframe>
    		</td>
    		<td valign="top">
    			<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit"
   					action="index.do"
   					useAjax="false"
				  	doPreload="false" 
				  	maxRowsExported="10000000" 
				  	pageSizeList="20,50"
				  	editable="false" 
				  	sortable="false" 
				  	rowsDisplayed="20"
				  	generateScript="true"
				  	resizeColWidth="true"
				  	classic="false"
				  	width="99.9%"
				  	height="460px" 
				  	minHeight="460"
				  	toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
					<ec:row>
						<ec:column width="40" property="_s" title="选择" sortable="false" style="text-align:center">
							<input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox" />
						</ec:column>
						<ec:column width="100" property="loginId" title="用户名" />
						<ec:column width="80" property="name" title="姓名" />
						<ec:column width="40" property="sex" title="性别"
							style="text-align:center">
							<s:if test='#attr.item.sex == "M"'>男</s:if>
							<s:else>女</s:else>
						</ec:column>
						<ec:column width="100" property="dept.name" title="部门"/>
						<ec:column width="90" property="position.name" title="职务"/>
						<ec:column width="90" property="phone" title="办公电话"/>
						<ec:column width="90" property="mobile" title="移动电话"/>
						<ec:column width="70" property="_sfzx" title="是否在线">
							<s:if test="#attr.item.online">
								<span class="online">在线</span>
							</s:if>
							<s:else>
								<span class="offline">离线</span>
							</s:else>
						</ec:column>
						<ec:column width="50" property="_status" title="状态" style="text-align:center;">
							<s:if test="#attr.item.status == 1">
								<img src="${ctx}/images/icons/accept.gif" title="可用">
							</s:if>
							<s:elseif test="#attr.item.status == 0">
								<img src="${ctx}/images/grid/clear.gif" title="禁用">
							</s:elseif>
						</ec:column>
						<ec:column width="80" property="_opt" title="操作" style="text-align:center">
							<a href="view.do?model.id=${item.id}" title="查看"> 
									<img src="${ctx}/images/icons/zoom.gif" class="detail-button"></a>&nbsp;
							<stc:role ifAnyGranted="ROLE_ADMIN">
								<a href="javascript:assignRoles('${item.id}');" title="角色">
									<img src="${ctx}/images/icons/flowpic.gif"></a>&nbsp;
								<a href="edit.do?model.id=${item.id}" title="编辑"> 
									<img src="${ctx}/images/icons/modify.gif"></a>
							</stc:role>
						</ec:column>
					</ec:row>
				</ec:table>
			</td>
    	</tr>	
    </table>
	
	</div>
</div>


<div id="win" class="x-hidden">
    <div class="x-window-header">角色列表</div>
    <div id="role_grid"></div>
</div>
<script type="text/javascript" src="${ctx}/pages/admin/security/user/user.js">
</script>
<div id='load-mask'></div>
</body>
</html>
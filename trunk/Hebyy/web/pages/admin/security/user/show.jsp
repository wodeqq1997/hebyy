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
<div class="x-panel">
  <div class="x-toolbar" style="min-width: 916px;width: 100%">
    <table style="line-height: 25px;">
      <tr>
        <td> 
          <form id="queryForm" action="show.do" method="post">
          &nbsp;用户名：<s:textfield id="userLoginId" name="model.loginId"  cssStyle="height:20px;"/>&nbsp;&nbsp;
          &nbsp;姓　名：<s:textfield id="userName" name="model.name"  cssStyle="height:20px;"/>&nbsp;&nbsp;
          &nbsp;<s:submit value="查询" cssClass="button" />
          </form>
        </td>
      </tr>
    </table>
    </div>   
    <div >
    <table cellpadding="0" cellspacing="0" style="border-bottom: 1px solid #99bbe8;width: 100%;">
    	<tr>
    		<td width="205" valign="top">
    			<iframe name="users" width="205" height="510" src="${ctx}/pages/admin/security/user/showDeptTree.jsp" frameborder="0" scrolling="no"></iframe>
    		</td>
    		<td valign="top">
    			<ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit"
   					action="show.do"
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
						<ec:column width="40" property="_s" title="序号" value="${GLOBALROWCOUNT}" style="text-align:center">
							<input type="checkbox" name="selectedItems" id="selectedItems" value="${item.id}" class="checkbox" />
						</ec:column>
						<ec:column width="80" property="name" title="姓名" />
						<ec:column width="40" property="sex" title="性别"
							style="text-align:center">
							<s:if test='#attr.item.sex == "M"'>男</s:if>
							<s:else>女</s:else>
						</ec:column>
						<ec:column width="70" property="_sfzx" title="是否在线">
							<s:if test="#attr.item.online">
								<span class="online">在线</span>
							</s:if>
							<s:else>
								<span class="offline">离线</span>
							</s:else>
						</ec:column>
						<ec:column width="90" property="dept.name" title="部门"/>
						<ec:column width="90" property="position.name" title="职务"/>
						<ec:column width="90" property="phone" title="办公电话"/>
						<ec:column width="90" property="mobile" title="移动电话"/>
					</ec:row>
				</ec:table>
			</td>
    	</tr>	
    </table>
	</div>
</div>
<script type="text/javascript" src="${ctx}/pages/admin/security/user/user.js">
</script>
<div id='load-mask'></div>
</body>
</html>
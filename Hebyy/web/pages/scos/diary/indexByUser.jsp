<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<%@include file="/common/ec.jsp"%>

<html>
<head>
    <%@include file="/common/extjs.jsp"%>
    <%@include file="/common/meta.jsp"%>
    <script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
    <title>日志管理</title>
    <link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>
    <script type="text/javascript">
        function remove(id) {
            if(confirm("确认要删除该日志？")) {
                window.location.href = URL_PREFIX+"/diary/remove.do?model.id=" + id;
            }
        }
    </script>
</head>
<body>
<div class="x-panel">
    <div class="x-panel-header">
        <div style="float: left;">
        ${empty items ? '下属':items[0].user.name}的日志
        </div>
    </div>
    <div class="x-toolbar">
        <table width="100%" style="margin: 4px 0px;" cellpadding="0" cellspacing="0">
            <tr>
                <td width="70%">
                    <s:form action="indexByUser.do" method="post">
                        &nbsp;&nbsp;标题：<s:textfield id="title" name="model.title"  maxlength="40"/>&nbsp;&nbsp;
                        创建时间：<input id="queryDate" name="queryDate"  value="<s:date name='queryDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />&nbsp;&nbsp;
                        <input type="hidden" value="${empty items ?'':items[0].user.id}" name="model.user.id"/>
                        <input type="submit" value="查询" class="button"/>
                    </s:form>
                </td>
                <td width="30%" align="right">
                </td>
            </tr>
        </table>
    </div>
    <div class="x-panel-body">
        <ec:table items="items" var="item" retrieveRowsCallback="limit" sortRowsCallback="limit"
                  action="indexByUser.do"
                  useAjax="false"
                  doPreload="false"
                  pageSizeList="20,50"
                  editable="false"
                  sortable="false"
                  rowsDisplayed="20"
                  generateScript="true"
                  resizeColWidth="false"
                  classic="true"
                  width="100%"
                  height="460px"
                  minHeight="460"
                  toolbarContent="navigation|pagejump|pagesize|refresh|extend|status">
            <ec:row>
                <ec:column width="40" property="_s" title="No." value="${GLOBALROWCOUNT}" style="text-align:center"/>
                <ec:column width="250" property="_title" title="标题">
                    <a href="view.do?model.id=${item.id}" title="${item.title}" target="_blank">${item.title}</a>
                </ec:column>
                <ec:column width="120" property="createTime" title="创建日期 " cell="date" format="yyyy-MM-dd" style="text-align:center"/>
                <ec:column width="120" property="updateTime" title="最后修改时间" cell="date" format="yyyy-MM-dd"  style="text-align:center;"/>
            </ec:row>
        </ec:table>
    </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<title>归档信息</title>
<%@include file="/common/meta.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css" />
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>
</head>
<body>
	<div class="x-panel" style="width: 100%">
		<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
			<div style="float: left;">归档信息</div>
			<div style="float: right;">
<%-- 				<a href="${ctx}/archive/tran/index.do"><img src="${ctx}/images/icons/rem-all.gif">档案移交</a> --%>
			</div>
		</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div align="center" style="width: 100%">
			<s:hidden name="model.id" />
            <c:if test="${empty model.id}">
                <table width="700" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0"
                       align="center">
                    <tr>
                        <th colspan="4">案卷信息</th>
                    </tr>
                    <tr class="empty-tr">
                        <td colspan="4">无案卷信息</td>
                    </tr>
                </table>
                </c:if>
            <c:if test="${not empty model.id}">
                <table width="700" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0" align="center">
                    <tr>
                        <th colspan="4">案卷信息</th>
                    </tr>
                    <tr>
                        <td width="100" align="center">案卷编号：</td>
                        <td width="250">
                            &nbsp;${model.archiveNO}
                        </td>
                        <td width="100" align="center">案卷名称：</td>
                        <td width="250">
                            &nbsp;${model.name}
                        </td>
                    </tr>
                    <tr>
                        <td align="center">案卷类别：</td>
                        <td>
                            &nbsp;${model.archiveType.name}
                        </td>
                        <td align="center">归档年代：</td>
                        <td>
                            &nbsp;<fmt:formatDate value="${model.archiveYear}" pattern="yyyy年"/>
                        </td>
                    </tr>
                </table>
                <table width="700" id="fineTable" align="center" style="margin-top: -1px;">
                    <tr>
                        <th colspan="4">档案文件信息</th>
                    </tr>
                    <tr>
                        <th width="100">文件号</th>
                        <th width="250">文件名称</th>
                        <th width="100">文件页数</th>
                        <th width="250">备注</th>
                    </tr>
                    <s:iterator value="model.archiveFiles" var="file" status="st">
                        <tr>
                            <td align="center">
                                &nbsp;<s:property value="#file.fileNO"/>
                            </td>
                            <td>
                                &nbsp;<a href="javascript:" onclick="openArchiveFile('${file.id}','viewFile')" title="查看文件信息"><s:property value="#file.name"/></a>
                            </td>
                            <td align="center">
                                &nbsp;<s:property value="#file.filePage"/>
                            </td>
                            <td>
                                &nbsp;<s:property value="#file.remark"/>
                            </td>
                        </tr>
                    </s:iterator>
                </table>

            </c:if>
		</div>
	</div>
</body>
</html>
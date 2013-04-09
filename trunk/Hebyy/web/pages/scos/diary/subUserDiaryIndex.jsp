<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<html>
<head>
    <script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
    <title>日志管理</title>
    <link href="${ctx}/styles/treeSelect.css" type='text/css'
          rel='stylesheet'>
    <style type="text/css">
        #fineTable {
            margin: 5px;
        }

        #fineTable th {
            text-align: center;
            font-weight: bold;
        }

        #fineTable td {
            padding-left: 2px;
        }

        .page-header {
            border-bottom: 1px solid #99bbe8;
            background-color: #D5E2F2;
            padding: 4px 5px 4px 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div>
    <div class="x-panel-header">
      	 下属工作日志
    </div>
	<div class="x-toolbar">
<%--		<table width="100%" style="margin: 4px 0px;" cellpadding="0" cellspacing="0">
			<tr>
				<td width="70%">
					<s:form action="subUserDiaryIndex.do" method="post">
	       				 创建时间：<input id="queryDate" name="queryDate"
							value="<s:date name='queryDate' format='yyyy-MM-dd'/>"
							onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})"
							class="Wdate" readonly="readonly" />&nbsp;&nbsp;
	        			&nbsp;&nbsp;<input type="submit" value="查询" class="button" />
					</s:form>
				</td>
			</tr>
		</table>--%>
	</div>
    <div style="width: 700px">
        <table id="fineTable" style="width: 100%;">
            <thead>
            <tr>
                <th width="60">No.</th>
                <th width="140">姓名</th>
                <th width="400">最近的工作日志</th>
                <th width="100">操作</th>
                <%--<th width="100">工作计划</th>--%>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="subUserDiarys" var="item" status="index">
                <tr>
                    <td align="center">${index.index + 1}</td>
                    <td>${item.user.name}</td>
                    <td>
                        <s:if test="#attr.item.diary != null">
                            <a href="${ctx}/diary/view.do?model.id=${item.diary.id}"
                               target="_blank">${item.diary.title}</a>
                        </s:if>
                        <s:else>未提交日志</s:else>
                    </td>
                    <td align="center">
                        <%--<s:date name="queryDate" format="yyyy-MM-dd"/>--%>
                        <a href="${ctx}/diary/indexByUser.do?model.user.id=${item.user.id}" target="_blank">查看所有</a>
                    </td>
<%--                    <td align="center">
                        <a href="${ctx}/workplan/selectUser.do?model.user.id=${item.user.id}">查看</a>
                    </td>--%>
                </tr>
            </s:iterator>

            <s:if test="subUserDiarys.size == 0">
                <tr>
                    <td colspan="4">您还未设置下属</td>
                </tr>
            </s:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
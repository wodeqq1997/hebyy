<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/ec2.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/meta.jsp"%>
<link href="${ctx}/styles/treeSelect.css" type='text/css'
	rel='stylesheet'>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<title>考勤管理</title>
<style type="text/css">
.button {
	height: 20px;
	padding: 2px 0px 2px 0px;
	background-color: #D2E0F1;
	border: 1px solid #99BBE8;
	background-image: url("../images/grid/footerBg.gif");
}
</style>
</head>
<body>
<script type="text/javascript">
	var rootName = '河北演艺集团';
	var dtree;
	Ext.onReady(function() {
		//var deptId = '${model.dept.id}';
		var initValue = '${model.dept.name}';
		if (initValue.length == 0) {
			initValue = rootName;
		}
		dtree = new DeptTree({
			url : '${ctx}/admin/dept/deptTree.do',
			rootName : rootName,
			initValue : initValue,
			el : 'comboxWithTree',
			innerTree : 'inner-tree',
			onclick : function(nodeId) {
				Ext.get('deptId').dom.value = nodeId;
			}
		});
		dtree.init();
	});
	function open_Attendance(id) {
		URL = URL_PREFIX + "/attendance/view.do?model.id=" + id;
		mytop = 100;
		mywidth = 800;
		myheight = 500;
		myleft = (screen.availWidth - mywidth) / 2;
		window
				.open(
						URL,
						null,
						"height="
								+ myheight
								+ ",width="
								+ mywidth
								+ ",status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,top="
								+ mytop + ",left=" + myleft + ",resizable=yes");
	}
</script>
<s:form action="user/remove" id="removeForm"></s:form>
<s:form action="user/unsealUser" id="unsealForm"></s:form>
<div id="r_main">
<div class="x-panel-header">考勤管理</div>
<div class="x-toolbar" style="position: relative;"><s:form
	action="index" theme="simple" id="pageQueryForm" method="post">

            &nbsp;&nbsp;年份：<input id="dateYear" name="dateYear"
		value='${dateYear}'
		onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy'})" class="Wdate"
		readonly="readonly" style="height: 20px;" />
            部门：<div id='comboxWithTree' style="display: inline-block;"></div>
	<input type="hidden" id="deptId" name="model.dept.id" class="dept"
		value="${model.dept.id}" />
	<s:submit value="查  询" cssClass="button" />

	<span style="position: absolute; right: 0.75em;"><a
		href="${ctx}/attendance/edit.do"><img
		src="${ctx}/images/icons/add.gif" />新建考勤</a></span>
	<s:hidden name="ec_p" id="ec_p" />
</s:form></div>
<div style="margin: 10px;">
<div>
<table>
	<tr>
		<td colspan="4" style="border: 0px; padding-top: 4px;" align="right"><%@include
			file="/pages/common/messages.jsp"%></td>
	</tr>
</table>
</div>
<table id="fineTable" width="800">
	<tr>
		<td style="background-color: #d0def0;" align="center"><b>序号</b></td>
		<td style="background-color: #d0def0;" align="center"><b>考勤记录</b></td>
		<td style="background-color: #d0def0;" align="center"><b>创建日期</b></td>
		<td style="background-color: #d0def0;" align="center"><b>操作</b></td>
	</tr>
	<s:iterator value="#attr.items" var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center">${st.index + 1}</td>
			<td align="center"><a href="javascript:"
				onclick="open_Attendance('${item.id}')"><font color="blue"><fmt:formatDate
				value="${item.attendanceDate}" pattern="yyyy年MM月" />【${item.dept.name}】考勤记录</font></a></td>
			<td align="center"><fmt:formatDate value="${item.createTime}"
				pattern="yyyy-MM-dd" /></td>
			<td align="center"><a href="edit.do?model.id=${item.id}"
				title="编辑"> <img src="${ctx}/images/icons/modify.gif"></a></td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;" align="right"><%@include
			file="/pages/common/page.jsp"%></td>
	</tr>
</table>



</div>
</div>
</body>
</html>
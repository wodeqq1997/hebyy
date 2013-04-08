<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>打卡</title>
<script type="text/javascript">
	
</script>
<style>
.label-th {
	text-align: center;
	width: 55px;
}

.item-tr input {
	width: 98%;
}
</style>
</head>
<body>
<div class="x-panel" style="width: 100%">
<div class="x-panel-header" style="border-bottom: 1px solid #99bbe8;">
<div style="float: left;">个人考勤</div>
</div>
<div align="center" style="width: 100%"><s:form action="save"
	id="save" validate="true" method="POST">
	<s:hidden name="model.id" />
	<table id="fineTable" width="800"
		style="margin-left: 0px; margin-top: 0px">
		<tr>
			<th>上午上班</th>
			<th>上午下班</th>
			<th>下午上班</th>
			<th>下午下班</th>
		</tr>
		<tr>
			<td>${time.morWork} <s:if test="#attr.morWork">
				<s:if test="#attr.model.morWorkStatus == null">
					<input type="button" value="签到" class="button" id="morWork"
						onclick="sub(0);">
				</s:if>
				<s:else>
					<s:if test="#attr.model.morWorkStatus == 'later'">迟到</s:if>
					<s:elseif test="#attr.model.morWorkStatus == 'normal'">正常</s:elseif>
					<s:else>未签到</s:else>
				</s:else>
			</s:if> <s:else>
				时间不符合
			</s:else></td>
			<td>${time.morOver} <s:if test="#attr.morOver">
				<s:if test="#attr.model.morOverStatus == null">
					<input type="button" value="签到" class="button" id="morOver"
						onclick="sub(1);">
				</s:if>
				<s:else>
					<s:if test="#attr.model.morOverStatus == 'early'">早退</s:if>
					<s:elseif test="#attr.model.morOverStatus == 'normal'">正常</s:elseif>
					<s:else>未签到</s:else>
				</s:else>
			</s:if> <s:else>
				时间不符合
			</s:else></td>
			<td>${time.afWork} <s:if test="#attr.afWork">
				<s:if test="#attr.model.aftWorkStatus == null">
					<input type="button" value="签到" class="button" id="aftWork"
						onclick="sub(2);">
				</s:if>
				<s:else>
					<s:if test="#attr.model.aftWorkStatus == 'later'">迟到</s:if>
					<s:elseif test="#attr.model.aftWorkStatus == 'normal'">正常</s:elseif>
					<s:else>未签到111</s:else>
				</s:else>
			</s:if> <s:else>
				时间不符合
			</s:else></td>
			<td>${time.afOver} <s:if test="#attr.afOver">
				<s:if test="#attr.model.aftOverStatus == null">
					<input type="button" value="签到" class="button" id="aftOver"
						onclick="sub(3);">
				</s:if>
				<s:else>
					<s:if test="#attr.model.aftOverStatus == 'early'">早退</s:if>
					<s:elseif test="#attr.model.aftOverStatus == 'normal'">正常</s:elseif>
					<s:else>未签到</s:else>
				</s:else>
			</s:if> <s:else>
				时间不符合
			</s:else></td>
		</tr>
	</table>
</s:form></div>
</div>
<input type="button" value="查看记录" onclick="index()" class="button">
<script type="text/javascript">
	function sub(sta) {
		window.location.href = "${ctx}/peopleAtt/save.do?sta=" + sta+ "&model.id=" + ${model.id};
	}
	function index(){
		window.location.href="${ctx}/peopleAtt/index.do";
	}
</script>

</body>
</html>
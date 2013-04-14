<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<LINK href="${ctx}/styles/style.css" type='text/css' rel='stylesheet'>
<title>图书信息</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-panel-header" align="left">图书信息</div>
		<div class="x-panel-body">
			<fieldset>
				<legend>图书信息</legend>
				<table width="750" border="0" align="center" style="line-height: 30px;">
					<tr>
						<td width="100" align="right">图书名称：</td>
						<td width="350">
							${model.tsMc}
						</td>
						<td width="300" rowspan="8" align="center">
							<div style="border:1px solid #ccc;width: 250px;height: 270px;">
								<s:if test="model.id != null && model.bookPhoto != null && model.bookPhoto != ''">
									<img  id="photo" src="${ctx}${model.fileAttch.path}" width="250px" height="270px"/>
								</s:if>
								<s:else>
									<img  id="photo" src="${ctx}/images/scos/defaultcarpic.gif" width="250px" height="270px"/>
								</s:else>						
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">图书作者:</td>
						<td>
							${model.author}
						</td>
					</tr>
					<tr>
						<td align="right">图书类别:</td>
						<td>
							${model.lbxx.lbMc}
						</td>
					</tr>
					<tr>
						<td align="right">入库数量：</td>
						<td >
							${model.totalNum}
						</td>
					</tr>
					<tr>
						<td align="right">入库时间：</td>
						<td class="simple">
							<s:date name="model.rkTime" format="yyyy-MM-dd" />
						</td>
					</tr>
					
					
					<tr>
						<td align="right" valign="top">图书描述：</td>
						<td colspan="2">
							${model.descn}
						</td>
					</tr>
				</table>
			</fieldset>
			<div align="center">
				<input type="button" value="返回" onclick="history.go(-1)"
					class="button" />
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/scos/asset/selector.js"></script>
<title>设备检测记录编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">设备检测记录</div>
		<div class="x-panel-body">
			<s:form action="save.do" id="save" method="post" cssStyle="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="500" id="fineTable" align="center" style="margin-top: 20px;margin-bottom: 10px;">
					<tr>
						<th colspan="2">设备检测记录</th>
					</tr>
					<tr>
						<td width="100" align="center">选择设备</td>
						<td width="400">
							<s:hidden name="model.asset.id" id="assetId" />
							<s:textfield id="name" name="model.asset.name" onclick="showAsset()"  readonly="true" cssClass="required"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center" >送检日期</td>
						<td class="simple">
							<input id="repairDate" name="model.checkDate"  value="<s:date name='model.checkDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate required" readonly="readonly" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center" >校检日期</td>
						<td class="simple">
							<input id="repairDate" name="model.correctDate"  value="<s:date name='model.correctDate' format='yyyy-MM-dd'/>" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate required" readonly="readonly" />
							<font color="red">*</font>
						</td>
					</tr>
					
					<tr>
						<td align="center">送&nbsp;&nbsp;检&nbsp;&nbsp;人</td>
						<td >
							<s:textfield name="model.executant" id="executant"  cssClass="required"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center" valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
						<td>
							<s:textarea name="model.notes" id="notes"  cssStyle="margin:3px 0px; width: 400px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
					<tr>
			        	<td align="center">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件</td>
						<td>
							<table style="border: 0px;">
							  <tr style="border: 0px;">
							    <td style="border: 0px;"><input type="file" id="systop_upload" />&nbsp;</td>
							    <td style="border: 0px;"><span style="color: #EB2A03">附件大小在30M以内!</span></td>
							  </tr>
							</table>
							<div id="custom">
								<div id="systop-file-queue"></div>
							</div>
							<div id="systop-uploaded-files" style="width: 400px; border-bottom: 1px solid #C3C3C3;">
								<s:hidden id="fileAttchIds" name="model.attachIds"/>
							</div>
							<div id="systop_file_list"></div>
						</td>
			        </tr>
				</table>
				<table width="500" align="center">
					<tr>
						<td>
							<span style="color: green;">检测证书以附件的形式上传。</span>
						</td>
					</tr>
				</table>
			  <div align="center" id="test" style="margin-top: 10px;">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		//渲染上传组件
		renderUploader(true, fileType, fileDesc, 30240000);
	</script>
	<s:if test="model.id != null">
		<script type="text/javascript">
			viewFileAttchList('${model.attachIds}', true);
		</script>
	</s:if>
</body>
</html>
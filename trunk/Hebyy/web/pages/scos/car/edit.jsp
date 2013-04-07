<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<title>车辆信息编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header">添加车辆信息</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div class="x-panel-body">
			<s:form action="save.do" id="save" method="post">
			  <s:hidden name="model.id"/>
			  <fieldset style="width: 99%;  padding:10px 10px 10px 10px;">
			    <legend>车辆信息编辑${model.fileAttch.id}</legend>
				<table border="0" align="center" style="line-height: 30px;width: 800">
					<tr>
						<td width="150" align="right">车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</td>
						<td width="350">
							<s:textfield name="model.carNo" id="carNo"  maxlength="20" cssClass="required"/>
							<span id="carNoDescn"></span>
							<font color="red">*</font> 
						</td>
						<td width="300" rowspan="8" align="center">
							<div style="border:1px solid #ccc;width: 250px;height: 270px;">
								<s:if test="model.id != null && model.carPhoto != null && model.carPhoto != ''">
									<img id="photo" src="${ctx}${model.fileAttch.path}" width="250px" height="270px"/>
								</s:if>
								<s:else>
									<img id="photo" src="${ctx}/images/scos/defaultcarpic.gif" width="250px" height="270px"/>
								</s:else>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">车辆类型：</td>
						<td>
							<s:select list="#{'轿车':'轿车','货车':'货车','商务车':'商务车'}" name="model.carType" headerKey="" id="carType" headerValue="全部" cssStyle="width:147px;" cssClass="carTypeCheck"/>
							<font color="red">*</font> 
						</td>
					</tr>
					<tr>
						<td align="right">发动机号：</td>
						<td>
							<s:textfield name="model.engineNo" id="engineNo"  maxlength="100" cssClass="required"/>
							<span id="engineNoDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" >购置日期：</td>
						<td class="simple">
							<input id="buyDate" name="model.buyDate"  value="<s:date name='model.buyDate' format="yyyy-MM-dd"/>" onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							<span id="buyDateDescn"></span>
							<font color="red">*</font> 
						</td>
					</tr>
					<tr>
						<td align="right" >保险购买日期：</td>
						<td class="simple">
							<input id="buyInsureTime" name="model.buyInsureTime"  value="<s:date name='model.buyInsureTime' format='yyyy-MM-dd'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'buyDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							<span id="buyInsureTimeDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="right" >年审日期：</td>
						<td class="simple">
							<input id="auditTime" name="model.auditTime"  value="<s:date name='model.auditTime' format='yyyy-MM-dd'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'buyDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
							<span id="auditTimeDescn"></span>
							<font color="red">*</font> 
						</td>
					</tr>
					<tr>
						<td align="right">车辆状态：</td>
						<td >
							<s:select list="statusMap" name="model.status" headerKey="" id="status" headerValue="全部" cssStyle="width:147px;" cssClass="statusCheck"/>
							<font color="red">*</font> 
						</td>
					</tr>
					<tr>
						<td align="right">车辆照片：</td>
						<td>
							<s:if test="model.carPhoto == null || model.carPhoto == ''">							
								<div id="file_buttom">
								  <table>
								    <tr>
								      <td><input type="file" id="systop_upload" />&nbsp;</td>
								      <td><span style="color: #EB2A03">照片大小在5M以内!</span></td>
								    </tr>
								  </table>
								</div>
<!-- 								<div id="custom"> -->
<!-- 									<div id="systop-file-queue"></div> -->
<!-- 								</div> -->
								<div id="systop-uploaded-files">
									<s:hidden id="fileAttchIds" name="model.carPhoto" onpropertychange="updateCarPhoto();"/>
								</div>
								<div id="systop_file_list"></div>
							</s:if>
							<s:else>
								<a href="${ctx}/car/removeCarPhoto.do?id=${model.id}"><font color="red">删除照片</font></a>
							</s:else>
						</td>
					</tr>
					<tr>
						<td align="right">服务电话：</td>
						<td width="650" colspan="2">
							<s:textfield name="model.servicePhone" id="servicePhone"  maxlength="20" />
							(例：某4S店)
						</td>
					</tr>
					<tr>
						<td align="right">多少公里保养：</td>
						<td colspan="2">
							<s:textfield name="model.maintenance" id="maintenance"  maxlength="20" />
						</td>
					</tr>
					<tr>
						<td align="right">厂&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
						<td colspan="2">
							<s:textfield name="model.factory" id="factory"  maxlength="255" />
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：</td>
						<td colspan="2">
							<s:textarea name="model.descn" id="descn"  cssStyle="margin:3px 0px; width: 635px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>
				</table>
			  </fieldset>
			  <div align="center" id="test">
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
		$(function(){
			$.validator.addMethod("statusCheck", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必选项");
			$.validator.addMethod("carTypeCheck", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必选项");
			$.validator.addMethod("Wdate", function(value, element) {
				return value != null && value.length  != 0;				
			}, "必填项");
		});
		//渲染上传组件
		renderUploader(false, '*.jpg; *.gif; *.png', '图片(JPG; GIF; PNG)', 5000000);
		function updateCarPhoto(){
			var fileAttchId = $('#fileAttchIds').val();
			if(fileAttchId  == null || fileAttchId == ""){
				$("#photo").attr("src", URL_PREFIX+"/images/scos/defaultcarpic.gif");
			}else{
				showCarPhoto(fileAttchId);
			}
		}
		/**
		 * 显示图片
		 * 
		 * @param fileIds
		 */
		function showCarPhoto(fileIds){
			if (fileIds == null || fileIds.length ==0){
				return;
			}
			$.ajax({
			    url: URL_PREFIX + '/fileattch/findFiles.do?fileIds=' + fileIds,
			    type: 'get',
			    dataType: 'json',
			    error: function(){
			    	alert('get file list error');
			    },
			    success: function(data, textStatus){
			    	if (data != null && data.files != null){
			    		for(var i = 0; i < data.files.length; i++){
			    			// 文件信息
			    			$("#photo").attr("src", URL_PREFIX + data.files[i].path);			    			
			    		}
			    	}
			    }
			});
		}
	</script>
	<s:if test="model.id != null">
		<script type="text/javascript">
			viewFileAttchList('${model.carPhoto}', true);
		</script>
	</s:if>
</body>
</html>